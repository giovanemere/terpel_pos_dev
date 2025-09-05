# Variables de Entorno

## Configuración por Ambiente

Las variables de entorno están organizadas por ambiente y componente para facilitar la gestión y el despliegue.

## Variables Globales

### Configuración de Base de Datos

```bash
# PostgreSQL Principal
DB_HOST=localhost
DB_PORT=5432
DB_NAME=terpel_pos
DB_USER=postgres
DB_PASSWORD=your_password
DB_POOL_SIZE=10
DB_TIMEOUT=30000
DB_SSL_MODE=require

# Connection String Format
DATABASE_URL=postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}?sslmode=${DB_SSL_MODE}
```

### Configuración de Cache

```bash
# Redis
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=your_redis_password
REDIS_DB=0
REDIS_TTL=300
REDIS_CONNECTION_TIMEOUT=5000

# Connection String
REDIS_URL=redis://:${REDIS_PASSWORD}@${REDIS_HOST}:${REDIS_PORT}/${REDIS_DB}
```

### Configuración de Mensajería

```bash
# Azure Service Bus
SERVICE_BUS_CONNECTION_STRING=Endpoint=sb://namespace.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=key
SERVICE_BUS_QUEUE_SALES=sales-sync
SERVICE_BUS_QUEUE_JORNADAS=jornadas-sync
SERVICE_BUS_QUEUE_ANULACIONES=anulaciones-sync
SERVICE_BUS_RETRY_ATTEMPTS=3
SERVICE_BUS_RETRY_DELAY=5000
```

## Variables por Microservicio

### MS Sincronización Jornadas

```bash
# Específicas del servicio
PORT=3000
SERVICE_NAME=ms-pos-sincronizacion-jornadas
LOG_LEVEL=info

# Head Office Integration
HO_JORNADAS_API_URL=https://api.headoffice.terpel.com/jornadas
HO_API_KEY=your_ho_api_key
HO_TIMEOUT=30000

# Business Rules
JORNADA_MAX_DURATION_HOURS=12
JORNADA_OVERLAP_MINUTES=15
VALIDATE_OPERATOR_SCHEDULE=true
```

### MS Sincronización Ventas

```bash
# Específicas del servicio
PORT=3001
SERVICE_NAME=ms-pos-sincronizacion-sales
LOG_LEVEL=info

# Head Office Integration
HO_SALES_API_URL=https://api.headoffice.terpel.com/sales
HO_BATCH_SIZE=100
HO_SYNC_INTERVAL=60000

# Performance
BATCH_PROCESSING_SIZE=500
PARALLEL_WORKERS=4
MEMORY_LIMIT=512MB
```

### MS Microcierre Backend

```bash
# Específicas del servicio
PORT=3005
SERVICE_NAME=ms-pos-microcierrebackend
LOG_LEVEL=info

# Report Generation
REPORT_TEMPLATE_PATH=./templates
REPORT_OUTPUT_PATH=./reports
REPORT_FORMAT=PDF
REPORT_TIMEOUT=30000

# Business Rules
TOLERANCE_AMOUNT=1000
MAX_DIFFERENCE_PERCENT=2
REQUIRE_SUPERVISOR_APPROVAL=true
```

### Frontend Microcierre

```bash
# Electron App
ELECTRON_ENV=production
WINDOW_WIDTH=1200
WINDOW_HEIGHT=800
ENABLE_DEV_TOOLS=false

# API Integration
REACT_APP_API_URL=http://localhost:3005
REACT_APP_API_TIMEOUT=30000
REACT_APP_RETRY_ATTEMPTS=3

# Features
REACT_APP_ENABLE_REPORTS=true
REACT_APP_ENABLE_ANALYTICS=false
REACT_APP_AUTO_REFRESH_INTERVAL=30000
```

## Variables por Ambiente

### Desarrollo (DEV)

```bash
# Environment
NODE_ENV=development
ENVIRONMENT=dev
DEBUG=true
LOG_LEVEL=debug

# Database
DB_HOST=dev-postgres.terpel.com
DB_NAME=terpel_pos_dev
DB_POOL_SIZE=5

# External Services
HO_API_URL=https://dev-api.headoffice.terpel.com
SERVICE_BUS_CONNECTION_STRING=Endpoint=sb://terpel-pos-dev-servicebus.servicebus.windows.net/...

# Performance (Relaxed)
REQUEST_TIMEOUT=60000
BATCH_SIZE=50
PARALLEL_WORKERS=2
```

