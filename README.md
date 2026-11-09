# Termodinámica Aplicada · Guía de estudio

Guía de estudio de Termodinámica Aplicada (521102006), Grado en Ingeniería Biomédica, UPCT, curso 2026-27.
Actualizada el 9 de noviembre de 2026.

## Contenido

- **Raíz**: sitio web multipágina (una página por bloque), instalable como aplicación (PWA) y con uso sin conexión.
- **descargas/**: HTML maestro de un solo archivo, guía completa en PDF con marcadores, exámenes resueltos y formulario de una página.
- **scripts/**: scripts de las prácticas I1 (agua) e I2 (ciclos), con su salida.
- **fuente/**: código fuente para regenerar todo (`src/*.dsl`, `build/builder.py`, figuras y herramientas de comprobación).

## Regenerar

```
cd fuente
python3 build/builder.py          # genera out/ (HTML y PDF auxiliares) y site/ (sitio web)
```

Después, copia `fuente/site/` a la raíz del repositorio para publicarlo con GitHub Pages.
El constructor necesita KaTeX (`katex` en npm) para prerenderizar las fórmulas; la ruta está en `KATEX` dentro de `build/builder.py` y debe ajustarse en cada equipo.
