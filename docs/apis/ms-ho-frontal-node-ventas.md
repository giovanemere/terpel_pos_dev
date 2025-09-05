# API Frontal Node Ventas

## Descripción

API REST desarrollada en Node.js que proporciona endpoints para consultas y operaciones relacionadas con ventas. Sirve como interfaz principal entre las aplicaciones frontend y los datos de ventas del sistema POS.

## Información Técnica

| Atributo | Valor |
|----------|-------|
| **Nombre del Proyecto** | ap31tpt-terpelpos-transicion-ms-ho-frontal-node-ventas |
| **Tecnología** | Node.js + NestJS |
| **Versión Node** | 18.12.1 |
| **Base de Datos** | PostgreSQL |
| **Puerto** | 4001 (configurable) |

## Endpoints Principales

### Consultas de Ventas

#### GET /ventas/resumen
Obtiene resumen de ventas por período.

**Query Parameters:**
- `fechaInicio`: Fecha inicio (YYYY-MM-DD)
- `fechaFin`: Fecha fin (YYYY-MM-DD)
- `estacionId`: ID de estación (opcional)

**Response:**
```json
{
  "totalVentas": 1500000,
  "cantidadTransacciones": 125,
  "ventaPromedio": 12000,
  "periodo": {
    "inicio": "2024-01-15",
    "fin": "2024-01-15"
  }
}
```

#### GET /ventas/detalle/{transactionId}
Obtiene detalle de una venta específica.

#### GET /ventas/por-producto
Obtiene ventas agrupadas por producto.

#### GET /ventas/por-operador
Obtiene ventas agrupadas por operador.

### Operaciones de Venta

#### POST /ventas/registrar
Registra una nueva venta.

#### PUT /ventas/{transactionId}/actualizar
Actualiza información de una venta.

## Configuración

### Variables de Entorno
```bash
# Base de datos
DB_HOST=localhost
DB_PORT=5432
DB_NAME=terpel_pos_ventas
DB_USER=ventas_user
DB_PASSWORD=ventas_password

# API Configuration
PORT=4001
API_VERSION=v1
CORS_ORIGINS=http://localhost:3000,http://localhost:3575

# Cache
REDIS_URL=redis://localhost:6379
CACHE_TTL=300
```

## Instalación y Ejecución

```bash
# Instalar dependencias
yarn install

# Desarrollo
yarn start:dev

# Producción
yarn build
yarn start:prod

# Tests
yarn test
yarn test:e2e
```

## Autenticación y Seguridad

### JWT Authentication
- Tokens JWT para autenticación
- Refresh tokens para renovación
- Rate limiting por endpoint

### Validación de Datos
- Validación de esquemas con Joi
- Sanitización de inputs
- Validación de permisos por rol

## Performance y Caching

### Estrategias de Cache
- Cache de consultas frecuentes (Redis)
- Cache de resultados agregados
- Invalidación automática

### Optimizaciones
- Paginación en consultas grandes
- Índices optimizados en BD
- Connection pooling

## Monitoreo

### Health Checks
- `/health`: Estado general de la API
- `/health/db`: Conectividad base de datos
- `/health/cache`: Estado del cache

### Métricas
- Requests por segundo
- Tiempo de respuesta promedio
- Tasa de errores
- Uso de cache
