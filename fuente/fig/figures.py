#!/usr/bin/env python3
"""Figuras SVG propias de la guía. Escribe build/fig/*.svg (sin dependencias externas)."""
import math, os
OUT = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'build', 'fig')
os.makedirs(OUT, exist_ok=True)
W, H = 640, 360
ST = 'stroke:var(--fg);fill:none;stroke-width:2'
AC = 'stroke:var(--acc);fill:none;stroke-width:3'
MU = 'fill:var(--muted);font-size:13px;font-family:IBM Plex Sans,sans-serif'
TX = 'fill:var(--fg);font-size:14px;font-family:IBM Plex Sans,sans-serif'
TB = 'fill:var(--fg);font-size:14px;font-weight:700;font-family:IBM Plex Sans,sans-serif'

def svg(body, aria):
    return (f'<svg viewBox="0 0 {W} {H}" role="img" aria-label="{aria}" xmlns="http://www.w3.org/2000/svg">'
            + body + '</svg>')

def ejes(x0, y0, x1, y1, xl, yl):
    s = f'<line x1="{x0}" y1="{y1}" x2="{x1}" y2="{y1}" style="{ST}"/><line x1="{x0}" y1="{y1}" x2="{x0}" y2="{y0}" style="{ST}"/>'
    s += f'<text x="{x1-4}" y="{y1+22}" text-anchor="end" style="{MU}">{xl}</text>'
    s += f'<text x="{x0-10}" y="{y0+6}" text-anchor="end" style="{MU}">{yl}</text>'
    return s

def polil(pts, est):
    d = 'M' + ' L'.join(f'{x:.1f} {y:.1f}' for x, y in pts)
    return f'<path d="{d}" style="{est}"/>'

# 1. Diagrama T-v de una sustancia pura (esquema)
def dominio():
    b = ejes(70, 30, 600, 320, 'v (volumen específico)', 'T')
    # campana: lado izquierdo (líquido) y derecho (vapor)
    izq = [(150 + 80 * (1 - math.cos(t)) / 2 * 0.9 + 0, 0) for t in []]
    cx_top, y_top = 330, 80
    izq = [(170 + 160 * ((1 - math.sin(a)) / 2) ** 1.3, 320 - (240 * (math.sin(a) * 0.5 + 0.5)) ** 1) for a in [i / 40 * math.pi for i in range(1, 40)]]
    # pts de la campana: izquierda desde (170,320) hasta cúspide (330,80) y derecha hasta (600,320)
    curva_izq = [(170 + (330 - 170) * t ** 1.6, 320 - (320 - 80) * (t ** 0.7)) for t in [i / 30 for i in range(0, 31)]]
    curva_der = [(330 + (580 - 330) * t ** 0.6, 80 + (320 - 80) * t ** 1.5) for t in [i / 30 for i in range(0, 31)]]
    b += polil(curva_izq, ST) + polil(curva_der, ST)
    b += f'<circle cx="330" cy="80" r="4" style="fill:var(--fg)"/><text x="338" y="72" style="{TX}">punto crítico</text>'
    # isobara a P < Pc: recta horizontal en T constante dentro de la campana
    b += f'<line x1="200" y1="170" x2="500" y2="170" style="{AC}"/>'
    b += f'<text x="506" y="175" style="{TX}">isoterma</text>'
    b += f'<text x="90" y="200" style="{TX}">líquido</text><text x="90" y="216" style="{MU}">comprimido</text>'
    b += f'<text x="370" y="250" style="{TX}">vapor</text><text x="370" y="266" style="{MU}">sobrecalentado</text>'
    b += f'<text x="235" y="150" style="{TX}">mezcla</text><text x="235" y="134" style="{MU}">líq.+vap.</text>'
    return svg(b, 'Diagrama T-v de una sustancia pura con la campana de saturación y el punto crítico (esquema)')

