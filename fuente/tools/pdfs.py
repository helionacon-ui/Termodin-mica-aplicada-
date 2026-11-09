"""Genera los PDF a partir de build/pdf/*.html: guía con marcadores, examenes resueltos y formulario de una página.
Los simuladores se sustituyen por capturas, y todos los desplegables se abren para que la solución sea visible."""
import os, re, subprocess, sys, base64, io
from playwright.sync_api import sync_playwright
from pypdf import PdfReader, PdfWriter

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PDFDIR = os.path.join(ROOT, 'build', 'pdf')
OUT = os.path.join(ROOT, 'out', 'pdf')
os.makedirs(OUT, exist_ok=True)
FECHA = '8 nov 2026'

CABECERA = '<div style="font-size:7.5px;width:100%;padding:0 12mm;color:#667;text-align:right">Termodinámica Aplicada · 521102006 · Grado en Ingeniería Biomédica · UPCT · curso 2026-27</div>'
PIE = ('<div style="font-size:7.5px;width:100%;padding:0 12mm;color:#667;display:flex;justify-content:space-between">'
       f'<span>Actualizada el {FECHA}</span><span><span class="pageNumber"></span> / <span class="totalPages"></span></span></div>')

def preparar(page):
    page.evaluate("() => { document.querySelectorAll('details').forEach(d => d.open = true); }")
    page.evaluate("() => document.fonts.ready.then(() => true)")
    sims = page.query_selector_all('[data-sim]')
    for el in sims:
        png = el.screenshot(type='png')
        src = 'data:image/png;base64,' + base64.b64encode(png).decode()
        el.evaluate("(el, src) => { el.innerHTML = '<img alt=\"Captura del simulador\" src=\"' + src + '\">'; el.removeAttribute('data-sim'); }", src)
    page.wait_for_timeout(200)

def imprimir(pw, html, destino, escala=1.0, margen='16mm', cabecera=True):
    nav = pw.chromium.launch()
    pg = nav.new_page(viewport={'width': 1000, 'height': 1200})
    pg.goto('file://' + html, wait_until='load')
    preparar(pg)
    pg.emulate_media(media='print')
    pg.pdf(path=destino, format='A4', print_background=True, scale=escala,
           margin={'top': '20mm', 'bottom': '18mm', 'left': '14mm', 'right': '14mm'},
           display_header_footer=cabecera, header_template=CABECERA if cabecera else '<span></span>',
           footer_template=PIE if cabecera else '<span></span>')
    nav.close()

def marcadores(pw, html, pdf_in, pdf_out, titulo):
    nav = pw.chromium.launch()
    pg = nav.new_page()
    pg.goto('file://' + html, wait_until='load')
    encabezados = pg.evaluate("() => Array.from(document.querySelectorAll('main h2, main h3')).map(h => [h.tagName, h.innerText.replace(/\\s+/g, ' ').trim()])")
    nav.close()
    lector = PdfReader(pdf_in)
    textos = [re.sub(r'\s+', '', (p.extract_text() or '')).lower() for p in lector.pages]
    escritor = PdfWriter(clone_from=lector)
    escritor.add_metadata({'/Title': titulo, '/Author': 'Guía de estudio', '/Subject': 'Termodinámica Aplicada 521102006'})
    pagina = 0
    padres = {}
    nivel1 = None
    encontrados = 0
    for tag, txt in encabezados:
        clave = re.sub(r'\s+', '', txt).lower()[:28]
        if len(clave) < 6:
            continue
        for i in range(pagina, len(textos)):
            if clave in textos[i]:
                pagina = i
                if tag == 'H2':
                    nivel1 = escritor.add_outline_item(txt, i)
                    padres['h2'] = nivel1
                else:
                    escritor.add_outline_item(txt, i, parent=padres.get('h2', None))
                encontrados += 1
                break
    escritor.write(pdf_out)
    return encontrados, len(encabezados)

if __name__ == '__main__':
    with sync_playwright() as pw:
        guia_pdf = os.path.join(OUT, 'termodinamica-aplicada-guia.pdf')
        imprimir(pw, os.path.join(PDFDIR, 'guia.html'), guia_pdf + '.tmp.pdf')
        n, total = marcadores(pw, os.path.join(PDFDIR, 'guia.html'), guia_pdf + '.tmp.pdf', guia_pdf, 'Termodinámica Aplicada · Guía de estudio')
        os.remove(guia_pdf + '.tmp.pdf')
        print('guía con marcadores:', n, 'de', total)

        ex_pdf = os.path.join(OUT, 'examenes-resueltos.pdf')
        imprimir(pw, os.path.join(PDFDIR, 'examenes.html'), ex_pdf)
        print('examenes páginas:', len(PdfReader(ex_pdf).pages))

        for sub in ['pdf_formulario_1p']:
            destino = os.path.join(OUT, 'formulario-una-pagina.pdf')
            for escala in (1.0, 0.92, 0.85, 0.78, 0.7):
                imprimir(pw, os.path.join(PDFDIR, sub + '.html'), destino, escala=escala, margen='12mm', cabecera=False)
                if len(PdfReader(destino).pages) == 1:
                    break
            print('formulario páginas:', len(PdfReader(destino).pages), 'escala', escala)
    for f in sorted(os.listdir(OUT)):
        print(f, os.path.getsize(os.path.join(OUT, f)) // 1024, 'KB')
