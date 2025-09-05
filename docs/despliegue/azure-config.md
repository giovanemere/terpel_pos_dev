# Configuración Azure

## Recursos Azure del Proyecto

El ecosistema Terpel POS utiliza múltiples servicios de Azure para hosting, datos, mensajería y monitoreo.

## Resource Groups

### Estructura por Ambiente
```
terpel-pos-dev-rg          # Desarrollo
terpel-pos-qa-rg           # QA/Testing  
terpel-pos-staging-rg      # Staging/Pre-prod
terpel-pos-prod-rg         # Producción
```

## App Services

### Configuración por Microservicio
| Servicio | SKU | Instancias | Auto-scale |
|----------|-----|------------|------------|
| **ms-pos-sincronizacion-jornadas** | B2 | 1-3 | ✅ CPU > 70% |
| **ms-pos-sincronizacion-sales** | B2 | 2-5 | ✅ CPU > 70% |
| **ms-pos-sincronizacion-anulaciones** | B1 | 1-2 | ✅ CPU > 80% |
| **ms-ho-frontal-node-ventas** | B2 | 2-4 | ✅ CPU > 70% |
| **ms-ho-frontal-node-cierres** | B2 | 1-3 | ✅ CPU > 70% |

### App Settings Comunes
```bash
# Runtime
WEBSITE_NODE_DEFAULT_VERSION=18.17.1
SCM_DO_BUILD_DURING_DEPLOYMENT=true
WEBSITE_RUN_FROM_PACKAGE=1

# Monitoring
APPINSIGHTS_INSTRUMENTATIONKEY={key}
APPLICATIONINSIGHTS_CONNECTION_STRING={connection}

# Health Check
WEBSITE_HEALTHCHECK_MAXPINGFAILURES=3
```

## Azure Database for PostgreSQL

### Configuración por Ambiente

#### Desarrollo
```yaml
Server: terpel-pos-dev-postgres.postgres.database.azure.com
Tier: Burstable
SKU: B1ms (1 vCore, 2GB RAM)
Storage: 32GB
Backup Retention: 7 días
```

#### Producción
```yaml
Server: terpel-pos-prod-postgres.postgres.database.azure.com
Tier: General Purpose
SKU: GP_Gen5_4 (4 vCores, 20GB RAM)
Storage: 512GB SSD
Backup Retention: 35 días
High Availability: Zone Redundant
```

### Connection Strings
```bash
# Formato
postgresql://{username}:{password}@{server}:5432/{database}?sslmode=require

# Variables por ambiente
DB_CONNECTION_STRING_DEV=postgresql://admin:***@terpel-pos-dev-postgres.postgres.database.azure.com:5432/terpel_pos_dev?sslmode=require
DB_CONNECTION_STRING_PROD=postgresql://admin:***@terpel-pos-prod-postgres.postgres.database.azure.com:5432/terpel_pos_prod?sslmode=require
```

## Azure Service Bus

### Configuración de Namespace
```yaml
Namespace: terpel-pos-servicebus
Tier: Standard
Location: East US 2
```

### Colas y Topics
| Nombre | Tipo | Max Size | TTL | Dead Letter |
|--------|------|----------|-----|-------------|
| **sales-sync** | Queue | 1GB | 14 días | ✅ |
| **jornadas-sync** | Queue | 1GB | 14 días | ✅ |
| **anulaciones-sync** | Queue | 1GB | 14 días | ✅ |
| **pos-events** | Topic | 5GB | 14 días | ✅ |

### Connection Strings
```bash
SERVICE_BUS_CONNECTION_STRING=Endpoint=sb://terpel-pos-servicebus.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=***
```

## Azure Cache for Redis

### Configuración
```yaml
Name: terpel-pos-redis
Tier: Basic
Size: C1 (1GB)
Location: East US 2
Port: 6380 (SSL)
```

### Connection String
```bash
REDIS_CONNECTION_STRING=terpel-pos-redis.redis.cache.windows.net:6380,password=***,ssl=True,abortConnect=False
```

## Application Insights

### Configuración por Ambiente
| Ambiente | Application | Sampling Rate | Retention |
|----------|-------------|---------------|-----------|
| **DEV** | terpel-pos-dev-insights | 100% | 30 días |
| **QA** | terpel-pos-qa-insights | 100% | 90 días |
| **PROD** | terpel-pos-prod-insights | 10% | 730 días |

### Instrumentación
```javascript
// applicationinsights.js
const appInsights = require('applicationinsights');

appInsights.setup(process.env.APPLICATIONINSIGHTS_CONNECTION_STRING)
  .setAutoDependencyCorrelation(true)
  .setAutoCollectRequests(true)
  .setAutoCollectPerformance(true)
  .setAutoCollectExceptions(true)
  .setAutoCollectDependencies(true)
  .setAutoCollectConsole(true)
  .setUseDiskRetryCaching(true)
  .start();
```

## Azure Key Vault

### Configuración
```yaml
Name: terpel-pos-keyvault
Tier: Standard
Location: East US 2
Access Policies: App Services + DevOps Service Principal
```

