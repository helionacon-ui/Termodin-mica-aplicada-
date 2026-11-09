@bloque demos | Demostraciones | Teoría completa · paso a paso | #4338ca | | Demostraciones | Repaso
Estas demostraciones desarrollan paso a paso los resultados de teoría que entran en el examen. Cada paso dice qué se hace y por qué.

@demo Primera ley a presión constante: c_p − c_v = R
@intuicion
Calentar un gas a presión constante exige más calor que calentarlo a volumen constante: parte de la energía se gasta en empujar el émbolo. Demostramos que esa diferencia es exactamente R.
@paso Partir de la primera ley
Para un sistema cerrado sin energía cinética ni potencial: $Q - W = \Delta U$. Lo escribimos por kilogramo de gas: $q - w = \Delta u$.
@paso Trabajo a presión constante
Si la presión es constante, el trabajo de frontera es $w = P\,(v_2 - v_1)$. Para un gas ideal, $Pv = RT$ en ambos estados, así que $P v_2 - P v_1 = R(T_2 - T_1)$, y $w = R\,\Delta T$.
@paso Calor a presión constante
Sustituimos el trabajo en la primera ley: $q_P = \Delta u + R\,\Delta T$. Para un gas ideal, $\Delta u = c_v\,\Delta T$ (la energía interna depende solo de T). Entonces $q_P = (c_v + R)\,\Delta T$.
@paso Definición de c_p
La entalpía es $h = u + Pv$. A presión constante, $dh = du + P\,dv + v\,dP = du + P\,dv = \delta q_P$. Por tanto $q_P = \Delta h = c_p\,\Delta T$ con la definición de $c_p$.
@paso Conclusión
Igualando $q_P = c_p\Delta T = (c_v + R)\Delta T$ se obtiene $c_p - c_v = R$. Es una identidad para cualquier gas ideal.
@resultado
$$c_p - c_v = R \qquad \text{y, con } k = c_p/c_v:\quad c_v = \frac{R}{k-1},\quad c_p = \frac{kR}{k-1}$$
@fin

@demo Variación de entropía de un gas ideal
@intuicion
La entropía mide cuánto "espacio" tienen las partículas para repartirse en energía y en volumen. Si aumenta la temperatura o el volumen, aumenta la entropía.
@paso Ecuación de Gibbs
Para un proceso reversible, $T\,ds = du + P\,dv$. Es la combinación de la primera ley ($\delta q = du + \delta w$) y la definición de trabajo reversible.
@paso Sustituir gas ideal
Con $du = c_v\,dT$ y $P = RT/v$:
$$ds = \frac{c_v\,dT}{T} + \frac{R\,dv}{v}$$
@paso Integrar
Con $c_v$ constante:
$$\Delta s = c_v\ln\frac{T_2}{T_1} + R\ln\frac{v_2}{v_1}$$
@paso Cambiar v por P
Para un gas ideal, $\frac{v_2}{v_1} = \frac{T_2}{T_1}\cdot\frac{P_1}{P_2}$. Sustituimos:
$$\Delta s = (c_v + R)\ln\frac{T_2}{T_1} - R\ln\frac{P_2}{P_1} = c_p\ln\frac{T_2}{T_1} - R\ln\frac{P_2}{P_1}$$
@paso Comprobación
Si $T_2 = T_1$ (isoterma), $\Delta s = -R\ln(P_2/P_1)$: al comprimir ($P_2 > P_1$) la entropía baja, como debe ser en un proceso reversible sin calor neto. Si $P_2 = P_1$ (isobaro), $\Delta s = c_p\ln(T_2/T_1)$: solo cambia por T.
@resultado
$$\Delta s = c_p\ln\frac{T_2}{T_1} - R\ln\frac{P_2}{P_1} = c_v\ln\frac{T_2}{T_1} + R\ln\frac{v_2}{v_1}$$
@fin

@demo Carnot: η = 1 − T_C/T_H desde la desigualdad de Clausius
@intuicion
Un ciclo reversible es el máximo que se puede exigir. Si un ciclo fuera más eficiente que Carnot, podríamos hacer funcionar un refrigerador "gratis". La desigualdad de Clausius formaliza ese argumento.
@paso Desigualdad de Clausius
Para cualquier ciclo: $\oint \delta Q/T \le 0$, con igualdad solo si el ciclo es reversible.
@paso Aplicarla a dos focos
Un ciclo que absorbe $Q_H$ a $T_H$ y cede $Q_C$ a $T_C$ (con $Q_C > 0$ como calor cedido) cumple:
$$\frac{Q_H}{T_H} - \frac{Q_C}{T_C} \le 0 \quad\Rightarrow\quad \frac{Q_C}{Q_H} \ge \frac{T_C}{T_H}$$
@paso Rendimiento
El rendimiento es $\eta = W/Q_H = 1 - Q_C/Q_H$. Usando la desigualdad anterior: $\eta \le 1 - T_C/T_H$.
@paso Caso reversible
Si el ciclo es reversible, la igualdad se cumple: $\eta = 1 - T_C/T_H$. Ese es el rendimiento de Carnot, y es el mismo para cualquier máquina reversible entre esos dos focos.
@paso Interpretar el resultado
Ningún ciclo entre $T_H$ y $T_C$ supera $1 - T_C/T_H$, y los reales quedan por debajo: tienen irreversibilidades. Con $T_H = 800$ K y $T_C = 300$ K, el límite es 62,5 %.
@resultado
$$\eta_{\text{rev}} = 1 - \frac{T_C}{T_H} \qquad \eta_{\text{real}} \le 1 - \frac{T_C}{T_H}$$
@fin
@fin
