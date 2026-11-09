@bloque formulario | Formulario por tema | Consulta rápida | #0d9488 | | Formulario | Repaso
Todas las fórmulas que entran, agrupadas por tema. La versión de una página está en el PDF de formulario.

@zero Constantes y unidades
- R (aire) = 0,287 kJ/(kg·K); R_u = 8,314 kJ/(kmol·K); M(aire) = 28,97 kg/kmol.
- c_p(aire) = 1,005 kJ/(kg·K); c_v(aire) = 0,718 kJ/(kg·K); k = 1,4.
- 1 bar = 100 kPa; 1 atm = 101,325 kPa; T(K) = T(°C) + 273,15.

@formula T1 · Agua y refrigerantes
$$v = v_f + x\,(v_g - v_f)\qquad h = h_f + x\,h_{fg}\qquad s = s_f + x\,s_{fg}\qquad 0 \le x \le 1$$

@formula T2 · Gases ideales
$$PV = mRT\qquad \Delta u = c_v\Delta T\qquad \Delta h = c_p\Delta T\qquad c_p - c_v = R$$
$$\Delta s = c_p\ln\frac{T_2}{T_1} - R\ln\frac{P_2}{P_1}$$

@formula T3 · Sistemas cerrados
$$Q - W = \Delta U\qquad W = P(V_2 - V_1)\ \text{(isobaro)}\qquad W = \frac{P_2V_2 - P_1V_1}{1 - n}\ \text{(politrópico)}$$

@formula T4 · Sistemas abiertos
$$\dot m_1 = \dot m_2\qquad \dot Q - \dot W = \dot m\left[\Delta h + \frac{\Delta c^2}{2} + g\,\Delta z\right]$$
$$\eta_T = \frac{h_1 - h_2}{h_1 - h_{2s}}\qquad \eta_C = \frac{h_{2s} - h_1}{h_2 - h_1}\qquad c_2 = \sqrt{2(h_1 - h_2)}\ \text{(tobera)}\qquad h_1 = h_2\ \text{(válvula)}$$

@formula T5 · Segundo principio
$$\eta = \frac{W}{Q_H} = 1 - \frac{Q_C}{Q_H}\qquad \mathrm{COP}_{\text{ref}} = \frac{Q_C}{W}\qquad \mathrm{COP}_{\text{bomba}} = \frac{Q_H}{W}$$
$$\eta_{\text{Carnot}} = 1 - \frac{T_C}{T_H}\qquad \mathrm{COP}_{\text{ref,C}} = \frac{T_C}{T_H - T_C}$$

@formula T6 · Entropía y balances
$$S_2 - S_1 = \int\frac{\delta Q}{T_b} + S_{\text{gen}}\qquad \dot S_{\text{gen}} = \sum\dot m_s s_s - \sum\dot m_e s_e - \sum\frac{\dot Q_j}{T_j}\qquad S_{\text{gen}} \ge 0$$

@formula T7 · Brayton de aire frío
$$\eta = 1 - r_p^{-(k-1)/k}\qquad T_2 = T_1r_p^{(k-1)/k}\qquad T_4 = T_3 r_p^{-(k-1)/k}$$

@formula T8 · Otto y Diesel
$$\eta_{\text{Otto}} = 1 - r^{1-k}\qquad \eta_{\text{Diesel}} = 1 - r^{1-k}\,\frac{r_c^k - 1}{k(r_c - 1)}$$

@formula T9 · Refrigeración por compresión de vapor
$$\mathrm{COP} = \frac{h_1 - h_4}{h_2 - h_1}\qquad h_3 = h_4\ \text{(válvula)}\qquad \mathrm{COP}_{\text{C}} = \frac{T_F}{T_C - T_F}$$

@formula T10 · Mezclas y psicrometría
$$p_i = y_iP\qquad \Delta S_{\text{mezcla}} = -R_u\sum n_i\ln y_i\qquad \omega = 0{,}622\,\frac{p_v}{P - p_v}$$
$$\mathrm{HR} = \frac{p_v}{p_g(T)}\qquad h = 1{,}006\,T + \omega\,(2501 + 1{,}86\,T)$$

@formula T11 · Combustión
$$\mathrm{CH_4} + (1 + e)\,2\,(\mathrm{O_2} + 3{,}76\,\mathrm{N_2}) \rightarrow \mathrm{CO_2} + 2\,\mathrm{H_2O} + 2e\,\mathrm{O_2} + 7{,}52(1 + e)\,\mathrm{N_2}$$
$$\mathrm{A/F}_{\text{CH}_4} = \frac{9{,}52\cdot 28{,}97}{16{,}043} = 17{,}19\qquad \mathrm{PCS} - \mathrm{PCI} = \text{agua condensada}\times h_{fg}$$

@fin
