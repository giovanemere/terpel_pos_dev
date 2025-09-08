# Diagramas Técnicos Detallados - MS POS Sincronización Sales

## 🗄️ Diagrama de Base de Datos Detallado

```mermaid
erDiagram
    LOGS_VENTAS_UNIFICADAS_POS {
        bigint id_logs_ventas_unificadas_pos PK
        varchar estado "A=nuevo, U=actualizado"
        varchar tipo "COMBUSTIBLE, CANASTILLA, KIOSKO"
        json data_venta "Datos completos de la venta"
        timestamp fecha_creacion
        timestamp fecha_actualizacion
        boolean sincronizado "false=pendiente, true=procesado"
        varchar error_message "Mensaje de error si falla"
        int retry_count "Número de reintentos"
        varchar transaction_id "ID único de transacción"
    }
    
    CONFIGURACION_HOST {
        int id PK
        varchar host_server "IP o dominio del servidor HO"
        varchar descripcion
        boolean activo
        timestamp fecha_actualizacion
        varchar ambiente "DEV, TEST, PROD"
    }
    
    TIPOS_TRANSACCION {
        int id PK
        varchar codigo "COMBUSTIBLE, CANASTILLA, KIOSKO"
        varchar descripcion
        varchar endpoint_url "/combustible, /canastilla, /kiosco"
        boolean activo
    }
    
    SYNC_LOG {
        bigint id PK
        bigint venta_id FK
        varchar status "PENDING, PROCESSING, SUCCESS, FAILED"
        timestamp inicio_proceso
        timestamp fin_proceso
        varchar response_code "200, 400, 500, etc"
        text response_body
        varchar error_details
    }
    
    LOGS_VENTAS_UNIFICADAS_POS ||--o{ SYNC_LOG : "genera logs"
    CONFIGURACION_HOST ||--o{ LOGS_VENTAS_UNIFICADAS_POS : "define destino"
    TIPOS_TRANSACCION ||--o{ LOGS_VENTAS_UNIFICADAS_POS : "categoriza"
```

## 🔄 Diagrama de Secuencia Detallado

```mermaid
sequenceDiagram
    participant MS as Microservicio
    participant DB as PostgreSQL
    participant API as API HO
    participant LOG as Sistema Logs
    
    Note over MS: Inicio del ciclo de sincronización
    
    MS->>DB: SELECT host_server FROM configuracion_host
    DB-->>MS: HOST_SERVER
    
    MS->>DB: UPDATE logs_ventas SET sincronizado=false
    DB-->>MS: OK
    
    MS->>DB: SELECT * FROM logs_ventas WHERE sincronizado=false
    DB-->>MS: Lista de ventas pendientes
    
    alt Hay ventas pendientes
        loop Para cada venta
            MS->>MS: Determinar método (POST/PUT) y endpoint
            MS->>LOG: Log inicio procesamiento venta
            
            MS->>API: HTTP Request (POST/PUT)
            
            alt Respuesta exitosa (200)
                API-->>MS: HTTP 200 + datos
                MS->>DB: UPDATE logs_ventas SET sincronizado=true
                MS->>LOG: Log éxito
            else Error HTTP
                API-->>MS: HTTP 4xx/5xx + error
                MS->>DB: UPDATE logs_ventas SET error_message=?
                MS->>LOG: Log error HTTP
            else Timeout
                MS->>DB: UPDATE logs_ventas SET error_message='TIMEOUT'
                MS->>LOG: Log timeout
            end
        end
        
        MS->>MS: Sleep(SLEEP_TIME)
        MS->>MS: Reiniciar ciclo (recursión)
        
    else No hay ventas
        MS->>LOG: Log "No hay ventas pendientes"
        MS->>MS: Sleep(SLEEP_TIME)
        MS->>MS: Reiniciar ciclo (recursión)
    end
```

## 🏗️ Diagrama de Componentes Técnicos

```mermaid
graph TB
    subgraph "NestJS Application"
        subgraph "Controllers Layer"
            AC[AppController]
            HC[HealthController]
        end
        
        subgraph "Services Layer"
            AS[AppService]
            CS[ConfigService]
            LS[LoggerService]
        end
        
        subgraph "Data Layer"
            NP[NeoPool]
            HS[HttpService]
        end
        
        subgraph "Common Layer"
            QU[Queries]
            EN[Enums]
            IF[Interfaces]
        end
    end
    
    subgraph "External Systems"
        PG[(PostgreSQL)]
        HOAPI[HO API]
        LOGS[Log System]
    end
    
    AC --> AS
    HC --> AS
    AS --> CS
    AS --> LS
    AS --> NP
    AS --> HS
    AS --> QU
    
    NP --> PG
    HS --> HOAPI
    LS --> LOGS
    
    QU --> EN
    QU --> IF
    
    classDef controller fill:#e3f2fd
    classDef service fill:#f3e5f5
    classDef data fill:#e8f5e8
    classDef common fill:#fff3e0
    classDef external fill:#ffebee
    
    class AC,HC controller
    class AS,CS,LS service
    class NP,HS data
    class QU,EN,IF common
    class PG,HOAPI,LOGS external
```

