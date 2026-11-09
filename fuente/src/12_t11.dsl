@bloque t11 | Mezcla reactiva. Combustión | UD6 · Tema 11 | #be185d | 11 | T11 · Combustión | Temas
@objetivos
- Escribo la reacción de combustión completa y calculo el aire teórico.
- Calculo la relación aire-combustible y el exceso de aire.
- Distingo PCS y PCI y los relaciono con el agua producida.
- Calculo la fracción de vapor en los productos y su punto de rocío.

@intro
Un combustible reacciona con el oxígeno del aire y libera energía. Este tema calcula cuánto aire hace falta, qué sale por la chimenea y cuánta energía se obtiene realmente.

@zero Qué es una reacción de combustión
Es una reacción química en la que el combustible (carbono, hidrógeno) se oxida. Con metano, CH₄, la reacción completa produce CO₂ y H₂O. El aire aporta el oxígeno, junto con el nitrógeno que lo acompaña.

@intuicion
El aire es 21 % de O₂ y 79 % de N₂ en moles. Por cada mol de O₂ entran unos 3,76 moles de N₂ "de regalo", que no reaccionan pero ocupan volumen y se llevan calor. Por eso el aire es tan importante en el cálculo de los productos.

@formula Combustión estequiométrica del metano
$$\mathrm{CH_4} + 2\,(\mathrm{O_2} + 3{,}76\,\mathrm{N_2}) \rightarrow \mathrm{CO_2} + 2\,\mathrm{H_2O} + 7{,}52\,\mathrm{N_2}$$

Aire teórico: 2 · 4,76 = 9,52 mol de aire por mol de CH₄. Relación aire-combustible en masa: $\mathrm{A/F} = 9{,}52\cdot 28{,}97/16{,}043 = 17{,}19$ kg de aire por kg de CH₄.

@formula Exceso de aire y productos
Con un exceso e, el aire es $(1+e)\cdot 9{,}52$ mol por mol de CH₄. Los productos son:
$$\mathrm{CO_2} = 1 \qquad \mathrm{H_2O} = 2 \qquad \mathrm{O_2} = 2e \qquad \mathrm{N_2} = 7{,}52\,(1+e)$$

@formula Poder calorífico superior e inferior
$$\mathrm{PCS} = -\Delta H_r \;\;(\text{agua líquida}) \qquad \mathrm{PCI} = -\Delta H_r \;\;(\text{agua vapor})$$

Con $\Delta H_r = \sum h_{f,\text{productos}} - \sum h_{f,\text{reactivos}}$ a 25 °C y 1 atm. Para el metano (datos de tabla): $\Delta H_{r,\text{PCS}} = -890\,330$ kJ/kmol y $\Delta H_{r,\text{PCI}} = -802\,310$ kJ/kmol.

@ejemplo Poderes caloríficos y aire del metano
@enunciado
Calcula el PCS y el PCI del metano en kJ/kg (M = 16,043 kg/kmol) y la relación aire-combustible estequiométrica.
@antes
Los valores de entalpía de formación dan la energía por kmol. Divide entre la masa molar para tener kJ/kg.
@paso Energía por kilomol
$$\Delta H_{\text{PCS}} = |{-393\,520} + 2(-285\,830) - (-74\,850)| = 890\,330\ \text{kJ/kmol}$$
$$\Delta H_{\text{PCI}} = |{-393\,520} + 2(-241\,820) - (-74\,850)| = 802\,310\ \text{kJ/kmol}$$
@paso Por kilogramo
$$\mathrm{PCS} = \frac{890\,330}{16{,}043} = 55\,496\ \text{kJ/kg} \qquad \mathrm{PCI} = \frac{802\,310}{16{,}043} = 50\,010\ \text{kJ/kg}$$
@paso Comprobación
La diferencia PCS − PCI = 5 486 kJ/kg debe ser igual a 2 moles de agua condensada por kilomol de metano. Con h_fg(25 °C) ≈ 2442 kJ/kg: 2 · 18,015 · 2442 / 16,043 ≈ 5 485 kJ/kg. Coincide.
@paso Aire
$$\mathrm{A/F} = \frac{9{,}52\cdot 28{,}97}{16{,}043} = 17{,}19\ \text{kg/kg}$$
@resultado
PCS ≈ 55 496 kJ/kg; PCI ≈ 50 010 kJ/kg; A/F = 17,19 kg de aire por kg de CH₄.
@fin

