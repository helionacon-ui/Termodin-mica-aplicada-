@bloque t09 | Refrigeración por compresión de vapor | UD5 · Tema 9 | #0891b2 | 9 | T9 · Refrigeración | Temas
@objetivos
- Describo los cuatro elementos del ciclo de refrigeración por compresión de vapor.
- Calculo el COP con entalpías de tabla.
- Explico por qué la válvula es isoentálpica.
- Entiendo el ciclo de dos etapas con cámara flash y su balance.

@intro
Tu nevera, un aire acondicionado y una bomba de calor usan el mismo ciclo: un refrigerante que cambia de fase, un compresor que lo comprime y una válvula que lo expande. Este tema lo calcula con tablas de R-134a.

@zero Qué hace un refrigerador
Un refrigerador no "crea frío": **transporta calor** de un espacio frío a uno caliente, gastando trabajo. El refrigerante absorbe calor del interior evaporándose a baja presión y lo cede fuera condensándose a alta presión.

@intuicion
Piensa en la evaporación del sudor: el cuerpo se enfría porque el líquido absorbe calor al evaporarse. En la nevera ocurre lo mismo, pero el refrigerante se evapora dentro del evaporador y luego se vuelve a condensar fuera. El compresor es el que empuja el fluido de vuelta a la presión alta.

@formula Los cuatro elementos y sus balances
- **Evaporador** (1 → 4): absorbe calor $q_L = h_1 - h_4$ a presión baja.
- **Compresor** (1 → 2): trabajo $w = h_2 - h_1$ (entra).
- **Condensador** (2 → 3): cede calor $q_H = h_2 - h_3$ a presión alta.
- **Válvula** (3 → 4): $h_4 = h_3$ (isoentálpica).

$$\mathrm{COP}_{\text{ref}} = \frac{q_L}{w} = \frac{h_1 - h_4}{h_2 - h_1}$$

@zero Desde cero: por qué la válvula conserva h
Como en el tema 4, la válvula no hace trabajo ni recibe calor. Por tanto h₃ = h₄. El líquido que entra a la válvula sale como mezcla líquido-vapor a baja presión: una parte se evapora y enfría el resto. Ese vapor "flash" es lo que hace que el ciclo funcione con dos etapas.

@trampa Errores típicos de refrigeración
- Usar la temperatura en °C en el COP de Carnot. Usa T en kelvin.
- Escribir COP = W/Q. Es al revés: COP = Q_L/W.
- Pensar que la válvula enfría "por la presión". Lo que la enfría es la evaporación parcial, a entalpía constante.
- Olvidar el caudal en el balance de cada etapa.

@grupo Trucos de clase · Tema 9 · Refrigeración, bombas de calor y refrigerantes | abierto
Un refrigerador y una bomba de calor son la misma máquina usada con dos objetivos: uno quiere frío y el otro quiere calor.
@intuicion
El refrigerador extrae calor de un foco frío usando trabajo. La bomba de calor entrega ese calor, más el trabajo, al foco caliente. Por eso su COP es siempre mayor que 1.
**Trucos**
1. Carnot inverso: EER = T_F / (T_C − T_F); COP de bomba = T_C / (T_C − T_F).
2. Bomba = refrigerador + 1: COP de bomba = 1 + EER.
3. Código de los refrigerantes, según la diapositiva: R-718 es agua y R-717 es amoníaco (industrial, eficiente, tóxico). R-290 y R-600a son hidrocarburos, inflamables. CFC (R-11, R-12) y HCFC (R-22) dañan la capa de ozono. HFC (R-134a) no la daña, pero tiene alto potencial de calentamiento global.
4. Compresor real: η_comp = (h₂s − h₁) / (h₂ − h₁). Mide cuánto se aleja del compresor isentrópico.
5. Ciclos avanzados: cascada (temperaturas muy bajas), multietapa con cámara flash, absorción (usa calor en lugar de trabajo mecánico), Linde-Hampson (licuación de gases) y Brayton inverso.
@trampa
Confundir el COP del refrigerador con el de la bomba de calor.
@fin

