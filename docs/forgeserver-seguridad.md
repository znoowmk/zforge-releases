# Seguridad de ForgeServer

- **Contraseñas** con Argon2id (mínimo 10 caracteres). Nunca se guardan ni se muestran.
- **Sesiones y enlaces** se guardan solo como huella SHA-256: una copia de la base de datos
  no permite entrar ni descargar.
- **Intentos de acceso:** 8 fallos en 15 minutos bloquean la dirección y el usuario. Si una
  cuenta no existe tarda lo mismo que una contraseña mala, para que no se puedan adivinar nombres.
- **Cada persona en su carpeta:** toda ruta pasa por una revisión que rechaza `..`, rutas
  absolutas y enlaces simbólicos que salgan de la carpeta (web y WebDAV).
- **Archivos subidos** se descargan siempre como adjunto, con `sandbox` y `nosniff`: un HTML o
  SVG subido no puede ejecutarse dentro del sitio.
- **Ataques desde otras páginas (CSRF):** cookies `SameSite=Strict` y una cabecera que solo
  las páginas del propio servidor envían.
- **Páginas** con política de contenido estricta (solo scripts propios, no se pueden incrustar
  en otros sitios).
- **HTTPS:** obligatorio fuera de la red local (Caddy o Tailscale lo dan gratis). Con
  `public_url` en `https://` las cookies se marcan `Secure`.
- **systemd** lo limita a escribir solo en su carpeta de datos.

Reporta problemas de seguridad a Znoow directamente, no en público.
