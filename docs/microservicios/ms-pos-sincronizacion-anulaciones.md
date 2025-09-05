# MS POS Sincronización Anulaciones

## Descripción

Microservicio encargado de la sincronización de anulaciones de transacciones entre el sistema POS local y el Head Office. Gestiona el procesamiento, validación y envío de todas las anulaciones realizadas en las estaciones de servicio.

## Información Técnica

| Atributo | Valor |
|----------|-------|
| **Nombre del Proyecto** | ap31tpt-terpelpos-transicion-ms-pos-sincronizacion-anulaciones |
| **Tecnología** | Node.js + NestJS |
| **Versión Node** | 18.17.1 |
| **Base de Datos** | PostgreSQL |
| **Puerto** | 3002 (configurable) |

## Funcionalidades Principales

### 1. Procesamiento de Anulaciones
- Recepción de solicitudes de anulación
- Validación de transacciones originales
- Cálculo de reversiones
- Generación de comprobantes

### 2. Sincronización con Head Office
- Envío de anulaciones al HO
- Confirmación de procesamiento
- Manejo de errores y reintentos
- Reconciliación de estados

## Endpoints API

### POST /anulaciones/procesar
Procesa una anulación de transacción.

**Request:**
```json
{
  "transactionId": "TXN-2024-001",
  "anulacionId": "ANU-2024-001",
  "motivo": "ERROR_OPERADOR",
  "operadorId": "OP001",
  "timestamp": "2024-01-15T16:30:00Z"
}
```

### GET /anulaciones/estado/{anulacionId}
Consulta el estado de una anulación.

### POST /anulaciones/sync
Sincroniza anulaciones pendientes con Head Office.

## Configuración

### Variables de Entorno
```bash
DB_HOST=localhost
DB_PORT=5432
DB_NAME=terpel_pos_anulaciones
HO_API_URL=https://api.headoffice.terpel.com/anulaciones
SERVICE_BUS_CONNECTION=your-connection-string
```

## Instalación y Ejecución

```bash
yarn install
yarn start:dev
yarn test
```

## Contacto
- **Equipo**: Terpel POS Development Team
- **Slack**: #terpel-pos-anulaciones
