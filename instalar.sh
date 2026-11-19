#!/bin/sh
# Instala ForgeLauncher (suite Z-FORGE) para tu usuario, sin pedir contraseña de administrador.
#   curl -fsSL https://raw.githubusercontent.com/znoowmk/zforge-releases/main/instalar.sh | sh
# Descarga la última versión, revisa su huella (SHA-256) y la pone en ~/.local con su ícono en el
# menú. Desde ForgeLauncher se instalan y actualizan las demás apps.
set -eu
REPO=znoowmk/zforge-releases
API="https://api.github.com/repos/$REPO/releases?per_page=100"
say() { printf '%s\n' "$*"; }
need() { command -v "$1" >/dev/null 2>&1 || { say "Falta el programa «$1». Instálalo y vuelve a intentar."; exit 1; }; }
need curl; need tar; need sha256sum

case "$(uname -m)" in
  x86_64|amd64) ;;
  *) say "Por ahora ForgeLauncher se publica para computadoras de 64 bits (x86_64)."; exit 1 ;;
esac

say "Buscando la última versión de ForgeLauncher…"
tag=$(curl -fsSL "$API" | grep -o '"tag_name": *"forgelauncher-v[0-9][^"]*"' | head -1 | sed 's/.*"\(forgelauncher-v[^"]*\)"/\1/')
[ -n "$tag" ] || { say "No se pudo consultar GitHub. Revisa tu conexión."; exit 1; }
ver=${tag#forgelauncher-v}
file="forgelauncher-$ver-linux-x86_64.tar.gz"
base="https://github.com/$REPO/releases/download/$tag"

tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
say "Descargando ForgeLauncher $ver…"
curl -fL --progress-bar -o "$tmp/$file" "$base/$file"
curl -fsSL -o "$tmp/SHA256SUMS.txt" "$base/SHA256SUMS.txt"
# La huella: el archivo descargado debe ser idéntico al publicado.
(cd "$tmp" && grep " $file\$" SHA256SUMS.txt | sha256sum -c --status) || { say "La descarga no coincide con la publicada; no se instaló nada. Vuelve a intentar."; exit 1; }

tar -xzf "$tmp/$file" -C "$tmp"
src="$tmp/forgelauncher-$ver-linux-x86_64"
mkdir -p "$HOME/.local/bin" "$HOME/.local/share/applications" "$HOME/.local/share/icons/hicolor/256x256/apps"
cp "$src/bin/forgelauncher" "$HOME/.local/bin/forgelauncher.new" && mv "$HOME/.local/bin/forgelauncher.new" "$HOME/.local/bin/forgelauncher"
chmod +x "$HOME/.local/bin/forgelauncher"
[ -f "$src/share/icons/hicolor/256x256/apps/forgelauncher.png" ] && cp "$src/share/icons/hicolor/256x256/apps/forgelauncher.png" "$HOME/.local/share/icons/hicolor/256x256/apps/"
cat > "$HOME/.local/share/applications/forgelauncher.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=ForgeLauncher
Comment=Instala y actualiza la suite Z-FORGE
Exec=$HOME/.local/bin/forgelauncher
Icon=forgelauncher
Categories=Office;
StartupWMClass=forgelauncher
EOF
command -v update-desktop-database >/dev/null 2>&1 && update-desktop-database "$HOME/.local/share/applications" >/dev/null 2>&1 || true

say ""
say "Listo: ForgeLauncher $ver ya está en el menú de aplicaciones."
say "Ábrelo desde ahí (o escribe «forgelauncher») y elige las apps que quieras."
