@bloque trucos | Trucos y explicaciones sencillas | Lo que se ve en los vídeos de clase, explicado en corto | #ea580c | | Trucos y explicaciones | Repasar
Explicaciones cortas de cada tema, con trucos para resolver sin perderte. Está basado en los 18 vídeos de clase (Tema 1 a Tema 9) muestreados cada 4 minutos y en las tandas de problemas.

@ojo Qué se ha visto y qué no
Se han revisado las diapositivas, la pizarra y los cálculos en pantalla. **No se ha podido escuchar la explicación del profesor**, así que los trucos marcados como propuesta son síntesis propia, no palabras literales de clase. Las fórmulas leídas desde las capturas deben comprobarse contra la guía antes de usarlas en examen.

@grupo Mapa de vídeos y temas | abierto
| Tema | Contenido | Vídeo de clase | Vídeo de problemas |
|---|---|---|---|
| 1 | Principio de estado, superficie P-v-T, diagramas, tablas, título | 1-Tema 1_Clase | 2-Tema 1_Problemas |
| 2 | Gas ideal, gas real (Z), calor específico, politrópicos | 3-Tema 2_Clase | 4-Tema 2_Problemas |
| 3 | Primer principio: trabajo, energía, procesos y ciclos | 5_Tema 3_Clase | 6-Tema 3_Problemas |
| 4 | Volumen de control: balances, toberas, turbinas, válvulas, no estacionario | 7-Tema 4_Clase | 8-Tema 4_Problemas |
| 5 | Segundo principio: Kelvin-Planck, Clausius, irreversibilidad, Carnot | 9-Tema5_Clase | 10_Tema 5_Problemas |
| 6 | Entropía: definición, gas ideal, balance de entropía | 11-Tema 6_Clase | 12 y 13 (Tema 6 Problemas) |
| 7 | Ciclos de vapor (Rankine) y de gas (Brayton) | 14-Tema 7_Clase | 16-Tema 7_Problemas |
| 8 | Motores alternativos: Otto, Diesel y Dual | 15-Tema 8_Clase | 17-Tema 8_Problemas |
| 9 | Refrigeración, bomba de calor, refrigerantes, ciclos avanzados | 18-Tema 9_Clase | (sin vídeo de problemas) |
@fin

@grupo Tema 1 · Estado de una sustancia pura | abierto
Con dos propiedades independientes (por ejemplo P y T, o P y v) queda fijado el estado de una sustancia pura simple y compresible.
@intuicion
Imagina agua en una olla. Mientras hierve a 1 atm, la temperatura se queda en 100 °C aunque sigas calentando: el calor se usa en cambiar de líquido a vapor. Por eso, dentro de la zona de dos fases, P y T no son independientes.
**Trucos**
1. Decide primero la región y después calcula. Compara T con T_sat(P): si T < T_sat es líquido comprimido; si T = T_sat es mezcla y hay que calcular el título; si T > T_sat es vapor sobrecalentado y no hay título.
2. Título = vapor / total: x = (v − v_f) / (v_g − v_f). Es la regla de la palanca en el diagrama P-v o T-v.
3. Líquido comprimido (aproximación de la diapositiva): v ≈ v_f(T) y h ≈ h_f(T) + v_f·(P − P_sat(T)). No uses v_g aquí.
4. En el diagrama P-v: a la izquierda líquido, dentro de la campana mezcla, a la derecha vapor. El punto crítico es donde desaparece la diferencia entre líquido y vapor.
5. Las tablas en inglés usan punto decimal. Antes de copiar un valor, comprueba el separador.
@trampa
Usar v_g cuando el estado es líquido comprimido; confundir P_sat con la presión de la mezcla; interpolar linealmente v_g entre temperaturas muy separadas.
@fin

@grupo Tema 2 · Gases: ideal, real, calor específico y politrópicos | abierto
El gas ideal cumple Pv = RT, y su energía interna y su entalpía dependen solo de la temperatura.
@intuicion
El factor de compresibilidad Z = Pv / RT mide cuánto se aleja el gas real del ideal. Cuando la presión baja o la temperatura sube, Z tiende a 1. Por eso el diagrama de Nelson-Obert sirve para decidir si puedes usar la ley del gas ideal.
**Trucos**
1. R = c_p − c_v. Recuérdalo y te ahorras tablas: con c_p y R tienes c_v.
2. γ = c_p / c_v. Para gas ideal, du = c_v dT y dh = c_p dT.
3. Los cuatro casos de PV^n = cte: n = 0 isobaro; n = 1 isotermo (gas ideal); n = γ adiabático reversible; n → ∞ isocoro. Trabajo politrópico: W₁₂ = (P₂V₂ − P₁V₁) / (1 − n), con n ≠ 1.
4. Experimento de Joule: en expansión libre de un gas ideal la temperatura no cambia, así que ΔU = 0 y W = 0.
5. Sustancia incompresible: c_p = c_v = c(T); solo depende de la temperatura.
@trampa
Aplicar la ley del gas ideal a un vapor cerca de la campana, donde Z se aleja mucho de 1.
@fin

@grupo Tema 3 · Primer principio | abierto
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

