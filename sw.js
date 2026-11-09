// Caché sin conexión de la guía. Versión: 9 nov 2026
const VERSION = 'termo-2026-11-09';
const ARCHIVOS = [
  './',
  'index.html',
  'style.css',
  'katex.css',
  'app.js',
  'sims.js',
  'search-index.json',
  'manifest.json',
  'icon-192.png',
  'icon-512.png',
  'autoevaluacion.html',
  'demos.html',
  'examen.html',
  'examenes.html',
  'formulario.html',
  'glosario.html',
  'plan.html',
  'practicas.html',
  'simulacros.html',
  't01.html',
  't02.html',
  't03.html',
  't04.html',
  't05.html',
  't06.html',
  't07.html',
  't08.html',
  't09.html',
  't10.html',
  't11.html',
  'trucos.html',
  'fonts/KaTeX_AMS-Regular.woff2',
  'fonts/KaTeX_Caligraphic-Bold.woff2',
  'fonts/KaTeX_Caligraphic-Regular.woff2',
  'fonts/KaTeX_Fraktur-Bold.woff2',
  'fonts/KaTeX_Fraktur-Regular.woff2',
  'fonts/KaTeX_Main-Bold.woff2',
  'fonts/KaTeX_Main-BoldItalic.woff2',
  'fonts/KaTeX_Main-Italic.woff2',
  'fonts/KaTeX_Main-Regular.woff2',
  'fonts/KaTeX_Math-BoldItalic.woff2',
  'fonts/KaTeX_Math-Italic.woff2',
  'fonts/KaTeX_SansSerif-Bold.woff2',
  'fonts/KaTeX_SansSerif-Italic.woff2',
  'fonts/KaTeX_SansSerif-Regular.woff2',
  'fonts/KaTeX_Script-Regular.woff2',
  'fonts/KaTeX_Size1-Regular.woff2',
  'fonts/KaTeX_Size2-Regular.woff2',
  'fonts/KaTeX_Size3-Regular.woff2',
  'fonts/KaTeX_Size4-Regular.woff2',
  'fonts/KaTeX_Typewriter-Regular.woff2'
];
self.addEventListener('install', (e) => {
  e.waitUntil(caches.open(VERSION).then((c) => c.addAll(ARCHIVOS)).then(() => self.skipWaiting()));
});
self.addEventListener('activate', (e) => {
  e.waitUntil(caches.keys()
    .then((ks) => Promise.all(ks.filter((k) => k !== VERSION).map((k) => caches.delete(k))))
    .then(() => self.clients.claim()));
});
self.addEventListener('fetch', (e) => {
  if (e.request.method !== 'GET') return;
  e.respondWith(caches.match(e.request).then((hit) => hit || fetch(e.request).then((resp) => {
    if (resp.ok) { const copia = resp.clone(); caches.open(VERSION).then((c) => c.put(e.request, copia)).catch(() => {}); }
    return resp;
  }).catch(() => caches.match('index.html'))));
});
