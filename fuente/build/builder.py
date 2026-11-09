#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Genera la guía de Termodinámica Aplicada a partir de src/*.dsl.

Uso (desde la raíz del proyecto):  python3 build/builder.py
Salidas:
  out/termodinamica-aplicada-guia.html   HTML maestro de un solo archivo
  site/                                  web multipágina (una página por bloque) + PWA

La mini-DSL (una directiva por línea, al inicio de línea, con «@»):
  @bloque id | título | kicker | color | badge | etiqueta-menú | grupo
  @fin                       cierra el contenedor abierto (bloque, ejemplo, ejercicio, ...)
  @ejemplo título | etiquetas
  @ejercicio id | título | examen | puntos | etiquetas
  @enunciado / @antes        (dentro de ejemplo o ejercicio)
  @paso título               pasos plegables (se cierran con el siguiente @paso/@resultado/@fin)
  @resultado [título]        «Resultado final» plegado
  @solucion [título]         bloque plegado con pasos (soluciones ocultas)
  @demo título               demostración completa (contenedor, usa @paso)
  @grupo título | abierto    agrupación plegable
  @zero título               «Desde cero» (cuadro)
  @intuicion / @esencial / @trampa / @ojo título / @formula título / @masfondo título
  @test                      una pregunta: «? enunciado», «- opción», «* opción correcta», «! explicación»
  @tarjeta frente | reverso  tarjeta de repaso (se agrupan)
  @sim id | título           simulador interactivo (ver build/sims.js)
  @abrirsim id | texto       botón «Abrir en el simulador»
  @fig nombre | pie          figura SVG (build/fig/nombre.svg)
  @codigo lenguaje | título  código con fondo
  @consola | título          salida tipo consola
  @objetivos                 lista marcable (se guarda en localStorage)
  @filtros | examen1;examen2 | tema1;tema2   chips y buscador de exámenes
  @botones / @estadisticas / @lista-enlaces (automáticos o en cuerpo)
