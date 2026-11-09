// Convierte fórmulas TeX a HTML con KaTeX en tiempo de construcción (sin JS en el navegador).
const fs = require('fs');
const katex = require('/opt/npm-tools/node_modules/katex');
const [entrada, salida] = process.argv.slice(2);
const items = JSON.parse(fs.readFileSync(entrada, 'utf8'));
const out = items.map(([tex, bloque]) => {
  try {
    return katex.renderToString(tex, { displayMode: bloque, throwOnError: false, strict: 'ignore', output: 'html' });
  } catch (e) {
    return '<span class="katex-error">' + tex.replace(/</g, '&lt;') + '</span>';
  }
});
fs.writeFileSync(salida, JSON.stringify(out));
console.log('KaTeX: ' + out.length + ' fórmulas');
