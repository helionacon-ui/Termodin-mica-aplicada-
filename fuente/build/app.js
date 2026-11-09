/* Comportamiento de la guía: tema, búsqueda, casillas, tests, tarjetas, filtros de exámenes y simuladores. */
(function () {
  'use strict';
  const $ = (s, r = document) => r.querySelector(s);
  const $$ = (s, r = document) => Array.from(r.querySelectorAll(s));
  const store = {
    get(k) { try { return window.localStorage.getItem(k); } catch (e) { return null; } },
    set(k, v) { try { window.localStorage.setItem(k, v); } catch (e) { /* almacenamiento no disponible */ } }
  };
  const norm = (s) => s.normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase();

  /* ----- tema claro/oscuro ----- */
  function aplicarTema(t) {
    if (t === 'light' || t === 'dark') document.documentElement.setAttribute('data-theme', t);
    else document.documentElement.removeAttribute('data-theme');
  }
  const temaGuardado = store.get('guia-tema');
  if (temaGuardado) aplicarTema(temaGuardado);
  const btnTema = $('#tema');
  if (btnTema) btnTema.addEventListener('click', () => {
    const actual = document.documentElement.getAttribute('data-theme');
    const oscuro = actual ? actual === 'dark' : window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
    const nuevo = oscuro ? 'light' : 'dark';
    aplicarTema(nuevo);
    store.set('guia-tema', nuevo);
  });

  /* ----- índice de búsqueda ----- */
  let indice = null;
  function cargarIndice() {
    const el = document.getElementById('sindex');
    if (el) { indice = JSON.parse(el.textContent); return Promise.resolve(indice); }
    const url = document.body.getAttribute('data-index');
    if (!url) return Promise.resolve([]);
    return fetch(url).then((r) => r.json()).then((j) => (indice = j)).catch(() => (indice = []));
  }
  const paginaActual = document.body.getAttribute('data-page');
  function buscar(q) {
    const palabras = norm(q).split(/\s+/).filter(Boolean);
    if (!indice || !palabras.length) return [];
    const res = [];
    for (const e of indice) {
      const txt = norm((e.t || '') + ' ' + (e.x || ''));
      if (palabras.every((p) => txt.indexOf(p) >= 0)) {
        const i = txt.indexOf(palabras[0]);
        const ini = Math.max(0, i - 60);
        res.push({ e, fragmento: (ini > 0 ? '…' : '') + (e.x || '').slice(ini, ini + 150) });
        if (res.length >= 12) break;
      }
    }
    return res;
  }
  function abrirDestino(e) {
    const id = e.id;
    const destino = document.getElementById(id);
    if (destino) {
      let p = destino.parentElement;
      while (p) { if (p.tagName === 'DETAILS') p.open = true; p = p.parentElement; }
      destino.scrollIntoView({ behavior: 'smooth', block: 'start' });
      destino.classList.add('resaltado');
      setTimeout(() => destino.classList.remove('resaltado'), 1800);
      history.replaceState(null, '', '#' + id);
      return;
    }
    if (e.u) window.location.href = e.u;
  }
  const busq = $('#gsearch');
  const cajaRes = $('.sres');
  if (busq && cajaRes) {
    cargarIndice();
    busq.addEventListener('input', () => {
      const r = buscar(busq.value);
      if (!busq.value.trim()) { cajaRes.hidden = true; cajaRes.innerHTML = ''; return; }
      cajaRes.hidden = false;
      cajaRes.innerHTML = r.length
        ? r.map((x, i) => `<button type="button" role="option" data-i="${i}"><b></b><small></small></button>`).join('')
        : '<p class="nores">Sin resultados.</p>';
      $$('button[data-i]', cajaRes).forEach((b, i) => {
        b.querySelector('b').textContent = r[i].e.t || 'Resultado';
        b.querySelector('small').textContent = (r[i].e.b ? r[i].e.b + ' · ' : '') + r[i].fragmento;
        b.addEventListener('click', () => {
          cajaRes.hidden = true;
          abrirDestino(r[i].e);
        });
      });
    });
    document.addEventListener('click', (ev) => {
      if (!ev.target.closest('.srch-card')) cajaRes.hidden = true;
    });
    busq.addEventListener('keydown', (ev) => { if (ev.key === 'Escape') { cajaRes.hidden = true; busq.blur(); } });
  }

  /* ----- casillas de seguimiento (localStorage) ----- */
  const chkClave = 'guia-chk';
  let marcas = {};
  try { marcas = JSON.parse(store.get(chkClave) || '{}') || {}; } catch (e) { marcas = {}; }
  function actualizarCasillas() {
    $$('.checks').forEach((grupo) => {
      const cajas = $$('input[type=checkbox]', grupo);
      const n = cajas.filter((c) => c.checked).length;
      let pie = grupo.nextElementSibling;
      if (!pie || !pie.classList.contains('fcount')) {
        pie = document.createElement('p'); pie.className = 'fcount'; grupo.after(pie);
      }
      pie.textContent = `${n} de ${cajas.length} objetivos marcados`;
    });
  }
  $$('input[data-chk]').forEach((c) => {
    c.checked = !!marcas[c.getAttribute('data-chk')];
    c.addEventListener('change', () => {
      marcas[c.getAttribute('data-chk')] = c.checked;
      store.set(chkClave, JSON.stringify(marcas));
      actualizarCasillas();
    });
  });
  actualizarCasillas();

  /* ----- tarjetas de repaso ----- */
  $$('.card-flip').forEach((b) => {
    b.addEventListener('click', () => {
      const on = b.classList.toggle('flipped');
      b.setAttribute('aria-pressed', on ? 'true' : 'false');
    });
  });

  /* ----- autoevaluación ----- */
  $$('[data-test]').forEach((t) => {
    t.addEventListener('change', (ev) => {
      const inp = ev.target;
      if (!inp.matches('input[type=radio]')) return;
      const ok = inp.getAttribute('data-ok') === '1';
      const res = $('.res', t);
      res.innerHTML = ok ? '<span class="ok">Correcta.</span>' : '<span class="ko">No es la correcta.</span>';
      const ex = $('.expl', t);
      ex.hidden = false;
      $$('input[type=radio]', t).forEach((r) => { r.disabled = true; });
      $$('label', t).forEach((l) => {
        const r = $('input', l);
        if (r.getAttribute('data-ok') === '1') l.style.fontWeight = '700';
      });
    });
  });

  /* ----- filtros de exámenes ----- */
  const filtros = $('[data-filtros]');
  if (filtros) {
    const seccion = filtros.closest('section') || document;
    const ejercicios = $$('article.ejer', seccion);
    const texto = $('#ftexto', filtros);
    let fEx = '', fTags = new Set();
    const chipsEx = $$('[data-fx]', filtros);
    const chipsTg = $$('[data-ft]', filtros);
    const conteo = $('.fcount', filtros);
    function aplicar() {
      let visibles = 0;
      const q = texto ? norm(texto.value).trim() : '';
      ejercicios.forEach((art) => {
        const exOk = !fEx || art.getAttribute('data-exam') === fEx;
        const tags = (art.getAttribute('data-tags') || '').split(',').map((t) => t.trim());
        const tgOk = !fTags.size || tags.some((t) => fTags.has(slugTag(t)));
        const txtOk = !q || norm(art.textContent).indexOf(q) >= 0;
        const ok = exOk && tgOk && txtOk;
        art.classList.toggle('hidden-by-search', !ok);
        if (ok) visibles++;
      });
      $$('details.grupo', seccion).forEach((g) => {
        const hay = $$('article.ejer', g).some((a) => !a.classList.contains('hidden-by-search'));
        g.classList.toggle('hidden-by-search', !hay);
        if (hay && (q || fEx || fTags.size)) g.open = true;
      });
      if (conteo) conteo.textContent = `${visibles} de ${ejercicios.length} ejercicios visibles`;
    }
    function slugTag(s) {
      return norm(s).normalize('NFKD').replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
    }
    chipsEx.forEach((c) => c.addEventListener('click', () => {
      fEx = c.getAttribute('data-fx');
      chipsEx.forEach((x) => x.setAttribute('aria-pressed', x === c ? 'true' : 'false'));
      aplicar();
    }));
    chipsTg.forEach((c) => c.addEventListener('click', () => {
      const k = c.getAttribute('data-ft');
      if (fTags.has(k)) fTags.delete(k); else fTags.add(k);
      c.setAttribute('aria-pressed', fTags.has(k) ? 'true' : 'false');
      aplicar();
    }));
    if (texto) texto.addEventListener('input', aplicar);
    aplicar();
  }

  /* ----- simuladores ----- */
  $$('[data-sim]').forEach((el) => { if (window.renderSim) window.renderSim(el, el.getAttribute('data-sim')); });
  $$('[data-open-sim]').forEach((b) => b.addEventListener('click', () => {
    const el = document.querySelector(`[data-sim="${b.getAttribute('data-open-sim')}"]`);
    if (!el) return;
    let p = el.parentElement;
    while (p) { if (p.tagName === 'DETAILS') p.open = true; p = p.parentElement; }
    el.scrollIntoView({ behavior: 'smooth', block: 'center' });
    const r = el.querySelector('input[type=range]');
    if (r) setTimeout(() => r.focus({ preventScroll: true }), 400);
  }));

  /* ----- botón de volver arriba ----- */
  const arriba = $('#totop');
  if (arriba) {
    const mostrar = () => arriba.classList.toggle('show', window.scrollY > 600);
    window.addEventListener('scroll', mostrar, { passive: true });
    mostrar();
  }

  /* ----- PWA: service worker (solo en sitio servido por http/https) ----- */
  if ('serviceWorker' in navigator && /^https?:/.test(window.location.protocol)) {
    try { navigator.serviceWorker.register('sw.js').catch(() => {}); } catch (e) { /* sin SW */ }
  }
})();
