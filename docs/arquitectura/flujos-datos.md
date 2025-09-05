# Flujos de Datos

## Visión General

Los flujos de datos en el ecosistema Terpel POS siguen patrones bien definidos que garantizan la consistencia, trazabilidad y performance del sistema. Los datos fluyen desde los puntos de captura (POS) hasta los sistemas de análisis (Data Warehouse) pasando por múltiples capas de procesamiento.

## Flujos Principales

### 1. Flujo de Transacciones de Venta

```mermaid
sequenceDiagram
    participant POS as Terminal POS
    participant API as API Frontal Ventas
    participant MS as MS Sync Ventas
    participant DB as PostgreSQL Local
    participant HO as Head Office
    participant ETL as ETL Ventas
    participant DW as Data Warehouse

    POS->>API: Registrar venta
    API->>DB: Guardar transacción local
    API->>MS: Notificar nueva venta
    MS->>HO: Sincronizar con HO
    HO-->>MS: Confirmación
    MS->>DB: Actualizar estado sync
    
    Note over ETL: Proceso batch cada 5 min
    ETL->>DB: Extraer ventas nuevas
    ETL->>DW: Cargar en warehouse
    DW-->>ETL: Confirmación carga
```

### 2. Flujo de Microcierre

```mermaid
sequenceDiagram
    participant FE as Frontend Microcierre
    participant API as API Frontal Cierres
    participant MS as MS Microcierre Backend
    participant DB as PostgreSQL
    participant SYNC as MS Sync Cierre
    participant HO as Head Office

    FE->>API: Solicitar microcierre
    API->>MS: Procesar microcierre
    MS->>DB: Consultar ventas período
    MS->>DB: Calcular totales
    MS->>MS: Validar diferencias
    MS->>DB: Guardar microcierre
    MS-->>API: Resultado microcierre
    API-->>FE: Mostrar resultado
    
    MS->>SYNC: Trigger sincronización
    SYNC->>HO: Enviar datos cierre
    HO-->>SYNC: Confirmación
```

### 3. Flujo de Anulaciones

```mermaid
sequenceDiagram
    participant POS as Terminal POS
    participant API as API Frontal Anulación
    participant MS as MS Sync Anulaciones
    participant DB as PostgreSQL
    participant HO as Head Office
    participant CONC as MS Conciliación

    POS->>API: Solicitar anulación
    API->>API: Validar transacción
    API->>DB: Guardar solicitud
    API->>MS: Procesar anulación
    MS->>DB: Actualizar transacción original
    MS->>HO: Notificar anulación
    HO-->>MS: Confirmación
    
    MS->>CONC: Notificar para conciliación
    CONC->>CONC: Ajustar conciliación
```

## Patrones de Flujo de Datos

### 1. Patrón Síncrono (Request-Response)

**Uso**: Operaciones críticas que requieren confirmación inmediata
**Ejemplos**: Registro de ventas, validaciones, consultas en tiempo real

```mermaid
graph LR
    A[Cliente] -->|Request| B[API]
    B -->|Query| C[Database]
    C -->|Result| B
    B -->|Response| A
```

**Características**:
- Latencia baja (< 200ms)
- Consistencia inmediata
- Manejo de errores directo
- Timeout configurado

### 2. Patrón Asíncrono (Event-Driven)

**Uso**: Sincronización con sistemas externos, procesamiento batch
**Ejemplos**: Sincronización HO, ETL, notificaciones

```mermaid
graph LR
    A[Productor] -->|Event| B[Service Bus]
    B -->|Deliver| C[Consumidor 1]
    B -->|Deliver| D[Consumidor 2]
    C -->|Process| E[Action 1]
    D -->|Process| F[Action 2]
```

**Características**:
- Desacoplamiento de servicios
- Tolerancia a fallos
- Escalabilidad horizontal
- Eventual consistency

### 3. Patrón ETL (Extract-Transform-Load)

**Uso**: Procesamiento de grandes volúmenes, análisis de datos
**Ejemplos**: Carga a Data Warehouse, reportes históricos

```mermaid
graph LR
    A[Fuente 1] -->|Extract| D[ETL Engine]
    B[Fuente 2] -->|Extract| D
    C[Fuente 3] -->|Extract| D
    D -->|Transform| E[Staging]
    E -->|Load| F[Data Warehouse]
```

**Características**:
- Procesamiento por lotes
- Transformaciones complejas
- Validación de calidad de datos
- Optimización para volumen

## Flujos por Dominio de Negocio

### Dominio: Gestión de Jornadas

