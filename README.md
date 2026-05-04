# GUT — Gestión Usuarios Tesorería

App Flask interna: búsqueda de usuarios por CUIT en `TW_Usuarios`, edición de `Fech_created` / `UPass` / `Email`, generación de credenciales (Word / mailto).

## Run

```bash
cp .env.example .env   # editar valores
docker compose up -d --build
```

<http://localhost:5000>

## Config

Todo se controla por `.env`. Cambiar `GUT_MODO` y reiniciar el contenedor decide si corre dev o prod:

| Var | Valores |
|---|---|
| `GUT_MODO` | `sqlite` (datos seed) \| `sqlserver` |
| `GUT_DB_SERVER` | `host\instancia` (solo prod) |
| `GUT_DB_NAME` | nombre de la base |
| `GUT_DB_USER` | usuario SQL |
| `GUT_DB_PASSWORD` | contraseña SQL |

## Stack

Python 3.12 · Flask · uv · waitress · pyodbc + msodbcsql17 · SQLite (dev)

CUITs de prueba: ver [`LEEME-DEV.md`](./LEEME-DEV.md).

## Estructura

```
.
├── Dockerfile
├── docker-compose.yml
├── .env.example
└── app/
    ├── pyproject.toml
    ├── app.py
    └── templates/index.html
```