## 🔧 Diagrama de Configuración y Variables

```mermaid
graph LR
    subgraph "Environment Variables"
        ENV[.env File]
        DB_CONFIG[Database Config]
        API_CONFIG[API Config]
        SYNC_CONFIG[Sync Config]
    end
    
    subgraph "Configuration Service"
        CS[ConfigService]
        VALIDATION[Config Validation]
    end
    
    subgraph "Application Components"
        POOL[Connection Pool]
        HTTP[HTTP Client]
        SCHEDULER[Sync Scheduler]
    end
    
    ENV --> DB_CONFIG
    ENV --> API_CONFIG
    ENV --> SYNC_CONFIG
    
    DB_CONFIG --> CS
    API_CONFIG --> CS
    SYNC_CONFIG --> CS
    
    CS --> VALIDATION
    VALIDATION --> POOL
    VALIDATION --> HTTP
    VALIDATION --> SCHEDULER
    
    POOL -.->|DB_HOST, DB_PORT| PG[(PostgreSQL)]
    HTTP -.->|API_URL, TIMEOUT| API[HO API]
    SCHEDULER -.->|SLEEP_TIME| TIMER[Timer]
```

## 📊 Diagrama de Flujo de Datos

```mermaid
flowchart TD
    START([Aplicación Inicia]) --> LOAD_CONFIG[Cargar Configuración]
    LOAD_CONFIG --> INIT_POOL[Inicializar Pool BD]
    INIT_POOL --> INIT_HTTP[Inicializar HTTP Client]
    INIT_HTTP --> START_SYNC[Iniciar Sincronización]
    
    START_SYNC --> GET_HOST[Obtener Host Server]
    GET_HOST --> MARK_PENDING[Marcar Ventas Pendientes]
    MARK_PENDING --> QUERY_SALES[Consultar Ventas]
    
    QUERY_SALES --> HAS_SALES{¿Hay Ventas?}
    
    HAS_SALES -->|No| LOG_EMPTY[Log: Sin Ventas]
    LOG_EMPTY --> SLEEP_NORMAL[Sleep Normal]
    SLEEP_NORMAL --> START_SYNC
    
    HAS_SALES -->|Sí| PROCESS_BATCH[Procesar Lote]
    PROCESS_BATCH --> TRANSFORM[Transformar Datos]
    TRANSFORM --> DETERMINE_METHOD[Determinar POST/PUT]
    DETERMINE_METHOD --> DETERMINE_ENDPOINT[Determinar Endpoint]
    
    DETERMINE_ENDPOINT --> SEND_HTTP[Enviar HTTP Request]
    SEND_HTTP --> RESPONSE{Respuesta}
    
    RESPONSE -->|200 OK| UPDATE_SUCCESS[Actualizar Estado: Éxito]
    RESPONSE -->|4xx/5xx| LOG_ERROR[Log Error HTTP]
    RESPONSE -->|Timeout| LOG_TIMEOUT[Log Timeout]
    
    UPDATE_SUCCESS --> MORE_SALES{¿Más Ventas?}
    LOG_ERROR --> MORE_SALES
    LOG_TIMEOUT --> MORE_SALES
    
    MORE_SALES -->|Sí| PROCESS_BATCH
    MORE_SALES -->|No| SLEEP_NORMAL
    
    classDef start fill:#4caf50,color:#fff
    classDef process fill:#2196f3,color:#fff
    classDef decision fill:#ff9800,color:#fff
    classDef error fill:#f44336,color:#fff
    classDef success fill:#8bc34a,color:#fff
    
    class START,SLEEP_NORMAL start
    class LOAD_CONFIG,INIT_POOL,INIT_HTTP,PROCESS_BATCH,TRANSFORM,SEND_HTTP process
    class HAS_SALES,RESPONSE,MORE_SALES decision
    class LOG_ERROR,LOG_TIMEOUT error
    class UPDATE_SUCCESS success
```

## 🚨 Diagrama de Manejo de Errores

