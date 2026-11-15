@bloque t07 | Turbinas de vapor y de gas | UD4 · Tema 7 | #dc2626 | 7 | T7 · Turbinas de vapor y de gas | Temas
@objetivos
- Describo un ciclo de potencia de vapor (Rankine) y uno de gas (Brayton).
- Calculo el rendimiento de un Brayton de aire frío con la relación de compresión.
- Calculo trabajos de compresor y turbina y el trabajo neto por kilogramo.
- Explico por qué el rendimiento sube con r_p hasta un límite.

@intro
Una central de carbón o de gas produce electricidad con una turbina. Este tema estudia el ciclo que mueve la turbina: el vapor (Rankine) o el aire caliente (Brayton).

@zero Qué es un ciclo de potencia
Es una secuencia de procesos que vuelve al estado inicial. El fluido absorbe calor en una caldera o cámara de combustión, produce trabajo en una turbina, cede calor en un condensador o al ambiente y vuelve al punto de partida. El trabajo neto es la diferencia entre el de la turbina y el del compresor o bomba.

@intuicion
La turbina es el "motor" del ciclo: el fluido se expande y gira el eje. El compresor (o la bomba) gasta parte de ese trabajo en volver a comprimir el fluido. Cuanto menor sea el trabajo del compresor frente al de la turbina, mejor el ciclo.

@zero Rankine y Brayton, en dos frases
- **Rankine** (vapor): caldera → turbina → condensador → bomba. El fluido cambia de fase (líquido ↔ vapor). Sus tablas de agua son las del tema 1.
- **Brayton** (gas): compresor → cámara de combustión → turbina → escape. El fluido es gas (aire) durante todo el ciclo. Es el de las turbinas de gas y de los motores de aviación.

@formula Brayton de aire frío ideal
Con aire como gas ideal, $c_p$ y $k$ constantes, y procesos isentrópicos en compresor y turbina:

$$\eta = 1 - \frac{1}{r_p^{(k-1)/k}} \qquad T_2 = T_1\,r_p^{(k-1)/k} \qquad T_4 = T_3\,r_p^{-(k-1)/k}$$

$$w_{\text{comp}} = c_p(T_2 - T_1) \qquad w_{\text{turb}} = c_p(T_3 - T_4) \qquad w_{\text{neto}} = w_{\text{turb}} - w_{\text{comp}}$$

El calor aportado es $q_{\text{ent}} = c_p(T_3 - T_2)$, y $\eta = w_{\text{neto}}/q_{\text{ent}}$.

@grupo Trucos de clase · Tema 7 · Ciclos de vapor (Rankine) y de gas (Brayton) | abierto
El rendimiento sube si el calor entra a mayor temperatura media o sale a menor temperatura media.
@intuicion
El ciclo Rankine tiene bomba, caldera, turbina y condensador. El Brayton es el de la turbina de gas (compresor, cámara de combustión y turbina) y es un ciclo abierto, el más habitual.
**Trucos**
1. Tres palancas en Rankine, según las diapositivas: subir la presión de la caldera, bajar la presión del condensador y sobrecalentar o recalentar el vapor. La regeneración también ayuda porque el agua entra más caliente en la caldera.
2. Brayton ideal con aire estándar: η = 1 − 1 / r^((γ−1)/γ), con r = P₂/P₁. Solo depende de la relación de presiones.
3. El condensador no es una pérdida inútil: hace posible que el agua vuelva a la bomba con poco trabajo.
@trampa
Usar las presiones en bar y en kPa a la vez sin convertirlas.
@fin

@ejemplo Brayton de aire frío con r_p = 8
@enunciado
Un ciclo Brayton de aire frío tiene r_p = 8. El aire entra al compresor a 300 K y la entrada a la turbina está a 1200 K. Calcula el rendimiento térmico, T₂, T₄, w_comp, w_turb y w_neto. Usa k = 1,4 y c_p = 1,005 kJ/(kg·K).
@antes
Isentrópico en compresor y turbina. Primero calcula las temperaturas, luego los trabajos.
@paso Rendimiento
$$\eta = 1 - 8^{-0{,}4/1{,}4} = 1 - 8^{-0{,}2857} = 1 - 0{,}5520 = 0{,}448 = 44{,}8\ \%$$
@paso Temperaturas
$$T_2 = 300\cdot 8^{0{,}2857} = 543{,}4\ \text{K} \qquad T_4 = 1200\cdot 8^{-0{,}2857} = 662{,}5\ \text{K}$$
@paso Trabajos
$$w_{\text{comp}} = 1{,}005(543{,}4 - 300) = 244{,}7\ \text{kJ/kg}$$
$$w_{\text{turb}} = 1{,}005(1200 - 662{,}5) = 540{,}2\ \text{kJ/kg}$$
$$w_{\text{neto}} = 540{,}2 - 244{,}7 = 295{,}5\ \text{kJ/kg}$$
@resultado
η ≈ 44,8 %; T₂ ≈ 543,4 K; T₄ ≈ 662,5 K; w_comp ≈ 244,7 kJ/kg; w_turb ≈ 540,2 kJ/kg; w_neto ≈ 295,5 kJ/kg.
@fin

