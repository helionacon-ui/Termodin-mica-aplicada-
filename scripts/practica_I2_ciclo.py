"""Práctica I2 · Análisis de un ciclo Brayton ideal (aire frío) con Python.

Equivalente en Python del análisis de ciclos con EES de la práctica I2.
Supone c_p y k constantes (aire frío). Compara resultados al cambiar r_p.

Ejecutar:  python3 practica_I2_ciclo.py
"""
import math

CP = 1.005   # kJ/(kg·K)
K = 1.4      # cociente de calores específicos
R = 0.287    # kJ/(kg·K)


def brayton(rp, T1, T3):
    """Estados y trabajos de un Brayton ideal. T en K, rp adimensional."""
    e = (K - 1.0) / K
    T2 = T1 * rp ** e             # compresión isentrópica
    T4 = T3 * rp ** (-e)          # expansión isentrópica
    wc = CP * (T2 - T1)           # trabajo del compresor (kJ/kg)
    wt = CP * (T3 - T4)           # trabajo de la turbina (kJ/kg)
    qin = CP * (T3 - T2)          # calor aportado (kJ/kg)
    wn = wt - wc                  # trabajo neto (kJ/kg)
    return {"T2": T2, "T4": T4, "wc": wc, "wt": wt, "wn": wn, "qin": qin,
            "eta": wn / qin, "bwr": wc / wt}


if __name__ == "__main__":
    T1, T3 = 300.0, 1200.0
    print(f"Ciclo base: T1 = {T1:g} K, T3 = {T3:g} K")
    r = brayton(8.0, T1, T3)
    for clave in ("T2", "T4", "wc", "wt", "wn", "qin", "eta", "bwr"):
        print(f"{clave:>4s} = {r[clave]:.4g}")

    print("\nBarrido de la relación de compresión:")
    print(" r_p    eta [%]   w_neto [kJ/kg]   relación de trabajos")
    for rp in (2, 4, 6, 8, 10, 12, 14, 16):
        b = brayton(rp, T1, T3)
        print(f"{rp:4d}   {100 * b['eta']:7.2f}   {b['wn']:12.2f}   {b['bwr']:12.3f}")

    print("\nComprobación con la fórmula cerrada: eta = 1 - rp^(-(k-1)/k)")
    print(f"eta = {100 * (1 - 8 ** (-(K - 1) / K)):.2f} %  (r_p = 8)")
