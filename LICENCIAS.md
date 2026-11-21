# Licencias y avisos de terceros

**Z-FORGE** es una suite de Znoow. © 2026 Znoow.

Varias apps de Z-FORGE incluyen o parten de software de código abierto. Sus licencias (MIT, Apache-2.0,
SIL Open Font License y otras) permiten usarlo, modificarlo y distribuirlo, y piden conservar sus avisos de
copyright y el texto de la licencia. Esos avisos están aquí y, completos, dentro de cada paquete:

- **Linux:** `share/doc/<app>/` dentro del `.tar.gz`
- **Windows:** la carpeta `LICENCIAS` junto al programa (portátil e instalador)

Las versiones de Z-FORGE cambian nombres, diseño, enlaces y funciones. No están afiliadas ni respaldadas por
los autores originales, y sus nombres y logotipos no se usan como marca de Z-FORGE.

## Software en el que se basan algunas apps

| App de Z-FORGE | Incluye código de | Aviso de copyright | Licencia |
|---|---|---|---|
| DocForge | WordCraft | Copyright (c) 2026 ArtCraft Team and the WordCraft contributors | MIT o Apache-2.0 |
| SheetForge | GridCraft | Copyright (c) 2026 ArtCraft Team and the GridCraft contributors | MIT o Apache-2.0 |
| SlideForge | DeckCraft | Copyright (c) 2026 ArtCraft Team and the DeckCraft contributors | MIT o Apache-2.0 |
| PDFForge | PdfCraft | Copyright (c) 2026 ArtCraft Team and the PdfCraft contributors | MIT o Apache-2.0 |
| ForgeLauncher | ArtCraft Launcher | Copyright (c) 2026 ArtCraft Team and the ArtCraft Launcher contributors | MIT o Apache-2.0 |

## Apps creadas por Znoow desde cero

MailForge, ZipForge, GalleryForge, PixelForge, SearchForge, MindForge (la app y el asistente de IA de
DocForge), ForgeServer, ForgeOCR y Macros IA son obra original de Znoow: © 2026 Znoow, todos los
derechos reservados. No parten del código de nadie más.

Como casi todo programa, usan bibliotecas de código abierto (por ejemplo egui para la interfaz y la
fuente Inter). Usarlas no da autoría a sus autores; sus licencias solo piden incluir su aviso y su
texto, y eso va en cada paquete:

- `THIRD-PARTY-LICENSES.txt`: cada biblioteca, su versión, su autor y su licencia completa
- `fonts/Inter-OFL.txt`: la licencia de la fuente Inter

## Componentes compartidos

| Componente | Para qué | Licencia |
|---|---|---|
| craft-libs (Storytold) | Bibliotecas de texto, corrección y formatos | MIT o Apache-2.0 |
| craft-i18n (Storytold) | Diccionarios, patrones de guiones y datos de idioma | Apache-2.0; cada diccionario con la suya (incluidas en el paquete, carpeta `language-data`). Los 75 paquetes de idioma que DocForge descarga están en la release [language-packs-2](https://github.com/znoowmk/zforge-releases/releases/tag/language-packs-2) de este repositorio, cada uno con sus licencias en `LICENCES/` |
| craft-fonts (Storytold) | Fuentes de respaldo para más escrituras | SIL Open Font License 1.1 por fuente (incluidas en el paquete, carpeta `fonts`) |
| egui / eframe | Interfaz gráfica | MIT o Apache-2.0 |
| Inter, JetBrains Mono, Noto y otras fuentes | Tipografía | SIL Open Font License 1.1 |
| Lucide | Iconos | ISC |
| hayro | Lectura y dibujo de PDF | MIT o Apache-2.0 |

Además se usan muchas bibliotecas de Rust (crates) con licencias permisivas (MIT, Apache-2.0, BSD, ISC,
Zlib, Unicode, MPL-2.0). La lista con autor, origen y licencia está dentro de cada paquete: en
`ATTRIBUTION.md` (DocForge, SheetForge, SlideForge, PDFForge, ForgeLauncher) o en
`THIRD-PARTY-LICENSES.txt` (las apps creadas por Znoow).

## Textos de las licencias

- [MIT](https://opensource.org/license/mit)
- [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0)
- [SIL Open Font License 1.1](https://openfontlicense.org)
- [ISC](https://opensource.org/license/isc-license-txt)
