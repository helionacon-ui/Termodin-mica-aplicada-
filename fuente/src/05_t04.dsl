@bloque t04 | Sistemas abiertos | UD2 · Tema 4 | #0e7490 | 4 | T4 · Sistemas abiertos | Temas
@objetivos
- Aplico el balance de masa y de energía a un volumen de control.
- Sé cuándo un dispositivo es turbina, compresor, tobera, válvula o intercambiador.
- Calculo trabajo, potencia y velocidad de salida en régimen estacionario.
- Sé por qué una válvula conserva la entalpía.

@intro
Un sistema abierto es una región del espacio por la que pasa masa: una turbina, un compresor, una tobera o un intercambiador. Casi todos los problemas de examen del material son de este tipo.

@zero Volumen de control y régimen estacionario
Dibuja una línea discontinua alrededor del dispositivo. Eso es el **volumen de control**. La masa y la energía pueden entrar y salir por las secciones de entrada y salida. Si nada cambia con el tiempo (presiones, temperaturas y caudales constantes), el sistema está en **régimen estacionario**. Ese es el caso de casi todos los problemas.

@formula Balances en régimen estacionario
$$\dot m_1 = \dot m_2 = \dot m \qquad \text{(balance de masa)}$$

$$\dot Q - \dot W = \dot m\left[(h_2 - h_1) + \frac{c_2^2 - c_1^2}{2} + g(z_2 - z_1)\right]$$

Con $c$ en m/s y $h$ en kJ/kg, el término $c^2/2$ sale en J/kg: divide entre 1000 para kJ/kg.

@intuicion
Piensa en un grifo abierto con un tubo que se estrecha. La masa que entra es la misma que sale (balance de masa). La energía que entra con el fluido (entalpía y velocidad) menos la que sale tiene que ser igual al trabajo que el dispositivo intercambia y al calor que pierde. Ya está: ese es el balance de energía.

@formula Dispositivos típicos
- **Turbina** (adiabática): $\dot W = \dot m (h_1 - h_2)$. Con el rendimiento isentrópico: $\eta_T = \dfrac{h_1 - h_2}{h_1 - h_{2s}}$.
- **Compresor**: $\eta_C = \dfrac{h_{2s} - h_1}{h_2 - h_1}$. Aquí el trabajo entra al sistema: $\dot W < 0$.
- **Tobera**: $c_2 = \sqrt{2(h_1 - h_2)}$ (con $c_1 \approx 0$ y en J/kg).
- **Válvula de estrangulamiento**: $h_1 = h_2$ (isoentálpica, sin trabajo ni calor).

@zero Desde cero: por qué la válvula conserva la entalpía
En una válvula el fluido pasa de alta a baja presión sin hacer trabajo ni recibir calor apreciable, y su velocidad cambia poco. El balance de energía se reduce a h₁ = h₂. Así que no hay que buscar ninguna otra relación: solo la entalpía se conserva. Es la clave del ciclo de refrigeración (tema 9).

@ejemplo Turbina de vapor con rendimiento isentrópico
@enunciado
Vapor entra en una turbina adiabática con h₁ = 3000 kJ/kg. La expansión isentrópica llega a h₂s = 2500 kJ/kg. El rendimiento isentrópico es η = 0,85. Calcula h₂ y el trabajo por kg.
@antes
Con η dado, el estado real de salida tiene más entalpía que el isentrópico. El trabajo real es menor que el ideal.
@paso Despejar h₂
$$\eta_T = \frac{h_1 - h_2}{h_1 - h_{2s}} \;\Rightarrow\; h_2 = h_1 - \eta_T(h_1 - h_{2s}) = 3000 - 0{,}85\cdot 500 = 2575\ \text{kJ/kg}$$
@paso Trabajo por kilogramo
$$w = h_1 - h_2 = 3000 - 2575 = 425\ \text{kJ/kg}$$
@resultado
h₂ = 2575 kJ/kg y w = 425 kJ/kg. El ideal daría 500 kJ/kg: pierdes 75 kJ/kg por irreversibilidad.
@fin