Texto: párrafos; «- » listas; «1. » listas numeradas; «|» tablas; **negrita**; `código`;
[texto](#ancla); $matemáticas$ en línea y $$...$$ en bloque (KaTeX en tiempo de construcción).
"""
import os, re, sys, json, html, subprocess, glob, base64, shutil, unicodedata

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, 'src')
BUILD = os.path.join(ROOT, 'build')
OUT = os.path.join(ROOT, 'out')
SITE = os.path.join(ROOT, 'site')
KATEX = '/opt/npm-tools/node_modules/katex/dist'
FECHA = '8 de noviembre de 2026'
FECHA_CORTA = '8 nov 2026'
PDFDIR = os.path.join(BUILD, 'pdf')
TITULO = 'Termodinámica Aplicada'
MAESTRO = 'termodinamica-aplicada-guia.html'

DIR_RE = re.compile(r'^@([a-z][a-z\-]*)\s*(.*)$')
CONTAINERS = {'bloque', 'ejemplo', 'ejercicio', 'demo', 'paso', 'solucion', 'grupo'}
MATH_D = re.compile(r'\$\$(.+?)\$\$', re.S)
MATH_I = re.compile(r'(?<![\\\w$])\$([^$\n]+?)\$(?![\w$])')

MATHS = []        # [tex, es_bloque]
IDX = []          # entradas del índice de búsqueda
ANCLA_BLOQUE = {} # id de ancla -> id de bloque
TOC = []          # (grupo, bloque, etiqueta, color, [(ancla, título)])
_n = [0]
_test = [0]
_stats = {'ejercicios': 0, 'sims': 0, 'tests': 0, 'ejemplos': 0, 'tarjetas': 0}
_warn = []


def nuevo_id(prefijo='e'):
    _n[0] += 1
    return f'{prefijo}{_n[0]}'


def slug(s):
    s = unicodedata.normalize('NFKD', s).encode('ascii', 'ignore').decode().lower()
    return re.sub(r'[^a-z0-9]+', '-', s).strip('-')


def pad(lst, n):
    return (lst + [''] * n)[:n]


# ---------------------------------------------------------------- lectura
def leer_items(ruta):
    items, cur = [], None
    with open(ruta, encoding='utf-8') as f:
        for n, linea in enumerate(f, 1):
            linea = linea.rstrip('\n').rstrip()
            if linea.startswith('%%'):
                continue
            m = DIR_RE.match(linea)
            if m:
                args = [a.strip() for a in m.group(2).split('|')] if m.group(2).strip() else []
                cur = {'name': m.group(1), 'args': args, 'body': [], 'line': n, 'file': ruta}
                items.append(cur)
            else:
                if cur is None:
                    if linea.strip():
                        raise SystemExit(f'{ruta}:{n}: texto fuera de directiva')
                    continue
                cur['body'].append(linea)
    return items


def construir_arbol(items):
    raiz = {'name': 'raiz', 'children': []}
    pila = [raiz]
    for it in items:
        nombre = it['name']
        if nombre == 'fin':
            while len(pila) > 1 and pila[-1]['name'] == 'paso':
                pila.pop()
            if len(pila) <= 1:
                raise SystemExit(f"{it['file']}:{it['line']}: @fin sin contenedor abierto")
            pila.pop()
            continue
        nodo = dict(it)
        nodo['children'] = []
        if nombre in ('paso', 'resultado') and pila[-1]['name'] == 'paso':
            pila.pop()
        pila[-1]['children'].append(nodo)
        if nombre in CONTAINERS:
            pila.append(nodo)
    if len(pila) != 1:
        raise SystemExit(f"{items[0]['file']}: contenedor sin cerrar «{pila[-1]['name']}»")
    return raiz


# ---------------------------------------------------------------- texto
def proteger_mates(texto):
    def d(m):
        MATHS.append((m.group(1).strip(), True))
        return f'\x00{len(MATHS) - 1}\x00'

    def i(m):
        MATHS.append((m.group(1).strip(), False))
        return f'\x00{len(MATHS) - 1}\x00'
    texto = MATH_D.sub(d, texto)
    return MATH_I.sub(i, texto)


def en_linea(s):
    """Formato en línea. Las matemáticas ya deben estar protegidas."""
    s = html.escape(s, quote=False)
    s = re.sub(r'\*\*(.+?)\*\*', r'<strong>\1</strong>', s)
    s = re.sub(r'`([^`]+)`', r'<code>\1</code>', s)
    s = re.sub(r'\[([^\]]+)\]\((#?[^)\s]+)\)', r'<a href="\2">\1</a>', s)
    return s


def es_mate_bloque(texto):
    m = re.fullmatch(r'\x00(\d+)\x00', texto.strip())
    return bool(m and MATHS[int(m.group(1))][1])


def cuerpo(lineas):
    """Convierte líneas de texto con formato ligero a HTML."""
    if not lineas:
        return ''
    texto = proteger_mates('\n'.join(lineas))
    out, par, lista, tabla = [], [], None, []

    def vaciar_par():
        if par:
            t = ' '.join(par).strip()
            par.clear()
            if es_mate_bloque(t):
                out.append(en_linea(t))
            else:
                out.append('<p>' + en_linea(t) + '</p>')

    def vaciar_lista():
        nonlocal lista
        if lista:
            tag, items = lista
            out.append(f'<{tag}>' + ''.join('<li>' + en_linea(x) + '</li>' for x in items) + f'</{tag}>')
            lista = None

    def vaciar_tabla():
        if tabla:
            filas = [r for r in tabla if not re.fullmatch(r'[\s|:\-]+', r)]
            h = '<div class="ptable"><table>'
            for i, r in enumerate(filas):
                celdas = [c.strip() for c in r.strip().strip('|').split('|')]
                tag = 'th' if i == 0 else 'td'
                h += '<tr>' + ''.join(f'<{tag}>{en_linea(c)}</{tag}>' for c in celdas) + '</tr>'
            out.append(h + '</table></div>')
            tabla.clear()

    for linea in texto.split('\n'):
        s = linea.strip()
        if not s:
            vaciar_par(); vaciar_lista(); vaciar_tabla()
            continue
        if s.startswith('|'):
            vaciar_par(); vaciar_lista(); tabla.append(s)
            continue
        vaciar_tabla()
        if s.startswith('- '):
            vaciar_par()
            if not lista or lista[0] != 'ul':
                vaciar_lista(); lista = ('ul', [])
            lista[1].append(s[2:])
            continue
        m = re.match(r'^\d+\.\s+(.*)$', s)
        if m:
            vaciar_par()
            if not lista or lista[0] != 'ol':
                vaciar_lista(); lista = ('ol', [])
            lista[1].append(m.group(1))
            continue
        vaciar_lista()
        par.append(s)
    vaciar_par(); vaciar_lista(); vaciar_tabla()
    return '\n'.join(out)


def texto_plano(h):
    h = re.sub(r'<annotation[^>]*>.*?</annotation>', ' ', h, flags=re.S)
    h = re.sub(r'<(script|style)[^>]*>.*?</\1>', ' ', h, flags=re.S)
    h = re.sub(r'<[^>]+>', ' ', h)
    h = html.unescape(h)
    h = re.sub(r'\s+', ' ', h).strip()
    return h[:4000]


def registrar(eid, titulo, bloque_titulo, frag):
    IDX.append({'t': titulo, 'id': eid, 'b': bloque_titulo, 'x': texto_plano(frag)})


# ---------------------------------------------------------------- renderizado
def hijos(nodos, ctx):
    out, tarjetas = [], []

    def vaciar():
        if tarjetas:
            out.append('<div class="cards">' + ''.join(tarjetas) + '</div>')
            tarjetas.clear()
    for c in nodos:
        if c['name'] == 'tarjeta':
            tarjetas.append(r_tarjeta(c, ctx))
            continue
        vaciar()
        out.append(render(c, ctx))
    vaciar()
    return '\n'.join(out)


def render(n, ctx):
    f = globals().get('r_' + n['name'].replace('-', '_'))
    if f is None:
        raise SystemExit(f"{n['file']}:{n['line']}: directiva desconocida @{n['name']}")
    return f(n, ctx)


def r_bloque(n, ctx):
    bid, titulo, kicker, color, badge, etiqueta, grupo = pad(n['args'], 7)
    ctx['bloque'] = bid
    ctx['btitulo'] = titulo
    ctx['pn'] = 0
    _stats['ejemplos'] += 0
    ANCLA_BLOQUE[bid] = bid
    subs = []
    ctx['subs'] = subs
    cont = hijos(n['children'], ctx)
    intro = cuerpo(n['body'])
    color = color or '#2456d6'
    badge = badge or ''
    cab = ''
    if titulo:
        cab = (f'<div class="sh"><div class="badge">{en_linea(badge)}</div>' if badge else '<div class="sh">')
        cab += f'<div><div class="kick">{en_linea(kicker)}</div><h2>{en_linea(titulo)}</h2></div></div>'
    TOC.append((grupo or 'Guía', bid, etiqueta or titulo, color, subs))
    return (f'<section class="sec bloque" id="{bid}" data-bloque="{bid}" '
            f'style="--tc:{color};--tcs:color-mix(in srgb,{color} 16%,transparent)">'
            f'{cab}{intro}\n{cont}</section>')


def _envoltura(n, ctx, clase, etiqueta, titulo, tags, cabecera_extra=''):
    eid = n.get('eid') or nuevo_id('ex')
    ANCLA_BLOQUE[eid] = ctx['bloque']
    ctx['pn'] = 0
    etiquetas = ''.join(f'<span class="tag">{en_linea(t.strip())}</span>' for t in tags.split(',') if t.strip())
    intro = cuerpo(n['body'])
    cont = hijos(n['children'], ctx)
    frag = (f'<article class="ex {clase}" id="{eid}" data-s="1">'
            f'<div class="tags"><span class="tag">{etiqueta}</span>{cabecera_extra}{etiquetas}</div>'
            f'<h3>{en_linea(titulo)}</h3>{intro}\n{cont}</article>')
    registrar(eid, titulo, ctx.get('btitulo', ''), frag)
    if ctx.get('subs') is not None and clase in ('ejemplo', 'ejer', 'demo'):
        ctx['subs'].append((eid, titulo))
    return frag


def r_ejemplo(n, ctx):
    titulo, tags = pad(n['args'], 2)
    _stats['ejemplos'] += 1
    return _envoltura(n, ctx, 'ejemplo', 'Ejemplo resuelto', titulo, tags)


def r_demo(n, ctx):
    titulo, tags = pad(n['args'], 2)
    return _envoltura(n, ctx, 'demo', 'Demostración', titulo, tags)


def r_ejercicio(n, ctx):
    eid, titulo, examen, pts, tags = pad(n['args'], 5)
    eid = eid or nuevo_id('ej')
    _stats['ejercicios'] += 1
    n['eid'] = eid
    cab = f'<span class="tag">{en_linea(pts)} pts</span>' if pts else ''
    tags_l = ','.join(t.strip().lower() for t in tags.split(',') if t.strip())
    ctx2 = dict(ctx)
    ctx2['pn'] = 0
    html_ = _envoltura(n, ctx2, 'ejer', en_linea(examen) if examen else 'Ejercicio', titulo, tags, cab)
    html_ = html_.replace(f'<article class="ex ejer" id="{eid}" data-s="1">',
                          f'<article class="ex ejer" id="{eid}" data-s="1" data-exam="{slug(examen)}" data-tags="{tags_l}">', 1)
    ANCLA_BLOQUE[eid] = ctx['bloque']
    return html_


def r_grupo(n, ctx):
    titulo, abierto = pad(n['args'], 2)
    op = ' open' if abierto.strip() == 'abierto' else ''
    return f'<details class="grupo"{op}><summary>{en_linea(titulo)}</summary>{cuerpo(n["body"])}\n{hijos(n["children"], ctx)}</details>'


def r_solucion(n, ctx):
    titulo = pad(n['args'], 1)[0] or 'Ver solución de referencia'
    ctx['pn'] = 0
    return f'<details class="sol"><summary>{en_linea(titulo)}</summary>{cuerpo(n["body"])}\n{hijos(n["children"], ctx)}</details>'


def r_paso(n, ctx):
    titulo = pad(n['args'], 1)[0]
    ctx['pn'] = ctx.get('pn', 0) + 1
    return (f'<details class="paso"><summary><span class="pn">{ctx["pn"]}</span>'
            f'<span>{en_linea(titulo)}</span></summary>{cuerpo(n["body"])}'
            f'\n{hijos(n["children"], ctx)}</details>')


def r_enunciado(n, ctx):
    return f'<div class="box enun"><h4>Enunciado</h4>{cuerpo(n["body"])}</div>'


def r_antes(n, ctx):
    return ('<div class="box antes"><h4>Antes de empezar: qué piden y qué teoría usas</h4>'
            f'{cuerpo(n["body"])}</div>')


def r_resultado(n, ctx):
    titulo = pad(n['args'], 1)[0] or 'Resultado final'
    return f'<details class="resul"><summary>{en_linea(titulo)}</summary>{cuerpo(n["body"])}</details>'


def _caja(clase, titulo_caja, n, ctx, extra=''):
    eid = nuevo_id('b')
    frag = (f'<div class="box {clase}" id="{eid}" data-s="1"><h4>{titulo_caja}</h4>'
            f'{cuerpo(n["body"])}</div>')
    registrar(eid, titulo_caja, ctx.get('btitulo', ''), frag)
    return frag


def r_intuicion(n, ctx):
    return _caja('intu', 'Intuición', n, ctx)


def r_esencial(n, ctx):
    return _caja('key', 'Lo esencial', n, ctx)


def r_trampa(n, ctx):
    return _caja('trap', 'Qué suele fallar', n, ctx)


def r_ojo(n, ctx):
    t = pad(n['args'], 1)[0] or 'errata'
    return _caja('ojo', f'Ojo: {en_linea(t)}', n, ctx)


def r_zero(n, ctx):
    t = pad(n['args'], 1)[0]
    eid = nuevo_id('z')
    frag = (f'<div class="zero" id="{eid}" data-s="1"><h3>Desde cero: {en_linea(t)}</h3>'
            f'{cuerpo(n["body"])}</div>')
    registrar(eid, 'Desde cero: ' + t, ctx.get('btitulo', ''), frag)
    return frag


def r_formula(n, ctx):
    t = pad(n['args'], 1)[0]
    eid = nuevo_id('f')
    frag = f'<div class="formula" id="{eid}" data-s="1"><h4>{en_linea(t)}</h4>{cuerpo(n["body"])}</div>'
    registrar(eid, 'Fórmula: ' + t, ctx.get('btitulo', ''), frag)
    return frag


def r_masfondo(n, ctx):
    t = pad(n['args'], 1)[0]
    eid = nuevo_id('d')
    frag = (f'<details class="deep" id="{eid}" data-s="1"><summary>Más a fondo: {en_linea(t)}</summary>'
            f'{cuerpo(n["body"])}{hijos(n["children"], ctx)}</details>')
    registrar(eid, 'Más a fondo: ' + t, ctx.get('btitulo', ''), frag)
    return frag


def r_test(n, ctx):
    _test[0] += 1
    _stats['tests'] += 1
    k = _test[0]
    q, opts, expl = '', [], ''
    for linea in n['body']:
        s = linea.strip()
        if s.startswith('? '):
            q = s[2:]
        elif s.startswith('* '):
            opts.append((True, s[2:]))
        elif s.startswith('- '):
            opts.append((False, s[2:]))
        elif s.startswith('! '):
            expl = (expl + ' ' + s[2:]).strip()
    if not q or not any(o for o, _ in opts):
        raise SystemExit(f"{n['file']}:{n['line']}: @test incompleto")
    filas = ''.join(
        f'<label><input type="radio" name="t{k}" value="{i}" data-ok="{1 if ok else 0}"> <span>{proteger_y(t)}</span></label>'
        for i, (ok, t) in enumerate(opts))
    eid = nuevo_id('q')
    frag = (f'<div class="test" id="{eid}" data-test data-s="1"><p class="q">{proteger_y(q)}</p>'
            f'<fieldset><legend class="sr-only">Opciones</legend>{filas}</fieldset>'
            f'<div class="res" aria-live="polite"></div>'
            f'<div class="expl" hidden>{cuerpo([expl]) if expl else ""}</div></div>')
    registrar(eid, 'Autoevaluación: ' + q[:60], ctx.get('btitulo', ''), frag)
    return frag


def proteger_y(t):
    """Formato en línea de un texto suelto (con matemáticas)."""
    return en_linea_m(t)


def en_linea_m(t):
    t = proteger_mates(t)
    return en_linea(t)


def r_tarjeta(n, ctx):
    fr, de = pad(n['args'], 2)
    _stats['tarjetas'] += 1
    eid = nuevo_id('c')
    return (f'<button class="card-flip" type="button" id="{eid}" data-s="1" aria-pressed="false">'
            f'<span class="in"><span class="f"><span><span class="kick">Pregunta</span><br>{en_linea_m(fr)}</span></span>'
            f'<span class="b"><span><span class="kick">Respuesta</span><br>{en_linea_m(de)}</span></span></span></button>')


def r_sim(n, ctx):
    sid, titulo = pad(n['args'], 2)
    _stats['sims'] += 1
    return (f'<figure class="simw"><figcaption>{en_linea(titulo)}</figcaption>'
            f'<div class="sim" data-sim="{sid}"></div>{cuerpo(n["body"])}</figure>')


def r_abrirsim(n, ctx):
    sid, texto = pad(n['args'], 2)
    return f'<p><button class="btn pri" type="button" data-open-sim="{sid}">{en_linea(texto)}</button></p>'


def r_fig(n, ctx):
    nombre, pie = pad(n['args'], 2)
    ruta = os.path.join(BUILD, 'fig', nombre + '.svg')
    if not os.path.exists(ruta):
        raise SystemExit(f'falta la figura {ruta}')
    svg = open(ruta, encoding='utf-8').read()
    svg = re.sub(r'<\?xml[^>]*\?>', '', svg).strip()
    return f'<figure class="fig"><figcaption>{en_linea(pie)}</figcaption>{svg}</figure>'


def r_codigo(n, ctx):
    lenguaje, titulo = pad(n['args'], 2)
    cod = html.escape('\n'.join(n['body']).rstrip(), quote=False)
    t = f'<div class="kick">{en_linea(titulo)}</div>' if titulo else ''
    return f'{t}<pre class="code" data-lang="{en_linea(lenguaje)}"><code>{cod}</code></pre>'


def r_consola(n, ctx):
    titulo = pad(n['args'], 1)[0]
    t = f'<div class="kick">{en_linea(titulo)}</div>' if titulo else ''
    return f'{t}<div class="consola">{html.escape(chr(10).join(n["body"]).rstrip(), quote=False)}</div>'


def r_objetivos(n, ctx):
    items = [l.strip()[2:] for l in n['body'] if l.strip().startswith('- ')]
    b = ctx.get('bloque', 'x')
    lis = ''.join(
        f'<label><input type="checkbox" data-chk="{b}-{i}"> <span>{en_linea_m(t)}</span></label>'
        for i, t in enumerate(items, 1))
    return f'<div class="box key"><h4>Objetivos (márcalos cuando los domines)</h4><div class="checks">{lis}</div></div>'


def r_filtros(n, ctx):
    ex, tg = pad(n['args'], 2)
    exs = [e.strip() for e in ex.split(';') if e.strip()]
    tgs = [t.strip() for t in tg.split(';') if t.strip()]
    chips_ex = '<button class="chip" type="button" aria-pressed="true" data-fx="">Todos</button>' + ''.join(
        f'<button class="chip" type="button" aria-pressed="false" data-fx="{slug(e)}">{en_linea(e)}</button>'
        for e in exs)
    chips_tg = ''.join(
        f'<button class="chip" type="button" aria-pressed="false" data-ft="{slug(t)}">{en_linea(t)}</button>'
        for t in tgs)
    return ('<div class="filtros" data-filtros>'
            '<label class="sr-only" for="ftexto">Buscar en exámenes</label>'
            '<input id="ftexto" type="search" placeholder="Buscar en el texto de los exámenes…" autocomplete="off">'
            f'<div class="chips" role="group" aria-label="Examen">{chips_ex}</div>'
            f'<div class="chips" role="group" aria-label="Tema">{chips_tg}</div>'
            '<p class="fcount" aria-live="polite"></p></div>')


def r_lista(n, ctx):
    return cuerpo(n['body'])


def r_estadisticas(n, ctx):
    return '\x01STATS\x01'


def r_botones(n, ctx):
    bs = []
    for l in n['body']:
        p = [x.strip() for x in l.split('|')]
        if len(p) < 2 or not p[0]:
            continue
        clase = 'btn pri' if len(p) > 2 and p[2] == 'pri' else 'btn'
        bs.append(f'<a class="{clase}" href="{p[1]}">{en_linea(p[0])}</a>')
    return '<div class="cta">' + ''.join(bs) + '</div>'


def r_hero(n, ctx):
    eyebrow, titulo, sub = pad(n['args'], 3)
    return (f'<div class="hero"><div class="eyebrow">{en_linea(eyebrow)}</div>'
            f'<h1>{titulo}</h1><p class="sub">{en_linea_m(sub)}</p>'
            f'<div class="fecha">Última actualización: {FECHA}</div>{cuerpo(n["body"])}</div>')


def r_intro(n, ctx):
    return f'<div class="intro">{cuerpo(n["body"])}</div>'


def r_tabla(n, ctx):
    return cuerpo(n['body'])


def r_nota(n, ctx):
    return f'<div class="box enun"><h4>{en_linea(pad(n["args"],1)[0])}</h4>{cuerpo(n["body"])}</div>'


def r_fin(n, ctx):
    raise SystemExit('@fin inesperado')


def r_archivo(n, ctx):
    lenguaje, titulo, ruta = pad(n['args'], 3)
    ruta_abs = os.path.join(ROOT, ruta)
    cod = open(ruta_abs, encoding='utf-8').read().rstrip()
    t_ = f'<div class="kick">{en_linea(titulo)} · <a href="{ruta}">{ruta}</a></div>' if titulo else ''
    return f'{t_}<pre class="code" data-lang="{en_linea(lenguaje)}"><code>{html.escape(cod, quote=False)}</code></pre>'


def r_salida(n, ctx):
    titulo, ruta = pad(n['args'], 2)
    ruta_abs = os.path.join(ROOT, ruta)
    res = subprocess.run([sys.executable, ruta_abs], capture_output=True, text=True, cwd=os.path.dirname(ruta_abs))
    if res.returncode != 0:
        raise SystemExit(f"{n['file']}:{n['line']}: el script {ruta} falla:\n{res.stderr}")
    salida = res.stdout.rstrip()
    t_ = f'<div class="kick">{en_linea(titulo)}</div>' if titulo else ''
    return f'{t_}<div class="consola" data-origen="{ruta}">{html.escape(salida, quote=False)}</div>'


# ---------------------------------------------------------------- páginas
def cargar_bloques():
    bloques = []
    for ruta in sorted(glob.glob(os.path.join(SRC, '*.dsl'))):
        if os.path.basename(ruta).startswith('pdf_'):
            continue
        items = leer_items(ruta)
        if not items or items[0]['name'] != 'bloque':
            raise SystemExit(f'{ruta}: debe empezar por @bloque')
        raiz = construir_arbol(items)
        bloques.append((ruta, raiz))
    return bloques


def cargar_pdf():
    salida = {}
    for ruta in sorted(glob.glob(os.path.join(SRC, 'pdf_*.dsl'))):
        salida[os.path.basename(ruta)[:-4]] = construir_arbol(leer_items(ruta))
    return salida


def generar():
    _n[0] = 0
    _test[0] = 0
    for k in _stats:
        _stats[k] = 0
    MATHS.clear(); IDX.clear(); ANCLA_BLOQUE.clear(); TOC.clear(); _warn.clear()
    secciones = []
    for ruta, raiz in cargar_bloques():
        ctx = {}
        for nodo in raiz['children']:
            secciones.append(render(nodo, ctx))
    return secciones


def render_math():
    entrada = os.path.join(BUILD, '_math_in.json')
    salida = os.path.join(BUILD, '_math_out.json')
    with open(entrada, 'w', encoding='utf-8') as f:
        json.dump([[t, d] for t, d in MATHS], f, ensure_ascii=False)
    subprocess.run(['node', os.path.join(BUILD, 'render_math.js'), entrada, salida], check=True)
    with open(salida, encoding='utf-8') as f:
        res = json.load(f)
    errores = sum(1 for r in res if 'katex-error' in r)
    if errores:
        print(f'AVISO: {errores} fórmulas con error de KaTeX', file=sys.stderr)
    return res


def sustituir_mates(texto, res):
    return re.sub(r'\x00(\d+)\x00', lambda m: res[int(m.group(1))], texto)


def css_katex(fuentes_embebidas):
    css = open(os.path.join(KATEX, 'katex.min.css'), encoding='utf-8').read()
    if fuentes_embebidas:
        def emb(m):
            ruta = os.path.join(KATEX, 'fonts', m.group(1) + '.woff2')
            b = base64.b64encode(open(ruta, 'rb').read()).decode()
            return f'url(data:font/woff2;base64,{b})'
        css = re.sub(r'url\(fonts/([^)]+)\.woff2\)', emb, css)
    css = re.sub(r',\s*url\(fonts/[^)]+\)\s*format\("(woff|truetype)"\)', '', css)
    return css


def toc_html(modo, pagina_de):
    grupos = {}
    for grupo, bid, etiqueta, color, subs in TOC:
        grupos.setdefault(grupo, []).append((bid, etiqueta, color, subs))
    h = ''
    for g, items in grupos.items():
        h += f'<h4>{en_linea(g)}</h4>'
        for bid, etiqueta, color, subs in items:
            h += f'<a href="{pagina_de(bid, bid)}" style="--tc:{color}"><span class="dot"></span>{en_linea(etiqueta)}</a>'
            for aid, at in subs[:12]:
                h += f'<a class="sub2" href="{pagina_de(bid, aid)}" style="font-size:.84rem;padding-left:26px;color:var(--muted)">{en_linea(at)}</a>'
    return h


def nav_html(pagina_de):
    enlaces = []
    for grupo, bid, etiqueta, color, subs in TOC:
        enlaces.append(f'<a href="{pagina_de(bid, bid)}" data-nav="{bid}">{en_linea(etiqueta)}</a>')
    return ''.join(enlaces)


def pagina_maestra(secciones, res):
    css = open(os.path.join(BUILD, 'style.css'), encoding='utf-8').read()
    js = open(os.path.join(BUILD, 'sims.js'), encoding='utf-8').read() + '\n' + open(os.path.join(BUILD, 'app.js'), encoding='utf-8').read()
    cuerpo_ = '\n'.join(secciones)
    cuerpo_ = cuerpo_.replace('\x01STATS\x01', stats_html())
    cuerpo_ = sustituir_mates(cuerpo_, res)
    idx = json.dumps(IDX, ensure_ascii=False).replace('</', '<\\/')
    pag = lambda bid, anc: '#' + anc
    doc = f'''<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{TITULO}</title>
<meta name="description" content="Guía de estudio de Termodinámica Aplicada (521102006): teoría desde cero, ejemplos, exámenes resueltos, simuladores y autoevaluación. Actualizada el {FECHA}.">
<meta name="theme-color" content="#2456d6">
<meta name="color-scheme" content="light dark">
<link rel="manifest" href="manifest.json">
<style>
{css_katex(True)}
{css}
</style>
</head>
<body data-version="{FECHA}">
<a class="skip" href="#principal">Saltar al contenido</a>
<header class="topbar"><div class="in">
  <a class="brand" href="#inicio">{TITULO}<small class="fecha-cab">Actualizada el {FECHA_CORTA}</small></a>
  <nav aria-label="Secciones">{nav_html(pag)}</nav>
  <div class="search"><label class="sr-only" for="gsearch">Buscar en la guía</label>
    <input id="gsearch" type="search" placeholder="Buscar en la guía…" autocomplete="off" data-index="">
    <div class="sres" hidden role="listbox" aria-label="Resultados"></div></div>
  <button class="btn theme-btn" type="button" id="tema" aria-label="Cambiar tema claro/oscuro">Tema</button>
</div></header>
<div class="wrap">
  <aside class="toc" aria-label="Índice">{toc_html('master', pag)}</aside>
  <main id="principal">
{cuerpo_}
  </main>
</div>
<footer class="foot"><div>{TITULO} · Grado en Ingeniería Biomédica · UPCT · curso 2026-27 · Guía de estudio.</div>
<div>Última actualización: {FECHA}. Las soluciones son de referencia y se verifican con código; los simuladores son aproximaciones didácticas.</div></footer>
<script type="application/json" id="sindex">{idx}</script>
<script>
{js}
</script>
</body>
</html>
'''
    return doc


def pagina_sitio(bid, secciones_por_bloque, res, pag_map):
    css = '<link rel="stylesheet" href="katex.css"><link rel="stylesheet" href="style.css">'
    def pag(b, anc):
        pagina = pag_map.get(anc) or b or 'index'
        return pagina + '.html' + ('#' + anc if anc != pagina else '')
    cuerpo_ = secciones_por_bloque[bid]
    cuerpo_ = cuerpo_.replace('\x01STATS\x01', stats_html())
    cuerpo_ = sustituir_mates(cuerpo_, res)
    cuerpo_ = re.sub(r'href="#([^"]+)"', lambda m: f'href="{pag(None, m.group(1))}"', cuerpo_)
    titulo_pag = next(t for g, b, t, c, s in TOC if b == bid)
    nombre_archivo = 'index' if bid == 'inicio' else bid
    doc = f'''<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{html.escape(titulo_pag)} · {TITULO}</title>
<meta name="description" content="Termodinámica Aplicada: {html.escape(titulo_pag)}. Actualizada el {FECHA}.">
<meta name="theme-color" content="#2456d6">
<meta name="color-scheme" content="light dark">
<link rel="manifest" href="manifest.json">
<link rel="icon" href="icon-192.png">
{css}
</head>
<body data-index="search-index.json" data-page="{nombre_archivo}">
<a class="skip" href="#principal">Saltar al contenido</a>
<header class="topbar"><div class="in">
  <a class="brand" href="index.html">{TITULO}<small class="fecha-cab">Actualizada el {FECHA_CORTA}</small></a>
  <nav aria-label="Secciones">{nav_html(lambda b, a: pag(b, a))}</nav>
  <div class="search"><label class="sr-only" for="gsearch">Buscar en la guía</label>
    <input id="gsearch" type="search" placeholder="Buscar en la guía…" autocomplete="off">
    <div class="sres" hidden role="listbox" aria-label="Resultados"></div></div>
  <button class="btn theme-btn" type="button" id="tema" aria-label="Cambiar tema claro/oscuro">Tema</button>
</div></header>
<div class="wrap">
  <aside class="toc" aria-label="Índice">{toc_html('site', lambda b, a: pag(b, a))}</aside>
  <main id="principal">
{cuerpo_}
  </main>
</div>
<footer class="foot"><div>{TITULO} · Grado en Ingeniería Biomédica · UPCT · curso 2026-27.</div>
<div>Última actualización: {FECHA}.</div></footer>
<script src="sims.js" defer></script>
<script src="app.js" defer></script>
</body>
</html>
'''
    return doc, nombre_archivo


def escribir_sitio(secciones_por_bloque, res, pag_map):
    if os.path.isdir(SITE):
        for f in glob.glob(os.path.join(SITE, '*.html')):
            os.remove(f)
    os.makedirs(SITE, exist_ok=True)
    for b in secciones_por_bloque:
        doc, nombre = pagina_sitio(b, secciones_por_bloque, res, pag_map)
        with open(os.path.join(SITE, nombre + '.html'), 'w', encoding='utf-8') as f:
            f.write(doc)
    shutil.copy(os.path.join(BUILD, 'style.css'), os.path.join(SITE, 'style.css'))
    shutil.copy(os.path.join(BUILD, 'app.js'), os.path.join(SITE, 'app.js'))
    shutil.copy(os.path.join(BUILD, 'sims.js'), os.path.join(SITE, 'sims.js'))
    with open(os.path.join(SITE, 'katex.css'), 'w', encoding='utf-8') as f:
        f.write(css_katex(False))
    fd = os.path.join(SITE, 'fonts')
    os.makedirs(fd, exist_ok=True)
    for ff in glob.glob(os.path.join(KATEX, 'fonts', '*.woff2')):
        shutil.copy(ff, fd)
    with open(os.path.join(SITE, 'search-index.json'), 'w', encoding='utf-8') as f:
        json.dump(IDX, f, ensure_ascii=False)
    escribir_pwa(secciones_por_bloque)
    print('site: páginas', len(secciones_por_bloque))


def escribir_pwa(secciones_por_bloque):
    from PIL import Image, ImageDraw, ImageFont
    manifest = {
        'name': TITULO + ' · Guía de estudio',
        'short_name': 'Guía TA',
        'description': 'Guía de estudio de Termodinámica Aplicada (521102006), UPCT, curso 2026-27.',
        'lang': 'es',
        'start_url': './index.html',
        'scope': './',
        'display': 'standalone',
        'background_color': '#ffffff',
        'theme_color': '#2456d6',
        'icons': [
            {'src': 'icon-192.png', 'sizes': '192x192', 'type': 'image/png', 'purpose': 'any maskable'},
            {'src': 'icon-512.png', 'sizes': '512x512', 'type': 'image/png', 'purpose': 'any maskable'},
        ],
    }
    with open(os.path.join(SITE, 'manifest.json'), 'w', encoding='utf-8') as f:
        json.dump(manifest, f, ensure_ascii=False, indent=2)
    for tam in (192, 512):
        im = Image.new('RGB', (tam, tam), '#2456d6')
        d = ImageDraw.Draw(im)
        try:
            fuente = ImageFont.load_default(size=int(tam * 0.62))
        except TypeError:
            fuente = ImageFont.load_default()
        d.text((tam / 2, tam / 2 + tam * 0.02), 'T', fill='white', font=fuente, anchor='mm')
        im.save(os.path.join(SITE, f'icon-{tam}.png'))
    archivos = ['./', 'index.html', 'style.css', 'katex.css', 'app.js', 'sims.js', 'search-index.json',
                'manifest.json', 'icon-192.png', 'icon-512.png']
    archivos += sorted(os.path.basename(p) for p in glob.glob(os.path.join(SITE, '*.html')) if os.path.basename(p) != 'index.html')
    archivos += sorted('fonts/' + os.path.basename(p) for p in glob.glob(os.path.join(SITE, 'fonts', '*.woff2')))
    lista = ',\n  '.join(repr(a) for a in archivos)
    sw = f"""// Caché sin conexión de la guía. Versión: {FECHA_CORTA}
const VERSION = 'termo-2026-11-08';
const ARCHIVOS = [
  {lista}
];
self.addEventListener('install', (e) => {{
  e.waitUntil(caches.open(VERSION).then((c) => c.addAll(ARCHIVOS)).then(() => self.skipWaiting()));
}});
self.addEventListener('activate', (e) => {{
  e.waitUntil(caches.keys()
    .then((ks) => Promise.all(ks.filter((k) => k !== VERSION).map((k) => caches.delete(k))))
    .then(() => self.clients.claim()));
}});
self.addEventListener('fetch', (e) => {{
  if (e.request.method !== 'GET') return;
  e.respondWith(caches.match(e.request).then((hit) => hit || fetch(e.request).then((resp) => {{
    if (resp.ok) {{ const copia = resp.clone(); caches.open(VERSION).then((c) => c.put(e.request, copia)).catch(() => {{}}); }}
    return resp;
  }}).catch(() => caches.match('index.html'))));
}});
"""
    with open(os.path.join(SITE, 'sw.js'), 'w', encoding='utf-8') as f:
        f.write(sw)


def stats_html():
    return (f'<div class="stats"><div class="stat"><b>11</b><span>temas explicados desde cero</span></div>'
            f'<div class="stat"><b>{_stats["ejercicios"]}</b><span>ejercicios resueltos</span></div>'
            f'<div class="stat"><b>{_stats["sims"]}</b><span>simuladores interactivos</span></div>'
            f'<div class="stat"><b>{_stats["tests"]}</b><span>preguntas de autoevaluación</span></div></div>')


def main():
    _n[0] = 0; _test[0] = 0
    MATHS.clear(); IDX.clear(); ANCLA_BLOQUE.clear(); TOC.clear()
    for k in _stats:
        _stats[k] = 0
    por_bloque = {}
    for ruta, raiz in cargar_bloques():
        ctx = {}
        por_bloque[leer_bid(raiz)] = '\n'.join(render(nodo, ctx) for nodo in raiz['children'])
    # Documentos PDF independientes: se renderizan aparte y no entran en la guía HTML.
    snap = (len(IDX), len(TOC), dict(ANCLA_BLOQUE))
    pdfs = {}
    for nombre, raiz in cargar_pdf().items():
        ctx = {}
        pdfs[nombre] = '\n'.join(render(nodo, ctx) for nodo in raiz['children'])
    del IDX[snap[0]:]
    del TOC[snap[1]:]
    ANCLA_BLOQUE.clear(); ANCLA_BLOQUE.update(snap[2])
    res = render_math()
    pag_map = {anc: ('index' if b == 'inicio' else b) for anc, b in ANCLA_BLOQUE.items()}
    for e in IDX:
        e['u'] = pag_map.get(e['id'], 'index') + '.html#' + e['id']
        e['u'] = e['u'].replace('.html#' + e['id'], '.html#' + e['id'])
    os.makedirs(OUT, exist_ok=True)
    maestro = pagina_maestra(list(por_bloque.values()), res)
    with open(os.path.join(OUT, MAESTRO), 'w', encoding='utf-8') as f:
        f.write(maestro)
    print('maestro:', os.path.join(OUT, MAESTRO), len(maestro) // 1024, 'KB')
    os.makedirs(PDFDIR, exist_ok=True)
    with open(os.path.join(PDFDIR, 'guia.html'), 'w', encoding='utf-8') as f:
        f.write(maestro)
    with open(os.path.join(PDFDIR, 'examenes.html'), 'w', encoding='utf-8') as f:
        f.write(pagina_maestra([por_bloque['examenes']], res))
    for nombre, cuerpo_pdf in pdfs.items():
        with open(os.path.join(PDFDIR, nombre + '.html'), 'w', encoding='utf-8') as f:
            f.write(pagina_maestra([cuerpo_pdf], res))
    print('pdf html:', ', '.join(['guia', 'examenes'] + list(pdfs)))
    escribir_sitio(por_bloque, res, pag_map)
    if _warn:
        print('\n'.join(_warn))


def leer_bid(raiz):
    return raiz['children'][0]['args'][0]


if __name__ == '__main__':
    main()
