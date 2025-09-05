# MS POS Sync Cierre Turno

## Descripción

Microservicio especializado en la sincronización de cierres de turno entre el sistema POS local y Head Office. Procesa y valida todos los datos de cierre de turno antes de enviarlos al sistema central.

## Información Técnica

| Atributo | Valor |
|----------|-------|
| **Nombre del Proyecto** | ap31tpt-terpelpos-transicion-ms-pos-sync-cierre-turno |
| **Tecnología** | Node.js + NestJS |
| **Versión Node** | 18.17.1 |
| **Base de Datos** | PostgreSQL |
| **Puerto** | 3004 (configurable) |

## Funcionalidades Principales

### 1. Procesamiento de Cierres
- Consolidación de datos de turno
- Cálculo de totales y diferencias
- Validación de cuadre de caja
- Generación de reportes de cierre

### 2. Sincronización
- Envío de datos de cierre al HO
- Confirmación de recepción
- Manejo de discrepancias
- Alertas por diferencias

## Endpoints API

### POST /cierre-turno/procesar
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
  }
}
```

### GET /cierre-turno/estado/{turnoId}
Consulta estado de sincronización de cierre.

## Configuración

### Variables de Entorno
```bash
DB_HOST=localhost
DB_NAME=terpel_pos_cierres
HO_CIERRE_API=https://api.headoffice.terpel.com/cierres
TOLERANCE_AMOUNT=1000
```

## Instalación y Ejecución

```bash
yarn install
yarn start:dev
yarn test
```
