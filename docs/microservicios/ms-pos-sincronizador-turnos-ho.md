# MS POS Sincronizador Turnos HO

## Descripción

Microservicio responsable de la sincronización de turnos de trabajo entre las estaciones POS locales y el sistema Head Office. Coordina horarios, asignaciones de personal y control de turnos.

## Información Técnica

| Atributo | Valor |
|----------|-------|
| **Nombre del Proyecto** | ap31tpt-terpelpos-transicion-ms-pos-sincronizador-turnos-ho |
| **Tecnología** | Node.js + NestJS |
| **Versión Node** | 18.17.1 |
| **Base de Datos** | PostgreSQL |
| **Puerto** | 3003 (configurable) |

## Funcionalidades Principales

### 1. Gestión de Turnos
- Sincronización de horarios de trabajo
- Asignación de operadores a turnos
- Control de solapamientos
- Validación de disponibilidad

### 2. Coordinación con Head Office
- Envío de cambios de turno
- Recepción de actualizaciones HO
- Resolución de conflictos
- Notificaciones automáticas

## Endpoints API

### POST /turnos/sincronizar
Sincroniza turnos con Head Office.

### GET /turnos/activos
Obtiene turnos activos por estación.

### PUT /turnos/{turnoId}/actualizar
Actualiza información de un turno.

## Configuración

### Variables de Entorno
```bash
DB_HOST=localhost
DB_NAME=terpel_pos_turnos
HO_TURNOS_API=https://api.headoffice.terpel.com/turnos
SYNC_INTERVAL=300000
```

## Instalación y Ejecución

```bash
yarn install
yarn start:dev
yarn test
```