### QA/Testing

```bash
# Environment
NODE_ENV=test
ENVIRONMENT=qa
DEBUG=false
LOG_LEVEL=info

# Database
DB_HOST=qa-postgres.terpel.com
DB_NAME=terpel_pos_qa
DB_POOL_SIZE=8

# External Services
HO_API_URL=https://qa-api.headoffice.terpel.com
SERVICE_BUS_CONNECTION_STRING=Endpoint=sb://terpel-pos-qa-servicebus.servicebus.windows.net/...

# Testing Specific
ENABLE_TEST_ENDPOINTS=true
MOCK_EXTERNAL_SERVICES=false
TEST_DATA_CLEANUP=true
```

### Staging

```bash
# Environment
NODE_ENV=production
ENVIRONMENT=staging
DEBUG=false
LOG_LEVEL=warn

# Database
DB_HOST=staging-postgres.terpel.com
DB_NAME=terpel_pos_staging
DB_POOL_SIZE=10
DB_SSL_MODE=require

# External Services (Production-like)
HO_API_URL=https://staging-api.headoffice.terpel.com
SERVICE_BUS_CONNECTION_STRING=Endpoint=sb://terpel-pos-staging-servicebus.servicebus.windows.net/...

# Performance (Production-like)
REQUEST_TIMEOUT=30000
BATCH_SIZE=100
PARALLEL_WORKERS=4
```

### Producción

```bash
# Environment
NODE_ENV=production
ENVIRONMENT=production
DEBUG=false
LOG_LEVEL=error

# Database (High Performance)
DB_HOST=prod-postgres.terpel.com
DB_NAME=terpel_pos_prod
DB_POOL_SIZE=20
DB_SSL_MODE=require
DB_CONNECTION_TIMEOUT=5000

# External Services
HO_API_URL=https://api.headoffice.terpel.com
SERVICE_BUS_CONNECTION_STRING=Endpoint=sb://terpel-pos-prod-servicebus.servicebus.windows.net/...

# Performance (Optimized)
REQUEST_TIMEOUT=15000
BATCH_SIZE=200
PARALLEL_WORKERS=8
MEMORY_LIMIT=1GB

# Security
ENABLE_CORS=false
ALLOWED_ORIGINS=https://pos.terpel.com
JWT_EXPIRATION=3600
RATE_LIMIT_REQUESTS=1000
RATE_LIMIT_WINDOW=60000
```

## Variables de Seguridad

### Secrets (Azure Key Vault)

```bash
# Database Passwords
DB_ADMIN_PASSWORD=@Microsoft.KeyVault(SecretUri=https://terpel-pos-kv.vault.azure.net/secrets/db-admin-password/)
DB_APP_PASSWORD=@Microsoft.KeyVault(SecretUri=https://terpel-pos-kv.vault.azure.net/secrets/db-app-password/)

# API Keys
HO_API_KEY=@Microsoft.KeyVault(SecretUri=https://terpel-pos-kv.vault.azure.net/secrets/ho-api-key/)
REDIS_PASSWORD=@Microsoft.KeyVault(SecretUri=https://terpel-pos-kv.vault.azure.net/secrets/redis-password/)

# JWT Secrets
JWT_SECRET=@Microsoft.KeyVault(SecretUri=https://terpel-pos-kv.vault.azure.net/secrets/jwt-secret/)
JWT_REFRESH_SECRET=@Microsoft.KeyVault(SecretUri=https://terpel-pos-kv.vault.azure.net/secrets/jwt-refresh-secret/)

# Service Bus
SERVICE_BUS_CONNECTION_STRING=@Microsoft.KeyVault(SecretUri=https://terpel-pos-kv.vault.azure.net/secrets/service-bus-connection/)
```

### Encryption

