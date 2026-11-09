"""Convierte la guía maestra en un fragmento para Artifact: quita doctype, html, head y body, que la plataforma añade."""
import os, re, sys
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
src = os.path.join(ROOT, 'out', 'termodinamica-aplicada-guia.html')
dst = sys.argv[1]
s = open(src, encoding='utf-8').read()
s = re.sub(r'<!doctype html>\s*', '', s, flags=re.I)
s = re.sub(r'<html[^>]*>\s*', '', s)
s = re.sub(r'</html>\s*', '', s)
s = re.sub(r'<head>\s*', '', s)
s = re.sub(r'\s*</head>', '', s)
s = re.sub(r'<body[^>]*>\s*', '', s)
s = re.sub(r'\s*</body>', '', s)
s = re.sub(r'<meta charset="utf-8">\n?', '', s)
s = re.sub(r'<meta name="viewport"[^>]*>\n?', '', s)
s = re.sub(r'<meta name="color-scheme"[^>]*>\n?', '', s)
s = re.sub(r'<link rel="manifest"[^>]*>\n?', '', s)
s = re.sub(r'<meta name="theme-color"[^>]*>\n?', '', s)
head_title = re.search(r'<title>.*?</title>\n?', s)
if head_title:
    t = head_title.group(0)
    s = s.replace(t, '', 1)
    s = t + s
open(dst, 'w', encoding='utf-8').write(s)
print('bytes', os.path.getsize(dst), 'starts:', s[:80].replace('\n', ' | '))