### Secrets Almacenados
| Secret Name | Descripción | Rotación |
|-------------|-------------|----------|
| **db-admin-password** | Password admin PostgreSQL | 90 días |
| **service-bus-connection** | Connection string Service Bus | Manual |
| **redis-password** | Password Redis | 90 días |
| **ho-api-key** | API Key Head Office | 180 días |
| **jwt-secret** | Secret para JWT tokens | 30 días |

### Acceso desde App Services
```bash
# App Setting
@Microsoft.KeyVault(SecretUri=https://terpel-pos-keyvault.vault.azure.net/secrets/db-admin-password/)
```

## Azure Container Registry

### Configuración
```yaml
Name: terpelposacr
SKU: Basic
Location: East US 2
Admin User: Enabled
```

### Repositorios
```
terpelposacr.azurecr.io/ms-pos-sincronizacion-jornadas:latest
terpelposacr.azurecr.io/ms-pos-sincronizacion-sales:latest
terpelposacr.azurecr.io/ms-pos-sincronizacion-anulaciones:latest
terpelposacr.azurecr.io/ms-ho-frontal-node-ventas:latest
```

## Azure DevOps

### Service Connections
| Nombre | Tipo | Scope | Uso |
|--------|------|-------|-----|
| **Azure-DEV** | Azure Resource Manager | terpel-pos-dev-rg | Deploy DEV |
| **Azure-QA** | Azure Resource Manager | terpel-pos-qa-rg | Deploy QA |
| **Azure-PROD** | Azure Resource Manager | terpel-pos-prod-rg | Deploy PROD |
| **TerpelACR** | Docker Registry | Container Registry | Push images |

### Variable Groups
```yaml
# terpel-pos-dev
variables:
  - DB_HOST: terpel-pos-dev-postgres.postgres.database.azure.com
  - REDIS_HOST: terpel-pos-dev-redis.redis.cache.windows.net
  - SERVICE_BUS_NAMESPACE: terpel-pos-dev-servicebus

# terpel-pos-prod  
variables:
  - DB_HOST: terpel-pos-prod-postgres.postgres.database.azure.com
  - REDIS_HOST: terpel-pos-prod-redis.redis.cache.windows.net
  - SERVICE_BUS_NAMESPACE: terpel-pos-prod-servicebus
```

## Networking y Seguridad

### Virtual Network
```yaml
Name: terpel-pos-vnet
Address Space: 10.0.0.0/16
Subnets:
  - app-subnet: 10.0.1.0/24 (App Services)
  - data-subnet: 10.0.2.0/24 (Databases)
  - integration-subnet: 10.0.3.0/24 (Service Bus, Redis)
```

### Network Security Groups
| NSG | Reglas | Aplicado a |
|-----|--------|------------|
| **app-nsg** | HTTP/HTTPS inbound, All outbound | app-subnet |
| **data-nsg** | PostgreSQL (5432) from app-subnet | data-subnet |
| **integration-nsg** | Service Bus, Redis from app-subnet | integration-subnet |

### Private Endpoints
- PostgreSQL: Acceso solo desde VNet
- Redis: Acceso solo desde VNet  
- Service Bus: Acceso solo desde VNet
- Key Vault: Acceso solo desde VNet + DevOps

## Monitoreo y Alertas

### Azure Monitor Alerts
| Alert | Metric | Threshold | Action |
|-------|--------|-----------|--------|
| **High CPU** | CPU Percentage | > 80% for 5 min | Email + Slack |
| **High Memory** | Memory Percentage | > 85% for 5 min | Email + Slack |
| **Response Time** | Response Time | > 2s for 3 min | Email + Slack |
| **Error Rate** | HTTP 5xx | > 5% for 2 min | Email + Slack + PagerDuty |
| **Database DTU** | DTU Percentage | > 80% for 5 min | Email + Auto-scale |

### Log Analytics Workspace
```yaml
Name: terpel-pos-logs
Retention: 30 días (DEV), 90 días (PROD)
Daily Cap: 1GB (DEV), 10GB (PROD)
```

## Backup y Disaster Recovery

### Backup Strategy
| Recurso | Frecuencia | Retención | Tipo |
|---------|------------|-----------|------|
| **PostgreSQL** | Diario | 35 días | Automated |
| **App Services** | Semanal | 30 días | Manual |
| **Key Vault** | Continuo | Soft-delete 90 días | Automated |

### Disaster Recovery
- **RTO**: 4 horas
- **RPO**: 1 hora
- **Secondary Region**: West US 2
- **Failover**: Manual con runbook automatizado

## Costos y Optimización

### Estimación Mensual (USD)
| Servicio | DEV | QA | PROD | Total |
|----------|-----|----|----- |-------|
| **App Services** | $150 | $200 | $800 | $1,150 |
| **PostgreSQL** | $50 | $100 | $400 | $550 |
| **Service Bus** | $10 | $15 | $50 | $75 |
| **Redis** | $20 | $30 | $100 | $150 |
| **Application Insights** | $25 | $50 | $200 | $275 |
| **Storage** | $10 | $15 | $50 | $75 |
| **Total** | $265 | $410 | $1,600 | $2,275 |

### Optimizaciones
- Auto-shutdown para ambientes DEV/QA
- Reserved Instances para PROD
- Cleanup automático de logs antiguos
- Monitoring de unused resources

---

*Configuración actualizada: Enero 2024*
