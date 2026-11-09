@bloque t03 | Sistemas cerrados | UD2 · Tema 3 | #c2410c | 3 | T3 · Sistemas cerrados | Temas
@objetivos
- Escribo el balance de energía de un sistema cerrado.
- Calculo el trabajo de frontera en procesos isobaros y politrópicos.
- Distingo W y Q por su signo y decido qué término es cero.
- Calculo ΔU con tablas o con c_v.

@intro
Un sistema cerrado no intercambia masa con el entorno: un gas dentro de un pistón, el agua de una olla tapada. Solo puede haber energía en forma de calor Q y de trabajo W.

@zero Qué es el trabajo de frontera
Si el pistón se mueve, el gas empuja y hace trabajo sobre el entorno. El trabajo de frontera es la fuerza por el desplazamiento: W = ∫P dV. Es la energía que "sale" con el movimiento del émbolo. Si el volumen no cambia, el trabajo es cero.

@intuicion
Piensa en un globo que se hincha. El aire del interior empuja la goma y hace trabajo sobre la atmósfera. Si lo calientas con el globo cerrado, no hay movimiento y no hay trabajo: toda la energía se queda dentro como energía interna.

@formula Balance de energía para un sistema cerrado
$$Q - W = \Delta U + \Delta E_c + \Delta E_p \qquad\text{(en la mayoría de problemas, } \Delta E_c = \Delta E_p = 0\text{)}$$

Convención de esta guía: **Q > 0 entra** al sistema y **W > 0 sale** del sistema. Con ella:

$$Q - W = m\,(u_2 - u_1)$$

@formula Trabajo de frontera en procesos concretos
- Isobaro: $W = P\,(V_2 - V_1)$
- Isocoro (volumen constante): $W = 0$
- Politrópico $PV^n = \text{cte}$, con $n \neq 1$: $W = \dfrac{P_2 V_2 - P_1 V_1}{1 - n}$
- Isotermo de gas ideal: $W = mRT\ln\dfrac{V_2}{V_1}$

@zero Desde cero: cómo se usa la primera ley
Escribe el balance antes de nada. Mira qué términos son cero (volumen constante, adiabático, sin cambio de energía cinética). Luego calcula ΔU, W y Q con las fórmulas de arriba. Si te dan Q y W, el signo indica si entra o sale.

@grupo Trucos de clase · Tema 3 · Primer principio | abierto
La energía no se crea ni se destruye: ΔE = Q − W, con Q que entra al sistema y W que sale.
@intuicion
El calor y el trabajo son dos formas de transferir energía. La energía total del sistema cambia por lo que entra menos lo que sale.
**Trucos**
1. Fija la convención de signos al principio del problema: Q positivo si entra al sistema; W positivo si lo realiza el sistema.
2. ΔU y ΔH no dependen del camino; Q y W sí. Si te piden Q o W, necesitas conocer el camino.
3. Trabajo de expansión W = ∫P dV. En un proceso isocoro W = 0 y Q = ΔU.
4. En un ciclo completo ΔU = 0, así que Q_neto = W_neto, y el rendimiento es η = W_neto / Q_entrada.
5. El trabajo de rozamiento |W_r| acaba como energía interna: W₁₂ = ∫P dV − |W_r|.
6. Si hay rozamiento, expansión libre o diferencias finitas de presión o temperatura, el proceso es irreversible.
@trampa
Tomar Q y W como propiedades del estado. Solo ΔU, ΔH y ΔS son independientes del camino.
@fin

@ejemplo Calentamiento isobaro de aire en un cilindro
@enunciado
1 kg de aire en un cilindro-émbolo a 2 bar se calienta a presión constante desde 300 K hasta 500 K. Calcula W, ΔU y Q. Usa c_v = 0,718 kJ/(kg·K) y R = 0,287 kJ/(kg·K).
@antes
El proceso es isobaro: W = P ΔV = mR ΔT. La energía interna depende de la temperatura: ΔU = m c_v ΔT. Luego la primera ley da Q.
@paso Trabajo
$$W = mR\,\Delta T = 1 \cdot 0{,}287 \cdot 200 = 57{,}4\ \text{kJ}$$
@paso Energía interna
$$\Delta U = m\,c_v\,\Delta T = 1 \cdot 0{,}718 \cdot 200 = 143{,}6\ \text{kJ}$$
@paso Calor
$$Q = \Delta U + W = 143{,}6 + 57{,}4 = 201{,}0\ \text{kJ}$$
@resultado
W = 57,4 kJ (sale del gas); ΔU = 143,6 kJ; Q = 201,0 kJ (entra).
@fin

