@bloque practicas | Prácticas I1 e I2 | Práctica y laboratorio | #0f766e | | Prácticas | Práctica y exámenes
La asignatura trabaja las prácticas con **EES** (Engineering Equation Solver). Aquí tienes el equivalente en **Python**: se ejecuta en cualquier ordenador, muestra la salida que hay que esperar y reproduce en el navegador los cálculos principales. Si tu grupo usa EES, los resultados deben coincidir dentro de la precisión de las tablas.

@esencial Qué se evalúa en las prácticas
- Dos sesiones de 2 horas (I1 e I2). La asistencia pesa el 15 % por sesión.
- La entrega pesa el 70 %: un informe con código, salida y la interpretación pedida.
- Lo que no puede faltar en cualquier entrega: qué calculas, de dónde sale cada dato y si el resultado tiene sentido físico.

@trampa Antes de programar
- Las tablas de estos scripts son **reducidas** (anclas de las tablas de Moran). Sirven para practicar. Para exámenes usa las tablas completas.
- Unidades coherentes: presiones en kPa, temperaturas en °C en las tablas de agua y en K en las fórmulas de gas.
- Un error de programa puede dar un resultado plausible. Antes de creerlo, comprueba un caso conocido (p_sat(100 °C) ≈ 101,3 kPa).

@masfondo Qué es EES y qué pide cada práctica
EES resuelve sistemas de ecuaciones no lineales con propiedades termodinámicas incorporadas. La práctica I1 enseña a introducir un problema básico (estado del agua, balance de energía). La práctica I2 estudia un ciclo completo y muestra cómo cambian sus resultados al variar un parámetro. Python hace lo mismo con más trabajo manual, y por eso aquí las tablas son explícitas.

@ejercicio pr-i1 | Práctica I1 · Estado del agua y región de trabajo | Práctica I1 · EES (equivalente Python) | | agua,tablas
@antes
Objetivo: dada una temperatura y una presión, decidir la región (líquido comprimido, mezcla o vapor sobrecalentado) y calcular el título cuando hay mezcla.
@paso Descargar el script y mirar la estructura
El script tiene tres partes: una tabla reducida de saturación, funciones de interpolación y el bloque principal con los cuatro casos de prueba.
@paso Ejecutarlo y leer la salida
Ejecuta el script. La salida que debes obtener es la siguiente.
@salida Salida esperada | scripts/practica_I1_agua.py
@paso Ver el código
@archivo python | Código completo | scripts/practica_I1_agua.py
@paso Probar en el simulador
Cambia T y P y mira cómo cambia la región. Es la misma lógica que el script.
@abrirsim agua-consola | Abrir el simulador de la práctica I1
@resultado
Interpretación pedida (propuesta de la guía; la práctica oficial puede pedir otra cosa): explica en 5 líneas por qué a 150 °C y 500 kPa el agua es líquido comprimido, y por qué a 100 °C y 101,33 kPa hay mezcla. Usa las palabras «p_sat», «región» y «título».
@fin

@ejercicio pr-i2 | Práctica I2 · Análisis de un ciclo Brayton | Práctica I2 · EES (equivalente Python) | | turbinas,gases
@antes
Objetivo: calcular el rendimiento de un ciclo Brayton de aire frío y estudiar cómo cambia con la relación de compresión r_p.
@paso Ejecutar el caso base
El script calcula primero el caso base (r_p = 8, T₁ = 300 K, T₃ = 1200 K) y luego barre r_p. La salida es la siguiente.
@salida Salida esperada | scripts/practica_I2_ciclo.py
@paso Leer el barrido
El rendimiento sube con r_p pero el trabajo neto tiene un máximo cerca de r_p = 10–12 con estas temperaturas. Comprueba que el caso r_p = 8 coincide con la fórmula cerrada del tema 7.
@paso Ver el código
@archivo python | Código completo | scripts/practica_I2_ciclo.py
@paso Probar en el simulador
Compara la gráfica del simulador con el barrido del script.
@abrirsim ciclo-consola | Abrir el simulador de la práctica I2
@resultado
Interpretación pedida (propuesta de la guía): responde en un párrafo qué parámetro limita el trabajo neto cuando r_p crece, y por qué la relación de trabajos w_comp/w_turb aumenta. Cita los valores del barrido.
@fin

@ejercicio pr-ent | Entrega y criterios | Prácticas | | entrega
@antes
Qué debe contener la entrega de cada práctica. Esta lista es una propuesta; comprueba las instrucciones de tu grupo.
- Código completo, con comentarios en español.
- Salida con los valores de los casos pedidos.
- Interpretación física (no solo números): signo, orden de magnitud, comparación con el caso ideal.
- Una comprobación independiente (fórmula cerrada, caso límite o tabla).
@resultado
Un informe corto y ordenado vale más que uno largo con capturas sin explicar.
@fin
@fin