# 2. Turbina: flujo estacionario
def turbina():
    b = '<rect x="230" y="110" width="180" height="120" rx="16" style="fill:var(--chip);stroke:var(--fg);stroke-width:2"/>'
    b += f'<text x="320" y="176" text-anchor="middle" style="{TB}">turbina</text>'
    b += f'<line x1="60" y1="170" x2="225" y2="170" style="stroke:var(--acc);stroke-width:4"/><polygon points="225,170 214,164 214,176" style="fill:var(--acc)"/>'
    b += f'<line x1="415" y1="170" x2="580" y2="170" style="stroke:var(--acc);stroke-width:4"/><polygon points="580,170 569,164 569,176" style="fill:var(--acc)"/>'
    b += f'<text x="60" y="150" style="{TX}">entrada: 1</text><text x="60" y="196" style="{MU}">ṁ, h₁, c₁, z₁</text>'
    b += f'<text x="580" y="150" text-anchor="end" style="{TX}">salida: 2</text><text x="580" y="196" text-anchor="end" style="{MU}">h₂, c₂, z₂</text>'
    b += f'<line x1="320" y1="110" x2="320" y2="50" style="stroke:var(--key-line);stroke-width:3"/><polygon points="320,50 314,61 326,61" style="fill:var(--key-line)"/>'
    b += f'<text x="330" y="64" style="{TX}">Q̇ (pérdidas)</text>'
    b += f'<line x1="410" y1="230" x2="470" y2="290" style="stroke:var(--trap-line);stroke-width:3"/><polygon points="470,290 458,286 464,276" style="fill:var(--trap-line)"/>'
    b += f'<text x="478" y="312" style="{TX}">Ẇ (sale)</text>'
    b += f'<text x="320" y="330" text-anchor="middle" style="{MU}">Balance de energía: Ẇ = ṁ[(h₁ − h₂) + (c₁² − c₂²)/2 + g(z₁ − z₂)] + Q̇</text>'
    return svg(b, 'Esquema de una turbina en régimen estacionario con entradas, salidas y potencia')

# 3. Procesos politrópicos en P-V
def politropica():
    x0, y0, x1, y1 = 80, 320, 600, 40
    b = ejes(70, 30, 600, 320, 'V', 'P')
    def sc(v, p):
        return 80 + (v - 0.2) / 1.8 * 500, 320 - (p - 0) / 900 * 280
    pts = lambda n: [sc(0.2 + i * (2.0 - 0.2) / 60, 300 * (0.5 / (0.2 + i * (2.0 - 0.2) / 60)) ** n) for i in range(1, 61)]
    b += polil(pts(0), 'stroke:var(--muted);fill:none;stroke-width:2;stroke-dasharray:6 5')
    b += polil(pts(1), 'stroke:var(--acc);fill:none;stroke-width:3')
    b += polil(pts(1.4), 'stroke:var(--key-line);fill:none;stroke-width:3')
    b += polil(pts(2.5), 'stroke:var(--trap-line);fill:none;stroke-width:3')
    b += f'<text x="520" y="150" style="{TX}">n = 0 (isobara)</text>'
    b += f'<text x="520" y="170" style="{TX}">n = 1 (isoterma)</text>'
    b += f'<text x="520" y="190" style="{TX}">n = 1,4 (adiabática)</text>'
    b += f'<text x="520" y="210" style="{TX}">n = 2,5</text>'
    return svg(b, 'Procesos politrópicos PV^n = cte en diagrama P-V para varios valores de n')

# 4. Ciclo de Carnot en T-s
def carnot():
    b = ejes(70, 30, 600, 320, 's', 'T')
    b += f'<rect x="170" y="110" width="300" height="140" style="fill:var(--key-bg);stroke:var(--key-line);stroke-width:2"/>'
    b += f'<line x1="170" y1="110" x2="470" y2="110" style="stroke:var(--trap-line);stroke-width:3"/>'
    b += f'<line x1="170" y1="250" x2="470" y2="250" style="stroke:var(--acc);stroke-width:3"/>'
    b += f'<text x="478" y="114" style="{TX}">T_H (absorbe Q_H)</text><text x="478" y="254" style="{TX}">T_C (cede Q_C)</text>'
    b += f'<text x="320" y="190" text-anchor="middle" style="{TB}">área = W_neto</text>'
    b += f'<text x="320" y="300" text-anchor="middle" style="{MU}">Isotermas horizontales y adiabáticas verticales (reversible)</text>'
    return svg(b, 'Ciclo de Carnot en diagrama T-s como rectángulo: área igual al trabajo neto')