@ejemplo Tobera adiabática
@enunciado
Vapor entra en una tobera adiabática con h₁ = 3000 kJ/kg, c₁ ≈ 0 y sale con h₂ = 2900 kJ/kg. Calcula c₂.
@antes
Balance de energía sin trabajo, sin calor y con c₁ ≈ 0. Queda c₂²/2 = h₁ − h₂ (en J/kg).
@paso Balance
$$\frac{c_2^2}{2} = (h_1 - h_2)\cdot 1000 = 100\,000\ \text{J/kg}$$
@paso Velocidad
$$c_2 = \sqrt{2\cdot 100\,000} = 447{,}2\ \text{m/s}$$
@resultado
c₂ ≈ 447,2 m/s.
@fin

@ejemplo Válvula de estrangulamiento sobre vapor de agua
@enunciado
Vapor de agua a 1 MPa y 200 °C pasa por una válvula hasta 0,1 MPa. Calcula el estado final, con h₂ = h₁ = 2827,9 kJ/kg. Datos de la tabla de vapor a 0,1 MPa: h a 150 °C = 2776,4 kJ/kg; h a 200 °C = 2870,5 kJ/kg; h_g(0,1 MPa) = 2675,5 kJ/kg.
@antes
Válvula: h₂ = h₁. A 0,1 MPa, h = 2827,9 es mayor que h_g: el estado final es vapor sobrecalentado, no mezcla.
@paso Comprobar la región
A 0,1 MPa, h_g = 2675,5 kJ/kg. Como 2827,9 > 2675,5, el vapor sale sobrecalentado.
@paso Interpolar la temperatura
$$T_2 = 150 + \frac{2827{,}9 - 2776{,}4}{2870{,}5 - 2776{,}4}\cdot 50 = 150 + 27{,}4 = 177{,}4\ \text{°C}$$
@resultado
Sale vapor sobrecalentado a unos 177 °C. La válvula no hace trabajo, pero el vapor pierde presión y se enfría.
@fin

@trampa Lo que te hace perder puntos en sistemas abiertos
- Olvidar el signo del trabajo de un compresor (entra al sistema).
- Dejar c²/2 en m²/s² sin pasar a kJ/kg.
- Usar h₁ = h₂ en una turbina. Una turbina no es una válvula: hay trabajo.
- Escribir Ṁ en vez de ṁ. Los caudales se escriben con punto sobre la masa.

@masfondo Dónde están el calor y el trabajo de un intercambiador
Un intercambiador no hace trabajo (Ẇ = 0) y se considera aislado si el enunciado lo dice. El calor que cede un fluido lo recibe el otro: Q̇ = ṁ₁(h₁ − h₂) = −ṁ₂(h₃ − h₄). Eso permite calcular un caudal desconocido.

@sim turbina-eta | Simulador: turbina con rendimiento isentrópico
@abrirsim turbina-eta | Abrir en el simulador: cambia η y mira el trabajo

@test
? Una válvula de estrangulamiento tiene h₂ = h₁. ¿Qué implica?
* No hay cambio de entalpía: la válvula conserva h.
- La válvula no cambia la presión.
- La temperatura siempre baja.
! En una válvula ideal la entalpía se conserva. La presión cae, y la temperatura puede bajar o subir según el fluido.
@test
? Para una turbina con η = 0,85, ¿el trabajo real es mayor o menor que el isentrópico?
- Mayor.
* Menor.
- Igual.
! El rendimiento isentrópico describe la pérdida: h₂ es mayor que h₂s y el trabajo es menor.

@tarjeta ¿Cuándo es tobera? | Cuando aumenta la velocidad a costa de entalpía. Sin trabajo ni calor.
@tarjeta ¿Qué es η de una turbina? | (h₁ − h₂)/(h₁ − h₂s). Compara el trabajo real con el ideal.
@tarjeta ¿Por qué ṁ en los balances? | Porque los balances son por unidad de tiempo: ṁ₁ = ṁ₂ en régimen estacionario.

@formula Resumen del tema 4
- Masa: ṁ₁ = ṁ₂ (si hay una entrada y una salida).
- Energía: Q̇ − Ẇ = ṁ[Δh + Δc²/2 + gΔz].
- Turbina η = (h₁ − h₂)/(h₁ − h₂s); compresor η = (h₂s − h₁)/(h₂ − h₁); válvula h₁ = h₂.

@fin
