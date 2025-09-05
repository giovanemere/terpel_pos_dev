# MS POS Node Turnos

## Descripción

Microservicio desarrollado en Node.js para la gestión local de turnos de trabajo en las estaciones POS. Maneja la asignación, control y seguimiento de turnos de operadores.

## Información Técnica

| Atributo | Valor |
|----------|-------|
| **Nombre del Proyecto** | ap31tpt-terpelpos-transicion-ms-pos-node-turnos |
| **Tecnología** | Node.js |
| **Base de Datos** | PostgreSQL |
| **Puerto** | 3007 (configurable) |

## Funcionalidades Principales

### 1. Gestión de Turnos
- Creación de turnos de trabajo
- Asignación de operadores
- Control de horarios
- Validación de disponibilidad

### 2. Control de Acceso
- Autenticación de operadores
- Validación de permisos por turno
- Registro de actividades
- Auditoría de cambios

## Endpoints API

### POST /turnos/crear
Crea un nuevo turno de trabajo.

### GET /turnos/activos
Lista turnos activos por estación.

### PUT /turnos/{turnoId}/asignar
Asigna un operador a un turno.

### DELETE /turnos/{turnoId}
Cancela un turno programado.

## Configuración

### Variables de Entorno
```bash
DB_HOST=localhost
DB_NAME=terpel_pos_turnos
AUTH_SECRET=your-secret-key
TURNO_DURATION_HOURS=8
OVERLAP_MINUTES=15
```

## Instalación y Ejecución

```bash
yarn install
yarn start:dev
yarn test
```