# 5. Brayton ideal en T-s (aire frío, cálculo real)
def brayton_ts():
    cp, R, k = 1.005, 0.287, 1.4
    rp, T1, T3 = 8.0, 300.0, 1200.0
    e = (k - 1) / k
    T2 = T1 * rp ** e; T4 = T3 * rp ** (-e)
    s3 = cp * math.log(T3 / T1) - R * math.log(rp)
    s4 = cp * math.log(T4 / T1)
    smax = s3 * 1.05
    def sc(s, T):
        return 90 + s / smax * 500, 320 - (T - 250) / (1250 - 250) * 270
    b = ejes(70, 30, 600, 320, 's (kJ/kg·K)', 'T (K)')
    p1 = [sc(i * s4 / 40, T1 * math.exp(i * s4 / 40 / cp)) for i in range(0, 41)]
    p2 = [sc(i * s3 / 40, T1 * math.exp((i * s3 / 40 + R * math.log(rp)) / cp)) for i in range(0, 41)]
    b += polil(p1, 'stroke:var(--muted);fill:none;stroke-width:2.5')
    b += polil(p2, 'stroke:var(--acc);fill:none;stroke-width:2.5')
    x1, y1 = sc(0, T1); x2, y2 = sc(0, T2); x3, y3 = sc(s3, T3); x4, y4 = sc(s3, T4)
    b += f'<line x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}" style="stroke:var(--key-line);stroke-width:2.5"/>'
    b += f'<line x1="{x3}" y1="{y3}" x2="{x4}" y2="{y4}" style="stroke:var(--key-line);stroke-width:2.5"/>'
    for (x, y, t) in [(x1, y1, '1'), (x2, y2, '2'), (x3, y3, '3'), (x4, y4, '4')]:
        b += f'<circle cx="{x:.1f}" cy="{y:.1f}" r="5" style="fill:var(--fg)"/><text x="{x+8:.1f}" y="{y-8:.1f}" style="{TB}">{t}</text>'
    b += f'<text x="520" y="60" style="{MU}">r_p = 8, T₁ = 300 K, T₃ = 1200 K</text>'
    b += f'<text x="520" y="78" style="{MU}">(azul: p = p₁; rojo: p = r_p p₁)</text>'
    return svg(b, 'Ciclo Brayton ideal en diagrama T-s con los estados 1 a 4')

# 6. Ciclo de refrigeración por compresión de vapor en P-h (esquema)
def refrig():
    b = ejes(80, 30, 600, 320, 'h (entalpía)', 'P (escala log.)')
    b += f'<polygon points="200,250 390,250 340,120 250,120" style="fill:var(--key-bg);stroke:var(--key-line);stroke-width:2"/>'
    pts = {'1': (200, 250), '2': (390, 250), '3': (340, 120), '4': (250, 120)}
    b = b.replace('<polygon', '<polygon', 1)
    pts2 = [(200, 250), (390, 250), (340, 120), (250, 120)]
    rot = [('1', 200, 250, 'vapor a la entrada del compresor'), ('2', 390, 250, 'compresión'), ('3', 340, 120, 'condensación'), ('4', 250, 120, 'estrangulamiento (válvula)')]
    for t, x, y, txt in rot:
        b += f'<circle cx="{x}" cy="{y}" r="5" style="fill:var(--fg)"/><text x="{x+8}" y="{y+(16 if t in "12" else -8)}" style="{TB}">{t}</text>'
    b += f'<text x="400" y="60" style="{MU}">Compresor: 1→2 · Condensador: 2→3 · Válvula: 3→4 · Evaporador: 4→1</text>'
    b += f'<text x="400" y="290" style="{MU}">Esquema: la válvula es isoentálpica (h₃ = h₄)</text>'
    return svg(b, 'Esquema del ciclo de refrigeración por compresión de vapor en diagrama P-h')

