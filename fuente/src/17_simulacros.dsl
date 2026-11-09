@bloque simulacros | Simulacros de examen | Resuélvelos antes de mirar la solución | #334155 | | Simulacros | Repaso
Dos simulacros. Resuélvelos sin mirar las soluciones y cronométrate. Las soluciones están plegadas: ábrelas solo cuando hayas intentado cada problema.

@ejercicio sim-a1 | Aire calentado a presión constante | Simulacro A | | Gases ideales,Sistemas cerrados
@enunciado
1 kg de aire a 1 bar y 300 K se calienta a presión constante hasta 500 K. Calcula W, Q y ΔS. Usa c_p = 1,005 kJ/(kg·K), c_v = 0,718 kJ/(kg·K) y R = 0,287 kJ/(kg·K).
@solucion Ver solución de referencia
@paso Trabajo
$$W = mR\,\Delta T = 1\cdot 0{,}287\cdot 200 = 57{,}4\ \text{kJ}$$
@paso Calor
$$Q = m\,c_p\,\Delta T = 1\cdot 1{,}005\cdot 200 = 201{,}0\ \text{kJ}$$
@paso Entropía
$$\Delta S = m\,c_p\ln\frac{T_2}{T_1} = 1\cdot 1{,}005\cdot\ln\frac{500}{300} = 0{,}5134\ \text{kJ/K}$$
Comprobación: $Q = \Delta U + W = 1\cdot 0{,}718\cdot 200 + 57{,}4 = 201{,}0$ kJ. ✓
@fin
@fin

@ejercicio sim-a2 | Aire húmedo a 30 °C y HR = 60 % | Simulacro A | | Psicrometría
@enunciado
Aire húmedo a 30 °C, 60 % de HR y 1 atm. Calcula p_v, ω, la temperatura de rocío y la entalpía por kilogramo de aire seco. Presión de vapor saturado a 30 °C: 4,246 kPa.
@solucion Ver solución de referencia
@paso Presión de vapor y humedad absoluta
$$p_v = 0{,}60\cdot 4{,}246 = 2{,}548\ \text{kPa}\qquad \omega = 0{,}622\,\frac{2{,}548}{101{,}325 - 2{,}548} = 0{,}01604\ \text{kg/kg}$$
@paso Temperatura de rocío
Es la T de saturación con p_g = 2,548 kPa: interpolando, T_dp ≈ 21,4 °C.
@paso Entalpía
$$h = 1{,}006\cdot 30 + 0{,}01604\,(2501 + 1{,}86\cdot 30) = 30{,}18 + 41{,}02 = 71{,}2\ \text{kJ/kg a.s.}$$
@fin
@fin

@ejercicio sim-a3 | Brayton de aire frío con r_p = 10 | Simulacro A | | Turbinas y gas,Sistemas abiertos
@enunciado
Ciclo Brayton de aire frío con r_p = 10. Entrada al compresor a 300 K; entrada a la turbina a 1300 K. Usa k = 1,4 y c_p = 1,005 kJ/(kg·K). Calcula η, T₂, T₄ y el trabajo neto por kilogramo.
@solucion Ver solución de referencia
@paso Temperaturas
$$T_2 = 300\cdot 10^{0{,}2857} = 579{,}2\ \text{K}\qquad T_4 = 1300\cdot 10^{-0{,}2857} = 673{,}3\ \text{K}$$
@paso Trabajos
$$w_{\text{comp}} = 1{,}005(579{,}2 - 300) = 280{,}6\ \text{kJ/kg}\qquad w_{\text{turb}} = 1{,}005(1300 - 673{,}3) = 629{,}8\ \text{kJ/kg}$$
$$w_{\text{neto}} = 629{,}8 - 280{,}6 = 349{,}2\ \text{kJ/kg}$$
@paso Rendimiento
$$\eta = 1 - 10^{-0{,}2857} = 0{,}4821 = 48{,}2\ \%$$
Comprobación: $w_{\text{neto}}/q_{\text{ent}} = 349{,}2/(1{,}005(1300 - 579{,}2)) = 349{,}2/724{,}4 = 0{,}482$. ✓
@fin
@fin

