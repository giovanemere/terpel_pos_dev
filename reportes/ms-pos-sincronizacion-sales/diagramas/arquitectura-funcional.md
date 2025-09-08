# Diagramas de Arquitectura - MS POS Sincronización Sales

## 🏗️ Diagrama de Arquitectura General

```mermaid
graph TB
    subgraph "POS Local"
        DB[(Base de Datos<br/>PostgreSQL)]
        MS[MS Sincronización<br/>Sales]
    end
    
    subgraph "Head Office (HO)"
        API[API Frontend<br/>Node.js]
        HODB[(Base de Datos<br/>HO)]
    end
    
    subgraph "Configuración"
        CONFIG[Variables de<br/>Entorno]
        LOGS[Sistema de<br/>Logs]
    end
    
    DB -->|1. Consulta ventas<br/>pendientes| MS
    MS -->|2. Procesa y<br/>transforma datos| MS
    MS -->|3. Envía ventas<br/>HTTP POST/PUT| API
    API -->|4. Almacena en<br/>base de datos| HODB
    API -->|5. Confirma<br/>recepción| MS
    MS -->|6. Actualiza estado<br/>sincronización| DB
    
    CONFIG -.->|Configuración| MS
    MS -.->|Eventos y errores| LOGS
    
    classDef database fill:#e1f5fe
    classDef microservice fill:#f3e5f5
    classDef api fill:#e8f5e8
    classDef config fill:#fff3e0
    
    class DB,HODB database
    class MS microservice
    class API api
    class CONFIG,LOGS config
```

## 🔄 Diagrama de Flujo de Proceso

```mermaid
flowchart TD
    START([Inicio del Proceso]) --> QUERY[Consultar Host Server]
    QUERY --> GETHOST{¿Host encontrado?}
    
    GETHOST -->|No| ERROR1[Log Error]
    ERROR1 --> SLEEP1[Sleep Error Time]
    SLEEP1 --> START
    
    GETHOST -->|Sí| GETSALES[Consultar Ventas Pendientes]
    GETSALES --> HASSALES{¿Hay ventas?}
    
    HASSALES -->|No| LOG1[Log: No hay ventas]
    LOG1 --> SLEEP2[Sleep Normal Time]
    SLEEP2 --> START
    
    HASSALES -->|Sí| PROCESS[Procesar Ventas]
    PROCESS --> ADDMETHOD[Agregar Method y URL]
    ADDMETHOD --> LOOP[Para cada venta]
    
    LOOP --> SEND[Enviar HTTP Request]
    SEND --> RESPONSE{¿Respuesta OK?}
    
    RESPONSE -->|200| UPDATE[Actualizar Estado BD]
    RESPONSE -->|Error| LOGERR[Log Error]
    
    UPDATE --> NEXT{¿Más ventas?}
    LOGERR --> NEXT
    
    NEXT -->|Sí| LOOP
    NEXT -->|No| SLEEP3[Sleep Normal Time]
    SLEEP3 --> START
    
    classDef startEnd fill:#4caf50,color:#fff
    classDef process fill:#2196f3,color:#fff
    classDef decision fill:#ff9800,color:#fff
    classDef error fill:#f44336,color:#fff
    
    class START,SLEEP1,SLEEP2,SLEEP3 startEnd
    class QUERY,GETSALES,PROCESS,ADDMETHOD,SEND,UPDATE process
    class GETHOST,HASSALES,RESPONSE,NEXT decision
    class ERROR1,LOGERR error
```

## 🗄️ Diagrama de Base de Datos

```mermaid
erDiagram
    LOGS_VENTAS_UNIFICADAS_POS {
        bigint id_logs_ventas_unificadas_pos PK
        varchar estado
        varchar tipo
        json data_venta
        timestamp fecha_creacion
        timestamp fecha_actualizacion
        boolean sincronizado
    }
    
    CONFIGURACION_HOST {
        int id PK
        varchar host_server
        varchar descripcion
        boolean activo
    }
    
    TIPOS_TRANSACCION {
        int id PK
        varchar codigo
        varchar descripcion
    }
    
    LOGS_VENTAS_UNIFICADAS_POS ||--o{ TIPOS_TRANSACCION : "tiene tipo"
    CONFIGURACION_HOST ||--o{ LOGS_VENTAS_UNIFICADAS_POS : "configura destino"
```