```mermaid
stateDiagram-v2
    [*] --> Procesando : Nueva venta
    
    Procesando --> Enviando : Datos preparados
    
    Enviando --> Exitoso : HTTP 200
    Enviando --> ErrorHTTP : HTTP 4xx/5xx
    Enviando --> Timeout : Sin respuesta
    Enviando --> ErrorRed : Error conexión
    
    ErrorHTTP --> Reintento : retry_count < MAX_RETRIES
    Timeout --> Reintento : retry_count < MAX_RETRIES
    ErrorRed --> Reintento : retry_count < MAX_RETRIES
    
    ErrorHTTP --> Fallido : retry_count >= MAX_RETRIES
    Timeout --> Fallido : retry_count >= MAX_RETRIES
    ErrorRed --> Fallido : retry_count >= MAX_RETRIES
    
    Reintento --> Enviando : Después de delay
    
    Exitoso --> [*] : Venta sincronizada
    Fallido --> DeadLetter : Requiere intervención
    DeadLetter --> [*] : Almacenado para revisión
    
    note right of ErrorHTTP
        400: Bad Request
        401: Unauthorized
        404: Not Found
        500: Server Error
    end note
    
    note right of Timeout
        Timeout configurado:
        10 segundos por defecto
    end note
    
    note right of Reintento
        Delay exponencial:
        1s, 2s, 4s, 8s, 16s
    end note
```

## 🔍 Diagrama de Monitoreo y Observabilidad

```mermaid
graph TB
    subgraph "Application Metrics"
        COUNTER[Ventas Procesadas Counter]
        HISTOGRAM[Tiempo Respuesta Histogram]
        GAUGE[Ventas Pendientes Gauge]
        ERROR_RATE[Error Rate Counter]
    end
    
    subgraph "System Metrics"
        CPU[CPU Usage]
        MEMORY[Memory Usage]
        DISK[Disk Usage]
        NETWORK[Network I/O]
    end
    
    subgraph "Database Metrics"
        DB_CONN[Active Connections]
        DB_QUERY[Query Performance]
        DB_LOCKS[Lock Waits]
    end
    
    subgraph "Collection & Storage"
        PROMETHEUS[Prometheus]
        GRAFANA[Grafana]
        ALERTMANAGER[Alert Manager]
    end
    
    subgraph "Alerting"
        SLACK[Slack Notifications]
        EMAIL[Email Alerts]
        PAGERDUTY[PagerDuty]
    end
    
    COUNTER --> PROMETHEUS
    HISTOGRAM --> PROMETHEUS
    GAUGE --> PROMETHEUS
    ERROR_RATE --> PROMETHEUS
    
    CPU --> PROMETHEUS
    MEMORY --> PROMETHEUS
    DISK --> PROMETHEUS
    NETWORK --> PROMETHEUS
    
    DB_CONN --> PROMETHEUS
    DB_QUERY --> PROMETHEUS
    DB_LOCKS --> PROMETHEUS
    
    PROMETHEUS --> GRAFANA
    PROMETHEUS --> ALERTMANAGER
    
    ALERTMANAGER --> SLACK
    ALERTMANAGER --> EMAIL
    ALERTMANAGER --> PAGERDUTY
    
    classDef metrics fill:#e3f2fd
    classDef system fill:#f3e5f5
    classDef database fill:#e8f5e8
    classDef monitoring fill:#fff3e0
    classDef alerting fill:#ffebee
    
    class COUNTER,HISTOGRAM,GAUGE,ERROR_RATE metrics
    class CPU,MEMORY,DISK,NETWORK system
    class DB_CONN,DB_QUERY,DB_LOCKS database
    class PROMETHEUS,GRAFANA,ALERTMANAGER monitoring
    class SLACK,EMAIL,PAGERDUTY alerting
```

## 🔐 Diagrama de Seguridad y Autenticación

```mermaid
graph LR
    subgraph "Security Layers"
        AUTH[Authentication]
        AUTHZ[Authorization]
        ENCRYPT[Encryption]
        AUDIT[Audit Logs]
    end
    
    subgraph "Network Security"
        FIREWALL[Firewall Rules]
        VPN[VPN Connection]
        TLS[TLS/SSL]
    end
    
    subgraph "Data Security"
        DB_ENCRYPT[DB Encryption]
        SECRETS[Secrets Management]
        BACKUP[Secure Backups]
    end
    
    MS[Microservicio] --> AUTH
    AUTH --> AUTHZ
    AUTHZ --> ENCRYPT
    ENCRYPT --> AUDIT
    
    MS --> FIREWALL
    FIREWALL --> VPN
    VPN --> TLS
    
    MS --> DB_ENCRYPT
    DB_ENCRYPT --> SECRETS
    SECRETS --> BACKUP
    
    classDef security fill:#ffebee
    classDef network fill:#e8f5e8
    classDef data fill:#e3f2fd
    
    class AUTH,AUTHZ,ENCRYPT,AUDIT security
    class FIREWALL,VPN,TLS network
    class DB_ENCRYPT,SECRETS,BACKUP data
```

---

**Nota**: Estos diagramas técnicos detallados complementan la documentación principal y pueden ser renderizados usando herramientas compatibles con Mermaid.