@ejercicio sim-b1 | Rendimientos de Otto y Diesel | Simulacro B | | Motores,Entropía
@enunciado
Calcula el rendimiento ideal (aire, k = 1,4) de un Otto con r = 9 y de un Diesel con r = 16 y r_c = 2,2. Di cuál rinde más y por qué.
@solucion Ver solución de referencia
@paso Otto
$$\eta_{\text{Otto}} = 1 - 9^{-0{,}4} = 1 - 0{,}4152 = 0{,}585 = 58{,}5\ \%$$
@paso Diesel
$$\eta_{\text{Diesel}} = 1 - 16^{-0{,}4}\cdot\frac{2{,}2^{1{,}4} - 1}{1{,}4\,(2{,}2 - 1)} = 1 - 0{,}3299\cdot\frac{2{,}016}{1{,}68} = 1 - 0{,}3299\cdot 1{,}200 = 0{,}604 = 60{,}4\ \%$$
@paso Conclusión
Con estos datos, el Diesel rinde algo más porque su compresión es mayor (16 frente a 9). A igual r, el Diesel rinde menos que el Otto.
@fin
@fin

@ejercicio sim-b2 | COP de un refrigerador: ideal y real | Simulacro B | | Refrigeración,Segundo principio
@enunciado
Un refrigerador mantiene un espacio a −10 °C en un ambiente a 35 °C. Calcula el COP de Carnot y el COP de una máquina real que alcanza el 45 % del de Carnot.
@solucion Ver solución de referencia
@paso Carnot
$$T_F = 263{,}15\ \text{K}\qquad T_C = 308{,}15\ \text{K}\qquad \mathrm{COP}_{\text{Carnot}} = \frac{263{,}15}{308{,}15 - 263{,}15} = 5{,}85$$
@paso Real
$$\mathrm{COP}_{\text{real}} = 0{,}45\cdot 5{,}85 = 2{,}63$$
@fin
@fin

@ejercicio sim-b3 | Mezcla de gases: entropía de mezcla y caso de gas idéntico | Simulacro B | | Entropía,Gases ideales
@enunciado
Se mezclan 2 kmol de O₂ con 1 kmol de N₂ a la misma T y P. Calcula la entropía de mezcla. Repite el cálculo si los dos gases fueran el mismo.
@solucion Ver solución de referencia
@paso Fracciones molares
$$y_{O_2} = 2/3 \qquad y_{N_2} = 1/3$$
@paso Entropía de mezcla
$$\Delta S = -8{,}314\,(2\ln\tfrac{2}{3} + 1\ln\tfrac{1}{3}) = -8{,}314\,(-0{,}8109 - 1{,}0986) = 15{,}88\ \text{kJ/K}$$
@paso Mismo gas
Si los dos gases son iguales, no hay mezcla que distinguir: $\Delta S = 0$.
@fin
@fin

@ejercicio sim-b4 | Metano con 20 % de exceso de aire | Simulacro B | | Combustión,Psicrometría
@enunciado
Metano quemado con 20 % de exceso de aire, a 1 atm. Calcula la fracción molar de H₂O en los productos, su presión parcial y la temperatura de rocío.
@solucion Ver solución de referencia
@paso Productos
Aire = 1,2 · 9,52 = 11,42 mol. Productos: CO₂ = 1; H₂O = 2; O₂ = 0,4; N₂ = 7,52·1,2 = 9,024; total = 12,424 mol.
@paso Fracción y presión parcial
$$y_{\text{H}_2\text{O}} = \frac{2}{12{,}424} = 0{,}1610 \qquad p_v = 0{,}1610\cdot 101{,}325 = 16{,}31\ \text{kPa}$$
@paso Rocío
Entre 55 °C (15,76 kPa) y 60 °C (19,94 kPa), interpolando: T_dp ≈ 55,8 °C.
@fin
@fin
@fin
