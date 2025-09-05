# Diagrama de Componentes

## Arquitectura de Componentes del Sistema

El ecosistema Terpel POS está estructurado en capas bien definidas que permiten escalabilidad, mantenibilidad y separación de responsabilidades.

## Diagrama General de Componentes

```mermaid
graph TB
    subgraph "Capa de Presentación"
        FE1["Microcierre Desktop<br/>Electron + React"]
        FE2["POS Terminal<br/>Sistema Propietario"]
        FE3["Web Dashboard<br/>React SPA"]
    end
    
    subgraph "Capa de API Gateway"
        GW["API Gateway<br/>Azure API Management"]
    end
    
    subgraph "Capa de APIs Frontend"
        API1["Frontal Ventas<br/>Node.js + NestJS"]
        API2["Frontal Cierres<br/>Node.js + NestJS"]
        API3["Frontal Anulaciones<br/>Node.js + NestJS"]
    end
    
    subgraph "Capa de Microservicios"
        MS1["Sync Jornadas<br/>NestJS"]
        MS2["Sync Ventas<br/>NestJS"]
        MS3["Sync Anulaciones<br/>NestJS"]
        MS4["Microcierre Backend<br/>Clean Architecture"]
        MS5["Sync Turnos HO<br/>NestJS"]
        MS6["Node Turnos<br/>Node.js"]
        MS7["Synchronizer POS Web<br/>Express"]
        MS8["Conciliación Medios<br/>NestJS"]
    end
    
    subgraph "Capa de Procesamiento"
        ETL1["ETL Ventas<br/>Node.js + Cron"]
        ETL2["ETL Venta Histórica<br/>Node.js + Scheduler"]
    end
    
    subgraph "Capa de Datos"
        DB1[("PostgreSQL POS<br/>Transaccional")]
        DB2[("PostgreSQL HO<br/>Maestros")]
        DB3[("Data Warehouse<br/>Analítica")]
        CACHE[("Redis<br/>Cache")]
    end
    
    subgraph "Sistemas Externos"
        HO["Head Office<br/>Sistema Central"]
        SB["Azure Service Bus<br/>Mensajería"]
        MON["Application Insights<br/>Monitoreo"]
    end
    
    FE1 --> GW
    FE2 --> GW
    FE3 --> GW
    
    GW --> API1
    GW --> API2
    GW --> API3
    
    API1 --> MS2
    API1 --> MS4
    API2 --> MS1
    API2 --> MS5
    API3 --> MS3
    
    MS1 --> DB1
    MS2 --> DB1
    MS3 --> DB1
    MS4 --> DB1
    MS5 --> DB1
    MS6 --> DB1
    MS7 --> DB1
    MS8 --> DB1
    
    ETL1 --> DB1
    ETL1 --> DB3
    ETL2 --> DB2
    ETL2 --> DB3
    
    API1 --> CACHE
    API2 --> CACHE
    API3 --> CACHE
    
    MS1 --> HO
    MS2 --> HO
    MS3 --> HO
    MS5 --> HO
    
    MS1 --> SB
    MS2 --> SB
    MS3 --> SB
    MS5 --> SB
    
    API1 --> MON
    API2 --> MON
    API3 --> MON
    MS1 --> MON
    MS2 --> MON
    MS3 --> MON
    MS4 --> MON
```

## Componentes por Capa

### 🖥️ Capa de Presentación

| Componente | Tecnología | Propósito | Estado |
|------------|------------|-----------|--------|
| **Microcierre Desktop** | Electron + React + TypeScript | Aplicación de escritorio para microcierres | 🟡 65% |
| **POS Terminal** | Sistema Propietario | Terminal punto de venta | 🟢 Estable |
| **Web Dashboard** | React + TypeScript | Dashboard web de monitoreo | 🔴 Planificado |

### 🌐 Capa de APIs Frontend

| Componente | Tecnología | Responsabilidad | Estado |
|------------|------------|-----------------|--------|
| **Frontal Ventas** | Node.js + NestJS | API para consultas y operaciones de ventas | 🟢 85% |
| **Frontal Cierres** | Node.js + NestJS | API para gestión de cierres de turno | 🟢 80% |
| **Frontal Anulaciones** | Node.js + NestJS | API para procesamiento de anulaciones | 🟡 50% |

### ⚙️ Capa de Microservicios