@ejemplo Refrigerador de dos etapas con cámara flash
@enunciado
Un refrigerador de R-134a de dos etapas tiene una cámara flash a 0,4 MPa, condensador a 1,4 MPa y evaporador a 0,1 MPa. Por el condensador circulan 0,25 kg/s. Con las entalpías de la solución de referencia del examen (h₁ = 252,32; h₂ = 280,95; h₃ = 125,26; h₅ = 62,00; h₇ = 231,35; h₈ = 259,50 kJ/kg), calcula el caudal del evaporador, Q_evap, Q_cond, W y el COP.
@antes
Dos corrientes: la que pasa por la cámara flash (vapor 1 y líquido 5) y la que sale del evaporador (7) y pasa por la etapa de baja presión (8). Balance de la cámara flash y balances de cada elemento.
@paso Caudal del evaporador
El balance de masa y energía de la cámara flash da $\dot m_B = 0{,}1608$ kg/s, que es el caudal que pasa por el evaporador.
@paso Calor absorbido en el evaporador
$$\dot Q_{\text{evap}} = \dot m_B (h_7 - h_6) = 0{,}1608\,(231{,}35 - 62{,}00) = 27{,}23\ \text{kW}$$
@paso Calor cedido en el condensador
$$\dot Q_{\text{cond}} = \dot m_A(h_3 - h_2) = 0{,}25\,(125{,}26 - 280{,}95) = -38{,}92\ \text{kW}$$
@paso Trabajo y COP
$$\dot W = |\dot Q_{\text{cond}}| - \dot Q_{\text{evap}} = 38{,}92 - 27{,}23 = 11{,}69\ \text{kW}$$
$$\mathrm{COP} = \frac{\dot Q_{\text{evap}}}{\dot W} = \frac{27{,}23}{11{,}69} = 2{,}33$$
@resultado
COP ≈ 2,33. Con temperaturas de 243 K (frío) y 298 K (caliente), el Carnot daría 243/55 = 4,42: el ciclo real llega a más de la mitad.
@fin

@ojo Signo del balance de entropía en la cámara flash
La solución de referencia escribe el balance de entropía con el signo invertido y obtiene −1,04·10⁻⁴ kW/K. El balance correcto es Ṡ_gen = ṁ_a s₁ + ṁ_B s₅ − ṁ_a s₄ − ṁ_B s₈ = +7,9·10⁻⁵ kW/K ≈ 0. Como es positivo, el proceso es posible. En el examen, un valor negativo no es una respuesta válida.

@masfondo Por qué dos etapas
Con una sola etapa, el compresor tendría que comprimir mucho el vapor de baja presión, con un trabajo grande. Dividir la compresión en dos etapas con un enfriamiento intermedio (la cámara flash) reduce el trabajo y mejora el COP. Es el motivo de los ciclos en cascada y de dos etapas.

@fig refrig-ph | Esquema del ciclo de refrigeración en diagrama P-h
@sim refrigeracion-cop | Simulador: COP de Carnot y COP real

@test
? En un refrigerador, ¿qué mide el COP?
* Calor extraído del espacio frío dividido entre el trabajo.
- Calor cedido al ambiente dividido entre el trabajo.
- Trabajo dividido entre calor extraído.
! COP_ref = Q_L/W. El COP puede ser mayor que 1.
@test
? En la válvula de un ciclo de refrigeración, ¿qué se conserva?
- La presión.
* La entalpía.
- La entropía.
! La válvula es isoentálpica: h₃ = h₄. La presión y la entropía cambian.

@tarjeta ¿Qué es el COP? | Calor extraído dividido entre el trabajo consumido.
@tarjeta ¿Por qué hay cámara flash? | Separa líquido y vapor a presión intermedia y reduce el trabajo de compresión.
@tarjeta ¿Y el COP de Carnot? | T_F/(T_C − T_F), con temperaturas absolutas. Es el máximo posible.

@formula Resumen del tema 9
- COP = q_L/w = (h₁ − h₄)/(h₂ − h₁).
- Válvula: h₃ = h₄.
- Cámara flash: balance de masa y energía; el caudal que sale de la parte baja es el que pasa por el evaporador.

@fin