@ejemplo Expansión politrópica de aire
@enunciado
Aire, 1,742 kg, sale de 300 kPa y 300 K (V₁ = 0,5 m³) y se expande con n = 1,3 hasta V₂ = 1 m³. Calcula P₂, T₂, W, ΔU y Q. Usa c_v = 0,718 kJ/(kg·K).
@antes
Con n ≠ 1: P₂ = P₁(V₁/V₂)ⁿ, T₂ de la ley de gas ideal, W con la fórmula politrópica, y la primera ley para Q.
@paso Presión final
$$P_2 = P_1\left(\frac{V_1}{V_2}\right)^n = 300\cdot 0{,}5^{1{,}3} = 121{,}8\ \text{kPa}$$
@paso Temperatura final
$$T_2 = T_1\left(\frac{P_2}{P_1}\right)^{\frac{n-1}{n}} = 300\cdot 0{,}406^{0{,}2308} = 243{,}7\ \text{K}$$
@paso Trabajo
$$W = \frac{P_2V_2 - P_1V_1}{1-n} = \frac{121{,}8\cdot 1 - 300\cdot 0{,}5}{1 - 1{,}3} = 93{,}9\ \text{kJ}$$
@paso Energía interna y calor
$$\Delta U = m c_v (T_2 - T_1) = 1{,}742 \cdot 0{,}718 \cdot (243{,}7 - 300) = -70{,}5\ \text{kJ}$$
$$Q = \Delta U + W = -70{,}5 + 93{,}9 = 23{,}4\ \text{kJ}$$
@resultado
P₂ ≈ 121,8 kPa; T₂ ≈ 243,7 K; W ≈ 93,9 kJ; ΔU ≈ −70,5 kJ; Q ≈ 23,4 kJ (entra calor al gas).
@fin

@trampa Signos y W: lo que más se pierde
- Si el gas se expande, W > 0 (sale). Si lo comprimes, W < 0.
- Un ΔU negativo no significa que el gas "pierda calor": significa que su temperatura baja. Con W > 0 el Q puede ser positivo aunque el gas se enfríe.
- En un proceso politrópico con n = 1,3, el calor no es cero. Solo es cero en un adiabático (n = k = 1,4 para el aire reversible).

@masfondo Por qué ΔU sale del calor específico y no del trabajo
La energía interna de un gas ideal no depende del volumen (es la ley de Joule). Por eso ΔU solo necesita ΔT. El trabajo y el calor sí dependen del camino: por eso se llaman funciones de camino y no propiedades.

@abrirsim gas-politropico | Abrir en el simulador: politrópico con aire

@test
? En un proceso isocoro de un gas, ¿cuánto vale W?
* Cero: no hay cambio de volumen.
- Igual a Q.
- Igual a ΔU.
! W = ∫P dV = 0 si dV = 0. Entonces Q = ΔU.
@test
? Un sistema cerrado gana 100 kJ de calor y hace 40 kJ de trabajo. ¿Cuánto cambia su energía interna (sin cambios de energía cinética ni potencial)?
- +140 kJ.
* +60 kJ.
- −60 kJ.
! Q − W = ΔU: 100 − 40 = 60 kJ.

@tarjeta ¿Qué pasa en un isocoro? | W = 0, luego Q = ΔU.
@tarjeta ¿Y en un adiabático? | Q = 0, luego −W = ΔU.
@tarjeta ¿Signo de W en esta guía? | W > 0 cuando el sistema hace trabajo (sale).

@formula Resumen del tema 3
- Q − W = ΔU (sistema cerrado, sin energía cinética ni potencial).
- W = P(V₂ − V₁) isobaro; W = (P₂V₂ − P₁V₁)/(1 − n) politrópico.
- ΔU = m c_v ΔT para gas ideal.

@fin
