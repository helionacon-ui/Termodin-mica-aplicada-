"""Comprobaciones de la guía con Playwright: consola, desbordes en móvil, simuladores, búsqueda, filtros y autoevaluación."""
import http.server, os, sys, threading, json, functools
from playwright.sync_api import sync_playwright

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = os.path.join(ROOT, 'site')
OUT = os.path.join(ROOT, 'out')
SHOTS = sys.argv[1] if len(sys.argv) > 1 else '/tmp/claude-0/-home-claude/20df35d4-eba7-52e9-bf5c-0a0eeade66b2/scratchpad/shots'
os.makedirs(SHOTS, exist_ok=True)

class Silencioso(http.server.SimpleHTTPRequestHandler):
    def log_message(self, *a, **k):
        pass
handler = functools.partial(Silencioso, directory=SITE)
srv = http.server.ThreadingHTTPServer(('127.0.0.1', 0), handler)
threading.Thread(target=srv.serve_forever, daemon=True).start()
BASE = f'http://127.0.0.1:{srv.server_address[1]}'

informe = []
def ok(nombre, cond, detalle=''):
    informe.append({'prueba': nombre, 'ok': bool(cond), 'detalle': detalle})

DESBORDE_JS = """() => {
  const W = window.innerWidth; const malos = [];
  document.querySelectorAll('body *').forEach(el => {
    const r = el.getBoundingClientRect();
    if (r.width === 0) return;
    if (r.right > W + 1) {
      let p = el.parentElement, cortado = false;
      while (p && p !== document.body) {
        const st = getComputedStyle(p);
        if (/(auto|hidden|scroll)/.test(st.overflowX)) { cortado = true; break; }
        p = p.parentElement;
      }
      if (!cortado) malos.push((el.className && el.className.baseVal === undefined ? el.className : el.tagName) + ' ' + Math.round(r.right));
    }
  });
  return { scroll: document.documentElement.scrollWidth, ancho: W, malos: malos.slice(0, 8) };
}"""

