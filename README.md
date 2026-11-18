<h1 align="center">Z-FORGE</h1>
<p align="center"><b>Tu oficina completa, en tu equipo y en tu propio servidor.</b><br>
Hojas de cálculo, documentos, presentaciones, PDF, correo y más. Sin suscripción, sin nube obligatoria, sin que tus archivos pasen por servidores de nadie más.</p>

<p align="center">
<img src="iconos/sheetforge.png" width="64" alt="SheetForge">
<img src="iconos/docforge.png" width="64" alt="DocForge">
<img src="iconos/slideforge.png" width="64" alt="SlideForge">
<img src="iconos/pdfforge.png" width="64" alt="PDFForge">
<img src="iconos/forgelauncher.png" width="64" alt="ForgeLauncher">
</p>

---

## Empieza aquí

La forma más fácil es **ForgeLauncher**: instala, abre y actualiza todas las apps desde un solo lugar.

1. Descarga [ForgeLauncher para Linux](https://github.com/znoowmk/zforge-releases/releases/download/forgelauncher-v0.19.2/forgelauncher-0.19.2-linux-x86_64.tar.gz).
2. Descomprime y abre `bin/forgelauncher`.
3. Elige las apps que quieras. El launcher las baja de este repositorio, verifica cada descarga y te avisa cuando hay versión nueva.

## Las apps

| | App | Para qué | Descarga (Linux x86-64) |
|---|---|---|---|
| <img src="iconos/sheetforge.png" width="32"> | **SheetForge** | Hojas de cálculo compatibles con Excel (`.xlsx`, `.xlsm`, `.xls`, `.ods`, `.csv`). Fórmulas con los mismos resultados que Excel y Macros IA. | [0.19.1](https://github.com/znoowmk/zforge-releases/releases/download/sheetforge-v0.19.1/sheetforge-0.19.1-linux-x86_64.tar.gz) |
| <img src="iconos/docforge.png" width="32"> | **DocForge** | Procesador de textos compatible con Word (`.docx`, `.odt`). | [0.18.1](https://github.com/znoowmk/zforge-releases/releases/download/docforge-v0.18.1/docforge-0.18.1-linux-x86_64.tar.gz) |
| <img src="iconos/slideforge.png" width="32"> | **SlideForge** | Presentaciones compatibles con PowerPoint (`.pptx`, `.odp`). | [0.18.1](https://github.com/znoowmk/zforge-releases/releases/download/slideforge-v0.18.1/slideforge-0.18.1-linux-x86_64.tar.gz) |
| <img src="iconos/pdfforge.png" width="32"> | **PDFForge** | Ver, anotar, firmar, unir y editar PDF. | [0.21.1](https://github.com/znoowmk/zforge-releases/releases/download/pdfforge-v0.21.1/pdfforge-0.21.1-linux-x86_64.tar.gz) |
| | **MailForge** | Correo de escritorio para tus cuentas IMAP/SMTP. | [0.2.0](https://github.com/znoowmk/zforge-releases/releases/download/mailforge-v0.2.0/mailforge-0.2.0-linux-x86_64.tar.gz) |
| | **MindForge** | Mapas mentales y lluvia de ideas. | [0.2.0](https://github.com/znoowmk/zforge-releases/releases/download/mindforge-v0.2.0/mindforge-0.2.0-linux-x86_64.tar.gz) |
| | **ZipForge** | Comprimir y descomprimir archivos. | [0.2.0](https://github.com/znoowmk/zforge-releases/releases/download/zipforge-v0.2.0/zipforge-0.2.0-linux-x86_64.tar.gz) |
| | **ForgeServer** | Tu propio servidor: archivos, carpetas compartidas, unidad de red y las apps en el navegador. | [0.1.0](https://github.com/znoowmk/zforge-releases/releases/download/forgeserver-v0.1.0/forgeserver-0.1.0-linux-x86_64.tar.gz) |
| <img src="iconos/forgelauncher.png" width="32"> | **ForgeLauncher** | Instala y actualiza toda la suite. | [0.19.2](https://github.com/znoowmk/zforge-releases/releases/download/forgelauncher-v0.19.2/forgelauncher-0.19.2-linux-x86_64.tar.gz) |

Todas las versiones anteriores están en [Releases](https://github.com/znoowmk/zforge-releases/releases). Windows: próximamente aquí mismo.

### Instalar una app a mano (Linux)

```bash
tar xzf sheetforge-0.19.1-linux-x86_64.tar.gz
cd sheetforge-0.19.1-linux-x86_64
./bin/sheetforge
```

Para que aparezca en el menú, copia `share/` a `~/.local/share/` y `bin/` a `~/.local/bin/`. Funciona en cualquier Linux de 2023 en adelante (glibc 2.36 o más nueva).

### Verificar la descarga

Cada versión trae `SHA256SUMS.txt`. Descárgalo junto al paquete y ejecuta:

```bash
sha256sum -c SHA256SUMS.txt
```

Debe decir `OK`. ForgeLauncher hace esta comprobación por ti.

## Tu propio servidor (ForgeServer)

Z-FORGE no te obliga a usar la nube de nadie: **cada quien monta su servidor** en la PC de la oficina, un VPS, una Raspberry Pi o Docker. Un solo programa de 7 MB, sin base de datos externa.

- Archivos de cada persona desde el navegador o como unidad de red (WebDAV) en Windows, macOS y Linux.
- Enlaces para compartir con fecha de caducidad y cuota por persona.
- SheetForge, DocForge y SlideForge en el navegador.

Guías: [Instalar ForgeServer](docs/forgeserver-instalar.md) · [Seguridad](docs/forgeserver-seguridad.md)

## ¿Por qué Z-FORGE y no Office?

| | Z-FORGE | Microsoft 365 |
|---|---|---|
| Precio | Gratis, sin suscripción | Suscripción mensual o anual |
| Dónde están tus archivos | En tu equipo o en tu servidor | En la nube de Microsoft |
| Funciona sin internet | Sí, todo | Parcial |
| Fórmulas de Excel | Mismos resultados (0 diferencias en 239,877 fórmulas de 1,835 archivos reales) | — |
| Macros | Macros IA: describes lo que quieres y se genera, se prueba y se repara sola; traduce VBA | VBA |
| Tamaño y velocidad | Apps nativas en Rust, abren al instante | Instalación de varios GB |
| Servidor propio | ForgeServer, 7 MB | SharePoint / Exchange |

## Reportar un problema

Abre un [issue](https://github.com/znoowmk/zforge-releases/issues) con la app, la versión y, si puedes, el archivo que falla (sin datos privados).

---

© 2026 Znoow · Suite Z-FORGE
