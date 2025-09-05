# ETL Ventas

## Descripción

Proceso ETL (Extract, Transform, Load) encargado de extraer datos de ventas desde las bases de datos POS locales, transformarlos según las reglas de negocio y cargarlos en el Data Warehouse para análisis y reportería.

## Información Técnica

| Atributo | Valor |
|----------|-------|
| **Nombre del Proyecto** | ap31tpt-terpelpos-transicion-ms-ho-etl-ventas |
| **Tecnología** | Node.js + TypeScript |
| **Scheduler** | Cron Jobs |
| **Base de Datos Origen** | PostgreSQL POS |
| **Base de Datos Destino** | Data Warehouse |

## Funcionalidades Principales

### 1. Extracción (Extract)
- Conexión a múltiples bases POS
- Extracción incremental de ventas
- Manejo de conexiones distribuidas
- Control de errores de conectividad

### 2. Transformación (Transform)
- Normalización de datos
- Cálculo de métricas agregadas
- Validación de integridad
- Enriquecimiento con datos maestros

### 3. Carga (Load)
- Inserción en Data Warehouse
- Manejo de duplicados
- Actualización de índices
- Notificación de completitud

## Configuración del Proceso

### Frecuencia de Ejecución
- **Tiempo Real**: Cada 5 minutos para datos críticos
- **Batch Diario**: 02:00 AM para consolidación
- **Batch Semanal**: Domingos para análisis histórico

### Variables de Entorno
```bash
# Fuentes de datos
POS_DB_CONNECTIONS=postgres://pos1,postgres://pos2
DW_CONNECTION=postgres://datawarehouse

# Configuración ETL
BATCH_SIZE=1000
PARALLEL_JOBS=4
RETRY_ATTEMPTS=3
```

## Flujo de Procesamiento

```mermaid
graph LR
    A[POS DBs] --> B[Extract]
    B --> C[Transform]
    C --> D[Validate]
    D --> E[Load DW]
    E --> F[Update Indexes]
    F --> G[Notify Complete]
```

## Instalación y Ejecución

```bash
yarn install
yarn build
yarn start:scheduler
yarn test
```

## Monitoreo

### Métricas Clave
- Registros procesados por minuto
- Tiempo de procesamiento promedio
- Tasa de errores
- Latencia de datos

### Alertas
- Fallos en extracción
- Datos inconsistentes
- Retrasos en procesamiento
- Errores de conectividad
