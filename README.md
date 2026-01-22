# 🏎️ Simple VShop | Neon Dealership Experience

![GitHub License](https://img.shields.io/badge/license-Personal_Use-blueviolet)
![Platform](https://img.shields.io/badge/framework-ESX-blue)
![Optimized](https://img.shields.io/badge/optimized-0.00ms-brightgreen)

Un concesionario de vehículos de alto rendimiento, profesional y con estilo neón para **FiveM (ESX)**. Diseñado para ofrecer una experiencia de compra cinematográfica con una NUI moderna y optimización extrema.

<p align="center">
  <img src="https://github.com/user-attachments/assets/2e7cf9da-309f-4764-9a79-ba62a06dcdfa" alt="SIMPLEHUD" width="1000">
</p>

---

## ✨ Features | Características

* 🖥️ **Neon Aesthetic:** Interfaz de alta visibilidad con efectos de brillo y estadísticas en tiempo real (Velocidad, Aceleración, Frenado).
* 🎥 **Cinematic Orbit Camera:** Rotación suave de cámara 360° alrededor del vehículo mientras navegas por el catálogo.
* 🏎️ **Test Drive System:** Sistema de prueba de conducción temporizado totalmente configurable en ubicaciones personalizadas.
* 📍 **Smart Delivery:** Tras la compra, el jugador aparece automáticamente dentro de su nuevo vehículo en el punto de salida.
* ⚙️ **Optimized Logic:** Consumo de **0.00ms** en reposo. Sistema integrado de limpieza de tráfico y NPCs en la zona.
* 🛠️ **Modern Config:** Estructura limpia utilizando coordenadas `vector3` y headings independientes.

---

## ⌨️ Controls | Controles

| Key / Tecla | Action | Acción |
| :--- | :--- | :--- |
| **E** | Open Dealership | Abrir el Concesionario |
| **MOUSE** | UI Navigation | Navegación por la interfaz |
| **ESC** | Close Menu | Cerrar el menú y volver al mundo |

---

## 🛠️ Installation | Instalación

1. **Download:** Descarga el repositorio y descomprímelo.
2. **Rename:** Cambia el nombre de la carpeta a `simple-vshop`.
3. **Database:** Asegúrate de tener las tablas estándar `vehicles` y `vehicle_categories`.
4. **Configure:** Abre `config.lua` y ajusta `MarkerPos`, `ShopInside`, y `ShopOutside`.
5. **Start:** Añade `ensure simple-vshop` a tu archivo `server.cfg`.

---

## 📂 Structure | Estructura

| File / Folder | Description | Descripción |
| :--- | :--- | :--- |
| `client/main.lua` | Cinematic camera & showroom logic | Cámara cinematográfica y lógica de exposición |
| `server/main.lua` | SQL sync & purchase validation | Sincronización SQL y validación de compra |
| `config.lua` | 3-Vector coords & Dealer settings | Coordenadas Vector3 y ajustes generales |
| `html/` | Neon NUI (HTML/CSS/JS) | Interfaz NUI y diseño visual |

---

## 📜 License & Terms | Licencia y Términos

| Condition | English | Español |
| :--- | :--- | :--- |
| 🚫 **Re-upload** | Do not re-upload: This script is licensed. | No resubir: Script bajo licencia y registrado. |
| 🔗 **Share** | Share the link to this official repository. | Comparte siempre el link a este repositorio. |
| 🔐 **Personal Use** | Free to use and edit for your own server. | Libre de usar y editar para tu servidor. |

---

## 📢 Support | Soporte

¿Buscas actualizaciones o nuevos scripts? ¡Únete a nuestra comunidad!

[![Discord Shield](https://img.shields.io/badge/Discord-Join%20Us-7289da?style=for-the-badge&logo=discord)](https://discord.gg/2W9PMsYWTZ)
