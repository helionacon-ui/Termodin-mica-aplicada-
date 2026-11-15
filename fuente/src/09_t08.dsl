@bloque t08 | Motores de combustión interna alternativos | UD4 · Tema 8 | #ca8a04 | 8 | T8 · Motores alternativos | Temas
@objetivos
- Describo los cuatro tiempos de Otto y Diesel en su ciclo ideal.
- Calculo el rendimiento de Otto y de Diesel con r y r_c.
- Comparo los dos ciclos a igual relación de compresión.
- Explico por qué el ciclo ideal sobreestima el rendimiento real.

@intro
El motor de tu coche es un ciclo de Otto y el de un camión, un ciclo Diesel. Son ciclos alternativos: un pistón sube y baja y cada golpe es un proceso.

@zero Qué es el ciclo ideal de aire
Para entender el motor no hace falta la química de la combustión. El **ciclo de aire estándar** sustituye la combustión por un aporte de calor y el escape por una cesión de calor a volumen constante. Así el aire es el único fluido y el ciclo es fácil de calcular.

@intuicion
El pistón comprime el aire en una décima de segundo. Como la compresión es rápida, casi no hay tiempo para que el calor escape: se aproxima como adiabática. Cuanto más comprimes (mayor r), más sube la temperatura antes de quemar el combustible, y mejor es el ciclo. Pero tiene límite: se alcanza la autoignición o el golpeteo.

@formula Rendimiento de Otto y de Diesel
$$\eta_{\text{Otto}} = 1 - \frac{1}{r^{k-1}} \qquad \eta_{\text{Diesel}} = 1 - \frac{1}{r^{k-1}}\cdot\frac{r_c^k - 1}{k\,(r_c - 1)}$$

$r$ es la relación de compresión (volumen máximo entre mínimo) y $r_c$ la relación de corte (volumen después de la combustión entre el inicial de ella). En Otto, la combustión es a volumen constante.

@grupo Trucos de clase · Tema 8 · Motores alternativos: Otto, Diesel y Dual | abierto
La diferencia entre los tres está en cómo entra el calor: Otto a volumen constante, Diesel a presión constante y Dual en las dos fases.
@intuicion
El motor de cuatro tiempos hace admisión, compresión, combustión y expansión, y escape. El ciclo de aire estándar sustituye la combustión por un aporte de calor.
**Trucos**
1. Otto: η = 1 − 1 / r^(γ−1).
2. Diesel: η = 1 − (1 / r^(γ−1)) · (β^γ − 1) / [γ(β − 1)].
3. Dual: η = 1 − (1 / r^(γ−1)) · (αβ^γ − 1) / [(α − 1) + γα(β − 1)].
4. Casos límite del Dual, según la diapositiva: si α = 1 se obtiene el Diesel; si β = 1, el Otto. Úsalo para comprobar la fórmula.
5. El Diesel comprime solo aire y el combustible entra al final, así que no hay detonación y puede usar relaciones de compresión mayores. En el Otto la mezcla se comprime y la detonación limita r.
6. A la misma relación de compresión, el Otto tiene mejor rendimiento que el Diesel.
@trampa
Confundir α (combustión a volumen constante, α = p₃/p₂) con β (combustión a presión constante, β = v₃/v₂).
@fin

@ejemplo Otto y Diesel a igual compresión
@enunciado
Calcula el rendimiento ideal de Otto con r = 8 y el de Diesel con r = 16 y r_c = 2. Usa k = 1,4.
@antes
Otto solo depende de r. Diesel depende de r y de r_c; el segundo factor es siempre mayor que 1 cuando r_c > 1.
@paso Otto
$$\eta_{\text{Otto}} = 1 - \frac{1}{8^{0{,}4}} = 1 - 0{,}4353 = 0{,}565 = 56{,}5\ \%$$
@paso Diesel
$$\eta_{\text{Diesel}} = 1 - \frac{1}{16^{0{,}4}}\cdot\frac{2^{1{,}4} - 1}{1{,}4\,(2 - 1)} = 1 - 0{,}3299\cdot 1{,}1707 = 0{,}614 = 61{,}4\ \%$$
@resultado
η_Otto ≈ 56,5 %; η_Diesel ≈ 61,4 % (con r = 16 y r_c = 2). Diesel gana con mayor compresión; a igual r, Diesel rinde menos.
@fin

