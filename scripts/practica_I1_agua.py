"""Práctica I1 · Estado del agua y del aire húmedo con Python.

Equivalente en Python de los problemas básicos que se resuelven con EES en la práctica I1.
Usa tablas reducidas (anclas de las tablas A-2 y A-3 de Moran y Shapiro) con interpolación lineal.
Para los exámenes, usa siempre las tablas completas publicadas. Las cifras son de práctica.

Ejecutar:  python3 practica_I1_agua.py
"""
import math

# Tabla reducida de saturación del agua: T [°C] -> P_sat [kPa]
T_TAB = [0.01, 20, 50, 100, 150, 200, 250, 300]
P_TAB = [0.6113, 2.339, 12.35, 101.33, 476.2, 1554.9, 3973.0, 8587.9]
# Anclas de propiedades de saturación (20, 100, 200 °C)
ANCLAS_T = [20.0, 100.0, 200.0]
ANCLAS = {
    "v_f": [0.001002, 0.001043, 0.001157],
    "v_g": [57.79, 1.673, 0.12736],
    "h_f": [83.96, 419.04, 852.45],
    "h_g": [2537.4, 2676.1, 2792.2],
}


def interpola(xs, ys, x):
    """Interpolación lineal de ys en xs; si x está fuera, recorta al extremo."""
    if x <= xs[0]:
        return ys[0]
    if x >= xs[-1]:
        return ys[-1]
    for i in range(len(xs) - 1):
        if xs[i] <= x <= xs[i + 1]:
            t = (x - xs[i]) / (xs[i + 1] - xs[i])
            return ys[i] + t * (ys[i + 1] - ys[i])


def p_sat(T):
    """Presión de saturación [kPa] a T [°C]: interpolación lineal en ln(p)."""
    lnp = [math.log(p) for p in P_TAB]
    return math.exp(interpola(T_TAB, lnp, T))


def T_sat(P):
    """Temperatura de saturación [°C] a P [kPa] (inverso de p_sat)."""
    lnp = [math.log(p) for p in P_TAB]
    return interpola(lnp, T_TAB, math.log(P))


def region(T, P):
    """Región del agua con T [°C] y P [kPa]."""
    ps = p_sat(T)
    if abs(P - ps) / ps < 0.005:
        return "mezcla saturada (P = p_sat)"
    if P < ps:
        return "vapor sobrecalentado (P < p_sat)"
    return "líquido comprimido (P > p_sat)"


def titulo_desde_v(T, v):
    """Título x y entalpía h [kJ/kg] en mezcla saturada a T [°C] con volumen v [m³/kg]."""
    vf = interpola(ANCLAS_T, ANCLAS["v_f"], T)
    vg = math.exp(interpola(ANCLAS_T, [math.log(x) for x in ANCLAS["v_g"]], T))
    if v < vf:
        return None, "líquido comprimido (v < v_f)"
    if v > vg:
        return None, "vapor sobrecalentado (v > v_g)"
    x = (v - vf) / (vg - vf)
    hf = interpola(ANCLAS_T, ANCLAS["h_f"], T)
    hg = interpola(ANCLAS_T, ANCLAS["h_g"], T)
    return x, hf + x * (hg - hf)


if __name__ == "__main__":
    print("== 1. Presión de saturación")
    for T in (20, 100, 150):
        print(f"p_sat({T} °C) = {p_sat(T):.1f} kPa")

    print("\n== 2. Temperatura de saturación a 101,33 kPa")
    print(f"T_sat(101,33 kPa) = {T_sat(101.33):.1f} °C")

    print("\n== 3. Región del agua")
    for T, P in [(150, 500), (100, 101.33), (200, 1000)]:
        print(f"T = {T} °C, P = {P} kPa -> {region(T, P)}")

    print("\n== 4. Título desde v (mezcla a 100 °C)")
    x, h = titulo_desde_v(100, 0.9)
    print(f"v = 0,9 m³/kg -> x = {x:.3f}, h = {h:.1f} kJ/kg")
