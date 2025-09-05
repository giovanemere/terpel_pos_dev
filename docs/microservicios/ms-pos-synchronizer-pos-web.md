# MS POS Synchronizer POS Web

## Descripción

Microservicio encargado de la sincronización bidireccional entre los sistemas POS locales y las aplicaciones web. Facilita la comunicación en tiempo real y la consistencia de datos entre ambos entornos.

## Información Técnica

| Atributo | Valor |
|----------|-------|
| **Nombre del Proyecto** | ap31tpt-terpelpos-transicion-ms-pos-synchronizer-pos-web |
| **Tecnología** | Node.js + Express |
| **Base de Datos** | PostgreSQL |
| **Puerto** | 3006 (configurable) |

## Funcionalidades Principales

### 1. Sincronización Bidireccional
- Envío de datos POS a Web
- Recepción de configuraciones desde Web
- Resolución de conflictos de datos
- Mantenimiento de consistencia

### 2. Comunicación en Tiempo Real
- WebSocket connections
- Server-Sent Events
- Push notifications
- Estado de conectividad

## Endpoints API

### POST /sync/pos-to-web
Sincroniza datos desde POS hacia Web.

### POST /sync/web-to-pos
Sincroniza configuraciones desde Web hacia POS.

### GET /sync/status
Obtiene estado de sincronización.

## Configuración

### Variables de Entorno
```bash
DB_HOST=localhost
DB_NAME=terpel_pos_sync
WEB_API_URL=https://web.terpel.com/api
POS_API_URL=http://localhost:8080/api
WEBSOCKET_PORT=3007
```

## Instalación y Ejecución

```bash
yarn install
yarn start:dev
yarn test
```