@ejemplo Otto: rendimiento y presión media efectiva
@enunciado
Ciclo Otto de aire estándar con r = 9, T₁ = 300 K y P₁ = 100 kPa. Se aportan q_ent = 1000 kJ/kg. Calcula el rendimiento, T₃ y la presión media efectiva. k = 1,4, c_v = 0,718, R = 0,287 kJ/(kg·K).
@antes
El rendimiento solo depende de r: η = 1 − r^(1−k). T₂ sale de la compresión adiabática y T₃ del aporte de calor a volumen constante. La presión media efectiva es el trabajo neto entre la cilindrada específica.
@paso Rendimiento y temperaturas
$$\eta = 1 - 9^{-0{,}4} = 0{,}5848\qquad T_2 = T_1 r^{k-1} = 300\cdot 9^{0{,}4} = 722{,}5\ \text{K}\qquad T_3 = T_2 + \frac{q_{ent}}{c_v} = 2115\ \text{K}$$
@paso Trabajo neto y presión media efectiva
$$w_{neto} = \eta\,q_{ent} = 584{,}8\ \text{kJ/kg}\qquad v_1 = \frac{RT_1}{P_1} = 0{,}861\ \text{m³/kg}$$
$$PME = \frac{w_{neto}}{v_1 - v_2} = \frac{w_{neto}}{v_1(1 - 1/r)} = 764\ \text{kPa}$$
@resultado
η ≈ 58,5 %; T₃ ≈ 2115 K; PME ≈ 764 kPa (≈ 7,6 bar).
@fin

@ejemplo Rendimiento del ciclo Diesel
@enunciado
Un ciclo Diesel de aire estándar tiene r = 18 y relación de corte r_c = 2 (k = 1,4). Calcula su rendimiento y compáralo con un Otto de la misma relación de compresión.
@antes
En el Diesel, el calor se aporta a presión constante, y η = 1 − r^(1−k) · (r_c^k − 1)/(k (r_c − 1)). El factor entre paréntesis siempre es mayor que 1.
@paso Otto con r = 18
$$\eta_{Otto} = 1 - 18^{-0{,}4} = 0{,}6853$$
@paso Diesel
$$\eta_{Diesel} = 1 - 18^{-0{,}4}\cdot\frac{2^{1{,}4} - 1}{1{,}4\,(2-1)} = 0{,}6316$$
@resultado
η_Diesel ≈ 63,2 % frente a η_Otto ≈ 68,5 %. A igual relación de compresión, el Otto rinde más; pero el Diesel admite r mucho mayor (no hay detonación), y por eso en la práctica rinde más.
@fin

@trampa Lo que el examen mira en motores
- No confundir r (compresión) con r_c (corte).
- Escribir η_Otto con r_c. Otto no tiene r_c.
- Creer que el ciclo ideal es el real: el real pierde por fricción, calor a las paredes y combustión incompleta. El rendimiento real de un coche está muy por debajo del 56 %.
- Comparar un Otto de r = 8 con un Diesel de r = 16 y decir que Diesel es peor: son ciclos con compresiones distintas.

@masfondo Por qué el Diesel tiene mejor rendimiento a igual r
A igual r, el Diesel rinde menos que el Otto (su factor de corte es mayor que 1). Pero el Diesel puede comprimir más sin golpeteo, porque el combustible no está mezclado con el aire al comprimir. Por eso, en la práctica, el Diesel con r ≈ 16 a 20 rinde mejor que un Otto con r ≈ 10.

@sim otto-diesel | Simulador: Otto y Diesel frente a la relación de compresión
@abrirsim otto-diesel | Abrir en el simulador: sube r y compara

@test
? Un Otto ideal con r = 8 y k = 1,4 tiene un rendimiento de:
* Aproximadamente 56,5 %.
- Aproximadamente 44,8 %.
- Aproximadamente 100 %.
! η = 1 − 1/8^0,4 = 0,565. El 44,8 % es el Brayton de r_p = 8 (tema 7).
@test
? En el Diesel, ¿qué representa r_c?
- La relación de compresión.
* La relación de volumen tras la combustión a presión constante.
- La relación de presiones de la turbina.
! r_c es el cociente de volúmenes en la fase de aporte de calor a presión constante.

@tarjeta ¿Qué es r? | Relación de compresión: V máximo entre V mínimo.
@tarjeta ¿Qué es r_c? | Relación de corte del Diesel: volumen final entre el inicial de la combustión.
@tarjeta ¿Por qué no es real? | Pérdidas por fricción, calor a las paredes y combustión incompleta.

@formula Resumen del tema 8
- η_Otto = 1 − r^(1−k).
- η_Diesel = 1 − r^(1−k)·(r_c^k − 1)/(k(r_c − 1)).
- Ciclo ideal de aire: cota superior, no valor real.

@fin
