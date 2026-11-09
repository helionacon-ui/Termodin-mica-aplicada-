#!/usr/bin/env python3
"""Convierte los exámenes resueltos de la guía (src/14_examenes.dsl) en un documento LaTeX.

Cada solución va en una capa opcional (ocgx2) que empieza oculta: el enunciado siempre se ve;
los pasos, el resultado y las notas «Ojo:» se muestran u ocultan desde el panel de capas del visor.
"""
import re
import sys
import unicodedata

SRC = '/home/claude/work/guia/src/14_examenes.dsl'
OUT = '/home/claude/work/latex/examenes.tex'

DIR = re.compile(r'^@([a-zñ]+)\b[ \t]*(.*)$')

# Símbolos Unicode que aparecen dentro de fórmulas: se pasan a comandos LaTeX.
MATH_UNI = {
    'η': r'\eta', 'ω': r'\omega', 'Δ': r'\Delta', 'ρ': r'\rho', 'γ': r'\gamma',
    'ε': r'\varepsilon', 'σ': r'\sigma', 'θ': r'\theta', 'μ': r'\mu',
    '≈': r'\approx', '→': r'\to', '⇒': r'\Rightarrow', '−': '-', '·': r'\cdot',
    'ṁ': r'\dot{m}', 'Ṡ': r'\dot{S}', 'Ẇ': r'\dot{W}', 'Q̇': r'\dot{Q}',
    '°': r'^{\circ}', '²': '^2', '³': '^3', '⁻': '^-',
    '₁': '_1', '₂': '_2', '₃': '_3', '₄': '_4', '₅': '_5', '₆': '_6', '₇': '_7', '₈': '_8', '₉': '_9', '₀': '_0',
}


def nombre_capa(texto):
    """Nombre de capa sin acentos: algunos visores muestran mal los nombres en UTF-8 dentro del PDF."""
    t = unicodedata.normalize('NFKD', texto)
    t = ''.join(c for c in t if not unicodedata.combining(c))
    t = t.replace('°', ' grados').replace('≈', 'aprox ').replace('%', ' por ciento').replace('#', ' num').replace('&', ' y ')
    t = re.sub(r'[^\x20-\x7e]', '', t)
    return t.strip()


def esc_texto(s):
    """Texto (fuera de fórmulas): escapa caracteres de LaTeX y convierte X_Y en subíndice."""
    s = s.replace('\\', r'\textbackslash{}')
    s = s.replace('&', r'\&').replace('%', r'\%').replace('#', r'\#')
    s = s.replace('~', r'\textasciitilde{}')
    s = re.sub(r'\*\*(.+?)\*\*', r'\\textbf{\1}', s)
    s = re.sub(r'`([^`]+)`', r'\\texttt{\1}', s)
    s = re.sub(r'\[([^\]]+)\]\(#[^)]*\)', r'\1', s)
    # subíndices escritos con guion bajo fuera de fórmula (p. ej. ṁ_AP): X_AP -> X$_{AP}$
    s = re.sub(r'(?<=[\w)\u0300-\u036f])_([A-Za-z0-9]+)', lambda m: '$_{' + m.group(1) + '}$', s)
    return s


def mates(tex):
    """Fórmula: convierte símbolos Unicode que LaTeX no admite dentro de modo matemático.
    El texto dentro de \\text{...} se deja tal cual (la fuente de texto sí tiene °, ², etc.)."""
    trozos = re.split(r'(\\text\{[^{}]*\})', tex)
    salida = []
    for t in trozos:
        if t.startswith('\\text{'):
            salida.append(t)
            continue
        for k, v in MATH_UNI.items():
            t = t.replace(k, v)
        salida.append(t)
    return ''.join(salida)


def parrafo(texto):
    """Un párrafo con texto y fórmulas ($...$ y $$...$$)."""
    partes = re.split(r'(\$\$.+?\$\$|\$[^$\n]+?\$)', texto, flags=re.S)
    out = []
    for p in partes:
        if not p:
            continue
        if p.startswith('$$'):
            out.append('\\[' + mates(p[2:-2].strip()) + '\\]')
        elif p.startswith('$'):
            out.append('$' + mates(p[1:-1].strip()) + '$')
        else:
            out.append(esc_texto(p))
    return ' '.join(out).replace(' \\]', '\\]').replace('\\[ ', '\\[')


def cuerpo(lineas):
    """Líneas de cuerpo -> bloques LaTeX (párrafos y listas)."""
    bloques, actual = [], []
    for l in lineas + ['']:
        if l.strip() == '':
            if actual:
                bloques.append(actual)
                actual = []
        else:
            actual.append(l.strip())
    out = []
    for b in bloques:
        if all(x.startswith('- ') for x in b):
            items = '\n'.join('\\item ' + parrafo(x[2:]) for x in b)
            out.append('\\begin{itemize}[leftmargin=1.2em,itemsep=2pt]\n' + items + '\n\\end{itemize}')
        else:
            out.append(parrafo(' '.join(b)))
    return '\n\n'.join(out)


def leer_items(ruta):
    items, cur = [], None
    with open(ruta, encoding='utf-8') as f:
        for linea in f:
            linea = linea.rstrip('\n').rstrip()
            if linea.startswith('%%'):
                continue
            m = DIR.match(linea)
            if m:
                args = [a.strip() for a in m.group(2).split('|')] if m.group(2).strip() else []
                cur = {'name': m.group(1), 'args': args, 'body': []}
                items.append(cur)
            elif cur is not None:
                cur['body'].append(linea)
    return items