@ojo Errores de la solución de referencia del examen (combustión)
La solución de referencia del problema de metano escribe PCS = 55 514,6 kJ/kg y PCI = 50 012,8 kJ/kg. Con los mismos datos de entalpía y M = 16,043 kg/kmol, los valores correctos son 55 496 y 50 010 kJ/kg. Además escribe −241 280 kJ/kmol en una línea intermedia, cuando el dato es −241 820.

@ejemplo Metano con 50 % de exceso de aire
@enunciado
Metano quemado con 50 % de exceso de aire, a 1 atm. Calcula la fracción molar de vapor de agua en los productos, su presión parcial y la temperatura de rocío de los productos.
@antes
Exceso: aire = 1,5 · 9,52 = 14,28 mol/mol. Productos con agua y la presión total de 1 atm.
@paso Productos
$$\mathrm{CO_2} = 1 \quad \mathrm{H_2O} = 2 \quad \mathrm{O_2} = 2\cdot 0{,}5 = 1{,}0 \quad \mathrm{N_2} = 7{,}52\cdot 1{,}5 = 11{,}28 \quad \text{total} = 15{,}28\ \text{mol}$$
@paso Fracción molar y presión parcial
$$y_{\text{H}_2\text{O}} = \frac{2}{15{,}28} = 0{,}1309 \qquad p_v = 0{,}1309\cdot 101{,}325 = 13{,}26\ \text{kPa}$$
@paso Punto de rocío
Interpolando en la tabla de saturación del agua entre 50 °C (12,35 kPa) y 55 °C (15,76 kPa), T_dp ≈ 51,5 °C.
@resultado
y_H₂O ≈ 0,1309; p_v ≈ 13,26 kPa; T de rocío ≈ 51,5 °C. Si la chimenea está por debajo de esta T, el vapor condensa.
@fin

@ojo Error de la solución de referencia en la fracción de agua
La solución de referencia escribe y_H₂O = 2/(11,28 + 1 + 2) = 0,14 atm, omitiendo el CO₂ de los productos. El total correcto incluye el CO₂: 1 + 2 + 1 + 11,28 = 15,28 mol, y la fracción es 0,1309.

@masfondo PCS, PCI y el rendimiento de una caldera
El PCS incluye la energía que da el vapor de agua al condensarse. Una caldera de condensación recupera ese calor, por eso su rendimiento sobre PCS puede superar el 100 % si se refiere a PCI. Conviene decir siempre a cuál se refiere el rendimiento.

@sim combustion-ch4 | Simulador: exceso de aire, productos y punto de rocío
@abrirsim combustion-ch4 | Abrir en el simulador: cambia el exceso de aire

@test
? ¿Cuál es la relación aire-combustible estequiométrica del metano (en masa)?
- 9,52 kg/kg.
* 17,19 kg/kg.
- 2,00 kg/kg.
! Son 9,52 mol de aire por mol de CH₄; en masa, 9,52·28,97/16,043 = 17,19 kg/kg.
@test
? ¿Qué diferencia hay entre PCS y PCI?
- El PCS usa el agua en fase vapor.
* El PCS supone agua líquida en los productos; el PCI, agua vapor.
- No hay diferencia en el metano.
! El PCS incluye el calor de condensación del agua. Por eso es mayor que el PCI.

@tarjeta ¿Qué es el exceso de aire? | Aire por encima del estequiométrico, que asegura la combustión completa.
@tarjeta ¿Qué es el PCS? | Poder calorífico superior: agua de los productos en estado líquido.
@tarjeta ¿Y el punto de rocío de los productos? | T a la que el vapor de agua de los gases de combustión empieza a condensar.

@formula Resumen del tema 11
- A/F estequiométrico del CH₄ = 17,19 kg/kg (9,52 mol de aire por mol).
- Productos con exceso e: CO₂ = 1; H₂O = 2; O₂ = 2e; N₂ = 7,52(1 + e).
- PCS − PCI = agua condensada por kilomol de combustible × h_fg.

@fin
