@bloque t10 | Mezcla de gases ideales y psicrometría | UD6 · Tema 10 | #15803d | 10 | T10 · Mezclas y psicrometría | Temas
@objetivos
- Calculo presiones parciales y fracciones molares de una mezcla de gases ideales.
- Calculo la entropía de mezcla y sé cuándo es cero.
- Calculo ω, HR, T de rocío y entalpía del aire húmedo.
- Hago balances de masa y energía en la mezcla adiabática de dos corrientes de aire húmedo.

@intro
El aire que respiras es una mezcla de gases, y casi siempre tiene vapor de agua. La psicrometría es el capítulo que te permite calcular la humedad de una sala, de una nave o de una torre de refrigeración.

@zero Mezcla de gases ideales
Cada gas se comporta como si ocupara solo el volumen total a la temperatura de la mezcla. La presión de cada componente es su **presión parcial**: $p_i = y_i\,P$, con $y_i = n_i/n$. Las fracciones molares suman 1.

@formula Mezcla: presiones parciales y entropía
$$p_i = y_i P \qquad \sum_i y_i = 1$$

$$\Delta S_{\text{mezcla}} = -R_u \sum_i n_i \ln y_i \quad\text{(kJ/K con } R_u = 8{,}314\text{ kJ/(kmol·K)}\text{)}$$

Si los componentes son el mismo gas, $\Delta S_{\text{mezcla}} = 0$ (no hay mezcla que contar).

@ejemplo Entropía de mezcla de O₂ y N₂
@enunciado
Se mezclan 1 kmol de O₂ con 3 kmol de N₂ a la misma T y P. Calcula la entropía de mezcla.
@antes
Fracciones molares y la fórmula de arriba. Son gases distintos, así que el término no es cero.
@paso Fracciones molares
$$y_{O_2} = \frac{1}{4} = 0{,}25 \qquad y_{N_2} = \frac{3}{4} = 0{,}75$$
@paso Entropía
$$\Delta S = -8{,}314\,(1\cdot\ln 0{,}25 + 3\cdot\ln 0{,}75) = -8{,}314\,(-1{,}3863 - 0{,}8630) = 18{,}70\ \text{kJ/K}$$
@resultado
ΔS_mezcla ≈ 18,70 kJ/K (para 4 kmol de mezcla).
@fin

@zero Desde cero: qué mide la psicrometría
El aire húmedo tiene aire seco y vapor de agua. Para describirlo se usan:
- **Humedad absoluta** ω (kg de vapor por kg de aire seco).
- **Humedad relativa** HR = p_v/p_g(T): cuánto vapor hay frente al máximo a esa T.
- **Temperatura de rocío** T_dp: la T a la que el vapor empieza a condensar al enfriar.
- **Temperatura de bulbo húmedo** T_bh: la que marca un termómetro con una gasa mojada.

@formula Ecuaciones básicas del aire húmedo
$$\omega = 0{,}622\,\frac{p_v}{P - p_v} \qquad \mathrm{HR} = \frac{p_v}{p_g(T)} \qquad h = 1{,}006\,T + \omega\,(2501 + 1{,}86\,T)$$

Con $P$ y $p_v$ en la misma unidad, $h$ en kJ por kg de aire seco y $T$ en °C.

@intuicion
Una sala a 25 °C con HR = 50 % tiene la mitad del vapor que podría tener. Si la enfrías hasta el punto de rocío, la HR llega al 100 % y el vapor empieza a condensar. Por eso los cristales de un coche se empañan en invierno.

@ejemplo Aire a 25 °C con HR = 50 %
@enunciado
Aire húmedo a 25 °C y HR = 50 %, a P = 101,325 kPa. Calcula p_v, ω, T de rocío y h. Presión de vapor saturado a 25 °C: p_g = 3,169 kPa.
@antes
Primero p_v a partir de HR, luego ω y la T de rocío como la T de saturación a esa p_v. La entalpía con la fórmula de la mezcla.
@paso Presión de vapor
$$p_v = \mathrm{HR}\cdot p_g = 0{,}50\cdot 3{,}169 = 1{,}585\ \text{kPa}$$
@paso Humedad absoluta
$$\omega = 0{,}622\,\frac{1{,}585}{101{,}325 - 1{,}585} = 0{,}00988\ \text{kg/kg}$$
@paso Temperatura de rocío
Buscamos T tal que $p_g(T) = 1{,}585$ kPa. Interpolando en la tabla de presiones de saturación entre 10 °C (1,228 kPa) y 15 °C (1,706 kPa), T_dp ≈ 13,9 °C. Si interpolas linealmente en p, sale unos 13,7 °C: la diferencia es normal y no cambia el resultado práctico.
@paso Entalpía
$$h = 1{,}006\cdot 25 + 0{,}00988\,(2501 + 1{,}86\cdot 25) = 25{,}15 + 25{,}17 = 50{,}3\ \text{kJ/kg a.s.}$$
@resultado
p_v ≈ 1,585 kPa; ω ≈ 0,00988 kg/kg; T_dp ≈ 13,9 °C; h ≈ 50,3 kJ/kg de aire seco.
@fin