with sync_playwright() as pw:
    navegador = pw.chromium.launch()
    paginas = ['index.html', 't01.html', 't02.html', 't03.html', 't04.html', 't05.html', 't06.html',
               't07.html', 't08.html', 't09.html', 't10.html', 't11.html', 'examen.html', 'examenes.html',
               'practicas.html', 'demos.html', 'autoevaluacion.html', 'simulacros.html', 'formulario.html',
               'glosario.html', 'plan.html']
    for ancho, nombre_vista in ((1280, 'escritorio'), (390, 'movil')):
        ctx = navegador.new_context(viewport={'width': ancho, 'height': 900}, color_scheme='light')
        for pag in paginas:
            page = ctx.new_page()
            errores = []
            page.on('console', lambda m, errores=errores: errores.append(m.text) if m.type == 'error' else None)
            page.on('pageerror', lambda e, errores=errores: errores.append(str(e)))
            page.goto(f'{BASE}/{pag}', wait_until='networkidle')
            page.wait_for_timeout(300)
            ok(f'consola sin errores {pag} ({nombre_vista})', not errores, '; '.join(errores)[:300])
            d = page.evaluate(DESBORDE_JS)
            ok(f'sin desborde horizontal {pag} ({nombre_vista})', d['scroll'] <= d['ancho'] + 1 and not d['malos'],
               f"scroll={d['scroll']} ancho={d['ancho']} {d['malos']}")
            if pag in ('index.html', 't01.html', 'examenes.html', 'simulacros.html'):
                page.screenshot(path=os.path.join(SHOTS, f'{nombre_vista}-{pag[:-5]}.png'), full_page=False)
            page.close()
        ctx.close()

    # Funciones (escritorio)
    ctx = navegador.new_context(viewport={'width': 1280, 'height': 900})
    page = ctx.new_page()
    errores = []
    page.on('pageerror', lambda e: errores.append(str(e)))
    page.on('console', lambda m: errores.append(m.text) if m.type == 'error' else None)
    # simuladores: cada uno debe reaccionar a su control deslizante, en todas las páginas
    pares = []
    for pag in paginas:
        page.goto(f'{BASE}/{pag}', wait_until='networkidle')
        pares += [(pag, s) for s in page.evaluate("() => Array.from(document.querySelectorAll('[data-sim]')).map(e => e.getAttribute('data-sim'))")]
    ok('simuladores presentes en la guía', len(pares) > 0, f'{len(pares)} simuladores')
    for pag, sid in pares:
        page.goto(f'{BASE}/{pag}', wait_until='networkidle')
        res = page.evaluate("""(sid) => {
          const el = document.querySelector(`[data-sim="${sid}"]`);
          const r = el.querySelector('input[type=range]');
          if (!r) return {ok: false, motivo: 'sin control deslizante'};
          const antes = el.innerText;
          const mid = (+r.min + +r.max) / 2 || +r.value;
          const vals = [r.min, r.max, r.value].map(Number);
          const nuevo = vals.find(v => String(v) !== String(r.value)) ?? r.value;
          r.value = nuevo; r.dispatchEvent(new Event('input', {bubbles: true}));
          const despues = el.innerText;
          return {ok: antes !== despues, motivo: antes === despues ? 'el texto no cambia' : ''};
        }""", sid)
        ok(f'simulador reacciona: {sid} ({pag})', res['ok'], res.get('motivo', ''))
    # búsqueda en el maestro
    page.goto(f'{BASE}/index.html', wait_until='networkidle')
    page.fill('#gsearch', 'carnot')
    page.wait_for_timeout(300)
    n = page.locator('.sres button').count()
    ok('búsqueda "carnot" devuelve resultados (site)', n > 0, f'{n} resultados')
    page.fill('#gsearch', 'zzzqqq')
    page.wait_for_timeout(200)
    ok('búsqueda sin resultados muestra mensaje', page.locator('.sres .nores').count() == 1)
    # tema claro/oscuro
    page.click('#tema')
    ok('botón de tema cambia data-theme', page.evaluate("() => document.documentElement.getAttribute('data-theme')") == 'dark')
    page.click('#tema')
    # filtros de exámenes
    page.goto(f'{BASE}/examenes.html', wait_until='networkidle')
    total_txt = page.locator('.fcount').first.inner_text()
    page.locator('[data-fx]').filter(has_text='Segundo').first.click()
    page.wait_for_timeout(200)
    txt2 = page.locator('.fcount').first.inner_text()
    ok('filtro de examen cambia el recuento', total_txt != txt2, f'{total_txt} -> {txt2}')
    page.locator('[data-fx]').filter(has_text='Segundo').first.click()
    page.locator('[data-ft]').first.click()
    page.wait_for_timeout(200)
    ok('filtro por tema aplica', page.locator('.fcount').first.inner_text() != total_txt)
    # autoevaluación: respuesta correcta
    page.goto(f'{BASE}/autoevaluacion.html', wait_until='networkidle')
    corr = page.locator('input[type=radio][data-ok="1"]').first
    corr.check()
    page.wait_for_timeout(150)
    txt = page.locator('.test .res').first.inner_text()
    ok('autoevaluación marca la respuesta correcta', 'Correcta' in txt, txt)
    ok('errores de consola en pruebas funcionales', not errores, '; '.join(errores)[:300])
    # tarjeta de repaso
    tarj = page.locator('.card-flip').first
    if tarj.count():
        tarj.click()
        ok('tarjeta de repaso se voltea', 'flipped' in (tarj.get_attribute('class') or ''))
    ctx.close()
    navegador.close()

srv.shutdown()
fallos = [x for x in informe if not x['ok']]
print(f'{len(informe)} pruebas, {len(fallos)} fallos')
for x in informe:
    if not x['ok'] or '-v' in sys.argv:
        print(('OK  ' if x['ok'] else 'FALLO ') + x['prueba'] + (' :: ' + x['detalle'] if x['detalle'] else ''))
with open(os.path.join(SHOTS, 'informe.json'), 'w', encoding='utf-8') as f:
    json.dump(informe, f, ensure_ascii=False, indent=1)
