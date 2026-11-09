@bloque t05 | Segundo principio | UD3 · Tema 5 | #b45309 | 5 | T5 · Segundo principio | Temas
@objetivos
- Enuncio el segundo principio con palabras propias.
- Calculo η de Carnot y los COP de un refrigerador y de una bomba de calor.
- Decido si un proceso es posible usando el sentido de la transferencia de calor.
- Explico por qué ningún ciclo real iguala al de Carnot.

@intro
El primer principio dice que la energía se conserva. El segundo dice **en qué sentido** ocurren los procesos. Sin él, un barco podría enfriar el mar para navegar.

@zero Qué dice el segundo principio
Hay dos enunciados equivalentes. **Kelvin-Planck**: no existe una máquina que convierta todo el calor de un foco en trabajo sin dejar nada más. **Clausius**: no existe un proceso cuyo único resultado sea pasar calor de un foco frío a uno caliente.

@intuicion
Un vaso con hielo en una habitación caliente se derrite solo. Nunca se enfría solo el vaso de agua caliente para dejar hielo más frío sin gastar energía. El calor va de caliente a frío por sí mismo; para ir al revés hace falta trabajo externo. Ese "sentido" es el segundo principio.

@formula Rendimientos y COP
Para una máquina térmica que absorbe $Q_H$ y cede $Q_C$:
$$\eta = \frac{W}{Q_H} = 1 - \frac{Q_C}{Q_H}$$

Para un refrigerador y una bomba de calor:
$$\mathrm{COP}_{\text{ref}} = \frac{Q_C}{W} \qquad \mathrm{COP}_{\text{bomba}} = \frac{Q_H}{W}$$

@formula Carnot: el máximo posible
Entre dos focos a $T_H$ y $T_C$ (absolutas), ninguna máquina supera el rendimiento de Carnot:

$$\eta_{\text{Carnot}} = 1 - \frac{T_C}{T_H} \qquad \mathrm{COP}_{\text{ref,Carnot}} = \frac{T_C}{T_H - T_C} \qquad \mathrm{COP}_{\text{bomba,Carnot}} = \frac{T_H}{T_H - T_C}$$

@zero Desde cero: por qué kelvin
Estas fórmulas usan **temperaturas absolutas**. Si usas °C, el cociente T_C/T_H puede dar valores absurdos (por ejemplo, con 0 °C y 100 °C daría 0, cuando el rendimiento real no es cero). Convierte siempre antes de calcular.

@ejemplo Carnot entre 800 K y 300 K
@enunciado
Una máquina de Carnot trabaja entre un foco a 800 K y otro a 300 K. Calcula su rendimiento, el COP de un refrigerador y el COP de una bomba de calor que trabajan entre esas temperaturas.
@antes
Con temperaturas absolutas, las tres fórmulas son directas. Ojo: el COP del refrigerador y de la bomba usan denominadores distintos.
@paso Rendimiento
$$\eta = 1 - \frac{300}{800} = 0{,}625 = 62{,}5\ \%$$
@paso COP del refrigerador
$$\mathrm{COP}_{\text{ref}} = \frac{T_C}{T_H - T_C} = \frac{300}{800 - 300} = 0{,}60$$
@paso COP de la bomba de calor
$$\mathrm{COP}_{\text{bomba}} = \frac{T_H}{T_H - T_C} = \frac{800}{500} = 1{,}60$$
@resultado
η = 62,5 %; COP refrigerador = 0,60; COP bomba = 1,60. Observa que COP bomba = COP refrigerador + 1 (en Carnot).
@fin

@trampa Dos errores frecuentes
- Calcular Carnot con °C: el resultado puede ser negativo o imposible.
- Confundir COP refrigerador con COP bomba. El refrigerador quiere sacar calor del frío (Q_C); la bomba quiere meterlo al caliente (Q_H).
- Pensar que un COP mayor que 1 es imposible. Un COP mayor que 1 es normal en refrigeración; lo imposible es un rendimiento mayor que 1.

@masfondo Cómo se llega a Carnot: la desigualdad de Clausius
Para un ciclo cualquiera: $\oint \frac{\delta Q}{T} \le 0$. La igualdad aparece solo en procesos reversibles. Con dos focos isotermos, el resultado es $\frac{Q_H}{T_H} + \frac{Q_C}{T_C} \le 0$ (con $Q_C < 0$ si sale calor), y de ahí se obtiene $\eta \le 1 - T_C/T_H$. Lo desarrollamos paso a paso en la sección de demostraciones.

@sim carnot | Simulador: ciclo de Carnot entre dos focos
@abrirsim carnot | Abrir en el simulador: prueba T_C cerca de T_H

@intuicion
Si los dos focos están a la misma temperatura, el rendimiento de Carnot es cero. Por eso no existe máquina útil sin diferencia de temperaturas.

@test
? Un refrigerador de Carnot trabaja entre 260 K y 300 K. ¿Cuál es su COP?
* 260/40 = 6,5.
- 300/40 = 7,5.
- 40/300 = 0,13.
! COP_ref = T_C/(T_H − T_C) = 260/(300 − 260) = 6,5. Usa la temperatura del frío en el numerador.
@test
? ¿Qué enunciado del segundo principio prohíbe convertir todo el calor en trabajo?
- Clausius.
* Kelvin-Planck.
- El primer principio.
! Kelvin-Planck afirma que no existe una máquina cíclica que convierta todo el calor de un foco en trabajo sin otros efectos.

@tarjeta ¿Qué es Carnot? | El ciclo reversible entre dos focos: el mejor rendimiento posible con esas temperaturas.
@tarjeta ¿Por qué kelvin? | Porque el rendimiento depende del cociente de temperaturas absolutas.
@tarjeta ¿Puede η ser 1? | Solo si T_C = 0 K, algo inalcanzable (tercer principio).

@formula Resumen del tema 5
- η = W/Q_H; COP_ref = Q_C/W; COP_bomba = Q_H/W.
- η_Carnot = 1 − T_C/T_H; COP_ref,Carnot = T_C/(T_H − T_C).
- Todos los rendimientos reales son menores que Carnot con los mismos focos.

@fin