@ejemplo Mezcla adiabática de dos corrientes de aire
@enunciado
Corriente 1: 1000 m³/h de aire a 20 °C con T_bh = 13,5 °C. Corriente 2: 2000 m³/h a 30 °C y HR = 60 %. Presión 101,325 kPa. Se mezclan adiabáticamente. Calcula ω₃, h₃ y T₃.
@antes
En la mezcla se conservan el aire seco y el agua (balance de masa) y la entalpía (balance de energía). La T de bulbo húmedo da la humedad de la corriente 1 a través del saturador adiabático.
@paso Humedad de la corriente 1
Con T_bh = 13,5 °C, la ecuación del saturador adiabático da ω₁ = 0,00696 kg/kg (HR₁ ≈ 47,9 %).
@paso Humedad de la corriente 2
$p_v = 0{,}60\cdot 4{,}246 = 2{,}548$ kPa, así que $\omega_2 = 0{,}622\cdot 2{,}548/(101{,}325 - 2{,}548) = 0{,}01604$ kg/kg.
@paso Caudales de aire seco
Volumen específico del aire seco: $v_a = R_a T/(P - p_v)$. Resulta $\dot m_{a1} = 0{,}3308$ kg/s y $\dot m_{a2} = 0{,}6307$ kg/s.
@paso Mezcla
$$\omega_3 = \frac{\dot m_{a1}\omega_1 + \dot m_{a2}\omega_2}{\dot m_{a1} + \dot m_{a2}} = 0{,}01292 \qquad h_3 = \frac{\dot m_{a1}h_1 + \dot m_{a2}h_2}{\dot m_{a1}+\dot m_{a2}} = 59{,}70\ \text{kJ/kg}$$
@paso Temperatura de la mezcla
$$T_3 = \frac{h_3 - 2501\,\omega_3}{1{,}006 + 1{,}86\,\omega_3} = 26{,}6\ \text{°C}$$
@resultado
ω₃ ≈ 0,01292 kg/kg; h₃ ≈ 59,70 kJ/kg a.s.; T₃ ≈ 26,6 °C; HR₃ ≈ 59 %.
@fin

@trampa Lo que más se pierde en psicrometría
- Usar 1 bar en vez de 1,01325 bar (1 atm) cuando el enunciado dice 1 atm: cambia ω en la tercera cifra y arrastra el resultado.
- Confundir HR con ω. HR depende de T; ω, no.
- Interpolar la T de rocío con p_g en kPa y en bar sin convertir.
- Sumar caudales de aire húmedo en vez de caudales de aire seco: el balance se hace con ṁ_a.

@fig mezcla-aire | Mezcla adiabática de dos corrientes de aire húmedo (esquema)
@sim psicrometria | Simulador: aire húmedo con T y HR
@abrirsim psicrometria | Abrir en el simulador: T de rocío y ω

@masfondo Por qué el T_bh se usa como si fuera un balance
El saturador adiabático es un aparato donde el aire pasa por agua en recirculación y se satura sin perder calor. La energía que el aire cede para evaporar el agua es la misma que el agua recibe del aire: la entalpía del aire no cambia. Por eso la temperatura de bulbo húmedo da el punto de partida para calcular ω.

@test
? Aire a 25 °C y HR = 50 % tiene ω ≈ 0,00988. ¿Cuál es la humedad relativa si la presión de vapor fuera 3,169 kPa?
- 50 %.
* 100 % (p_v = p_g).
- 25 %.
! HR = p_v/p_g: si p_v = p_g(25 °C) = 3,169 kPa, la HR es 100 %.
@test
? Para un balance de aire húmedo en una mezcla, ¿qué caudal se conserva?
- El de aire húmedo.
* El de aire seco.
- El de vapor de agua.
! El aire seco se conserva; el vapor de agua puede cambiar por condensación o evaporación.

@tarjeta ¿Qué es ω? | Kilogramos de vapor de agua por kilogramo de aire seco.
@tarjeta ¿Qué es la HR? | p_v/p_g(T): fracción del vapor máximo posible a esa temperatura.
@tarjeta ¿Qué es el T_dp? | La temperatura a la que el vapor empieza a condensar al enfriar a P constante.

@formula Resumen del tema 10
- Mezcla: p_i = y_iP; ΔS = −R_u Σ n_i ln y_i (cero si el gas es el mismo).
- Aire húmedo: ω = 0,622 p_v/(P − p_v); HR = p_v/p_g; h = 1,006T + ω(2501 + 1,86T).
- Mezcla adiabática: balances de aire seco (ṁ_a), de agua (ṁ_a ω) y de energía (ṁ_a h).

@fin