@ejemplo Brayton con regeneración ideal
@enunciado
Un ciclo Brayton de aire estándar tiene T₁ = 300 K, T₃ = 1200 K y r_p = 8 (k = 1,4). Compara el rendimiento sin regeneración con el de un regenerador ideal.
@antes
Sin regenerador, η = 1 − r_p^(−(k−1)/k). Con regenerador ideal, el aire de la compresión se calienta hasta T₄ con los gases de escape y el rendimiento pasa a η = 1 − (T₁/T₃) r_p^((k−1)/k).
@paso Sin regeneración
$$\eta = 1 - 8^{-0{,}2857} = 0{,}448$$
@paso Con regeneración ideal
$$\eta_{reg} = 1 - \frac{T_1}{T_3}\,r_p^{\frac{k-1}{k}} = 1 - \frac{300}{1200}\cdot 8^{0{,}2857} = 0{,}547$$
@resultado
η ≈ 44,8 % sin regenerar y 54,7 % con regenerador ideal (+9,9 puntos). La regeneración compensa cuando r_p es bajo y T₃ alta; para relaciones de presión altas deja de ser útil.
@fin

@ejemplo Brayton con rendimientos isentrópicos
@enunciado
El mismo ciclo (T₁ = 300 K, T₃ = 1200 K, r_p = 8), pero con η_compresor = 0,80 y η_turbina = 0,85. Calcula trabajo neto específico y rendimiento. c_p = 1,005 kJ/(kg·K).
@antes
Se calculan las temperaturas ideales (isentrópicas) y se corrigen con los rendimientos. El rendimiento del ciclo baja porque el compresor consume más y la turbina produce menos.
@paso Temperaturas
$$T_{2s} = 543{,}4\ \text{K}\Rightarrow T_2 = T_1 + \frac{T_{2s}-T_1}{0{,}8} = 604{,}3\ \text{K}$$
$$T_{4s} = 662{,}5\ \text{K}\Rightarrow T_4 = T_3 - 0{,}85\,(T_3 - T_{4s}) = 743{,}1\ \text{K}$$
@paso Trabajos y calor
$$w_c = c_p(T_2 - T_1) = 305{,}8\qquad w_t = c_p(T_3 - T_4) = 459{,}2\ \text{kJ/kg}$$
$$w_{neto} = 153{,}4\ \text{kJ/kg}\qquad q_{ent} = c_p(T_3 - T_2) = 598{,}7\ \text{kJ/kg}$$
@resultado
w_neto ≈ 153,4 kJ/kg; η = w_neto/q_ent ≈ 25,6 % (frente al 44,8 % ideal). Alrededor de dos tercios del trabajo de la turbina se gastan en comprimir el aire.
@fin

@trampa Lo que sale en un examen de gas
- Usar °C en las temperaturas del ciclo. Todo en kelvin.
- Confundir la relación de compresión r_p con la de volumen.
- Olvidar que el trabajo del compresor es grande: en Brayton de aire, la relación de trabajos w_comp/w_turb es alta (0,45 con r_p = 8).
- Poner la temperatura de escape T₄ igual a T₁. Solo si la turbina no existe.

@masfondo Por qué sube el rendimiento con r_p y luego se estanca
Con r_p mayor, el compresor gasta más trabajo, pero el aire llega más caliente a la turbina y el trabajo neto sube. Sin embargo, al crecer r_p, la temperatura de salida T₂ se acerca a T₃ y el calor aportado se reduce: el trabajo neto tiene un máximo y el rendimiento sigue subiendo más despacio. Con T₁ = 300 K y T₃ = 1200 K, el trabajo neto máximo está cerca de r_p ≈ 12.

@masfondo Cómo se conecta con Rankine
En Rankine, el fluido cambia de fase, así que el trabajo de la bomba es mínimo (líquido casi incompresible) y el rendimiento depende de las presiones y temperaturas del vapor. Las tablas del tema 1 son las que se usan en todo el cálculo.

@fig brayton-ts | Ciclo Brayton ideal en diagrama T-s (aire frío, r_p = 8)
@sim brayton | Simulador: ciclo Brayton ideal con aire frío
@abrirsim brayton | Abrir en el simulador: cambia r_p y mira el rendimiento

@test
? En un Brayton de aire frío con r_p = 8, el rendimiento es aproximadamente:
- 56,5 %.
* 44,8 %.
- 61,4 %.
! η = 1 − r_p^(−(k−1)/k) = 1 − 8^(−0,2857) ≈ 0,448. Los 56,5 % y 61,4 % son de Otto y Diesel (tema 8).
@test
? ¿Qué temperatura se usa en la fórmula de η?
- T en °C.
* T en kelvin (no hay η con °C).
- T en °F.
! El cociente de presiones y temperaturas exige la escala absoluta.

@tarjeta ¿Qué es Brayton? | Ciclo de gas con compresor, combustión y turbina; el fluido siempre es gas.
@tarjeta ¿Qué es Rankine? | Ciclo de vapor con caldera, turbina, condensador y bomba.
@tarjeta ¿Cómo mejorar Brayton? | Subir r_p o T₃, con regeneración o recalentamiento (fuera del material).

@formula Resumen del tema 7
- η_Brayton = 1 − r_p^(−(k−1)/k).
- T₂ = T₁r_p^((k−1)/k); T₄ = T₃r_p^(−(k−1)/k).
- w_neto = c_p[(T₃ − T₄) − (T₂ − T₁)].

@fin