```mermaid
flowchart TD
    A[Operador inicia jornada] --> B[MS Sync Jornadas]
    B --> C{Validar horario}
    C -->|Válido| D[Registrar apertura]
    C -->|Inválido| E[Rechazar apertura]
    D --> F[Notificar HO]
    F --> G[Actualizar estado local]
    
    H[Operador cierra jornada] --> I[Validar ventas pendientes]
    I -->|Sin pendientes| J[Procesar cierre]
    I -->|Con pendientes| K[Alertar operador]
    J --> L[Sincronizar cierre HO]
```

### Dominio: Procesamiento de Pagos

```mermaid
flowchart TD
    A[Transacción con tarjeta] --> B[Validar con banco]
    B -->|Aprobada| C[Registrar venta]
    B -->|Rechazada| D[Cancelar transacción]
    C --> E[MS Conciliación]
    E --> F[Comparar con reporte bancario]
    F -->|Coincide| G[Marcar conciliado]
    F -->|Diferencia| H[Generar alerta]
    H --> I[Revisión manual]
```

## Calidad de Datos

### Validaciones en Tiempo Real

| Punto de Validación | Reglas | Acción en Error |
|-------------------|--------|-----------------|
| **Entrada POS** | Formato, rangos, obligatorios | Rechazar transacción |
| **API Frontend** | Esquemas JSON, tipos de datos | HTTP 400 Bad Request |
| **Microservicios** | Reglas de negocio | Log error + compensación |
| **ETL** | Integridad referencial | Quarantine + alerta |

### Monitoreo de Calidad

```mermaid
graph TD
    A[Datos de entrada] --> B[Validación automática]
    B -->|Válidos| C[Procesamiento normal]
    B -->|Inválidos| D[Quarantine]
    D --> E[Alerta automática]
    E --> F[Revisión manual]
    F -->|Corregir| C
    F -->|Descartar| G[Log de descarte]
```

## Performance y Optimización

### Estrategias por Tipo de Flujo

#### Flujos de Alta Frecuencia (Ventas)
- **Cache**: Redis para consultas frecuentes
- **Connection Pooling**: Reutilización de conexiones DB
- **Batch Processing**: Agrupación de operaciones similares
- **Índices**: Optimización de queries frecuentes

#### Flujos de Baja Latencia (Validaciones)
- **In-Memory Processing**: Datos críticos en memoria
- **Circuit Breaker**: Protección contra servicios lentos
- **Timeout Agresivo**: Fallos rápidos
- **Fallback**: Respuestas alternativas

#### Flujos de Alto Volumen (ETL)
- **Parallel Processing**: Procesamiento en paralelo
- **Streaming**: Procesamiento continuo
- **Compression**: Compresión de datos
- **Partitioning**: División de datos por criterios

## Trazabilidad y Auditoría

### Correlation IDs

Cada flujo de datos incluye un ID de correlación único que permite rastrear la transacción a través de todos los servicios.

```json
{
  "correlationId": "550e8400-e29b-41d4-a716-446655440000",
  "timestamp": "2024-01-15T14:30:00Z",
  "service": "ms-sync-ventas",
  "operation": "process-sale",
  "data": { ... }
}
```

### Audit Trail

```mermaid
graph LR
    A[Evento] --> B[Audit Service]
    B --> C[Audit Log]
    B --> D[Metrics Collector]
    C --> E[Long-term Storage]
    D --> F[Real-time Dashboard]
```

## Manejo de Errores

### Estrategias por Tipo de Error

| Tipo de Error | Estrategia | Ejemplo |
|---------------|------------|---------|
| **Transient** | Retry con backoff | Timeout de red |
| **Business** | Compensación | Saldo insuficiente |
| **System** | Circuit breaker | Servicio no disponible |
| **Data** | Quarantine | Formato inválido |

### Dead Letter Queue

```mermaid
graph TD
    A[Mensaje] --> B[Procesamiento]
    B -->|Success| C[Completado]
    B -->|Error| D[Retry Queue]
    D -->|Max retries| E[Dead Letter Queue]
    E --> F[Manual Review]
    F -->|Fix| A
    F -->|Discard| G[Log & Archive]
```

## Métricas y Monitoreo

### KPIs de Flujo de Datos

| Métrica | Objetivo | Alerta |
|---------|----------|--------|
| **Throughput** | > 1000 TPS | < 500 TPS |
| **Latency P95** | < 200ms | > 500ms |
| **Error Rate** | < 0.1% | > 1% |
| **Data Quality** | > 99.9% | < 99% |

### Dashboard de Flujos

- **Tiempo real**: Volumen actual, latencia, errores
- **Histórico**: Tendencias, patrones, comparativas
- **Alertas**: Umbrales, anomalías, fallos críticos
- **Trazabilidad**: Seguimiento end-to-end de transacciones

---

*Flujos documentados: Enero 2024*
