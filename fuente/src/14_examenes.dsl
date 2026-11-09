@bloque examenes | Exámenes resueltos | Práctica con exámenes reales | #b91c1c | | Exámenes | Exámenes
Los enunciados son resúmenes fieles de los problemas del material; los datos de tabla son los de la solución de referencia. Cada problema tiene una resolución de la guía, verificada con código, y las erratas de la solución de referencia van con su nota «Ojo:».

@esencial Empieza por aquí
Si solo haces cinco problemas, haz estos. Cubren agua, sistemas abiertos, turbinas de gas, refrigeración y psicrometría.
- [Problema del cilindro-émbolo con agua](#ex-sf-agua-cilindro) (sistemas cerrados, entropía)
- [Turbina de aire con difusor](#ex-sf-turbina) (sistemas abiertos, gases ideales)
- [Refrigerador de dos etapas con cámara flash](#ex-sp-refrig-flash) (refrigeración, balance de entropía)
- [Mezcla adiabática de aire húmedo](#ex-sp-psicro-mezcla) (psicrometría)
- [Ciclo Brayton de aire](#ex-sf-brayton) (turbinas de gas)

@zero Practicar por tema
- **T1 Agua y refrigerantes**: [cilindro-émbolo con agua](#ex-sf-agua-cilindro), [depósito rígido con agua](#ex-sf-tanque-rigido), [depósito de R-134a](#ex-sf-tanque-r134a).
- **T2 Gases ideales**: [compresor de dos etapas](#ex-sf-compresor), [ciclo reversible con aire](#ex-sf-ciclo-aire), [cámaras rígidas de aire](#ex-sp-camaras).
- **T3 Sistemas cerrados**: [cilindro-émbolo con agua](#ex-sf-agua-cilindro), [depósito rígido con agua](#ex-sf-tanque-rigido).
- **T4 Sistemas abiertos**: [turbina con difusor](#ex-sf-turbina), [intercambiador aire-R-134a con tobera](#ex-sf-tobera), [compresor de dos etapas](#ex-sf-compresor), [intercambiador R-134a-agua](#ex-sf-intercambiador).
- **T5 Segundo principio**: [ciclo reversible con aire](#ex-sf-ciclo-aire), [refrigerador de dos etapas](#ex-sp-refrig-flash).
- **T6 Entropía y balances**: [cilindro-émbolo con agua](#ex-sf-agua-cilindro), [depósito rígido con agua](#ex-sf-tanque-rigido), [intercambiador R-134a-agua](#ex-sf-intercambiador).
- **T7 Turbinas y gas**: [ciclo Brayton de aire](#ex-sf-brayton), [turbina con difusor](#ex-sf-turbina).
- **T9 Refrigeración**: [refrigerador de dos etapas](#ex-sp-refrig-flash), [refrigerador de dos etapas (6 puntos)](#ex-sp-refrig-6).
- **T10 Mezclas y psicrometría**: [mezcla adiabática de aire húmedo](#ex-sp-psicro-mezcla), [mezcla de dos corrientes de aire (UTA)](#ex-sp-uta), [humidificación de aire](#ex-sp-humidif).
- **T11 Combustión**: [metano con exceso de aire](#ex-sp-metano).

@zero Buscar un examen
Filtra por examen, por tema o escribe una palabra del enunciado. Los grupos se despliegan al filtrar.

@filtros Sin fecha en el material;Segundo parcial, 20-12-2024 | Sistemas cerrados;Sistemas abiertos;Gases ideales;Agua;Refrigeración;Refrigerante R-134a;Psicrometría;Combustión;Turbinas y gas;Entropía;Segundo principio

@grupo Sin fecha en el material | abierto

@ejercicio ex-sf-agua-cilindro | Cilindro-émbolo con agua: calentamiento, expansión y posibilidad | Sin fecha en el material | 3 | Agua,Sistemas cerrados,Entropía
@enunciado
0,25 kg de agua a 80 °C ocupan 0,5 L en un cilindro-émbolo. El proceso 1→2 es isobaro hasta vapor saturado, con 500 kJ de energía eléctrica aportada. El 2→3 es politrópico hasta V₃ = 3V₂ y P₃ = 6 kPa. Pide: n, W de cada proceso, Q, ΔS, si el proceso global es posible con un foco a 100 °C, y el diagrama p-v.
@antes
Estado 1 con v₁ = V₁/m = 0,002 m³/kg: está casi en líquido (mezcla con x ≈ 0,0003). La presión de 1→2 es P_sat(80 °C) = 47,39 kPa. Trabajo de frontera con P·ΔV; la energía eléctrica es trabajo entrante.
@paso Proceso 1→2 (isobaro)
Estado 2: vapor saturado a 47,39 kPa. Volumen V₂ = 0,85175 m³ (la solución de referencia pone 0,85115).
$$W_{12,\text{frontera}} = 47{,}39\,(0{,}85175 - 0{,}0005) = 40{,}34\ \text{kJ}$$
$$W_{12} = 40{,}34 - 500 = -459{,}66\ \text{kJ} \;(\text{la energía eléctrica entra})$$
Con $U_2 - U_1 = 536{,}7$ kJ: $Q_{12} = \Delta U + W = 536{,}7 - 459{,}66 = 77{,}0$ kJ.
@paso Proceso 2→3 (politrópico)
Se obtiene n = 1,881 con $V_3 = 3V_2$ y $P_3 = 6$ kPa: $n = \ln(P_2/P_3)/\ln(V_3/V_2) = \ln(47{,}39/6)/\ln 3 = 1{,}881$.
$$W_{23} = \frac{P_3V_3 - P_2V_2}{1 - n} = \frac{6\cdot 2{,}55525 - 47{,}39\cdot 0{,}85175}{1 - 1{,}881} = 28{,}41\ \text{kJ}$$
El título del estado 3 es x₃ = 0,43053, con u₃ = 1130,33 kJ/kg. $\Delta U_{23} = -337{,}97$ kJ y $Q_{23} = \Delta U_{23} + W_{23} = -309{,}56$ kJ.
@paso Entropía y posibilidad
$\Delta S_{\text{global}} = 0{,}7015$ kJ/K. Con un foco a 373 K, $S_{\text{gen}} \approx 1{,}325$ kJ/K > 0: el proceso global es posible.
@resultado
n ≈ 1,881; W₁₂ = −459,66 kJ (con la energía eléctrica); Q₁₂ ≈ 77,0 kJ; W₂₃ ≈ 28,41 kJ; Q₂₃ ≈ −309,56 kJ; ΔS ≈ 0,7015 kJ/K; S_gen ≈ 1,325 kJ/K (posible).
@ojo W₁₂ (aritmética)
La solución de referencia escribe W₁₂ = −459,61 kJ. El resultado es 40,34 − 500 = −459,66 kJ, y por eso Q₁₂ = 77,02 kJ y no 77,07.
@ojo Redondeo del título
La solución de referencia redondea x₃ a 0,4305 antes de calcular u₃. Con x₃ = 0,43053 se obtiene u₃ = 1130,33 kJ/kg (no 1130,26). El efecto es pequeño, pero conviene conservar cifras.
@fin

@ejercicio ex-sf-turbina | Turbina de aire con difusor isentrópico | Sin fecha en el material | 3 | Gases ideales,Sistemas abiertos,Entropía,Turbinas y gas
@enunciado
Aire entra a una turbina a 800 °C, 3 bar y 100 m/s, con ṁ = 18 kg/s y potencia de salida 3600 kW. Sale con c₂ = 150 m/s. Un difusor isentrópico lleva el aire a c₃ = 10 m/s y 1 bar. Pide T₂, P₂ y Ṡ_gen de la turbina.
@antes
Balance de energía en la turbina, luego el difusor como proceso isentrópico (s₃ = s₂). Tablas de aire A-22.
@paso Temperatura de salida T₂
Con h₁ = 1129,83 kJ/kg (A-22 a 1073 K):
$$h_2 = h_1 + \frac{c_1^2 - c_2^2}{2000} - \frac{\dot W}{\dot m} = 1129{,}83 - 6{,}25 - 200 = 923{,}58\ \text{kJ/kg}$$
Interpolando en A-22: T₂ = 891,6 K ≈ 618,5 °C, con s°₂ = 2,83806.
@paso Presión P₂ con el difusor
Difusor isentrópico: $h_3 = h_2 + \frac{c_2^2 - c_3^2}{2000} = 934{,}78$ kJ/kg, con T₃ = 901,65 K y s°₃ = 2,85059. Como s₃ = s₂:
$$\ln\frac{P_3}{P_2} = \frac{s^\circ_3 - s^\circ_2}{R} = \frac{0{,}01253}{0{,}287} = 0{,}04367 \;\Rightarrow\; P_2 = 0{,}957\ \text{bar}$$
@paso Generación de entropía
$$\dot S_{\text{gen}} = \dot m\left[(s^\circ_2 - s^\circ_1) - R\ln\frac{P_2}{P_1}\right] = 18\left[(-0{,}21046) + 0{,}32795\right] = 2{,}11\ \text{kW/K}$$
@resultado
T₂ ≈ 891,6 K (618,5 °C); P₂ ≈ 0,957 bar; Ṡ_gen ≈ 2,11 kW/K > 0: proceso posible.
@ojo P₂ (lectura de la tabla)
La solución de referencia da P₂ = 0,951 bar. Con los datos de A-22 y el difusor, P₂ = 0,957 bar.
@ojo Ṡ_gen con P₂ correcto
Como la solución usa P₂ = 0,951, obtiene 2,12 kW/K. Con P₂ = 0,957 bar sale 2,11 kW/K.
@fin

@ejercicio ex-sf-tanque-rigido | Depósito rígido de agua: calentamiento eléctrico y posibilidad | Sin fecha en el material | 3 | Agua,Sistemas cerrados,Entropía
@enunciado
Un depósito rígido de 1 L contiene 0,25 kg de agua a 25 °C. Con 50 kJ de energía eléctrica se calienta hasta 360 °C; luego se calienta hasta 28 MPa. El foco está a 5 °C. Pide Q, W, ΔS y S_gen de cada proceso, y dibujar p-v, T-v y T-s.
@antes
Volumen constante: W de frontera = 0; la energía eléctrica sí es trabajo. Cuidado: 28 MPa es mayor que P_c = 22,06 MPa, así que no hay mezcla en el estado 3.
@paso Proceso 1→2 (isócoro con energía eléctrica)
$$\Delta U_{12} = 470{,}35\ \text{kJ} \qquad Q_{12} = \Delta U_{12} - W_{\text{eléc}} = 470{,}35 - (-50) = 420{,}35\ \text{kJ}$$
$$\Delta S_{12} = 1{,}0053\ \text{kJ/K} \qquad S_{\text{gen},12} = \Delta S_{12} - \frac{Q_{12}}{T_b} = 1{,}0053 - \frac{420{,}35}{278} = -0{,}507\ \text{kJ/K}$$
Como S_gen < 0, el proceso con esos calores no es posible con el foco a 5 °C.
@paso Proceso 2→3 (isócoro hasta 28 MPa)
$$\Delta U_{23} = Q_{23} = 64{,}29\ \text{kJ} \qquad \Delta S_{23} = 0{,}0991\ \text{kJ/K} \qquad S_{\text{gen},23} = 0{,}0991 - \frac{64{,}29}{278} = -0{,}132\ \text{kJ/K}$$
Otra vez negativo: imposible con ese foco.
@resultado
Proceso 1→2: Q₁₂ ≈ 420,35 kJ, ΔS₁₂ ≈ 1,0053 kJ/K, S_gen,12 ≈ −0,507 kJ/K (imposible). Proceso 2→3: Q₂₃ ≈ 64,29 kJ, S_gen,23 ≈ −0,132 kJ/K (imposible).
@ojo Errata de la solución de referencia
La solución escribe S_gen,12 = −0,707 kJ/K. El valor correcto con sus propios datos es −0,507 kJ/K.
@ojo Concepto: 28 MPa es supercrítico
A 28 MPa no hay mezcla líquido-vapor: el agua está por encima de la presión crítica (22,06 MPa). El estado 3 se lee de la tabla de agua a esa presión, no comparando v con v_g. Los valores de la tabla a 28 MPa no están en esta guía; cómpruebalos en tu tabla completa.
@fin

@ejercicio ex-sf-tobera | Intercambiador aire-R-134a y tobera adiabática | Sin fecha en el material | 3 | Sistemas abiertos,Refrigeración,Gases ideales,Refrigerante R-134a
@enunciado
Aire entra a 25 °C y sale a 20 °C a 1,5 bar, cediendo calor a R-134a que entra a 0,14 MPa con x = 0,30 y sale a 10 °C a la misma presión. Después el aire pasa por una tobera adiabática hasta 1 bar, con c₂ = 40 m/s, A₂ = 90 cm² y A₃ = 60 cm². Pide ṁ de aire, potencia cedida, ṁ de refrigerante, c₃ y T₃.
@antes
Intercambiador aislado: el calor cedido por el aire es el absorbido por el refrigerante. Tobera: balance de energía con c₁ pequeña y sin trabajo.
@paso Caudal de aire y calor cedido
$$v_{a2} = \frac{RT}{P} = \frac{0{,}287\cdot 293{,}15}{150} = 0{,}5606\ \text{m}^3/\text{kg} \qquad \dot m_a = \frac{A_2c_2}{v_{a2}} = \frac{0{,}009\cdot 40}{0{,}5606} = 0{,}6422\ \text{kg/s}$$
$$\dot Q_{\text{aire}} = \dot m_a c_p (T_2 - T_1) = 0{,}6422\cdot 1\cdot(-5) = -3{,}21\ \text{kW}$$
@paso Caudal de refrigerante
$h_{R1} = 88{,}85$ kJ/kg (x = 0,30 a 1,4 bar) y $h_{R2} = 260{,}43$ kJ/kg (vapor sobrecalentado a 1,4 bar y 10 °C):
$$\dot m_R = \frac{3{,}21}{260{,}43 - 88{,}85} = 0{,}01871\ \text{kg/s}$$
@paso Tobera
$$c_3 \approx 89{,}0\ \text{m/s} \qquad T_3 \approx 16{,}8\ \text{°C}$$
La temperatura sale del balance $c_p(T_2 - T_3) = (c_3^2 - c_2^2)/2000$ con T₂ = 20 °C: $T_3 = 20 - 3{,}16 = 16{,}8$ °C.
@resultado
ṁ_aire ≈ 0,6422 kg/s; potencia cedida ≈ 3,21 kW; ṁ_R ≈ 0,01871 kg/s; c₃ ≈ 89,0 m/s; T₃ ≈ 16,8 °C.
@ojo Temperatura de salida de la tobera
La solución de referencia da T₃ = 289,87 K (16,72 °C) a partir de un redondeo de 3,2559 K. Con el balance de la tobera, la caída es de 3,16 K y T₃ ≈ 16,8 °C.
@fin

@ejercicio ex-sf-brayton | Ciclo Brayton de aire: compresor, intercambiador y turbina | Sin fecha en el material | 3 | Turbinas y gas,Gases ideales,Sistemas abiertos,Entropía
@enunciado
Un compresor toma aire a 0,95 bar y 22 °C; el aire sale por el intercambiador a T₄ = 427 °C; la turbina lo expulsa a 0,95 bar y 122 °C. ṁ = 10 kg/s, c₁ = 10 m/s, Q̇_in = 1,13 MW. Pide ρ₁, A₁, W_turbina, T₃ y Δs₃₄.
@antes
Datos de aire con R = 0,287 kJ/(kg·K) y tablas A-22. Balances en régimen estacionario en cada equipo.
@paso Entrada
$$v_1 = \frac{RT_1}{P_1} = \frac{0{,}287\cdot 295{,}15}{95} = 0{,}8912\ \text{m}^3/\text{kg} \qquad \rho_1 = 1{,}122\ \text{kg/m}^3$$
$$A_1 = \frac{\dot m v_1}{c_1} = \frac{10\cdot 0{,}8912}{10} = 0{,}891\ \text{m}^2$$
@paso Turbina
Con h₄ = 713,27 kJ/kg (700 K) y h₂ = 395,93 kJ/kg (395 K) de A-22:
$$\dot W_T = \dot m(h_4 - h_2) = 10\,(713{,}27 - 395{,}93) = 3173\ \text{kW} = 3{,}17\ \text{MW}$$
@paso Temperatura T₃
Del balance de energía en el intercambiador: $h_3 = 600{,}27$ kJ/kg, $T_3 = 593{,}6$ K ≈ 320,4 °C.
@paso Variación de entropía en la turbina
$$\Delta s_{34} = s^\circ_4 - s^\circ_3 = 2{,}52277 - 2{,}39770 = 0{,}125\ \text{kJ/(kg·K)}$$
@resultado
ρ₁ ≈ 1,122 kg/m³; A₁ ≈ 0,891 m²; Ẇ_T ≈ 3,17 MW; T₃ ≈ 320,4 °C; Δs₃₄ ≈ 0,125 kJ/(kg·K).
@ojo Resta de entropías
La solución de referencia da Δs₃₄ = 0,175. La resta correcta es 2,52277 − 2,39770 = 0,125 kJ/(kg·K).
@ojo Unidades de la potencia
La solución escribe la potencia de la turbina en MW con el valor en kW. 3173 kW = 3,17 MW.
@fin

@ejercicio ex-sf-tanque-r134a | Depósito de 50 L con R-134a: descarga por vapor y calentamiento | Sin fecha en el material | 3 | Refrigerante R-134a,Sistemas cerrados,Entropía
@enunciado
Un depósito rígido de 0,05 m³ contiene R-134a a 24 °C con título x₁ = 0,05. Por la válvula superior sale vapor saturado a presión y temperatura constantes. Entran 0,5 kW por las paredes. Se cierra cuando se evapora la última gota de líquido. Pide las masas inicial y final, el tiempo, el calor para evaporar todo en 10 min y S_gen.
@antes
Tabla de saturación de R-134a a 24 °C. Cada kilogramo que sale lleva la entalpía h_g; el proceso ocurre a T constante.
@paso Masas
$$m_1 = \frac{V}{v_1} \approx 21{,}1\ \text{kg} \qquad m_2 = \frac{V}{v_g} \approx 1{,}58\ \text{kg} \qquad m_e = 19{,}5\ \text{kg}$$
@paso Calor y tiempo
$$Q = m_2u_2 - m_1u_1 + m_eh_g \approx 3559\ \text{kJ} \qquad t = \frac{Q}{0{,}5\ \text{kW}} = \frac{3559}{0{,}5} = 7119\ \text{s} \approx 118{,}6\ \text{min}$$
@paso Potencia para 10 min
$$\dot W_{\text{res}} = \frac{3559\ \text{kJ}}{600\ \text{s}} = 5{,}93\ \text{kW}$$
@paso Generación de entropía
El proceso ocurre a T ≈ 297 K sin diferencia de temperatura apreciable: $S_{\text{gen}} \approx 0$ dentro de la precisión de la tabla.
@resultado
m₁ ≈ 21,1 kg; m₂ ≈ 1,58 kg; t ≈ 118,6 min; potencia de la resistencia ≈ 5,93 kW; S_gen ≈ 0.
@ojo Valor negativo de S_gen
La solución de referencia da −0,00028 kJ/K. Un valor negativo no es físico: la respuesta correcta es S_gen ≈ 0 dentro de la precisión de la tabla. Además, la solución escribe kJ/(kg·K) donde el enunciado pide kJ/K.
@fin

@ejercicio ex-sf-compresor | Compresor de dos etapas con intercooler | Sin fecha en el material | 2 | Gases ideales,Sistemas abiertos,Entropía
@enunciado
Aire con caudal volumétrico de 0,861 m³/s a 100 kPa y 300 K se comprime hasta 1000 kPa en dos etapas. El intercooler enfría hasta 300 K a 300 kPa. Rendimiento del primer compresor η₁ = 0,9, del segundo 1. Pide ṁ, T a la salida del compresor 1, calor del intercooler, T a la salida del compresor 2 y trabajos.
@antes
Tabla A-22 de aire con interpolación en p_r. Rendimiento isentrópico en el primer compresor.
@paso Caudal másico y compresor 1
$$\dot m = \frac{0{,}861}{0{,}861} = 1{,}000\ \text{kg/s} \qquad P_{r,c} = 4{,}158 \Rightarrow h_{cs} = 411{,}26\ \text{kJ/kg}$$
$$h_c = h_1 + \frac{h_{cs} - h_1}{0{,}9} = 423{,}60\ \text{kJ/kg} \Rightarrow T_c = 422{,}30\ \text{K} = 149{,}15\ \text{°C}$$
@paso Intercooler y compresor 2
Intercooler: $\dot Q = \dot m(h_d - h_c) = -123{,}41$ kW (cedido). Compresor 2 ideal: $P_{r2} = (1000/300)\cdot 1{,}386 = 4{,}620$ → $h_2 = 423{,}80$ kJ/kg, $T_2 = 422{,}49$ K = 149,34 °C.
@paso Trabajos
$$\dot W_1 = 123{,}41\ \text{kW} \qquad \dot W_2 = 123{,}61\ \text{kW}$$
@resultado
ṁ = 1,000 kg/s; T_c ≈ 422,3 K; Q_intercooler ≈ −123,4 kW; T₂ ≈ 422,5 K; W₁ ≈ 123,4 kW; W₂ ≈ 123,6 kW.
@ojo Interpolación de T_c
La solución de referencia da T_c = 423,298 K. La interpolación en A-22 da 422,30 K.
@ojo Temperatura de salida del compresor 2
La solución de referencia da 423,47 K. El valor correcto es 422,49 K.
@fin

@ejercicio ex-sf-intercambiador | Intercambiador R-134a-agua: calor, caudal de agua y posibilidad | Sin fecha en el material | 2 | Refrigerante R-134a,Sistemas abiertos,Entropía
@enunciado
R-134a entra a 7 bar y 40 °C y sale a 6 bar y 20 °C con ṁ = 0,08 kg/s. Agua entra a 10 °C y 1 bar con caudal de 684,26 L/h, c_p = 4,18 kJ/(kg·K). Pide Q, ṁ de agua, T de salida del agua, S_gen y los diagramas T-s y p-h.
@antes
Intercambiador aislado: lo que cede el R-134a lo absorbe el agua. S_gen = suma de variaciones de entropía de los dos fluidos.
@paso Calor absorbido
$$\dot Q = \dot m_R(h_3 - h_4) = 0{,}08\,(275{,}93 - 77{,}27) = 15{,}89\ \text{kW}$$
@paso Caudal de agua
$$\dot m_w = \frac{\dot V}{v_f(10\ \text{°C})} = \frac{1{,}9007\cdot 10^{-4}}{1{,}0003\cdot 10^{-3}} = 0{,}190\ \text{kg/s}$$
@paso Temperatura de salida
$$T_2 = 10 + \frac{15{,}89}{0{,}190\cdot 4{,}18} = 10 + 20{,}0 = 30{,}0\ \text{°C} = 303{,}16\ \text{K}$$
@paso Generación de entropía
$$\dot S_{\text{gen}} = \dot m_R(s_4 - s_3) + \dot m_w(s_2 - s_1) = 0{,}08(0{,}2929 - 0{,}9539) + 0{,}190(0{,}4369 - 0{,}1510) = +0{,}00145\ \text{kW/K}$$
@resultado
Q ≈ 15,89 kW; ṁ_w ≈ 0,190 kg/s; T₂ ≈ 30,0 °C; Ṡ_gen ≈ +0,00145 kW/K > 0: el proceso es posible.
@ojo Caudal de agua: volumen específico
La solución escribe v = 1,0432·10⁻³ m³/kg, que corresponde a agua a unos 100 °C. A 10 °C, v_f = 1,0003·10⁻³ m³/kg, y el caudal es 0,190 kg/s.
@ojo Temperatura del agua de salida
La solución da 303,02 K = 30,02 °C. Según su propio balance, 303,02 K son 29,87 °C; el valor correcto es 303,16 K = 30,0 °C.
@ojo Signo de S_gen (grave)
La solución escribe Ṡ_gen = −0,1072 kW/K y concluye que el proceso no es posible. Sus propios datos dan +0,00145 kW/K. El proceso es posible.
@ojo Vapor sobrecalentado, no líquido
La solución dice que a 7 bar con T₃ > T_sat el fluido es «líquido sobrecalentado». Es vapor sobrecalentado. A 6 bar con T₄ < T_sat, el estado 4 es líquido subenfriado (h₄ ≈ h_f(20 °C) ≈ 77,27 kJ/kg).
@fin

@ejercicio ex-sf-ciclo-aire | Ciclo reversible con aire: expansión isoterma, compresión adiabática e isobara | Sin fecha en el material | 2 | Gases ideales,Entropía,Segundo principio,Sistemas cerrados
@enunciado
Aire en un ciclo reversible: 1→2 expansión isoterma desde 300 K, 400 kPa y 0,3 m³ hasta 150 kPa; 2→3 compresión adiabática reversible hasta P₃ = P₁; 3→1 compresión isobara. Pide T₃, volúmenes, W y Q de cada proceso, y si es un ciclo de potencia o inverso, con COP.
@antes
Masa con la ley de gas ideal. Isoterma: W = Q = P₁V₁ ln(P₁/P₂). Tabla A-22 para el proceso adiabático.
@paso Estados
$$m = \frac{P_1V_1}{RT_1} = 1{,}394\ \text{kg} \qquad v_1 = 0{,}2153\ \text{m}^3/\text{kg} \qquad V_2 = 0{,}800\ \text{m}^3$$
@paso Proceso 2→3
Con $P_{r3} = P_{r2}P_3/P_2 = 3{,}696$ en A-22: $T_3 = 396{,}6$ K. Entonces $V_3 = m\,v_3 = 0{,}3966$ m³.
@paso Trabajos y calores (kJ)
$$W_{12} = Q_{12} = P_1V_1\ln\frac{P_1}{P_2} = 117{,}7 \qquad W_{23} = -m c_v(T_3 - T_1) = -96{,}7 \quad (Q_{23} = 0)$$
$$W_{31} = P_3(V_1 - V_3) = -38{,}6 \qquad Q_{31} = m c_v(T_1 - T_3) + W_{31} = -135{,}3$$
@paso Tipo de ciclo
$W_{\text{neto}} = 117{,}7 - 96{,}7 - 38{,}6 = -17{,}6$ kJ < 0: ciclo inverso. $\mathrm{COP}_{\text{ref}} = 117{,}7/17{,}6 = 6{,}7$ y $\mathrm{COP}_{\text{bomba}} = 135{,}3/17{,}6 = 7{,}7$.
@resultado
T₃ ≈ 396,6 K; V₃ ≈ 0,3966 m³; W₁₂ = Q₁₂ ≈ 117,7 kJ; W₂₃ ≈ −96,7 kJ; W₃₁ ≈ −38,6 kJ; W_neto ≈ −17,6 kJ: ciclo inverso, COP_ref ≈ 6,7, COP_bomba ≈ 7,7.
@ojo Volumen V₃
La solución de referencia da V₃ = 0,3907 m³. Con v₃ = RT₃/P₃ = 0,287·396,6/400 = 0,2846 m³/kg y m = 1,394 kg: V₃ = 0,3966 m³.
@ojo Solución incompleta
La solución de referencia del material queda incompleta en la última página. La resolución completa es la de esta guía.
@fin
@fin

@grupo Segundo parcial, 20-12-2024 | abierto

@ejercicio ex-sp-psicro-mezcla | Mezcla adiabática de aire húmedo saturado con aire a 31 °C | Segundo parcial, 20-12-2024 | 3 | Psicrometría,Sistemas abiertos,Mezclas
@enunciado
Aire húmedo saturado a 14 °C con caudal de 50 m³/min se mezcla adiabáticamente con aire a 31 °C con T_bh = 25 °C y 20 m³/min, a 1 atm. Pide ω₂, los caudales de aire seco de entrada y salida, ω₃, HR₃ y T_bs₃. (Enunciado resumido; los apartados se indican según la transcripción.)
@antes
Aire seco y agua se conservan en la mezcla; la energía también. Estado 1 saturado: su ω sale de p_g(14 °C). Estado 2: la T_bh da ω₂ con el saturador adiabático. Presión total 1,01325 bar.
@paso Estado 1
$$p_{g}(14\,°\text{C}) = 1{,}598\ \text{kPa} \qquad \omega_1 = 0{,}622\,\frac{1{,}598}{101{,}325 - 1{,}598} = 0{,}00997\ \text{kg/kg}$$
$$v_{a1} = \frac{R\,T}{P - p_v} = \frac{0{,}287\cdot 287{,}15}{99{,}727} = 0{,}8264\ \text{m}^3/\text{kg} \qquad \dot m_{a1} = \frac{50/60}{0{,}8264} = 1{,}008\ \text{kg/s}$$
@paso Estado 2
Con T_bh = 25 °C: $\omega' = 0{,}622\,p_g(25)/(P - p_g) = 0{,}622\cdot 3{,}169/98{,}156 = 0{,}02008$. El balance del saturador da $\omega_2 = 0{,}01749$ kg/kg, con $\mathrm{HR}_2 = 61{,}6\,\%$. Caudal: $\dot m_{a2} = (20/60)/0{,}8857 = 0{,}376$ kg/s.
@paso Mezcla
$$\dot m_{a3} = \dot m_{a1} + \dot m_{a2} = 1{,}384\ \text{kg/s}$$
$$\omega_3 = \frac{1{,}008\cdot 0{,}00997 + 0{,}376\cdot 0{,}01749}{1{,}384} = 0{,}01201\ \text{kg/kg}$$
$$h_1 = 39{,}27,\quad h_2 = 75{,}95 \Rightarrow h_3 = \frac{1{,}008\cdot 39{,}27 + 0{,}376\cdot 75{,}95}{1{,}384} = 49{,}24\ \text{kJ/kg}$$
@paso Temperatura y humedad relativa de la mezcla
$$T_3 = \frac{h_3 - 2501\,\omega_3}{1{,}006 + 1{,}86\,\omega_3} = 18{,}7\ \text{°C} \qquad p_{v3} = \frac{0{,}01201\cdot 101{,}325}{0{,}622 + 0{,}01201} = 1{,}918\ \text{kPa}$$
$$\mathrm{HR}_3 = \frac{1{,}918}{p_g(18{,}7\,°\text{C})} \approx 89\ \%$$
@resultado
ω₂ ≈ 0,01749 kg/kg (HR₂ ≈ 61,6 %); ṁ_a1 ≈ 1,008 kg/s; ṁ_a2 ≈ 0,376 kg/s; ṁ_a3 ≈ 1,384 kg/s; ω₃ ≈ 0,01201 kg/kg; T₃ ≈ 18,7 °C; HR₃ ≈ 89 %.
@ojo Presión: 1,01325 bar, no 1 bar
La solución de referencia usa (1 − p_g) = 0,96831 bar. Con 1 atm, ω' = 0,02008 (no 0,02036) y ω₂ = 0,01749 (no 0,0178). Por eso HR₂ = 61,6 % (no 62,7 %).
@ojo El balance de energía no cierra en la solución
La solución da ω₃ = 0,0212 kg/kg, que no es compatible con el balance de agua (ω₃ ≈ 0,0120) y deja un balance de energía con 446,86 frente a 444,5 kJ/s. Con ω₂ corregido, el resultado es el de esta resolución.
@fin

@ejercicio ex-sp-refrig-flash | Refrigerador de dos etapas con cámara flash | Segundo parcial, 20-12-2024 | 3 | Refrigeración,Refrigerante R-134a,Entropía,Sistemas abiertos
@enunciado
Máquina de refrigeración de R-134a de dos etapas con cámara flash a 0,4 MPa, condensación a 1,4 MPa y evaporador a 0,10 MPa. Por el condensador circulan 0,25 kg/s. El compresor de baja presión es isentrópico y el de alta presión tiene η = 0,9. Pide caudales, calores, trabajo, COP y S_gen de la cámara flash.
@antes
Propiedades de R-134a (A-11, A-12). Cámara flash: balance de masa y energía con tres corrientes (entrada de líquido y vapor, dos salidas). Válvulas isoentálpicas.
@paso Compresor de baja presión
Vapor saturado a 0,4 MPa: h₁ = 252,32 kJ/kg, s₁ = 0,9145. Isentrópico hasta 1,4 MPa, con s₂s = 0,9145: h₂s = 278,09 kJ/kg. Con η = 0,9: $h_2 = 252{,}32 + (278{,}09 - 252{,}32)/0{,}9 = 280{,}95$ kJ/kg.
@paso Cámara flash y evaporador
Entrada desde el condensador: $h_3 = 125{,}26$ kJ/kg (líquido saturado a 1,4 MPa). Válvula: $h_4 = h_3$ y título $x_4 = 0{,}3324$ a 0,4 MPa. Líquido saturado a 0,4 MPa: $h_5 = 62{,}00$. Válvula: $h_6 = h_5$.
Vapor saturado a 0,1 MPa: $h_7 = 231{,}35$, $s_7 = 0{,}9395$. Compresor de baja isentrópico a 0,4 MPa: $h_8 = 259{,}50$ kJ/kg.
Balance de la cámara flash: $\dot m_B = 0{,}1608$ kg/s es el caudal que pasa por el evaporador.
@paso Calores, trabajo y COP
$$\dot Q_{\text{evap}} = 0{,}1608(231{,}35 - 62{,}00) = 27{,}23\ \text{kW} \qquad \dot Q_{\text{cond}} = 0{,}25(125{,}26 - 280{,}95) = -38{,}92\ \text{kW}$$
$$\dot W = 38{,}92 - 27{,}23 = 11{,}69\ \text{kW} \qquad \mathrm{COP} = \frac{27{,}23}{11{,}69} = 2{,}33$$
Para Carnot con T_F = 243 K y T_C = 298 K: COP = 243/55 = 4,42.
@paso Generación de entropía de la cámara flash
$$\dot S_{\text{gen}} = \dot m_a s_1 + \dot m_B s_5 - \dot m_a s_4 - \dot m_B s_8 = +7{,}9\cdot 10^{-5}\ \text{kW/K}$$
@resultado
ṁ_B ≈ 0,1608 kg/s; Q̇_evap ≈ 27,23 kW; Q̇_cond ≈ −38,92 kW; Ẇ ≈ 11,69 kW; COP ≈ 2,33; Ṡ_gen (flash) ≈ +7,9·10⁻⁵ kW/K ≈ 0: proceso posible.
@ojo Signo del balance de entropía
La solución escribe el balance con el signo invertido ("0 = entradas − salidas − Ṡ_gen") y obtiene −1,04·10⁻⁴ kW/K. El resultado correcto es +7,9·10⁻⁵ kW/K. Un valor negativo no puede ser la respuesta.
@fin

@ejercicio ex-sp-metano | Metano con 50 % de exceso de aire: PCS, PCI y punto de rocío | Segundo parcial, 20-12-2024 | 2 | Combustión,Psicrometría
@enunciado
Metano (CH₄) quemado a 25 °C y 1 atm con 50 % de exceso de aire. Pide PCS y PCI (kJ/kg), la reacción, el aire, la composición de los productos y la temperatura de rocío de los productos.
@antes
Reacción estequiométrica y exceso de aire. Entalpías de formación a 25 °C. Presión parcial del vapor de agua en productos a 1 atm.
@paso Reacción y aire
$$\mathrm{CH_4} + 2(\mathrm{O_2} + 3{,}76\,\mathrm{N_2}) 
ightarrow \mathrm{CO_2} + 2\,\mathrm{H_2O} + 7{,}52\,\mathrm{N_2}$$
Aire estequiométrico: 9,52 mol por mol de CH₄. Con 50 % de exceso: 14,28 mol de aire, de los que O₂ en exceso = 1,0 mol y N₂ = 11,28 mol.
@paso PCS y PCI
PCS: $|{-393\,520} - 2\cdot 285\,830 + 74\,850| = 890\,330$ kJ/kmol → $890\,330/16{,}043 = 55\,496$ kJ/kg.
PCI: $|{-393\,520} - 2\cdot 241\,820 + 74\,850| = 802\,310$ kJ/kmol → $802\,310/16{,}043 = 50\,010$ kJ/kg.
@paso Productos y punto de rocío
Productos: CO₂ = 1, H₂O = 2, O₂ = 1, N₂ = 11,28; total = 15,28 mol.
$$y_{\text{H}_2\text{O}} = \frac{2}{15{,}28} = 0{,}1309 \qquad p_v = 13{,}26\ \text{kPa} \qquad T_{\text{rocío}} \approx 51{,}5\ \text{°C}$$
@resultado
PCS ≈ 55 496 kJ/kg; PCI ≈ 50 010 kJ/kg; y_H₂O ≈ 0,1309; p_v ≈ 13,26 kPa; T de rocío ≈ 51,5 °C.
@ojo PCS y PCI
La solución de referencia da PCS = 55 514,6 kJ/kg y PCI = 50 012,8 kJ/kg. Con M = 16,043 kg/kmol y los mismos datos, los valores correctos son 55 496 y 50 010 kJ/kg.
@ojo Entalpía intermedia y fracción de agua
La solución escribe −241 280 kJ/kmol en una línea intermedia; el dato es −241 820. Además escribe y_H₂O = 2/(11,28 + 1 + 2) = 0,14: omite el CO₂. La fracción correcta es 0,1309.
@fin

@ejercicio ex-sp-refrig-6 | Refrigerador de dos etapas de R-134a (6 puntos) | Segundo parcial, 20-12-2024 | 6 | Refrigeración,Refrigerante R-134a
@enunciado
Refrigerador de R-134a de dos etapas con cámara flash a 0,45 MPa, condensación a 1,2 MPa y evaporación a 0,2 MPa; caudal de baja presión ṁ_LP = 0,15 kg/s; η = 0,8 en ambos compresores. Hay apartados a) a d), incluido el comparativo con una sola etapa.
@antes
Esquema de dos etapas con cámara flash y tablas de R-134a a 0,45, 1,2 y 0,2 MPa.
@trampa Resolución pendiente
La resolución completa de este problema no está cerrada en esta versión de la guía. Hay una errata conocida de la solución de referencia en la interpolación de 4,5 bar (el peso correcto es 0,25, no 0,5) y el estado 9 es vapor saturado, no sobrecalentado. Se completará cuando se verifique con tablas completas.
@fin

@ejercicio ex-sp-camaras | Dos cámaras rígidas de aire que se mezclan | Segundo parcial, 20-12-2024 | 4 | Gases ideales,Entropía,Sistemas cerrados
@enunciado
Cámara A: 5 kmol de aire a 300 K y 3 bar. Cámara B: 2 kmol de aire a 600 K y 6 bar. Se abre la válvula que las une y el aire se mezcla. Pide T₂, p₂, ΔS₁₂ y la generación de entropía σ₁₂. (Enunciado resumido.)
@antes
Gases idénticos: la entropía de mezcla de gases idénticos no tiene término de mezcla; el cambio de entropía se debe a T y a la presión de cada componente.
@trampa Resolución pendiente
La resolución numérica completa de T₂, p₂ y σ₁₂ no está cerrada en esta versión. Lo verificado: el balance de energía es el que fija T₂, y la variación total de entropía es positiva (ΔS_total ≈ +9,23 kJ/K), por lo que el proceso es irreversible.
@ojo Signo de la variación de entropía
La solución de referencia da una variación de −0,1267 kJ/(kg·K) y lo presenta como resultado. Con sus propios datos la variación total es positiva. Usa la presión total en el término de presión, no 1 bar.
@fin

@ejercicio ex-sp-uta | Mezcla adiabática de dos corrientes de aire en una UTA | Segundo parcial, 20-12-2024 | 2 | Psicrometría,Sistemas abiertos,Mezclas
@enunciado
Corriente 1: 1000 m³/h de aire a 20 °C con T_bh = 13,5 °C. Corriente 2: 2000 m³/h de aire a 30 °C y 60 % de HR. Presión de 1 atm. Se mezclan adiabáticamente en una unidad de tratamiento de aire. Pide ω₁, ω₃, caudales de aire seco, T₃ y HR₃. (Enunciado resumido.)
@antes
Igual que el problema de mezcla de la sección anterior, con T_bh en lugar de ω. Caudales de aire seco: volumen específico con la presión parcial del vapor.
@paso Humedad de la corriente 1
Con T_bh = 13,5 °C y T = 20 °C, el saturador adiabático da $\omega_1 = 0{,}00696$ kg/kg (p_v = 1,121 kPa, HR₁ ≈ 47,9 %).
@paso Humedad de la corriente 2
$p_v = 0{,}60\cdot 4{,}246 = 2{,}548$ kPa → $\omega_2 = 0{,}01604$ kg/kg.
@paso Caudales de aire seco
$$v_{a1} = \frac{0{,}287\cdot 293{,}15}{101{,}325 - 1{,}121} = 0{,}8348\ \text{m}^3/\text{kg} \;\Rightarrow\; \dot m_{a1} = 0{,}3308\ \text{kg/s}$$
$$v_{a2} = 0{,}8857\ \text{m}^3/\text{kg} \;\Rightarrow\; \dot m_{a2} = 0{,}6307\ \text{kg/s}$$
@paso Mezcla
$$\omega_3 = \frac{0{,}3308\cdot 0{,}00696 + 0{,}6307\cdot 0{,}01604}{0{,}9615} = 0{,}01292\ \text{kg/kg}$$
$$h_3 = 59{,}70\ \text{kJ/kg a.s.} \Rightarrow T_3 = 26{,}6\ \text{°C} \qquad \mathrm{HR}_3 \approx 59\ \%$$
@resultado
ω₁ ≈ 0,00696; ω₃ ≈ 0,01292 kg/kg; ṁ_a1 ≈ 0,3308 kg/s; ṁ_a2 ≈ 0,6307 kg/s; T₃ ≈ 26,6 °C; HR₃ ≈ 59 %.
@fin

@ejercicio ex-sp-humidif | Calentamiento y humidificación de aire con vapor saturado | Segundo parcial, 20-12-2024 | 3 | Psicrometría,Sistemas abiertos
@enunciado
Aire de 22 m³/min a 10 °C y 40 % de HR se calienta hasta 24 °C y pasa después por un humidificador a 1 bar hasta 25 °C y 55 % de HR, inyectando vapor saturado. (Enunciado resumido.)
@antes
Dos equipos: calentador (sin humedad nueva) y humidificador (vapor que se añade). Balances de aire seco, de agua y de energía en cada uno.
@trampa Resolución parcial
Verificado: el caudal de aire seco es del orden de 0,45 kg/s y la potencia del calentador del orden de 6,4 kW. La cifra exacta depende del volumen específico que tome la solución y no está cerrada en esta versión.
@ojo Temperatura del vapor inyectado
La solución de referencia da el vapor a 98,66 °C. Vapor saturado a 1 bar está a T_sat = 99,6 °C. Usa siempre la T de saturación a la presión dada.
@fin
@fin
@fin
