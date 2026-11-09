@bloque t02 | Gases ideales | UD1 · Tema 2 | #1f8a6b | 2 | T2 · Gases ideales | Temas
@objetivos
- Aplico la ley de gas ideal y calculo la masa de un gas.
- Distingo R (del gas) y R_u (universal) y sé cuál usar.
- Calculo Δu, Δh y Δs con c_v, c_p constantes.
- Uso la tabla de aire A-22 (h, u, s°, p_r, v_r) con interpolación.

@intro
El aire que respiras, el de un compresor o el de una turbina de gas se comporta como **gas ideal** con muy buena aproximación. Este tema te da la herramienta para casi todo lo que viene después.

@zero Qué es un gas ideal
Un gas ideal son moléculas que casi no se atraen ni se repelen y que ocupan un volumen despreciable frente al del recipiente. Es una idealización, pero a presiones moderadas (unos pocos bar) y temperaturas por encima de unos cientos de kelvin, el aire, el nitrógeno y el oxígeno se comportan así con errores de unos pocos por ciento.

@intuicion
Si aprietas un globo, sube la presión. Si lo calientas, sube la presión o se hincha. La ley de gas ideal es la regla que une las tres cosas: P, v y T. Cuando una cambia, las otras dos se reajustan.

@formula Ley de gas ideal
$$PV = mRT \qquad Pv = RT \qquad PV = nR_uT$$

- P en kPa, v en m³/kg, T en **kelvin**, R en kJ/(kg·K).
- R_u = 8,314 kJ/(kmol·K). Para un gas de masa molar M: R = R_u/M.
- Aire: M = 28,97 kg/kmol, R = 0,287 kJ/(kg·K).

@formula Calores específicos y variaciones
Para un gas ideal, u y h dependen solo de T:

$$du = c_v\,dT \qquad dh = c_p\,dT \qquad c_p - c_v = R \qquad k = \frac{c_p}{c_v}$$

Para el aire con k = 1,4: c_v = 0,718 kJ/(kg·K) y c_p = 1,005 kJ/(kg·K). Si c_p y c_v son constantes:

$$\Delta u = c_v\,\Delta T \qquad \Delta h = c_p\,\Delta T \qquad \Delta s = c_p\ln\frac{T_2}{T_1} - R\ln\frac{P_2}{P_1}$$

@zero Desde cero: por qué sirven las tablas de aire
Cuando el rango de temperaturas es grande, c_p deja de ser constante. Entonces se usa la tabla de aire A-22 de Moran. Tiene columnas T, h, u, s°, p_r y v_r. La entropía relativa s° depende solo de T; el resto de la diferencia de entropía se obtiene con la presión:

$$s_2 - s_1 = s^\circ_2 - s^\circ_1 - R\ln\frac{P_2}{P_1}$$

Para los cambios isentrópicos, la tabla da directamente la relación p_r: $\frac{P_2}{P_1} = \frac{p_{r2}}{p_{r1}}$ con $p_r$ sacado de A-22.

@trampa Errores típicos con gases
- Usar °C en la ley de gas ideal. Siempre kelvin.
- Usar R_u (8,314) con kg. Si el enunciado da kg, usa R = 0,287 kJ/(kg·K).
- Confundir c_p y c_v: Δu siempre con c_v, Δh siempre con c_p.
- Olvidar el término de presión en Δs. Un gas que se calienta a presión constante gana entropía; uno que se comprime isotérmicamente la pierde.

@ejemplo Masa de aire en un depósito
@enunciado
Un depósito de 2 m³ contiene aire a 300 kPa y 300 K. Calcula la masa de aire.
@antes
Ley de gas ideal con T en kelvin y R del aire. Se despeja m.
@paso Despejar la masa
$$m = \frac{PV}{RT} = \frac{300 \cdot 2}{0{,}287 \cdot 300} = 6{,}969\ \text{kg}$$
@resultado
m ≈ 6,97 kg de aire.
@fin

@ejemplo Variación de entropía del aire
@enunciado
Aire de 300 K y 1 bar se calienta hasta 600 K y se comprime hasta 3 bar. Calcula Δs (kJ/(kg·K)) con c_p = 1,005 kJ/(kg·K).
@antes
Son dos cambios a la vez: temperatura y presión. La fórmula con c_p tiene los dos términos.
@paso Sustituir
$$\Delta s = c_p\ln\frac{T_2}{T_1} - R\ln\frac{P_2}{P_1} = 1{,}005\ln\frac{600}{300} - 0{,}287\ln\frac{3}{1}$$
@paso Calcular cada término
$$1{,}005\cdot 0{,}6931 = 0{,}6966 \qquad 0{,}287\cdot 1{,}0986 = 0{,}3153$$
@paso Restar
$$\Delta s = 0{,}6966 - 0{,}3153 = 0{,}3813\ \text{kJ/(kg·K)}$$
@resultado
Δs ≈ 0,381 kJ/(kg·K). Positivo: aumenta la entropía, como esperamos al calentar.
@fin

@masfondo Cuándo falla el modelo de gas ideal
Cerca de la saturación o a presiones de decenas de bar, el aire y el vapor se separan del modelo. El factor de compresibilidad Z = Pv/(RT) mide la desviación: Z = 1 es ideal. Para el aire a temperatura ambiente y 1 bar, Z ≈ 1 con error inferior al 0,1 %. Para el agua cerca de la saturación, Z ≈ 0,9 y no sirve el modelo.

@zero Un ejercicio que te ahorra fallos
Si el enunciado te da dos estados de un gas, calcula primero T en kelvin, luego P en kPa y luego v = RT/P. Si los tres valores tienen unidades coherentes, el resultado sale bien casi siempre.

@abrirsim gas-politropico | Abrir en el simulador: proceso con aire
@sim gas-politropico | Simulador: proceso politrópico de aire (n = 1 es isoterma)

@test
? Un gas ideal a presión constante pasa de 300 K a 600 K. ¿Qué pasa con su volumen?
* Se duplica (v proporcional a T a P constante).
- No cambia.
- Se reduce a la mitad.
! Con PV = mRT y P constante, V es proporcional a T (en kelvin). Doble T, doble V.
@test
? ¿Qué R usas para aire con masa en kilogramos?
- R_u = 8,314 kJ/(kmol·K).
* R = 0,287 kJ/(kg·K).
- R = 1,005 kJ/(kg·K).
! R = R_u/M con M = 28,97 kg/kmol. c_p es 1,005, no R.

@tarjeta ¿Qué es un gas ideal? | Gas con moléculas sin interacción apreciable. Cumple PV = mRT; u y h dependen solo de T.
@tarjeta ¿Cuál es c_p − c_v? | R del gas: c_p − c_v = R.
@tarjeta ¿Cuándo usar A-22? | Cuando c_p no es constante (rango grande de T). Da s° y p_r.

@formula Resumen del tema 2
- Ley: PV = mRT (T en K).
- Δu = c_v ΔT; Δh = c_p ΔT; c_p − c_v = R.
- Δs = c_p ln(T₂/T₁) − R ln(P₂/P₁).

@fin