| Componente | Patrón Arquitectónico | Responsabilidad | Estado |
|------------|----------------------|-----------------|--------|
| **Sync Jornadas** | Hexagonal Architecture | Sincronización de jornadas laborales | 🟡 75% |
| **Sync Ventas** | Event-Driven | Sincronización de transacciones de venta | 🟢 85% |
| **Sync Anulaciones** | CQRS | Sincronización de anulaciones | 🟡 80% |
| **Microcierre Backend** | Clean Architecture | Lógica de negocio para microcierres | 🟡 70% |
| **Sync Turnos HO** | Event Sourcing | Sincronización de turnos con HO | 🟡 70% |
| **Node Turnos** | MVC | Gestión local de turnos | 🔴 40% |
| **Synchronizer POS Web** | Layered Architecture | Sincronización POS-Web | 🔴 45% |
| **Conciliación Medios** | Domain-Driven Design | Conciliación de medios de pago | 🔴 40% |

### 📊 Capa de Procesamiento

| Componente | Patrón | Frecuencia | Estado |
|------------|--------|------------|--------|
| **ETL Ventas** | Batch Processing | Tiempo real + Diario | 🟡 60% |
| **ETL Venta Histórica** | Stream Processing | Semanal | 🔴 35% |

### 💾 Capa de Datos

| Componente | Tipo | Propósito | Tecnología |
|------------|------|-----------|------------|
| **PostgreSQL POS** | Transaccional | Datos operacionales POS | PostgreSQL 13+ |
| **PostgreSQL HO** | Maestros | Datos maestros y configuración | PostgreSQL 13+ |
| **Data Warehouse** | Analítica | Datos históricos y reportería | PostgreSQL + TimescaleDB |
| **Redis Cache** | Cache | Cache distribuido y sesiones | Redis 6+ |

## Patrones de Comunicación

### Comunicación Síncrona
```mermaid
sequenceDiagram
    participant FE as Frontend
    participant API as API Frontend
    participant MS as Microservicio
    participant DB as Database
    
    FE->>API: HTTP Request
    API->>MS: HTTP/gRPC Call
    MS->>DB: SQL Query
    DB-->>MS: Result
    MS-->>API: Response
    API-->>FE: HTTP Response
```

### Comunicación Asíncrona
```mermaid
sequenceDiagram
    participant MS1 as Microservicio A
    participant SB as Service Bus
    participant MS2 as Microservicio B
    
    MS1->>SB: Publish Event
    SB->>MS2: Deliver Event
    MS2->>MS2: Process Event
    MS2->>SB: Publish Result (optional)
```

## Dependencias entre Componentes

### Dependencias Críticas
- **APIs Frontend** → **Microservicios**: Dependencia directa para operaciones
- **Microservicios** → **PostgreSQL**: Dependencia crítica para persistencia
- **ETLs** → **Múltiples DBs**: Dependencia para procesamiento de datos
- **Todos los servicios** → **Head Office**: Dependencia externa crítica

### Dependencias Opcionales
- **Microservicios** → **Redis**: Mejora performance pero no crítico
- **Servicios** → **Service Bus**: Mejora resilencia pero no crítico
- **Servicios** → **Monitoring**: Observabilidad pero no funcional

## Escalabilidad por Componente

### Escalabilidad Horizontal
| Componente | Escalable | Método | Limitaciones |
|------------|-----------|--------|--------------|
| **APIs Frontend** | ✅ | Load Balancer + Múltiples instancias | Sesiones stateless |
| **Microservicios** | ✅ | Container orchestration | Base de datos compartida |
| **ETLs** | ✅ | Parallel processing | Orden de procesamiento |
| **Frontend Desktop** | ❌ | N/A | Aplicación local |

### Escalabilidad Vertical
- **PostgreSQL**: Escalable verticalmente hasta cierto punto
- **Redis**: Escalable verticalmente con clustering
- **Microservicios**: Escalables verticalmente por recursos

## Consideraciones de Deployment

### Estrategia por Componente
| Componente | Estrategia | Frecuencia | Rollback |
|------------|------------|------------|----------|
| **APIs Frontend** | Blue-Green | Semanal | Automático |
| **Microservicios** | Rolling Update | Bi-semanal | Manual |
| **ETLs** | Scheduled Deployment | Mensual | Manual |
| **Frontend Desktop** | Client Update | Mensual | Manual |

### Orden de Deployment
1. **Base de Datos** (migraciones)
2. **Microservicios** (backend services)
3. **APIs Frontend** (interfaces)
4. **ETLs** (procesamiento)
5. **Frontend** (aplicaciones cliente)

---

*Diagrama actualizado: Enero 2024*