@grupo Tema 4 · Volumen de control (sistemas abiertos) | abierto
En régimen estacionario, lo que entra en energía es igual a lo que sale, más el calor y el trabajo intercambiados.
@intuicion
Un sistema abierto es un tubo, una turbina o una tobera: el fluido entra, cambia y sale. Ya no tienes una masa fija, tienes flujos.
**Trucos**
1. Tacha antes de escribir la ecuación. En tobera y difusor: Q̇ = 0, Ẇ = 0, Δz ≈ 0, luego h₁ + c₁²/2 = h₂ + c₂²/2. En turbina adiabática: Ẇ = ṁ(h₁ − h₂). En compresor o bomba: Ẇ = ṁ(h₂ − h₁), cuidado con el signo.
2. Válvula o estrangulamiento: h₁ = h₂ (isentálpico), sin trabajo.
3. Intercambiador: sin trabajo y sin mezcla; el calor pasa de un fluido a otro. Cámara de mezcla: primero el balance de masa y después el de energía.
4. Con un solo flujo de entrada y de salida, ṁ₁ = ṁ₂ = ṁ, y Q̇ = Ẇ + ṁ[Δh + Δc²/2 + gΔz].
5. Tobera subsónica: acelera el fluido (c₂ > c₁) y baja la presión. El difusor hace lo contrario.
6. Tanque que se descarga: es régimen no estacionario. No basta con el balance de estacionario; hay que integrar en el tiempo.
@trampa
Dejar términos de energía cinética o potencial que son despreciables sin comprobarlo, o olvidar que el trabajo de un compresor entra en el sistema.
@fin

@grupo Tema 5 · Segundo principio | abierto
Los procesos tienen sentido: el calor no pasa solo de frío a caliente, y no se puede convertir todo el calor de un foco en trabajo.
@intuicion
El primer principio dice qué energía se conserva; el segundo dice en qué dirección ocurren las cosas y cuánto trabajo máximo se puede obtener.
**Trucos**
1. Kelvin-Planck (no hay motor que convierta el calor de un solo foco en trabajo neto) y Clausius (no pasa calor de frío a caliente sin aporte de trabajo) son equivalentes. Si rompes una, rompes la otra.
2. Agrupa las irreversibilidades por familias: térmicas (diferencia finita de temperatura), mecánicas (expansión libre, rozamiento, deformación inelástica) y otras (reacción química, mezcla de sustancias distintas, resistencia eléctrica, magnetización).
3. Internamente reversible significa que no hay irreversibilidades dentro del sistema, aunque sí puede haberlas con el entorno.
4. Carnot siempre en kelvin: η_Carnot = 1 − T_F / T_C. Si usas °C, el resultado es incorrecto.
5. Refrigerador: EER = Q_F / W. Bomba de calor: COP = Q_C / W = 1 + EER. Usa la segunda igualdad para comprobar el resultado.
6. Escala Kelvin: T = 273,16 · (Q / Q_triple). El punto triple del agua es la referencia.
@trampa
Usar °C en Carnot o confundir el COP de la bomba de calor con el del refrigerador.
@fin

@grupo Tema 6 · Entropía | abierto
La entropía mide la irreversibilidad: en un sistema aislado nunca disminuye.
@intuicion
Si un proceso es reversible, puedes deshacerlo sin dejar huella. Si hay rozamiento, calor a través de una diferencia finita de temperatura o expansión libre, se genera entropía.
**Trucos**
1. Calcula ΔS con un camino reversible imaginario. Aunque el proceso real sea irreversible, la entropía es una propiedad.
2. Gas ideal: ds = c_p dT/T − R dP/P, o bien ds = c_v dT/T + R dv/v. En un isotermo, Δs = −R ln(P₂/P₁).
3. Adiabático y reversible: ΔS = 0 (isentrópico). Adiabático e irreversible: ΔS > 0.
4. Balance de entropía: dS/dt = Σ Q̇/T + Ṡ_gen, con Ṡ_gen ≥ 0. Si te sale negativa, revisa los signos.
5. Isentrópico con tablas de gas ideal: P₂/P₁ = exp((s°₂ − s°₁)/R), o con presiones relativas.
@trampa
Calcular ΔS con el calor real de un proceso irreversible en lugar de usar un camino reversible.
@fin

@grupo Tema 7 · Ciclos de vapor (Rankine) y de gas (Brayton) | abierto
El rendimiento sube si el calor entra a mayor temperatura media o sale a menor temperatura media.
@intuicion
El ciclo Rankine tiene bomba, caldera, turbina y condensador. El Brayton es el de la turbina de gas (compresor, cámara de combustión y turbina) y es un ciclo abierto, el más habitual.
**Trucos**
1. Tres palancas en Rankine, según las diapositivas: subir la presión de la caldera, bajar la presión del condensador y sobrecalentar o recalentar el vapor. La regeneración también ayuda porque el agua entra más caliente en la caldera.
2. Brayton ideal con aire estándar: η = 1 − 1 / r^((γ−1)/γ), con r = P₂/P₁. Solo depende de la relación de presiones.
3. El condensador no es una pérdida inútil: hace posible que el agua vuelva a la bomba con poco trabajo.
@trampa
Usar las presiones en bar y en kPa a la vez sin convertirlas.
@fin

@grupo Tema 8 · Motores alternativos: Otto, Diesel y Dual | abierto
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

@grupo Tema 9 · Refrigeración, bombas de calor y refrigerantes | abierto
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

@grupo Hoja de trucos general | abierto
1. Identifica la región antes de buscar en tablas: líquido, mezcla o vapor.
2. En cada equipo, tacha los términos que valen cero antes de escribir la ecuación de energía.
3. Temperatura en kelvin en Carnot, Clausius, entropía y gas ideal.
4. Signos: Q que entra es positivo; W que sale es positivo. Fíjalo al principio.
5. Entropía de un proceso irreversible: calcúlala por un camino reversible imaginario.
6. Comprobaciones rápidas: Ṡ_gen ≥ 0, η ≤ η_Carnot, COP de bomba = 1 + EER.
7. Separador decimal en las tablas: revisa punto y coma antes de copiar.
@fin

@ojo Pendiente
Para recoger las explicaciones literales del profesor hace falta transcribir el audio de los vídeos. Las fórmulas dudosas, como α y β del Dual o los rendimientos de Diesel, deben verificarse contra la guía.

@fin
