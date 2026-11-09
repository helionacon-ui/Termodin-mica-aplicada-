@bloque t06 | Entropía y balances | UD3 · Tema 6 | #7c3aed | 6 | T6 · Entropía y balances | Temas
@objetivos
- Calculo Δs de gases ideales, líquidos y sustancias puras.
- Escribo el balance de entropía de un sistema cerrado y de un volumen de control.
- Calculo S_gen y uso su signo para decidir si un proceso es posible.
- Distingo un proceso adiabático de un proceso isentrópico.

@intro
La entropía es la cuenta de cuánto se ha dispersado la energía. Un proceso es posible solo si la entropía total no disminuye. Este tema es el que más puntúa en los exámenes del material.

@zero Qué es la entropía
Si fueras a describir un sistema con la mínima información, la entropía mide cuántas configuraciones internas son compatibles con lo que ves. Un gas que se expande a un volumen mayor tiene más formas de estar repartido: su entropía sube. Para el cálculo, la definición práctica es: $\delta Q_{\text{rev}}/T$.

@intuicion
Un café caliente en una habitación fría tiene una temperatura que tiende a igualarse. La energía no desaparece, pero se reparte de forma menos útil. Esa "dispersión" aumenta la entropía total, y no vuelve atrás sin gastar trabajo.

@formula Balance de entropía de un sistema cerrado
$$S_2 - S_1 = \int_1^2 \frac{\delta Q}{T_b} + S_{\text{gen}} \qquad S_{\text{gen}} \ge 0$$

$S_{\text{gen}}$ es la entropía generada por las irreversibilidades. Solo es cero en procesos reversibles.

@formula Balance de entropía de un volumen de control
$$\frac{dS_{vc}}{dt} = \sum \frac{\dot Q_j}{T_j} + \sum \dot m_e s_e - \sum \dot m_s s_s + \dot S_{\text{gen}}$$

En régimen estacionario, $dS_{vc}/dt = 0$, y $\dot S_{\text{gen}} = \sum \dot m_s s_s - \sum \dot m_e s_e - \sum \dot Q_j/T_j$.

@zero Desde cero: el signo de S_gen
Si S_gen sale negativo, el proceso es imposible. Si sale cero, es reversible (ideal). Si sale positivo, es posible e irreversible. Antes de dar la respuesta, revisa el signo: es lo que más se evalúa.

@formula Δs para gases ideales y líquidos
- Gas ideal con c constante: $\Delta s = c_p\ln\frac{T_2}{T_1} - R\ln\frac{P_2}{P_1}$ (o con $c_v$ y $v$).
- Líquido incompresible: $\Delta s \approx c\ln\frac{T_2}{T_1}$.
- Sustancia pura: lee $s_f$, $s_g$, $s_{fg}$ o $s$ de la tabla, con interpolación.

@ejemplo Entropía generada en un proceso adiabático de aire
@enunciado
Un kilogramo de aire pasa de 10 bar y 400 K a 2 bar y 330 K en un proceso adiabático. Calcula el cambio de entropía del aire y la entropía generada. Usa c_p = 1,005 kJ/(kg·K) y R = 0,287 kJ/(kg·K).
@antes
Adiabático: Q = 0, luego el término de transferencia de entropía es cero. La entropía generada es el cambio de entropía del sistema.
@paso Cambio de entropía del aire
$$\Delta s = c_p\ln\frac{T_2}{T_1} - R\ln\frac{P_2}{P_1} = 1{,}005\ln\frac{330}{400} - 0{,}287\ln\frac{2}{10}$$
$$= 1{,}005\cdot(-0{,}1924) - 0{,}287\cdot(-1{,}6094) = -0{,}1934 + 0{,}4619 = 0{,}2686\ \text{kJ/(kg·K)}$$
@paso Balance de entropía
Como Q = 0: $S_2 - S_1 = S_{\text{gen}}$. Por kilogramo, $s_{\text{gen}} = \Delta s = 0{,}2686\ \text{kJ/(kg·K)}$.
@paso Interpretar
$s_{\text{gen}} > 0$: el proceso es posible e irreversible. Un proceso isentrópico con la misma relación de presiones daría una temperatura final menor: T₂s = 400·(2/10)^{0,2857} ≈ 253 K.
@resultado
Δs = 0,2686 kJ/(kg·K); s_gen = 0,2686 kJ/(kg·K) > 0: proceso posible.
@fin

@ejemplo Transferencia de calor entre dos focos
@enunciado
Un kilojulio de calor pasa de un foco a 500 K a otro a 300 K. Calcula la entropía generada.
@antes
El calor sale del foco caliente (ΔS negativo) y entra en el frío (ΔS positivo). La generación es la suma de los dos.
@paso Cambios de entropía
$$\Delta S_{\text{caliente}} = -\frac{1}{500} = -0{,}002\ \text{kJ/K} \qquad \Delta S_{\text{frío}} = +\frac{1}{300} = +0{,}003333\ \text{kJ/K}$$
@paso Suma
$$S_{\text{gen}} = 0{,}003333 - 0{,}002 = 0{,}001333\ \text{kJ/K}$$
@resultado
S_gen = 1,333·10⁻³ kJ/K > 0: el proceso es posible e irreversible.
@fin

@trampa Los errores de signo de todo el tema
- Escribir S_gen = ΔS_sistema. No es lo mismo: el balance incluye los focos o el entorno.
- Decir "adiabático = isentrópico". Un adiabático puede ser irreversible (S_gen > 0). Isentrópico = adiabático **y** reversible.
- Usar kelvin mal: la fórmula de Δs del foco usa Q/T con T en K, no en °C.
- Dar S_gen negativo y no revisar. Es imposible: vuelve a comprobar datos o unidades.

@fig balance-entropia | Balance de entropía de un volumen de control

@masfondo Mezcla de gases idénticos: por qué el término es cero
Si mezclas dos porciones del mismo gas a la misma T y P, al final no hay nada que distinguir: la entropía no aumenta. En el tema 10 se ve que la entropía de mezcla solo aparece cuando los gases son distintos.

@sim entropia-transferencia | Simulador: generación de entropía por transferencia de calor
@abrirsim entropia-transferencia | Abrir en el simulador: S_gen con T_H y T_C

@test
? Un proceso adiabático de un gas ideal da S_gen = 0. ¿Qué puedes concluir?
- Que es imposible.
* Que es reversible (e isentrópico).
- Que el gas no cambia de temperatura.
! Sin irreversibilidades y sin calor, la entropía no cambia: el proceso es isentrópico.
@test
? En un proceso real, ¿qué signo tiene S_gen?
- Negativo.
* Positivo (o nulo en el caso ideal).
- Depende del fluido.
! La segunda ley exige S_gen ≥ 0. Un valor negativo indica un error en los datos o los signos.

@tarjeta ¿Qué es S_gen? | La entropía creada por las irreversibilidades. Debe ser ≥ 0.
@tarjeta ¿Adiabático = isentrópico? | No. Isentrópico = adiabático y reversible.
@tarjeta ¿Signo del calor en el balance? | Q/T_b con T_b la temperatura de la frontera donde entra el calor.

@formula Resumen del tema 6
- Sistema cerrado: S₂ − S₁ = ∫δQ/T_b + S_gen.
- Volumen de control: Ṡ_gen = Σṁs_s − Σṁs_e − ΣQ̇/T_b (en régimen estacionario).
- S_gen ≥ 0. Un signo negativo significa error.

@fin
