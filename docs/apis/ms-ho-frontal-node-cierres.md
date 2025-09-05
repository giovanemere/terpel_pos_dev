# API Frontal Node Cierres

## Descripción

API REST especializada en la gestión de cierres de turno y jornada. Proporciona endpoints para consultas, procesamiento y validación de cierres en el sistema POS.

## Información Técnica

| Atributo | Valor |
|----------|-------|
| **Nombre del Proyecto** | ap31tpt-terpelpos-transicion-ms-ho-frontal-node-cierres |
| **Tecnología** | Node.js + NestJS |
| **Versión Node** | 18.12.1 |
| **Base de Datos** | PostgreSQL |
| **Puerto** | 4002 (configurable) |

## Endpoints Principales

### Gestión de Cierres

#### POST /cierres/turno
Procesa un cierre de turno.

**Request:**
```json
{
  "turnoId": "TURNO-2024-001",
  "operadorId": "OP001",
  "fechaCierre": "2024-01-15T22:00:00Z",
  "totales": {
    "efectivo": 500000,
    "tarjetas": 300000,
    "total": 800000
  },
  "diferencias": {
    "efectivo": 0,
    "tarjetas": 0
  }
}
```

#### POST /cierres/jornada
Procesa un cierre de jornada completa.

#### GET /cierres/estado/{cierreId}
Consulta estado de un cierre.

#### GET /cierres/resumen
Obtiene resumen de cierres por período.

### Validaciones

#### POST /cierres/validar
Valida datos antes del cierre.

#### GET /cierres/diferencias/{turnoId}
Calcula diferencias en el cierre.

## Configuración

### Variables de Entorno
```bash
# Base de datos
DB_HOST=localhost
DB_PORT=5432
DB_NAME=terpel_pos_cierres
DB_USER=cierres_user
DB_PASSWORD=cierres_password

# API Configuration
PORT=4002
TOLERANCE_AMOUNT=1000
MAX_DIFFERENCE_PERCENT=2

# Integración
MICROCIERRE_API=http://localhost:3005
SYNC_CIERRE_API=http://localhost:3004
```

## Validaciones de Negocio

### Reglas de Cierre
- Diferencias máximas permitidas
- Validación de totales
- Verificación de transacciones pendientes
- Control de horarios de cierre

### Alertas Automáticas
- Diferencias superiores al límite
- Cierres fuera de horario
- Transacciones no cuadradas
- Fallos en sincronización

## Instalación y Ejecución

```bash
yarn install
yarn start:dev
yarn build
yarn start:prod
yarn test
```

## Integración

### Servicios Consumidos
- MS Microcierre Backend
- MS Sync Cierre Turno
- MS Sincronización Jornadas

### Servicios Consumidores
- Frontend Microcierre
- Dashboard Web
- Reportes de gestión
