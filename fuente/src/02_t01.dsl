@bloque t01 | Agua y refrigerantes | UD1 · Tema 1 | #2456d6 | 1 | T1 · Agua y refrigerantes | Temas
@objetivos
- Identifico si una sustancia está en líquido, mezcla o vapor.
- Leo el título x en una mezcla líquido-vapor.
- Sé cuándo usar la tabla de saturación y cuándo la de vapor sobrecalentado.
- Interpolo en tablas de agua y refrigerante.

@intro
Un tema de tablas. Casi todos los problemas de sistemas empiezan aquí: hay que saber en qué estado está el agua o el refrigerante antes de calcular nada.

@zero Sustancia pura: qué significa
Una **sustancia pura** tiene la misma composición química en todas partes (agua, R-134a, nitrógeno). Basta con dos propiedades intensivas independientes para fijar su estado (por ejemplo, P y T, o P y v). Si la sustancia es una mezcla de fases de la misma composición, sigue siendo una sustancia pura.

@intuicion
Piensa en una olla con agua al fuego. A 1 atm el agua hierve a 100 °C. Mientras hierve, la temperatura no sube aunque sigas calentando: todo el calor se gasta en cambiar de líquido a vapor. Por eso, en la zona de dos fases, la presión y la temperatura **no son independientes**: si fijas una, la otra queda fijada.

@formula Dos fases: el título
En una mezcla líquido-vapor la fracción de masa que es vapor se llama **título** x. Las propiedades medias se calculan así:

$$v = v_f + x\,(v_g - v_f) \qquad h = h_f + x\,h_{fg} \qquad s = s_f + x\,s_{fg}$$

$$0 \le x \le 1 \qquad x = 0 \text{ líquido saturado} \qquad x = 1 \text{ vapor saturado}$$

@formula Tres regiones con P y T
Con la presión P y la temperatura T se sabe en qué región está:

- Si T < T_sat(P): **líquido comprimido** o subenfriado. Aproximación: v ≈ v_f(T), h ≈ h_f(T).
- Si T = T_sat(P): **mezcla** saturada. Calcula x.
- Si T > T_sat(P): **vapor sobrecalentado**. No hay título: lee directamente la tabla de vapor sobrecalentado.

@zero Desde cero: cómo leer la tabla de saturación
La tabla de saturación de agua (Moran A-2 por temperatura, A-3 por presión) tiene estas columnas: T, P_sat, v_f, v_g, u_f, u_g, h_f, h_fg, h_g, s_f, s_fg, s_g. Las columnas f se refieren al líquido saturado y las g al vapor saturado. Para una mezcla usa la fórmula de arriba. Para el vapor sobrecalentado usa la tabla A-4 (dos entradas: P y T).

@trampa Errores típicos con tablas
- Usar v_g cuando el estado es líquido comprimido (el líquido casi no cambia de volumen).
- Confundir la presión de saturación con la presión de la mezcla: si P = P_sat(T) estás en mezcla, no en vapor.
- Interpolar linealmente v entre dos temperaturas lejanas. Para v_g, la interpolación en ln(v) es más fiable. En examen, interpola como indique la tabla o haz la interpolación en la columna que mejor se comporte.

@grupo Trucos de clase · Tema 1 · Estado de una sustancia pura | abierto
Con dos propiedades independientes (por ejemplo P y T, o P y v) queda fijado el estado de una sustancia pura simple y compresible.
@intuicion
Imagina agua en una olla. Mientras hierve a 1 atm, la temperatura se queda en 100 °C aunque sigas calentando: el calor se usa en cambiar de líquido a vapor. Por eso, dentro de la zona de dos fases, P y T no son independientes.
**Trucos**
1. Decide primero la región y después calcula. Compara T con T_sat(P): si T < T_sat es líquido comprimido; si T = T_sat es mezcla y hay que calcular el título; si T > T_sat es vapor sobrecalentado y no hay título.
2. Título = vapor / total: x = (v − v_f) / (v_g − v_f). Es la regla de la palanca en el diagrama P-v o T-v.
3. Líquido comprimido (aproximación de la diapositiva): v ≈ v_f(T) y h ≈ h_f(T) + v_f·(P − P_sat(T)). No uses v_g aquí.
4. En el diagrama P-v: a la izquierda líquido, dentro de la campana mezcla, a la derecha vapor. El punto crítico es donde desaparece la diferencia entre líquido y vapor.
5. Las tablas en inglés usan punto decimal. Antes de copiar un valor, comprueba el separador.
@trampa
Usar v_g cuando el estado es líquido comprimido; confundir P_sat con la presión de la mezcla; interpolar linealmente v_g entre temperaturas muy separadas.
@fin

