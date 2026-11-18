# Instalar ForgeServer

## La forma más rápida: una computadora de la oficina o de tu casa

1. Descarga ForgeServer desde https://github.com/znoowmk/zforge-releases/releases (busca `forgeserver`)
   y descomprímelo.
2. Ábrelo (`bin/forgeserver`). La primera vez crea su configuración y te muestra algo así:

   ```
   ForgeServer 0.2.0 está funcionando.
   Ábrelo desde el navegador de cualquier equipo de tu red:
       http://192.168.1.20:8080
   Primera vez: entra a una de esas direcciones y crea la cuenta de administración con este código:
       QE9M-BLU8
   ```
3. Entra a esa dirección desde el navegador, escribe el código y crea tu cuenta de administración.
4. En **Administración** agrega a las demás personas y crea carpetas compartidas (por ejemplo
   «Oficina») con quienes las usarán.
5. Cada persona entra con su usuario desde el navegador o conecta ForgeServer como unidad de red
   (instrucciones en **Mi cuenta y conexión**) para abrir y guardar directo desde sus programas.

Los datos quedan en la carpeta de datos de tu usuario (`~/.local/share/forgeserver` en Linux,
`%LOCALAPPDATA%\ForgeServer` en Windows, `~/Library/Application Support/ForgeServer` en macOS).
Respáldala.

**Qué te protege de errores:** lo que se borra (desde el navegador o la unidad de red) va a la
**Papelera** 30 días, y cada vez que un archivo se reemplaza se guarda la copia anterior (las
últimas 10) en **Versiones anteriores**.

Para que funcione también desde fuera de la oficina, con HTTPS, sigue una de las opciones de abajo.

---

ForgeServer corre en **tu** equipo o en **tu** nube. Elige una opción:

| Opción | Para quién | Dificultad |
|---|---|---|
| [A. Docker con HTTPS automático](#a-docker-con-https-automático-recomendada) | VPS o servidor con dominio propio | Fácil |
| [B. Programa + systemd (Linux)](#b-programa--systemd-linux) | Servidor Linux sin Docker | Media |
| [C. PC de la oficina, solo red local](#c-pc-de-la-oficina-solo-red-local) | Oficina pequeña, sin acceso desde fuera | Fácil |
| [D. Acceso desde fuera sin abrir puertos](#d-acceso-desde-fuera-sin-abrir-puertos-tailscale) | Oficina que quiere entrar desde casa | Fácil |

**Requisitos:** 1 núcleo, 512 MB de RAM y el espacio que ocupen tus archivos. Funciona en
x86-64 y ARM (Raspberry Pi 4/5, Oracle Cloud Ampere).

¿Dónde conseguir un servidor barato? Cualquier VPS con Linux sirve: Oracle Cloud (capa
gratuita ARM), Hetzner, DigitalOcean, Contabo, o una PC vieja en la oficina.

---

## A. Docker con HTTPS automático (recomendada)

Necesitas un dominio (por ejemplo `nube.tuempresa.mx`) apuntando a la IP del servidor
(registro DNS tipo **A**), y los puertos **80** y **443** abiertos.

```bash
# 1. Instala Docker (Debian/Ubuntu)
curl -fsSL https://get.docker.com | sh

# 2. Copia la carpeta apps/forgeserver al servidor y entra a deploy/
cd forgeserver/deploy

# 3. Pon tu dominio en dos archivos
nano Caddyfile            # cambia nube.ejemplo.mx
nano forgeserver.toml     # cambia public_url

# 4. Arranca (la primera vez compila; tarda unos minutos)
docker compose up -d

# 5. Mira el código de primer inicio y entra a https://tu-dominio para crear la administración
docker compose logs forgeserver | grep -A1 "código"
#    (o desde la terminal: docker compose exec -T forgeserver forgeserver user add tunombre --admin)
```

Abre `https://nube.tuempresa.mx`. Caddy obtiene el certificado HTTPS solo y lo renueva.

## B. Programa + systemd (Linux)

```bash
# Compilar (o copiar el binario ya compilado)
cargo build --release                       # dentro de apps/forgeserver
sudo install -m 755 target/release/forgeserver /usr/local/bin/

# Usuario del sistema y carpetas
sudo useradd --system --home /var/lib/forgeserver --create-home forge
sudo mkdir -p /etc/forgeserver
sudo forgeserver init /etc/forgeserver/forgeserver.toml
sudo nano /etc/forgeserver/forgeserver.toml       # data_dir = "/var/lib/forgeserver", public_url

# Primer usuario
echo 'tu-contraseña-larga' | sudo -u forge FORGESERVER_CONFIG=/etc/forgeserver/forgeserver.toml forgeserver user add tunombre --admin

# Servicio
sudo cp deploy/forgeserver.service /etc/systemd/system/
sudo systemctl enable --now forgeserver
```

Para HTTPS pon Caddy delante: instala `caddy` y usa en `/etc/caddy/Caddyfile`:

```
nube.tuempresa.mx {
	reverse_proxy 127.0.0.1:8080
}
```

## C. PC de la oficina, solo red local

Windows, macOS o Linux. Sin dominio ni HTTPS público: solo la red de la oficina.

1. Copia `forgeserver` (o `forgeserver.exe`) a una carpeta, por ejemplo `C:\ForgeServer`.
2. En esa carpeta: `forgeserver init`, y en `forgeserver.toml`:
   - `listen = "0.0.0.0:8080"`
   - `data_dir = "C:/ForgeServer/datos"` (o la ruta que quieras respaldar)
   - `public_url = "http://IP-DE-ESTA-PC:8080"`
3. `forgeserver user add tunombre --admin`
4. `forgeserver serve` (en Windows se puede dejar como servicio con NSSM o el Programador de tareas).
5. Las demás PCs abren `http://IP-DE-ESTA-PC:8080`.

> Sin HTTPS las contraseñas viajan sin cifrar por la red local. Úsalo solo en una red de
> confianza, o usa la opción D.

## D. Acceso desde fuera sin abrir puertos (Tailscale)

Instala [Tailscale](https://tailscale.com) en el servidor y en los equipos que lo usan. El
servidor tendrá una dirección `100.x.y.z` accesible solo para tus equipos. Con
`tailscale serve --bg 8080` además obtienes HTTPS automático en `https://servidor.tu-red.ts.net`.
Pon esa dirección en `public_url`.

---

## Usuarios

```bash
forgeserver user add NOMBRE [--admin] [--quota MB]   # crea (pide contraseña)
forgeserver user passwd NOMBRE                       # cambia contraseña y cierra sus sesiones
forgeserver user quota NOMBRE MB                     # cambia su espacio (0 = sin límite)
forgeserver user del NOMBRE [--keep-files]           # borra (y sus archivos, salvo --keep-files)
forgeserver user list                                # usuarios y espacio usado
```

Con Docker antepón `docker compose exec -T forgeserver`.

## Conectar como unidad (WebDAV)

Dirección: `https://nube.tuempresa.mx/dav/`, con usuario y contraseña.

- **Windows:** Explorador › Este equipo › «Conectar unidad de red» › escribe la dirección.
- **macOS:** Finder › Ir › «Conectarse al servidor…».
- **Linux:** en el gestor de archivos, `davs://nube.tuempresa.mx/dav/`.
- **Android/iOS:** cualquier app con WebDAV (por ejemplo, gestores de archivos con «Red»).

## Versiones web de la suite (opcional)

```bash
cargo install trunk && rustup target add wasm32-unknown-unknown
cd apps/sheetforge/apps/sheetforge-web && trunk build --release
cp -r dist /opt/forgeserver/web/sheetforge
```

y en `forgeserver.toml`:

```toml
[apps]
sheetforge = "/opt/forgeserver/web/sheetforge"
```

Igual para `docforge` y `slideforge`. Aparecen arriba en la página de archivos.

## Respaldos

Todo está en `data_dir`: la base `forgeserver.db` (usuarios, sesiones, enlaces) y la carpeta
`files/` (un subdirectorio por usuario). Respalda esa carpeta completa. Con
[restic](https://restic.net):

```bash
restic -r /ruta/respaldo init
restic -r /ruta/respaldo backup /var/lib/forgeserver
# programarlo a diario: crontab -e
# 30 3 * * * restic -r /ruta/respaldo backup /var/lib/forgeserver --quiet
```

Para restaurar: detén el servicio, restaura la carpeta y vuelve a arrancar.

## Actualizar

- **Docker:** `git pull` (o copia la versión nueva) y `docker compose up -d --build`.
- **systemd:** reemplaza `/usr/local/bin/forgeserver` y `sudo systemctl restart forgeserver`.

Tus datos no se tocan al actualizar.

## Problemas comunes

| Síntoma | Causa |
|---|---|
| «Demasiados intentos» | 8 contraseñas malas en 15 min desde esa dirección o para ese usuario. Espera o reinicia el servicio. |
| Windows no conecta la unidad | Windows exige HTTPS para WebDAV con contraseña. Usa la opción A o D. |
| Subidas grandes fallan | Sube `max_upload_mb` y, con Caddy, `request_body max_size`. |
| La página dice «inicia sesión» al rato | La sesión dura `session_hours` (14 días por defecto). |