# 7. Mezcla adiabática de dos corrientes (esquema)
def mezcla():
    b = '<rect x="250" y="130" width="140" height="100" rx="14" style="fill:var(--chip);stroke:var(--fg);stroke-width:2"/>'
    b += f'<text x="320" y="186" text-anchor="middle" style="{TB}">mezclador</text>'
    b += '<line x1="60" y1="110" x2="245" y2="150" style="stroke:var(--acc);stroke-width:4"/><polygon points="245,150 233,146 238,137" style="fill:var(--acc)"/>'
    b += '<line x1="60" y1="260" x2="245" y2="200" style="stroke:var(--acc);stroke-width:4"/><polygon points="245,200 237,213 225,208" style="fill:var(--acc)"/>'
    b += f'<text x="60" y="95" style="{TX}">corriente 1: ṁ₁, T₁, ω₁</text><text x="60" y="290" style="{TX}">corriente 2: ṁ₂, T₂, ω₂</text>'
    b += '<line x1="390" y1="180" x2="580" y2="180" style="stroke:var(--key-line);stroke-width:4"/><polygon points="580,180 568,174 568,186" style="fill:var(--key-line)"/>'
    b += f'<text x="580" y="160" text-anchor="end" style="{TX}">corriente 3</text><text x="580" y="208" text-anchor="end" style="{MU}">ṁ₃ = ṁ₁ + ṁ₂ (aire seco)</text>'
    b += f'<text x="320" y="330" text-anchor="middle" style="{MU}">Adiabático: Q̇ = 0 y W = 0. Balance de agua: ṁ₁ω₁ + ṁ₂ω₂ = ṁ₃ω₃</text>'
    return svg(b, 'Esquema de mezcla adiabática de dos corrientes de aire húmedo')

# 8. Balance de entropía de un volumen de control
def entropia():
    b = '<rect x="230" y="110" width="180" height="120" rx="14" style="fill:var(--chip);stroke:var(--fg);stroke-width:2"/>'
    b += f'<text x="320" y="170" text-anchor="middle" style="{TB}">volumen de control</text>'
    b += f'<text x="320" y="192" text-anchor="middle" style="{MU}">Ṡ_gen ≥ 0</text>'
    b += '<line x1="60" y1="170" x2="225" y2="170" style="stroke:var(--acc);stroke-width:4"/><polygon points="225,170 214,164 214,176" style="fill:var(--acc)"/>'
    b += '<line x1="415" y1="170" x2="580" y2="170" style="stroke:var(--acc);stroke-width:4"/><polygon points="580,170 569,164 569,176" style="fill:var(--acc)"/>'
    b += f'<text x="60" y="150" style="{TX}">ṁ s₁ (entra)</text><text x="580" y="150" text-anchor="end" style="{TX}">ṁ s₂ (sale)</text>'
    b += '<line x1="320" y1="110" x2="320" y2="50" style="stroke:var(--key-line);stroke-width:3"/><polygon points="320,50 314,61 326,61" style="fill:var(--key-line)"/>'
    b += f'<text x="330" y="64" style="{TX}">Q̇/T_b (entropía por calor)</text>'
    b += f'<text x="320" y="330" text-anchor="middle" style="{MU}">dS_vc/dt = Σ ṁ s (entra − sale) + Σ Q̇/T_b + Ṡ_gen</text>'
    return svg(b, 'Volumen de control con flujos de entropía y generación de entropía')

if __name__ == '__main__':
    fig = {'dominio-tv': dominio, 'turbina': turbina, 'politropica': politropica, 'carnot-ts': carnot,
           'brayton-ts': brayton_ts, 'refrig-ph': refrig, 'mezcla-aire': mezcla, 'balance-entropia': entropia}
    for nombre, f in fig.items():
        with open(os.path.join(OUT, nombre + '.svg'), 'w', encoding='utf-8') as fh:
            fh.write(f())
    print('figuras:', len(fig), 'en', OUT)
