/* Simuladores interactivos de la guía. Aproximaciones didácticas: no sustituyen a las tablas A-2…A-22.
   Cada simulador: {title, desc, controls:[{id,label,unit,min,max,step,value,dec}], run(v) -> {text, plot, consola}, code?} */
(function () {
  'use strict';

  const R = 0.287, CP = 1.005, CV = 0.718, K = 1.4, RU = 8.314, MCH4 = 16.043;

  /* ---------- utilidades ---------- */
  const f = (x, d = 2) => (Number.isFinite(x) ? x : NaN).toFixed(d).replace('.', ',');
  const lin = (xs, ys, x) => {
    const n = xs.length;
    if (x <= xs[0]) return ys[0];
    if (x >= xs[n - 1]) return ys[n - 1];
    for (let i = 0; i < n - 1; i++) {
      if (x <= xs[i + 1]) {
        const t = (x - xs[i]) / (xs[i + 1] - xs[i]);
        return ys[i] + t * (ys[i + 1] - ys[i]);
      }
    }
    return ys[n - 1];
  };

  // Presión de saturación del agua (kPa), anclas de tabla A-2 (interpolación lineal en ln p)
  const PS_T = [0.01, 20, 50, 100, 150, 200, 250, 300];
  const PS_P = [0.6113, 2.339, 12.35, 101.33, 476.2, 1554.9, 3973, 8587.9];
  const PS_LN = PS_P.map(Math.log);
  const psat = (T) => Math.exp(lin(PS_T, PS_LN, T));
  const tsat = (p) => lin(PS_LN, PS_T, Math.log(p));

  // Propiedades de saturación del agua (anclas 20, 100, 200 °C), interpolación aproximada
  const AW_T = [20, 100, 200];
  const AW = {
    vf: [0.001002, 0.001043, 0.001157], vg: [57.79, 1.673, 0.12736],
    hf: [83.96, 419.04, 852.45], hg: [2537.4, 2676.1, 2792.2],
    sf: [0.2966, 1.3069, 2.3309], sg: [8.6672, 7.3549, 6.4302]
  };
  const awv = (k, T) => (k === 'vg' ? Math.exp(lin(AW_T, AW[k].map(Math.log), T)) : lin(AW_T, AW[k], T));

  // Presión de vapor saturado del aire húmedo (kPa), tabla psicrométrica (Pg)
  const PG_T = [0, 5, 10, 12, 14, 15, 20, 25, 30, 31, 35, 40, 50, 60, 70, 80, 90, 100];
  const PG_P = [0.6113, 0.8721, 1.2276, 1.4028, 1.598, 1.7057, 2.339, 3.169, 4.246, 4.496, 5.629, 7.384, 12.35, 19.94, 31.2, 47.39, 70.14, 101.33];
  const PG_LN = PG_P.map(Math.log);
  const pg = (T) => Math.exp(lin(PG_T, PG_LN, T));
  const tdp = (pv) => lin(PG_LN, PG_T, Math.log(pv));

  const hAire = (T, w) => 1.006 * T + w * (2501 + 1.86 * T);

  /* ---------- gráficas ---------- */
  function plot(o) {
    const W = 560, H = 280, L = 56, Rr = 14, Tt = 14, B = 42;
    const sx = (x) => L + ((x - o.xmin) / (o.xmax - o.xmin)) * (W - L - Rr);
    const sy = (y) => H - B - ((y - o.ymin) / (o.ymax - o.ymin)) * (H - B - Tt);
    let s = `<svg viewBox="0 0 ${W} ${H}" role="img" aria-label="${o.xl} frente a ${o.yl}">`;
    for (let i = 0; i <= 4; i++) {
      const yv = o.ymin + (i * (o.ymax - o.ymin)) / 4;
      s += `<line x1="${L}" x2="${W - Rr}" y1="${sy(yv)}" y2="${sy(yv)}" style="stroke:var(--line)"/>`;
      s += `<text x="${L - 6}" y="${sy(yv) + 4}" text-anchor="end" style="fill:var(--muted);font-size:11px">${f(yv, o.yd ?? 0)}</text>`;
      const xv = o.xmin + (i * (o.xmax - o.xmin)) / 4;
      s += `<text x="${sx(xv)}" y="${H - B + 16}" text-anchor="middle" style="fill:var(--muted);font-size:11px">${f(xv, o.xd ?? 0)}</text>`;
    }
    s += `<line x1="${L}" y1="${H - B}" x2="${W - Rr}" y2="${H - B}" style="stroke:var(--fg)"/>`;
    s += `<line x1="${L}" y1="${Tt}" x2="${L}" y2="${H - B}" style="stroke:var(--fg)"/>`;
    s += `<text x="${(L + W - Rr) / 2}" y="${H - 6}" text-anchor="middle" style="fill:var(--fg);font-size:12px">${o.xl}</text>`;
    s += `<text transform="translate(14 ${(Tt + H - B) / 2}) rotate(-90)" text-anchor="middle" style="fill:var(--fg);font-size:12px">${o.yl}</text>`;
    for (const se of o.series || []) {
      let d = '';
      se.xs.forEach((x, i) => {
        const y = se.ys[i];
        if (!Number.isFinite(y)) return;
        d += (d ? 'L' : 'M') + sx(x).toFixed(1) + ' ' + sy(y).toFixed(1) + ' ';
      });
      s += `<path d="${d}" fill="none" style="stroke:${se.c || 'var(--acc)'}" stroke-width="2.4"${se.dash ? ' stroke-dasharray="6 5"' : ''}/>`;
    }
    for (const p of o.pts || []) {
      s += `<circle cx="${sx(p.x).toFixed(1)}" cy="${sy(p.y).toFixed(1)}" r="5.5" style="fill:#d9485f"/>`;
      if (p.l) s += `<text x="${(sx(p.x) + 8).toFixed(1)}" y="${(sy(p.y) - 8).toFixed(1)}" style="fill:var(--fg);font-size:12px">${p.l}</text>`;
    }
    return s + '</svg>';
  }

  function barras(items, yl) {
    const W = 560, H = 260, L = 56, B = 44, Tt = 16;
    const max = Math.max(1e-9, ...items.map((i) => Math.abs(i.v))) * 1.15;
    const y0 = H - B;
    const hgt = y0 - Tt;
    const yy = (v) => y0 - (v / max + 1) / 2 * hgt;
    let s = `<svg viewBox="0 0 ${W} ${H}" role="img" aria-label="${yl}">`;
    s += `<line x1="${L}" x2="${W - 10}" y1="${yy(0)}" y2="${yy(0)}" style="stroke:var(--fg)"/>`;
    const bw = (W - L - 20) / items.length;
    items.forEach((it, i) => {
      const x = L + i * bw + bw * 0.18;
      const y1 = yy(it.v), y2 = yy(0);
      s += `<rect x="${x.toFixed(1)}" y="${Math.min(y1, y2).toFixed(1)}" width="${(bw * 0.64).toFixed(1)}" height="${Math.abs(y1 - y2).toFixed(1)}" style="fill:${it.c || 'var(--acc)'}" rx="4"/>`;
      s += `<text x="${(x + bw * 0.32).toFixed(1)}" y="${H - 24}" text-anchor="middle" style="fill:var(--fg);font-size:12px">${it.l}</text>`;
      s += `<text x="${(x + bw * 0.32).toFixed(1)}" y="${(Math.min(y1, y2) - 6).toFixed(1)}" text-anchor="middle" style="fill:var(--fg);font-size:12px">${f(it.v, it.dec ?? 2)}</text>`;
    });
    s += `<text x="${L - 6}" y="${Tt + 8}" text-anchor="end" style="fill:var(--muted);font-size:11px">${yl}</text>`;
    return s + '</svg>';
  }

  const rango = (a, b, paso) => { const r = []; for (let x = a; x <= b + 1e-9; x += paso) r.push(x); return r; };

  /* ---------- simuladores ---------- */
  const SIMS = {};

  SIMS['agua-psat'] = {
    title: 'Presión de saturación del agua',
    desc: 'Mueve la temperatura: verás la presión a la que el agua hierve a esa temperatura (la curva de saturación).',
    controls: [{ id: 'T', label: 'Temperatura', unit: '°C', min: 0, max: 300, step: 1, value: 100, dec: 0 }],
    run(v) {
      const p = psat(v.T);
      const xs = rango(0, 300, 5);
      return {
        text: `p_sat(${f(v.T, 0)} °C) = ${f(p, 1)} kPa  (${f(p / 100, 3)} bar)\n` +
          `A esa presión el agua hierve (y el vapor condensa) a ${f(v.T, 0)} °C.\n` +
          `Por encima de la curva, a esa T la presión es mayor que p_sat: líquido comprimido.`,
        plot: plot({ xmin: 0, xmax: 300, ymin: 0, ymax: 9000, xl: 'T (°C)', yl: 'p_sat (kPa)', yd: 0,
          series: [{ xs, ys: xs.map(psat) }], pts: [{ x: v.T, y: p, l: `${f(v.T, 0)} °C` }] })
      };
    }
  };

  SIMS['agua-fase'] = {
    title: 'Fase del agua: líquido, mezcla o vapor',
    desc: 'Fija T y P. Compara P con p_sat(T) para saber en qué región estás.',
    controls: [
      { id: 'T', label: 'Temperatura', unit: '°C', min: 0, max: 300, step: 1, value: 120, dec: 0 },
      { id: 'P', label: 'Presión', unit: 'kPa', min: 10, max: 9000, step: 10, value: 300, dec: 0 }
    ],
    run(v) {
      const ps = psat(v.T);
      let reg;
      if (Math.abs(v.P - ps) / ps < 0.005) reg = 'Mezcla saturada (en la curva)';
      else if (v.P < ps) reg = 'Vapor sobrecalentado (P < p_sat)';
      else reg = 'Líquido comprimido o subenfriado (P > p_sat)';
      return {
        text: `p_sat(T) = ${f(ps, 1)} kPa\nTsat(P) = ${f(tsat(v.P), 1)} °C\nRegión: ${reg}`,
        plot: plot({ xmin: 0, xmax: 300, ymin: 0, ymax: 9000, xl: 'T (°C)', yl: 'P (kPa)', yd: 0,
          series: [{ xs: rango(0, 300, 5), ys: rango(0, 300, 5).map(psat) }], pts: [{ x: v.T, y: v.P, l: 'estado' }] })
      };
    }
  };

  SIMS['agua-x'] = {
    title: 'Mezcla líquido-vapor: título x',
    desc: 'Con T y el título x, calcula v, h y s de la mezcla con v = v_f + x(v_g − v_f), etc. Valores aproximados (tabla reducida).',
    controls: [
      { id: 'T', label: 'Temperatura', unit: '°C', min: 20, max: 200, step: 1, value: 100, dec: 0 },
      { id: 'x', label: 'Título x', unit: '', min: 0, max: 1, step: 0.01, value: 0.5, dec: 2 }
    ],
    run(v) {
      const vf = awv('vf', v.T), vg = awv('vg', v.T);
      const hf = awv('hf', v.T), hg = awv('hg', v.T), sf = awv('sf', v.T), sg = awv('sg', v.T);
      const vm = vf + v.x * (vg - vf), hm = hf + v.x * (hg - hf), sm = sf + v.x * (sg - sf);
      const xs = rango(0, 1, 0.05);
      return {
        text: `v = ${f(vm, 4)} m³/kg\nh = ${f(hm, 1)} kJ/kg\ns = ${f(sm, 4)} kJ/(kg·K)\n` +
          `(v_f = ${f(vf, 6)}, v_g = ${f(vg, 4)} m³/kg; h_f = ${f(hf, 1)}, h_g = ${f(hg, 1)} kJ/kg)`,
        plot: plot({ xmin: 0, xmax: 1, ymin: 0, ymax: Math.max(0.2, vg * 1.05), xl: 'título x', yl: 'v (m³/kg)', xd: 1, yd: 2,
          series: [{ xs, ys: xs.map((x) => vf + x * (vg - vf)) }], pts: [{ x: v.x, y: vm, l: 'estado' }] })
      };
    }
  };

  SIMS['gas-politropico'] = {
    title: 'Proceso politrópico PV^n = cte (aire)',
    desc: 'Aire: 0,5 m³ a 300 kPa y 300 K. Cambia n y el volumen final. Verás W, Q, ΔU y ΔS del proceso.',
    controls: [
      { id: 'n', label: 'Exponente politrópico n', unit: '', min: -1, max: 1.6, step: 0.05, value: 1.3, dec: 2 },
      { id: 'V2', label: 'Volumen final V₂', unit: 'm³', min: 0.2, max: 2, step: 0.05, value: 1, dec: 2 }
    ],
    run(v) {
      const P1 = 300, V1 = 0.5, T1 = 300;
      const m = (P1 * V1) / (R * T1);
      const n = v.n, V2 = v.V2;
      const P2 = P1 * Math.pow(V1 / V2, n);
      const T2 = T1 * Math.pow(P2 / P1, (n - 1) / n);
      const W = Math.abs(n - 1) < 1e-9 ? P1 * V1 * Math.log(V2 / V1) : (P2 * V2 - P1 * V1) / (1 - n);
      const dU = m * CV * (T2 - T1);
      const Q = dU + W;
      const dS = m * (CV * Math.log(T2 / T1) + R * Math.log(V2 / V1));
      const xs = rango(0.2, 2, 0.02);
      const pol = xs.map((x) => P1 * Math.pow(V1 / x, n));
      const ad = xs.map((x) => P1 * Math.pow(V1 / x, K));
      const it = xs.map((x) => P1 * V1 / x);
      return {
        text: `masa m = ${f(m, 3)} kg\nP₂ = ${f(P2, 1)} kPa   T₂ = ${f(T2, 1)} K\n` +
          `W = ${f(W, 2)} kJ   (W > 0: el gas hace trabajo)\nΔU = ${f(dU, 2)} kJ\nQ = ${f(Q, 2)} kJ   (Q > 0: entra calor)\nΔS = ${f(dS, 4)} kJ/K`,
        plot: plot({ xmin: 0.2, xmax: 2, ymin: 0, ymax: 900, xl: 'V (m³)', yl: 'P (kPa)', xd: 1, yd: 0,
          series: [{ xs, ys: pol }, { xs, ys: ad, c: 'var(--muted)', dash: true }, { xs, ys: it, c: 'var(--key-line)', dash: true }],
          pts: [{ x: V2, y: P2, l: `n = ${f(n, 2)}` }] })
      };
    }
  };

  SIMS['turbina-eta'] = {
    title: 'Turbina: rendimiento isentrópico',
    desc: 'Entalpías en kJ/kg. Un η menor da menos trabajo y mayor h₂. Compara el trabajo real con el ideal.',
    controls: [
      { id: 'h1', label: 'Entalpía de entrada h₁', unit: 'kJ/kg', min: 2800, max: 3400, step: 10, value: 3000, dec: 0 },
      { id: 'h2s', label: 'Entalpía isentrópica h₂s', unit: 'kJ/kg', min: 2300, max: 2900, step: 10, value: 2500, dec: 0 },
      { id: 'eta', label: 'Rendimiento η', unit: '', min: 0.5, max: 1, step: 0.01, value: 0.85, dec: 2 }
    ],
    run(v) {
      const h2 = v.h1 - v.eta * (v.h1 - v.h2s);
      const wr = v.h1 - h2, wi = v.h1 - v.h2s;
      return {
        text: `h₂ = ${f(h2, 1)} kJ/kg\nw_real = ${f(wr, 1)} kJ/kg   w_ideal = ${f(wi, 1)} kJ/kg\n` +
          `η = (h₁ − h₂)/(h₁ − h₂s) = ${f(wr / wi, 3)}`,
        plot: barras([{ l: 'ideal', v: wi, c: 'var(--muted)', dec: 0 }, { l: 'real', v: wr, dec: 0 }], 'trabajo (kJ/kg)')
      };
    }
  };

  SIMS['carnot'] = {
    title: 'Ciclo de Carnot entre dos focos',
    desc: 'El rendimiento depende solo de las temperaturas absolutas (K). Prueba a acercar T_C a T_H.',
    controls: [
      { id: 'TH', label: 'Foco caliente T_H', unit: 'K', min: 300, max: 1200, step: 1, value: 800, dec: 0 },
      { id: 'TC', label: 'Foco frío T_C', unit: 'K', min: 200, max: 1100, step: 1, value: 300, dec: 0 }
    ],
    run(v) {
      if (v.TC >= v.TH) return { text: 'Hace falta T_C < T_H.', plot: '' };
      const eta = 1 - v.TC / v.TH, cr = v.TC / (v.TH - v.TC), cb = v.TH / (v.TH - v.TC);
      const ds = 1, s0 = 0, s1 = 1;
      return {
        text: `η_Carnot = 1 − T_C/T_H = ${f(eta * 100, 1)} %\nCOP refrigerador = T_C/(T_H − T_C) = ${f(cr, 2)}\nCOP bomba de calor = T_H/(T_H − T_C) = ${f(cb, 2)}`,
        plot: plot({ xmin: 0, xmax: 1.2, ymin: 0, ymax: 1300, xl: 's (relativo)', yl: 'T (K)', xd: 1, yd: 0,
          series: [{ xs: [s0, s1], ys: [v.TH, v.TH], c: 'var(--tc,var(--acc))' }, { xs: [s0, s1], ys: [v.TC, v.TC], c: 'var(--muted)' },
            { xs: [s0, s0, s1, s1, s0], ys: [v.TC, v.TH, v.TH, v.TC, v.TC], c: 'var(--key-line)' }] })
      };
    }
  };

  SIMS['entropia-transferencia'] = {
    title: 'Transferencia de calor: generación de entropía',
    desc: 'Q pasa del foco caliente al frío. ΔS_total = Q/T_C − Q/T_H ≥ 0. Si T_H = T_C, sale 0 (proceso reversible).',
    controls: [
      { id: 'Q', label: 'Calor Q', unit: 'kJ', min: 0.1, max: 10, step: 0.1, value: 1, dec: 1 },
      { id: 'TH', label: 'T del foco caliente', unit: 'K', min: 200, max: 1000, step: 1, value: 500, dec: 0 },
      { id: 'TC', label: 'T del foco frío', unit: 'K', min: 200, max: 1000, step: 1, value: 300, dec: 0 }
    ],
    run(v) {
      if (v.TC > v.TH) return { text: 'Con T_C > T_H el calor iría al revés: cambia los focos.', plot: '' };
      const dSH = -v.Q / v.TH, dSC = v.Q / v.TC, sg = dSH + dSC;
      return {
        text: `ΔS foco caliente = ${f(dSH, 5)} kJ/K\nΔS foco frío = ${f(dSC, 5)} kJ/K\nS_gen = ${f(sg, 5)} kJ/K  ${sg < 1e-12 ? '(reversible)' : '(irreversible, > 0)'}`,
        plot: barras([{ l: 'caliente', v: dSH * 1000, dec: 2 }, { l: 'frío', v: dSC * 1000, dec: 2 }, { l: 'total', v: sg * 1000, dec: 2, c: 'var(--key-line)' }], 'ΔS (J/K)')
      };
    }
  };

  // Brayton aire frío (cp constante)
  function brayton(rp, T1, T3) {
    const e = (K - 1) / K;
    const T2 = T1 * Math.pow(rp, e), T4 = T3 * Math.pow(rp, -e);
    const wc = CP * (T2 - T1), wt = CP * (T3 - T4), wn = wt - wc, qin = CP * (T3 - T2);
    return { T2, T4, wc, wt, wn, qin, eta: wn / qin, bwr: wc / wt };
  }

  SIMS['brayton'] = {
    title: 'Ciclo Brayton ideal (aire frío)',
    desc: 'Turbina de gas con aire como gas ideal y c_p constante. Sube la relación de compresión y mira el rendimiento.',
    controls: [
      { id: 'rp', label: 'Relación de compresión r_p', unit: '', min: 2, max: 20, step: 0.5, value: 8, dec: 1 },
      { id: 'T1', label: 'T de entrada al compresor', unit: 'K', min: 250, max: 350, step: 1, value: 300, dec: 0 },
      { id: 'T3', label: 'T a la entrada de la turbina', unit: 'K', min: 700, max: 1600, step: 10, value: 1200, dec: 0 }
    ],
    run(v) {
      const b = brayton(v.rp, v.T1, v.T3);
      const s = (T, P) => CP * Math.log(T / v.T1) - R * Math.log(P);
      const s1 = 0, s3 = s(v.T3, v.rp), s4 = s(b.T4, 1);
      const xs = rango(0, Math.max(s3, s4) + 0.0001, 0.02);
      return {
        text: `T₂ = ${f(b.T2, 1)} K    T₄ = ${f(b.T4, 1)} K\nw_comp = ${f(b.wc, 1)} kJ/kg   w_turb = ${f(b.wt, 1)} kJ/kg\n` +
          `w_neto = ${f(b.wn, 1)} kJ/kg   q_entrada = ${f(b.qin, 1)} kJ/kg\nη_térmico = ${f(b.eta * 100, 1)} %   (η = 1 − r_p^(−(k−1)/k))\nrelación de trabajos = ${f(b.bwr, 2)}`,
        plot: plot({ xmin: 0, xmax: Math.max(s3, s4) + 0.2, ymin: v.T1 * 0.9, ymax: v.T3 * 1.05, xl: 's − s₁ (kJ/(kg·K))', yl: 'T (K)', xd: 2, yd: 0,
          series: [
            { xs: rango(0, s4, s4 / 60 || 0.01), ys: rango(0, s4, s4 / 60 || 0.01).map((x) => v.T1 * Math.exp(x / CP)) , c: 'var(--muted)', dash: true },
            { xs: rango(0, s3, s3 / 60 || 0.01), ys: rango(0, s3, s3 / 60 || 0.01).map((x) => v.T1 * Math.exp((x + R * Math.log(v.rp)) / CP)), c: 'var(--acc)' }
          ],
          pts: [{ x: s1, y: v.T1, l: '1' }, { x: s1, y: b.T2, l: '2' }, { x: s3, y: v.T3, l: '3' }, { x: s4, y: b.T4, l: '4' }] })
      };
    }
  };

  SIMS['otto-diesel'] = {
    title: 'Motores Otto y Diesel: rendimiento con la relación de compresión',
    desc: 'Aire frío, k = 1,4. Otto depende de r; Diesel depende de r y del corte r_c (aporte de calor a presión constante).',
    controls: [
      { id: 'r', label: 'Relación de compresión r', unit: '', min: 4, max: 20, step: 0.5, value: 8, dec: 1 },
      { id: 'rc', label: 'Relación de corte r_c (Diesel)', unit: '', min: 1.1, max: 4, step: 0.05, value: 2, dec: 2 }
    ],
    run(v) {
      const eO = 1 - Math.pow(v.r, 1 - K);
      const eD = 1 - (Math.pow(v.r, 1 - K) * (Math.pow(v.rc, K) - 1)) / (K * (v.rc - 1));
      const xs = rango(4, 20, 0.5);
      return {
        text: `η_Otto = 1 − r^(1−k) = ${f(eO * 100, 1)} %\nη_Diesel = ${f(eD * 100, 1)} %  (r_c = ${f(v.rc, 2)})\nA igual r, el Diesel rinde menos que el Otto si r_c > 1.`,
        plot: plot({ xmin: 4, xmax: 20, ymin: 0, ymax: 0.75, xl: 'r', yl: 'η', xd: 0, yd: 2,
          series: [{ xs, ys: xs.map((r) => 1 - Math.pow(r, 1 - K)) }, { xs, ys: xs.map((r) => 1 - (Math.pow(r, 1 - K) * (Math.pow(v.rc, K) - 1)) / (K * (v.rc - 1))), c: 'var(--key-line)', dash: true }],
          pts: [{ x: v.r, y: eO, l: 'Otto' }] })
      };
    }
  };

  SIMS['refrigeracion-cop'] = {
    title: 'Refrigeración: COP ideal y real',
    desc: 'Compara el COP de Carnot con el de una máquina real que alcanza una fracción η_2 del de Carnot.',
    controls: [
      { id: 'TF', label: 'T del espacio frío', unit: '°C', min: -30, max: 10, step: 1, value: -10, dec: 0 },
      { id: 'TC', label: 'T del ambiente (condensación)', unit: '°C', min: 20, max: 50, step: 1, value: 35, dec: 0 },
      { id: 'eta', label: 'Fracción del COP de Carnot', unit: '', min: 0.3, max: 0.8, step: 0.01, value: 0.5, dec: 2 }
    ],
    run(v) {
      const TF = v.TF + 273.15, TC = v.TC + 273.15;
      const cc = TF / (TC - TF), cr = v.eta * cc;
      return {
        text: `COP_Carnot = T_F/(T_C − T_F) = ${f(cc, 2)}\nCOP real ≈ ${f(v.eta, 2)} × COP_Carnot = ${f(cr, 2)}\nPor cada kW de compresor se extraen ${f(cr, 2)} kW del espacio frío.`,
        plot: barras([{ l: 'Carnot', v: cc, dec: 2 }, { l: 'real', v: cr, dec: 2, c: 'var(--key-line)' }], 'COP')
      };
    }
  };

  SIMS['psicrometria'] = {
    title: 'Aire húmedo: humedad absoluta y punto de rocío',
    desc: 'Con T de bulbo seco y humedad relativa, calcula ω, T de rocío, T de bulbo húmedo y entalpía (P = 101,325 kPa).',
    controls: [
      { id: 'T', label: 'Temperatura de bulbo seco', unit: '°C', min: 0, max: 45, step: 0.5, value: 25, dec: 1 },
      { id: 'HR', label: 'Humedad relativa', unit: '%', min: 5, max: 100, step: 1, value: 50, dec: 0 }
    ],
    run(v) {
      const P = 101.325;
      const ps = pg(v.T);
      const pv = (v.HR / 100) * ps;
      const w = (0.622 * pv) / (P - pv);
      const wsat = (T) => (0.622 * pg(T)) / (P - pg(T));
      const Tdp = tdp(pv);
      // Tbh por bisección: ecuación del saturador adiabático
      let lo = -5, hi = v.T;
      for (let i = 0; i < 60; i++) {
        const m = (lo + hi) / 2;
        const ws = wsat(m);
        const wc = ((2501 - 2.326 * m) * ws - 1.006 * (v.T - m)) / (2501 + 1.86 * v.T - 4.186 * m);
        if (wc < w) lo = m; else hi = m;
      }
      const Tbh = (lo + hi) / 2;
      const h = hAire(v.T, w);
      const xs = rango(0, 45, 1);
      return {
        text: `p_v = ${f(pv, 3)} kPa    p_g(T) = ${f(ps, 3)} kPa\nω = ${f(w, 5)} kg v/kg a.s.\nT de rocío = ${f(Tdp, 1)} °C\nT de bulbo húmedo ≈ ${f(Tbh, 1)} °C\nh = ${f(h, 1)} kJ/kg a.s.`,
        plot: plot({ xmin: 0, xmax: 45, ymin: 0, ymax: 0.03, xl: 'T bulbo seco (°C)', yl: 'ω (kg/kg)', xd: 0, yd: 3,
          series: [{ xs, ys: xs.map(wsat), c: 'var(--muted)' }, { xs, ys: xs.map((T) => (0.622 * (v.HR / 100) * pg(T)) / (P - (v.HR / 100) * pg(T))) }],
          pts: [{ x: v.T, y: w, l: 'estado' }] })
      };
    }
  };

  SIMS['combustion-ch4'] = {
    title: 'Combustión de metano con exceso de aire',
    desc: 'CH₄ + (1+e)·2(O₂ + 3,76 N₂) → CO₂ + 2 H₂O + 2e O₂ + 7,52(1+e) N₂. Mira la composición de los productos y el punto de rocío a 1 atm.',
    controls: [
      { id: 'e', label: 'Exceso de aire e', unit: '%', min: 0, max: 150, step: 1, value: 50, dec: 0 }
    ],
    run(v) {
      const e = v.e / 100;
      const aire = 2 * (1 + e) * 4.76;
      const O2ex = 2 * e, N2 = 7.52 * (1 + e);
      const prod = 1 + 2 + O2ex + N2;
      const yH2O = 2 / prod;
      const pv = yH2O * 101.325;
      const AF = (aire * 28.97) / MCH4;
      const ch = (val, nom) => ({ l: nom, v: val, dec: 2 });
      return {
        text: `Aire = ${f(aire / 1, 2)} mol/mol CH₄   (A/F = ${f(AF, 2)} kg/kg)\n` +
          `Productos: CO₂ = 1; H₂O = 2; O₂ = ${f(O2ex, 2)}; N₂ = ${f(N2, 2)} (total ${f(prod, 2)} mol)\n` +
          `y_H₂O = ${f(yH2O, 4)}   p_v = ${f(pv, 2)} kPa   T de rocío = ${f(tdp(pv), 1)} °C`,
        plot: barras([ch(1, 'CO₂'), ch(2, 'H₂O'), ch(O2ex, 'O₂'), ch(N2, 'N₂')], 'moles por mol de CH₄')
      };
    }
  };

  SIMS['mezcla-gases'] = {
    title: 'Mezcla de gases ideales: entropía de mezcla',
    desc: 'ΔS_mezcla = −R_u Σ n_i ln y_i. Si los dos gases son el mismo, el término es 0 (no hay mezcla que contar).',
    controls: [
      { id: 'n1', label: 'Moles de gas A', unit: 'kmol', min: 0.1, max: 5, step: 0.1, value: 1, dec: 1 },
      { id: 'n2', label: 'Moles de gas B', unit: 'kmol', min: 0.1, max: 5, step: 0.1, value: 3, dec: 1 },
      { id: 'mismo', label: '¿Mismo gas? (0 = no, 1 = sí)', unit: '', min: 0, max: 1, step: 1, value: 0, dec: 0 }
    ],
    run(v) {
      const N = v.n1 + v.n2;
      const y1 = v.n1 / N, y2 = v.n2 / N;
      const dS = v.mismo ? 0 : -RU * (v.n1 * Math.log(y1) + v.n2 * Math.log(y2));
      return {
        text: `y_A = ${f(y1, 3)}   y_B = ${f(y2, 3)}\nΔS_mezcla = ${f(dS, 2)} kJ/K  (total ${f(N, 1)} kmol)`,
        plot: barras([{ l: 'A', v: y1, dec: 3 }, { l: 'B', v: y2, dec: 3, c: 'var(--key-line)' }], 'fracción molar')
      };
    }
  };

  /* ---------- prácticas: misma lógica, con código y salida tipo consola ---------- */
  const CODIGO_AGUA = `# Práctica I1 (versión Python): estado del agua con una tabla reducida
import math
T_tab = [0.01, 20, 50, 100, 150, 200, 250, 300]        # °C
P_tab = [0.6113, 2.339, 12.35, 101.33, 476.2, 1554.9, 3973, 8587.9]  # kPa
def p_sat(T):
    # interpolación lineal en ln(p): aprox. ±1 % dentro del rango
    for i in range(len(T_tab) - 1):
        if T_tab[i] <= T <= T_tab[i + 1]:
            t = (T - T_tab[i]) / (T_tab[i + 1] - T_tab[i])
            return math.exp(math.log(P_tab[i]) * (1 - t) + math.log(P_tab[i + 1]) * t)
    raise ValueError("T fuera de la tabla")
def region(T, P):
    ps = p_sat(T)
    if P < ps: return "vapor sobrecalentado"
    if P > ps: return "líquido comprimido"
    return "mezcla saturada"
T, P = 150.0, 500.0
print(f"p_sat({T:g} °C) = {p_sat(T):.1f} kPa")
print(f"Región a {P:g} kPa: {region(T, P)}")`;

  SIMS['agua-consola'] = {
    title: 'Práctica I1 · Estado del agua (con salida tipo consola)',
    desc: 'Equivalente en navegador de la práctica I1. Cambia T y P y compara la salida con el código.',
    code: CODIGO_AGUA,
    controls: [
      { id: 'T', label: 'T', unit: '°C', min: 0, max: 300, step: 1, value: 150, dec: 0 },
      { id: 'P', label: 'P', unit: 'kPa', min: 10, max: 9000, step: 10, value: 500, dec: 0 }
    ],
    run(v) {
      const ps = psat(v.T);
      const reg = Math.abs(v.P - ps) / ps < 0.005 ? 'mezcla saturada' : v.P < ps ? 'vapor sobrecalentado' : 'líquido comprimido';
      const consola = `p_sat(${f(v.T, 0)} °C) = ${f(ps, 1)} kPa\nRegión a ${f(v.P, 0)} kPa: ${reg}`;
      return { text: 'Salida tipo consola:', plot: plot({ xmin: 0, xmax: 300, ymin: 0, ymax: 9000, xl: 'T (°C)', yl: 'p_sat (kPa)', yd: 0,
        series: [{ xs: rango(0, 300, 5), ys: rango(0, 300, 5).map(psat) }], pts: [{ x: v.T, y: ps, l: 'p_sat' }] }), consola };
    }
  };

  SIMS['ciclo-consola'] = {
    title: 'Práctica I2 · Análisis de un ciclo Brayton (con salida tipo consola)',
    desc: 'Equivalente en navegador de la práctica I2: calcula el ciclo y compara la gráfica y la salida con el código.',
    code: `# Práctica I2 (versión Python): ciclo Brayton de aire frío
import math
cp, k = 1.005, 1.4
R = 0.287
def brayton(rp, T1, T3):
    e = (k - 1) / k
    T2 = T1 * rp**e
    T4 = T3 * rp**(-e)
    wc = cp * (T2 - T1)
    wt = cp * (T3 - T4)
    qin = cp * (T3 - T2)
    return dict(T2=T2, T4=T4, wc=wc, wt=wt, wn=wt - wc, eta=(wt - wc) / qin)
r = brayton(8, 300, 1200)
for clave in ("T2", "T4", "wc", "wt", "wn", "eta"):
    print(f"{clave:4s} = {r[clave]:.4g}")`,
    controls: [
      { id: 'rp', label: 'r_p', unit: '', min: 2, max: 20, step: 0.5, value: 8, dec: 1 },
      { id: 'T1', label: 'T1', unit: 'K', min: 250, max: 350, step: 1, value: 300, dec: 0 },
      { id: 'T3', label: 'T3', unit: 'K', min: 700, max: 1600, step: 10, value: 1200, dec: 0 }
    ],
    run(v) {
      const b = brayton(v.rp, v.T1, v.T3);
      const consola = Object.entries({ T2: b.T2, T4: b.T4, wc: b.wc, wt: b.wt, wn: b.wn, eta: b.eta })
        .map(([k2, val]) => `${k2.padEnd(4)} = ${(+val.toPrecision(4)).toString().replace('.', ',')}`).join('\n');
      return { text: 'Salida tipo consola (mismos resultados que la gráfica):', consola,
        plot: barras([{ l: 'w_comp', v: b.wc, dec: 1 }, { l: 'w_turb', v: b.wt, dec: 1 }, { l: 'w_neto', v: b.wn, dec: 1, c: 'var(--key-line)' }], 'kJ/kg') };
    }
  };

  window.SIMS = SIMS;

  /* ---------- montaje en la página ---------- */
  function ctrlHTML(c) {
    return `<label>${c.label}${c.unit ? ' (' + c.unit + ')' : ''} <output data-o="${c.id}"></output>` +
      `<input type="range" data-c="${c.id}" min="${c.min}" max="${c.max}" step="${c.step}" value="${c.value}" aria-label="${c.label}"></label>`;
  }

  function renderSim(el, id) {
    const S = SIMS[id];
    if (!S) { el.textContent = 'Simulador no encontrado: ' + id; return; }
    const v = {};
    S.controls.forEach((c) => (v[c.id] = c.value));
    el.innerHTML = `<p class="sdesc">${S.desc || ''}</p>` +
      `<div class="ctrl">${S.controls.map(ctrlHTML).join('')}</div>` +
      `<div class="readout" aria-live="polite"></div><div class="splot"></div>` +
      (S.code ? `<div class="kick">Código equivalente (Python)</div><pre class="code"><code></code></pre>` +
        `<div class="kick">Salida tipo consola</div><div class="consola"></div>` : '');
    const upd = () => {
      S.controls.forEach((c) => {
        const inp = el.querySelector(`[data-c="${c.id}"]`);
        v[c.id] = parseFloat(inp.value);
        el.querySelector(`[data-o="${c.id}"]`).textContent = `${f(v[c.id], c.dec || 0)}${c.unit ? ' ' + c.unit : ''}`;
      });
      const r = S.run(v);
      el.querySelector('.readout').textContent = r.text || '';
      el.querySelector('.splot').innerHTML = r.plot || '';
      if (S.code) {
        el.querySelector('pre code').textContent = S.code;
        el.querySelector('.consola').textContent = r.consola || '';
      }
    };
    el.addEventListener('input', upd);
    upd();
  }
  window.renderSim = renderSim;
  window.SIMS_FMT = f;
})();