## 🔌 Diagrama de Integraciones

```mermaid
graph LR
    subgraph "Microservicio"
        APP[AppService]
        POOL[NeoPool]
        HTTP[HttpService]
        CONFIG[ConfigService]
    end
    
    subgraph "Externos"
        POSTGRES[(PostgreSQL)]
        FRONTEND[API Frontend HO]
    end
    
    APP --> POOL
    APP --> HTTP
    APP --> CONFIG
    
    POOL <--> POSTGRES
    HTTP <--> FRONTEND
    
    POSTGRES -.->|Queries| POOL
    FRONTEND -.->|REST API| HTTP
    
    classDef service fill:#e3f2fd
    classDef external fill:#f1f8e9
    classDef connection fill:#fff3e0
    
    class APP,POOL,HTTP,CONFIG service
    class POSTGRES,FRONTEND external
```

## 📊 Diagrama de Estados de Venta

```mermaid
stateDiagram-v2
    [*] --> Pendiente : Nueva venta creada
    
    Pendiente --> Procesando : Microservicio toma venta
    Procesando --> Enviando : Preparar datos para envío
    
    Enviando --> Sincronizada : HTTP 200 OK
    Enviando --> Error : HTTP Error
    Enviando --> Timeout : Sin respuesta
    
    Error --> Reintento : Después de sleep
    Timeout --> Reintento : Después de sleep
    
    Reintento --> Enviando : Nuevo intento
    Reintento --> Fallida : Máximo reintentos
    
    Sincronizada --> [*] : Proceso completado
    Fallida --> [*] : Requiere intervención manual
    
    note right of Sincronizada
        Estado actualizado en BD
        Venta marcada como procesada
    end note
    
    note right of Error
        Log de error generado
        Sleep antes de reintento
    end note
```

## 🚀 Diagrama de Despliegue

```mermaid
deployment
    node "Servidor POS" {
        component "MS Sincronización Sales" as MS
        database "PostgreSQL Local" as DBLOCAL
    }
    
    node "Servidor HO" {
        component "API Frontend" as API
        database "PostgreSQL HO" as DBHO
    }
    
    cloud "Red Terpel" {
        interface "HTTP/HTTPS" as NET
    }
    
    MS --> NET : REST API Calls
    NET --> API : Forward Requests
    
    MS --> DBLOCAL : SQL Queries
    API --> DBHO : SQL Queries
    
    note top of MS : Puerto: 3000\nProtocolo: HTTP
    note top of API : Puerto: 8080\nProtocolo: HTTPS
```

## 📈 Diagrama de Métricas y Monitoreo

```mermaid
graph TB
    subgraph "Microservicio"
        MS[MS Sincronización<br/>Sales]
        METRICS[Métricas<br/>Internas]
    end
    
    subgraph "Observabilidad"
        LOGS[Logs<br/>Centralizados]
        PROMETHEUS[Prometheus<br/>Métricas]
        GRAFANA[Grafana<br/>Dashboards]
        ALERTS[Sistema de<br/>Alertas]
    end
    
    MS --> METRICS
    METRICS --> LOGS
    METRICS --> PROMETHEUS
    
    PROMETHEUS --> GRAFANA
    PROMETHEUS --> ALERTS
    
    LOGS -.->|Análisis| GRAFANA
    ALERTS -.->|Notificaciones| MS
    
    classDef service fill:#e8eaf6
    classDef monitoring fill:#e0f2f1
    classDef alert fill:#ffebee
    
    class MS,METRICS service
    class LOGS,PROMETHEUS,GRAFANA monitoring
    class ALERTS alert
```

---

**Nota**: Estos diagramas pueden ser renderizados usando cualquier herramienta compatible con Mermaid como:
- GitHub/GitLab (renderizado automático)
- Mermaid Live Editor
- VS Code con extensión Mermaid
- Confluence con plugin Mermaid
