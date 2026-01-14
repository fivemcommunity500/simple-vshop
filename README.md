🏎️ simple-vshop | Neon Dealership Experience

A high-performance, professional, and neon-styled vehicle dealership for **FiveM (ESX)**. Designed to provide a cinematic car-buying experience with a modern NUI and high performance.

---

🚀 Features | Características

- 🖥️ Neon Aesthetic: High-visibility UI with glow effects, displaying real-time vehicle stats (Speed, Acceleration, Braking).
- 🎥 Cinematic Orbit Camera: Smooth 360° camera rotation around the vehicle while browsing.
- 🏎️ Test Drive System: Fully configurable timed test drives at custom locations.
- 📍 **Smart Delivery: After purchase, players are automatically spawned inside their new vehicle at the exit point.
- ⚙️ **Optimized Logic: Running at **0.00ms** on idle. Built-in traffic and NPC clearing for the area.
- 🛠️ **Modern Config:* Clean structure using `vector3` coordinates and independent headings.

---

 ⌨️ Controls | Controles

| Key / Tecla | Action | Acción |
| :--- | :--- | :--- |
| **E** | Open Dealership | Abrir el Concesionario |
| **MOUSE** | UI Navigation | Navegación por la interfaz |
| **ESC** | Close Menu | Cerrar el menú y volver al mundo |

---

### 🛠️ Installation | Instalación

1. Download the repository / Descarga el repositorio.
2. Rename the folder to `simple-vshop`.
3. Database: Ensure you have the standard `vehicles` and `vehicle_categories` tables.
4. **Configuration: Open `config.lua` and set your `MarkerPos`, `ShopInside`, and `ShopOutside` coordinates using the new 3-coordinate format.
5. Add `ensure simple-vshop` to your `server.cfg`.

---

 📂 Structure | Estructura

- client/main.lua: Cinematic camera, showroom logic, and spawning.
- server/main.lua: SQL database sync and purchase validation.
- config.lua: 3-Vector coords & Dealer settings.
- html/: Neon NUI (HTML/CSS/JS).

---

### 📜 License & Terms | Licencia y Términos

English:
- 🚫 Do not re-upload: This script is licensed. Share the link to this official repository.
- 🔐 Personal Use: Free to use and edit for your own server.

Español:
- 🚫 No resubir: Este script está registrado. Comparte siempre el link a este repositorio oficial.
- 🔐 Uso Personal: Eres libre de usarlo y editarlo para tu propio servidor.

---

📢 Discord: https://discord.gg/2W9PMsYWTZ