PREAMBULO = r'''\documentclass[11pt,a4paper]{article}
\usepackage{fontspec}
\setmainfont{DejaVu Serif}[Scale=0.93]
\usepackage{polyglossia}
\setmainlanguage{spanish}
\usepackage{amsmath,amssymb}
\usepackage[a4paper,margin=2.1cm,top=2.2cm,bottom=2.2cm]{geometry}
\usepackage{xcolor}
\definecolor{lila}{HTML}{6B4FBB}
\definecolor{lilasuave}{HTML}{F2EEFB}
\definecolor{ambar}{HTML}{9A6412}
\definecolor{ambarsuave}{HTML}{FFF7E0}
\usepackage[most,breakable]{tcolorbox}
\newtcolorbox{resbox}{colback=lilasuave,colframe=lila,title={Resultado},fonttitle=\bfseries,breakable,boxrule=0.6pt}
\newtcolorbox{ojobox}[1]{colback=ambarsuave,colframe=ambar,title={Ojo: #1},fonttitle=\bfseries,breakable,boxrule=0.6pt}
\newtcolorbox{antesbox}{colback=gray!6,colframe=gray!55,title={Antes de empezar},fonttitle=\bfseries,breakable,boxrule=0.6pt}
\usepackage{enumitem}
\usepackage[bookmarksnumbered,hidelinks]{hyperref}
\usepackage{ocgx2}
\hypersetup{pdftitle={Exámenes resueltos de Termodinámica Aplicada},pdfauthor={Guía de estudio}}
\setlength{\parindent}{0pt}
\setlength{\parskip}{5pt}
\begin{document}
'''


def generar():
    items = leer_items(SRC)
    partes = []
    intro = ''
    for it in items:
        if it['name'] == 'bloque':
            # la frase introductoria es la primera línea de texto del bloque
            for l in it['body']:
                if l.strip() and not l.startswith(('-', '|', '@')):
                    intro = l.strip()
                    break
    partes.append(r'''\begin{center}
{\LARGE\bfseries Exámenes resueltos}\\[4pt]
{\large Termodinámica Aplicada · Grado en Ingeniería Biomédica · UPCT}
\end{center}
\vspace{4pt}
''')
    partes.append(r'\noindent ' + parrafo(intro) + '\n\n')
    partes.append(r'''\noindent\textbf{Cómo usar este PDF.} Los enunciados se ven siempre. Cada solución está en una capa
oculta: en el panel de capas del visor (en Adobe Acrobat, Ver › Mostrar u ocultar › Árbol de navegación › Capas)
activa la solución que quieras ver. Si el visor no tiene panel de capas, las soluciones no se muestran.

''')

    en_ejercicio = False
    en_capa = False
    ids_capa = set()

    def cerrar_capa():
        nonlocal en_capa
        if en_capa:
            partes.append('\\hspace{0pt}\\end{ocg}\n\n')
            en_capa = False

    def abrir_capa(titulo, ident):
        nonlocal en_capa
        if not en_capa:
            base = nombre_capa(titulo)
            partes.append('\\begin{ocg}{Solucion: ' + base + '}{' + ident + '}{off}\n')
            en_capa = True

    for it in items:
        n = it['name']
        a = it['args']
        if n == 'grupo':
            cerrar_capa()
            if en_ejercicio:
                en_ejercicio = False
            partes.append('\\section{' + esc_texto(a[0]) + '}\n\n')
        elif n == 'ejercicio':
            cerrar_capa()
            ident, titulo, examen, puntos, temas = (a + [''] * 5)[:5]
            en_ejercicio = True
            partes.append('\\subsection{' + esc_texto(titulo) + '}\n')
            meta = 'Examen: ' + esc_texto(examen) + ' · Puntuación: ' + esc_texto(puntos) + ' puntos'
            if temas:
                meta += ' · Temas: ' + esc_texto(temas.replace(',', ', '))
            partes.append('\\noindent\\textit{' + meta + '}\\par\\medskip\n\n')
            # Capa de solución identificada por el id de la guía
            ids_capa.add(ident)
            ejercicio_actual = (ident, titulo)
        elif n == 'enunciado':
            partes.append(cuerpo(it['body']) + '\n\n')
        elif n == 'antes':
            abrir_capa(ejercicio_actual[1], 'sol-' + ejercicio_actual[0])
            partes.append('\\begin{antesbox}\n' + cuerpo(it['body']) + '\n\\end{antesbox}\n\n')
        elif n == 'paso':
            abrir_capa(ejercicio_actual[1], 'sol-' + ejercicio_actual[0])
            partes.append('\\par\\medskip\\noindent\\textbf{' + esc_texto(a[0]) + '.}\\par\n' + cuerpo(it['body']) + '\n\n')
        elif n == 'resultado':
            abrir_capa(ejercicio_actual[1], 'sol-' + ejercicio_actual[0])
            partes.append('\\begin{resbox}\n' + cuerpo(it['body']) + '\n\\end{resbox}\n\n')
        elif n == 'ojo':
            abrir_capa(ejercicio_actual[1], 'sol-' + ejercicio_actual[0])
            partes.append('\\begin{ojobox}{' + esc_texto(a[0]) + '}\n' + cuerpo(it['body']) + '\n\\end{ojobox}\n\n')
        elif n == 'fin':
            if en_ejercicio:
                cerrar_capa()
                en_ejercicio = False
            # fin de grupo o de bloque: no hay nada que hacer aquí
        # resto de directivas (bloque, esencial, zero, filtros) no forman parte del PDF

    cerrar_capa()
    return PREAMBULO + ''.join(partes) + '\\end{document}\n'


if __name__ == '__main__':
    tex = generar()
    with open(OUT, 'w', encoding='utf-8') as f:
        f.write(tex)
    print('escrito', OUT, len(tex), 'caracteres')