```bash
# Data Encryption
ENCRYPTION_KEY=your_encryption_key_32_chars
ENCRYPTION_ALGORITHM=aes-256-gcm
HASH_SALT_ROUNDS=12

# SSL/TLS
SSL_CERT_PATH=/etc/ssl/certs/terpel-pos.crt
SSL_KEY_PATH=/etc/ssl/private/terpel-pos.key
SSL_CA_PATH=/etc/ssl/certs/ca-bundle.crt
```

## Variables de Monitoreo

### Application Insights

```bash
# Azure Application Insights
APPINSIGHTS_INSTRUMENTATIONKEY=your_instrumentation_key
APPLICATIONINSIGHTS_CONNECTION_STRING=InstrumentationKey=key;IngestionEndpoint=https://eastus-8.in.applicationinsights.azure.com/

# Sampling
APPINSIGHTS_SAMPLING_PERCENTAGE=10
APPINSIGHTS_DISABLE_ALL_EXTENDED_METRICS=false
APPINSIGHTS_ENABLE_LIVE_METRICS=true
```

### Logging

```bash
# Log Configuration
LOG_LEVEL=info
LOG_FORMAT=json
LOG_MAX_SIZE=10MB
LOG_MAX_FILES=5
LOG_DATE_PATTERN=YYYY-MM-DD

# Log Destinations
LOG_TO_CONSOLE=true
LOG_TO_FILE=true
LOG_TO_AZURE=true
LOG_FILE_PATH=./logs/app.log
```

## Variables de Performance

### Timeouts y Limits

```bash
# HTTP Timeouts
HTTP_TIMEOUT=30000
HTTP_KEEP_ALIVE_TIMEOUT=5000
HTTP_HEADERS_TIMEOUT=60000

# Database Timeouts
DB_QUERY_TIMEOUT=30000
DB_CONNECTION_TIMEOUT=10000
DB_IDLE_TIMEOUT=300000

# Memory Limits
NODE_OPTIONS=--max-old-space-size=1024
HEAP_SIZE_LIMIT=1GB
```

### Caching

```bash
# Cache TTL (seconds)
CACHE_TTL_SHORT=300      # 5 minutes
CACHE_TTL_MEDIUM=1800    # 30 minutes
CACHE_TTL_LONG=3600      # 1 hour

# Cache Sizes
CACHE_MAX_KEYS=10000
CACHE_MAX_MEMORY=256MB
```

## Gestión de Variables

### Azure DevOps Variable Groups

```yaml
# Variable Group: terpel-pos-common
variables:
  - SERVICE_BUS_RETRY_ATTEMPTS: 3
  - LOG_LEVEL: info
  - BATCH_SIZE: 100

# Variable Group: terpel-pos-dev
variables:
  - DB_HOST: dev-postgres.terpel.com
  - HO_API_URL: https://dev-api.headoffice.terpel.com
  - DEBUG: true

# Variable Group: terpel-pos-prod
variables:
  - DB_HOST: prod-postgres.terpel.com
  - HO_API_URL: https://api.headoffice.terpel.com
  - DEBUG: false
```

### Validación de Variables

```javascript
// config/env.validation.js
const Joi = require('joi');

const envSchema = Joi.object({
  NODE_ENV: Joi.string().valid('development', 'test', 'production').required(),
  PORT: Joi.number().port().default(3000),
  DB_HOST: Joi.string().hostname().required(),
  DB_PORT: Joi.number().port().default(5432),
  DB_NAME: Joi.string().required(),
  LOG_LEVEL: Joi.string().valid('error', 'warn', 'info', 'debug').default('info'),
}).unknown();

const { error, value } = envSchema.validate(process.env);
if (error) {
  throw new Error(`Config validation error: ${error.message}`);
}

module.exports = value;
```

## Best Practices

### Nomenclatura
- Usar UPPER_CASE con underscores
- Prefijos por categoría (DB_, REDIS_, HO_)
- Sufijos descriptivos (_URL, _KEY, _TIMEOUT)

### Seguridad
- Nunca hardcodear secrets en código
- Usar Azure Key Vault para datos sensibles
- Rotar secrets regularmente
- Validar todas las variables al inicio

### Documentación
- Documentar propósito de cada variable
- Incluir valores por defecto
- Especificar formato esperado
- Mantener ejemplos actualizados

---

*Variables documentadas: Enero 2024*