@ejemplo Mezcla a 200 °C
@enunciado
Agua a 200 °C con v = 0,05 m³/kg. Calcula el título x y la entalpía específica. Datos de saturación a 200 °C (tabla de saturación): v_f = 0,001157 m³/kg, v_g = 0,12736 m³/kg, h_f = 852,45 kJ/kg, h_fg = 1939,8 kJ/kg.
@antes
Comprobar en qué región está el agua (¿es menor v que v_g?), luego despejar x de la fórmula de v y calcular h.
@paso Comprobar la región
Como v_f < v = 0,05 m³/kg < v_g, el agua es una mezcla saturada. Si v fuera mayor que v_g, sería vapor sobrecalentado.
@paso Despejar el título
Despejamos x de v = v_f + x(v_g − v_f):

$$x = \frac{v - v_f}{v_g - v_f} = \frac{0{,}05 - 0{,}001157}{0{,}12736 - 0{,}001157} = 0{,}3870$$
@paso Entalpía
$$h = h_f + x\,h_{fg} = 852{,}45 + 0{,}3870 \cdot 1939{,}8 = 1603{,}2\ \text{kJ/kg}$$
@resultado
El título es x ≈ 0,387 (38,7 % de la masa es vapor) y h ≈ 1603,2 kJ/kg.
@fin

@ejemplo Vapor sobrecalentado: 1 MPa y 200 °C
@enunciado
Agua a 1 MPa y 200 °C. Calcula v y h. Comprueba primero si hay mezcla.
@antes
Con P = 1 MPa la temperatura de saturación es unos 180 °C. Como 200 °C es mayor, el agua es vapor sobrecalentado. No hay título.
@paso Región
A 1 MPa, T_sat ≈ 179,9 °C. Como T = 200 °C > T_sat, es vapor sobrecalentado.
@paso Leer la tabla de vapor sobrecalentado
En la tabla de vapor sobrecalentado de Moran (A-4), a P = 1,0 MPa y T = 200 °C se lee directamente v = 0,2060 m³/kg y h = 2827,9 kJ/kg. No se interpola con x.
@resultado
v ≈ 0,2060 m³/kg; h ≈ 2827,9 kJ/kg.
@fin

@trampa Un error que te cuesta el problema
Para vapor sobrecalentado, el valor v = 0,2 m³/kg no sale de x: con las columnas de saturación daría x = 1,58 (imposible). Es la señal de que estás fuera de la mezcla.

@masfondo Por qué el agua y el R-134a se tratan igual
Con un refrigerante la lógica es la misma: sus tablas (Moran A-10, A-11, A-12) tienen la misma estructura. Lo que cambia es el punto de referencia de la entalpía y la entropía. Si comparas un valor de tabla de agua con uno de R-134a, mira siempre la referencia de cada tabla antes de restar.

@masfondo El punto crítico y la presión supercrítica
Por encima de la presión crítica (22,06 MPa para el agua) no hay separación de fases: el paso de líquido a vapor es continuo. Un valor de P mayor que P_c nunca es una mezcla saturada. Ojo con esto en problemas a 28 MPa.

@sim agua-fase | Simulador: fase del agua (T y P)
@sim agua-x | Simulador: mezcla líquido-vapor con título x

@fig dominio-tv | Diagrama T-v de una sustancia pura (esquema, no a escala)

@test
? Tengo agua a 100 °C y 1 atm (101,33 kPa). ¿En qué región está?
- Líquido comprimido.
* Mezcla saturada (en la curva de saturación).
- Vapor sobrecalentado.
! A 1 atm, p_sat(100 °C) = 101,33 kPa. Si P = P_sat(T), estamos en la curva: mezcla, y el título se calcula con x.
@test
? En una mezcla con x = 0,3, ¿qué porcentaje de la masa es vapor?
* 30 %.
- 70 %.
- 3 %.
! El título es la fracción másica de vapor: x = 0,3 significa 30 % de la masa.
@test
? Un refrigerante a 1,4 MPa tiene T = 60 °C y el de su tabla de saturación T_sat = 52 °C. ¿Qué estado tiene?
- Mezcla saturada.
* Vapor sobrecalentado (T > T_sat).
- Líquido subenfriado.
! Con T mayor que la de saturación a esa presión, el fluido es vapor sobrecalentado. El título no existe fuera de la curva.

@tarjeta ¿Qué es el título x? | Fracción másica de vapor en una mezcla saturada. Vale 0 en líquido saturado y 1 en vapor saturado.
@tarjeta ¿Cuándo hay mezcla? | Cuando P = P_sat(T) (o T = T_sat(P)). Fuera de la curva el estado es líquido o vapor.
@tarjeta ¿Y si P es mayor que P_c? | No hay mezcla: el paso de líquido a vapor es continuo. Usa la tabla de agua a esa presión.

@formula Resumen del tema 1
- Mezcla: v = v_f + x(v_g − v_f); h = h_f + x h_fg; s = s_f + x s_fg.
- Región: compara P con P_sat(T), o T con T_sat(P).
- Líquido comprimido: v ≈ v_f(T); vapor sobrecalentado: lectura directa de la tabla A-4.

@fin
