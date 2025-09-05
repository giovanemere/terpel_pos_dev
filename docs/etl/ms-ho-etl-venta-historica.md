# ETL Venta Histórica

## Descripción

Proceso ETL especializado en el procesamiento de datos históricos de ventas desde el sistema Head Office hacia el Data Warehouse. Maneja grandes volúmenes de datos históricos para análisis y reportería.

## Información Técnica

| Atributo | Valor |
|----------|-------|
| **Nombre del Proyecto** | ap31tpt-terpelpos-transicion-ms-ho-etl-venta-historica |
| **Tecnología** | Node.js + TypeScript |
| **Scheduler** | Azure Functions + Timer |
| **Base de Datos Origen** | Head Office DB |
| **Base de Datos Destino** | Data Warehouse |

## Funcionalidades Principales

### 1. Extracción Histórica
- Conexión a base de datos Head Office
- Extracción por rangos de fechas
- Manejo de datos legacy
- Validación de integridad histórica

### 2. Transformación de Datos
- Normalización de formatos históricos
- Conversión de monedas
- Agregación por períodos
- Limpieza de datos inconsistentes

### 3. Carga Optimizada
- Bulk insert para grandes volúmenes
- Particionado por fechas
- Indexación automática
- Compresión de datos antiguos

## Configuración del Proceso

### Frecuencia de Ejecución
- **Inicial**: Carga completa histórica (una vez)
- **Incremental**: Semanal para datos recientes
- **Reconciliación**: Mensual para validación

### Variables de Entorno
```bash
# Head Office
HO_DB_CONNECTION=postgres://ho-server/ho_database
HO_BATCH_SIZE=5000

# Data Warehouse
DW_CONNECTION=postgres://dw-server/warehouse
DW_PARTITION_SIZE=1000000

# Procesamiento
PARALLEL_WORKERS=8
MEMORY_LIMIT=4GB
TEMP_STORAGE=/tmp/etl
```

## Flujo de Procesamiento

```mermaid
graph LR
    A[Head Office DB] --> B[Extract Historical]
    B --> C[Transform Legacy]
    C --> D[Validate Data]
    D --> E[Partition by Date]
    E --> F[Bulk Load DW]
    F --> G[Update Indexes]
    G --> H[Archive Processed]
```

## Instalación y Ejecución

```bash
yarn install
yarn build
yarn start:historical-load
yarn test
```

## Monitoreo

### Métricas Clave
- Registros históricos procesados
- Tiempo de procesamiento por lote
- Errores de transformación
- Uso de memoria y storage

### Alertas
- Fallos en extracción histórica
- Inconsistencias en datos
- Límites de memoria excedidos
- Errores de particionado
