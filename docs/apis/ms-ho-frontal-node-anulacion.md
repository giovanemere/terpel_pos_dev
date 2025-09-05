# API Frontal Node Anulación

## Descripción

API REST para la gestión de anulaciones de transacciones en el sistema POS. Proporciona endpoints para solicitar, validar y procesar anulaciones de ventas.

## Información Técnica

| Atributo | Valor |
|----------|-------|
| **Nombre del Proyecto** | ap31tpt-terpelpos-transicion-ms-ho-frontal-node-anulacion |
| **Tecnología** | Node.js + NestJS |
| **Base de Datos** | PostgreSQL |
| **Puerto** | 4003 (configurable) |

## Endpoints Principales

### Gestión de Anulaciones

#### POST /anulaciones/solicitar
Solicita anulación de una transacción.

**Request:**
```json
{
  "transactionId": "TXN-2024-001",
  "motivo": "ERROR_OPERADOR",
  "operadorId": "OP001",
  "supervisorId": "SUP001",
  "observaciones": "Error en cantidad de producto"
}
```

#### GET /anulaciones/{anulacionId}
Consulta detalles de una anulación.

#### PUT /anulaciones/{anulacionId}/aprobar
Aprueba una anulación pendiente.

#### GET /anulaciones/pendientes
Lista anulaciones pendientes de aprobación.

### Validaciones

#### POST /anulaciones/validar
Valida si una transacción puede ser anulada.

#### GET /anulaciones/motivos
Lista motivos válidos para anulación.

## Reglas de Negocio

### Validaciones de Anulación
- Transacción debe existir y estar activa
- Tiempo límite para anulación (24 horas)
- Autorización por supervisor requerida
- Motivo válido obligatorio

### Estados de Anulación
- `SOLICITADA`: Anulación solicitada
- `PENDIENTE_APROBACION`: Esperando supervisor
- `APROBADA`: Aprobada por supervisor
- `PROCESADA`: Procesada en sistema
- `RECHAZADA`: Rechazada por supervisor

## Configuración

### Variables de Entorno
```bash
DB_HOST=localhost
DB_NAME=terpel_pos_anulaciones
ANULACION_TIME_LIMIT=24
REQUIRE_SUPERVISOR=true
SYNC_ANULACIONES_API=http://localhost:3002
```

## Instalación y Ejecución

```bash
yarn install
yarn start:dev
yarn test
```
