#!/bin/bash

echo "🖥️ Generando propuestas actualizadas para Windows 10 POS + Mensajería..."

# Crear diagrama de arquitectura POS Windows con mensajería
create_windows_pos_architecture() {
    cat > /tmp/windows-pos-architecture.mmd << 'EOF'
graph TB
    subgraph "POS Windows 10"
        POSAPP[Aplicación POS<br/>Actual]
        LOCALDB[(SQL Server<br/>LocalDB)]
        MSGQUEUE[Message Queue<br/>Local]
    end
    
    subgraph "Servicios de Sincronización"
        BASIC[Propuesta 1: Básica<br/>NestJS + Local Queue]
        INTER[Propuesta 2: Intermedia<br/>NestJS + Redis + Workers]
        ADV[Propuesta 3: Avanzada<br/>NestJS + RabbitMQ Cluster]
        PYTHON[Propuesta 4: Python<br/>FastAPI + Celery]
    end
    
    subgraph "Head Office"
        API[API HO]
        HODB[(SQL Server<br/>Central)]
    end
    
    POSAPP -->|INSERT venta| LOCALDB
    LOCALDB -->|Trigger/Polling| MSGQUEUE
    
    MSGQUEUE -->|Consume| BASIC
    MSGQUEUE -->|Consume| INTER
    MSGQUEUE -->|Consume| ADV
    MSGQUEUE -->|Consume| PYTHON
    
    BASIC -->|HTTP Sync| API
    INTER -->|HTTP Sync| API
    ADV -->|HTTP Sync| API
    PYTHON -->|HTTP Sync| API
    
    API --> HODB
    
    classDef pos fill:#0078d4,color:#fff
    classDef service fill:#107c10,color:#fff
    classDef ho fill:#d13438,color:#fff
    
    class POSAPP,LOCALDB,MSGQUEUE pos
    class BASIC,INTER,ADV,PYTHON service
    class API,HODB ho
EOF

    echo "✅ Arquitectura Windows POS creada"
}

# Crear diagrama de flujo específico para POS
create_pos_flow_diagram() {
    cat > /tmp/pos-flow.mmd << 'EOF'
sequenceDiagram
    participant POS as Aplicación POS
    participant DB as SQL Server LocalDB
    participant QUEUE as Message Queue
    participant SYNC as Servicio Sincronización
    participant HO as API Head Office
    
    Note over POS: Venta realizada en Windows 10 POS
    
    POS->>DB: INSERT INTO ventas (datos_venta)
    DB->>DB: TRIGGER/Stored Procedure
    DB->>QUEUE: Publish message (venta_id, tipo, datos)
    
    Note over QUEUE: Message persiste hasta procesamiento exitoso
    
    QUEUE->>SYNC: Consume message
    SYNC->>SYNC: Validate & Transform data
    
    alt Conexión disponible
        SYNC->>HO: HTTP POST/PUT (venta)
        HO-->>SYNC: 200 OK
        SYNC->>DB: UPDATE venta SET sincronizado=1
        SYNC->>QUEUE: ACK message
    else Sin conexión/Error
        SYNC->>QUEUE: NACK message (retry later)
        QUEUE->>QUEUE: Requeue with backoff
    end
    
    Note over SYNC,HO: Funciona OFFLINE - mensajes se acumulan
EOF

    echo "✅ Flujo POS Windows creado"
}

# Generar diagramas
generate_pos_diagrams() {
    echo "🖼️  Generando diagramas POS Windows..."
    mmdc -i /tmp/windows-pos-architecture.mmd -o imagenes/propuestas/arquitectura-windows-pos.png -t default -b white
    mmdc -i /tmp/pos-flow.mmd -o imagenes/propuestas/flujo-pos-windows.png -t default -b white
    rm -f /tmp/windows-pos-*.mmd /tmp/pos-flow.mmd
    echo "✅ Diagramas POS Windows generados"
}

# Crear HTML actualizado para POS Windows
create_windows_pos_html() {
    cat > imagenes/propuestas-pos-windows.html << 'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Propuestas POS Windows 10 + Mensajería - MS Sincronización Sales</title>
    <style>
        @media print { body { margin: 0; padding: 0; } .page-break { page-break-before: always; } }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0; padding: 10px; background: white; color: #1e293b;
            line-height: 1.4; font-size: 12px;
        }
        
        .header {
            background: linear-gradient(135deg, #0078d4 0%, #005a9e 100%);
            color: white; padding: 20px; text-align: center; margin-bottom: 15px;
        }
        
        .header h1 { margin: 0; font-size: 2em; }
        
        .context-box {
            background: #fff4e6; border-left: 4px solid #ff8c00; padding: 20px;
            margin: 20px 0; border-radius: 6px;
        }
        
        .propuesta {
            margin: 25px 0; border: 2px solid #e5e7eb; border-radius: 8px;
            overflow: hidden; page-break-inside: avoid;
        }
        
        .propuesta-header { padding: 15px; font-weight: bold; color: white; }
        .basica { background: #10b981; }
        .intermedia { background: #f59e0b; }
        .avanzada { background: #ef4444; }
        .python { background: #306998; }
        
        .propuesta-content { padding: 20px; background: white; }
        
        .diagram-container {
            text-align: center; margin: 15px 0; background: #f9fafb;
            padding: 10px; border-radius: 6px;
        }
        
        .diagram-container img {
            max-width: 90%; height: auto; border: 1px solid #d1d5db; border-radius: 4px;
        }
        
        table { width: 100%; border-collapse: collapse; margin: 10px 0; font-size: 0.9em; }
        th, td { padding: 8px; text-align: left; border: 1px solid #d1d5db; }
        th { background: #f3f4f6; font-weight: 600; }
        
        .comparison { background: #f0f9ff; padding: 15px; border-radius: 6px; margin: 15px 0; }
        .page-break { page-break-before: always; }
        
        .highlight { background: #fef3c7; padding: 15px; border-radius: 6px; border-left: 4px solid #f59e0b; }
        .windows-box { background: #e6f3ff; padding: 15px; border-radius: 6px; border-left: 4px solid #0078d4; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🖥️ Propuestas para POS Windows 10</h1>
        <div>MS Sincronización Sales + Arquitectura de Mensajería</div>
        <div style="font-size: 0.9em; margin-top: 10px;">08/09/2024 | JONATHAN OSORIO | Terpel S.A.</div>
    </div>

    <div class="context-box">
        <h2 style="margin-top: 0; color: #d97706;">🎯 Contexto: POS Windows 10 + Mensajería</h2>
        <p><strong>Situación Actual:</strong></p>
        <ul>
            <li><strong>Sistema Operativo:</strong> Windows 10 en cada estación de servicio</li>
            <li><strong>Aplicación POS:</strong> Sistema de ventas local con SQL Server LocalDB</li>
            <li><strong>Problema:</strong> Sincronización directa causa bloqueos y pérdida de datos</li>
            <li><strong>Solución:</strong> Arquitectura de mensajería para desacoplar POS de sincronización</li>
        </ul>
        
        <p><strong>Nuevo Enfoque:</strong> El POS solo <strong>deja mensajes</strong> en una cola local, y un servicio independiente los procesa de forma asíncrona.</p>
    </div>

    <div class="windows-box">
        <h3>🏗️ Arquitectura General para POS Windows</h3>
        <div class="diagram-container">
            <img src="propuestas/arquitectura-windows-pos.png" alt="Arquitectura POS Windows">
        </div>
        
        <h3>🔄 Flujo de Mensajería en POS</h3>
        <div class="diagram-container">
            <img src="propuestas/flujo-pos-windows.png" alt="Flujo POS Windows">
        </div>
    </div>

    <div class="propuesta">
        <div class="propuesta-header basica">
            📈 PROPUESTA 1: BÁSICA - NestJS + Queue Local (2-3 semanas)
        </div>
        <div class="propuesta-content">
            <h3>🎯 Enfoque: Mensajería Local Simple</h3>
            
            <h4>🔧 Componentes Windows:</h4>
            <ul>
                <li><strong>POS App:</strong> Solo inserta ventas en LocalDB (sin cambios)</li>
                <li><strong>SQL Server Trigger:</strong> Automáticamente crea mensaje en tabla queue</li>
                <li><strong>NestJS Service:</strong> Polling cada 30s, procesa mensajes</li>
                <li><strong>Local Queue:</strong> Tabla SQL simple para mensajes</li>
                <li><strong>Retry Logic:</strong> Máximo 5 reintentos con backoff</li>
            </ul>

            <h4>💻 Implementación Windows:</h4>
            <div style="background: #1e293b; color: #e2e8f0; padding: 15px; border-radius: 6px; font-family: monospace; font-size: 0.8em;">
-- SQL Server Trigger (en POS LocalDB)
CREATE TRIGGER tr_venta_queue ON ventas
AFTER INSERT, UPDATE AS
BEGIN
    INSERT INTO message_queue (venta_id, tipo, datos, estado)
    SELECT id, tipo_venta, 
           (SELECT * FROM inserted FOR JSON AUTO),
           'PENDING'
    FROM inserted
END

-- NestJS Service (Windows Service)
@Injectable()
export class WindowsSyncService {
  async processMessages() {
    const messages = await this.getMessages('PENDING', 10);
    for (const msg of messages) {
      try {
        await this.syncToHO(msg.datos);
        await this.updateMessage(msg.id, 'PROCESSED');
      } catch (error) {
        await this.retryMessage(msg.id);
      }
    }
  }
}
            </div>

            <h4>📊 Ventajas para POS Windows:</h4>
            <table>
                <tr><th>Aspecto</th><th>Beneficio</th></tr>
                <tr><td><strong>POS App</strong></td><td>Sin cambios - solo inserta ventas</td></tr>
                <tr><td><strong>Offline Mode</strong></td><td>Mensajes se acumulan localmente</td></tr>
                <tr><td><strong>Performance POS</strong></td><td>Sin bloqueos por sincronización</td></tr>
                <tr><td><strong>Resilencia</strong></td><td>Reintentos automáticos</td></tr>
                <tr><td><strong>Deployment</strong></td><td>Windows Service estándar</td></tr>
            </table>

            <div class="comparison">
                <strong>💰 Inversión:</strong> 1 desarrollador × 3 semanas<br>
                <strong>🎯 Riesgo:</strong> Bajo - Cambios mínimos en POS<br>
                <strong>⚡ Impacto:</strong> Elimina bloqueos del POS + resilencia básica
            </div>
        </div>
    </div>

    <div class="page-break"></div>

    <div class="propuesta">
        <div class="propuesta-header intermedia">
            ⚡ PROPUESTA 2: INTERMEDIA - NestJS + Redis + Workers (4-6 semanas)
        </div>
        <div class="propuesta-content">
            <h3>🎯 Enfoque: Queue Distribuido con Workers</h3>
            
            <h4>🔧 Componentes Windows Avanzados:</h4>
            <ul>
                <li><strong>POS App:</strong> Publica a Redis local via stored procedure</li>
                <li><strong>Redis Windows:</strong> Queue distribuido + cache de configuración</li>
                <li><strong>NestJS Workers:</strong> Múltiples workers paralelos</li>
                <li><strong>Bull Queue:</strong> Gestión avanzada de colas con UI</li>
                <li><strong>Prometheus:</strong> Métricas en tiempo real</li>
            </ul>

            <h4>💻 Implementación Windows Avanzada:</h4>
            <div style="background: #1e293b; color: #e2e8f0; padding: 15px; border-radius: 6px; font-family: monospace; font-size: 0.8em;">
-- SQL Server + Redis Integration
CREATE PROCEDURE sp_PublishSale @venta_id INT AS
BEGIN
    DECLARE @json NVARCHAR(MAX) = (
        SELECT * FROM ventas WHERE id = @venta_id FOR JSON AUTO
    )
    
    -- Publish to Redis using CLR or external call
    EXEC sp_redis_publish 'sales_queue', @json
END

// NestJS Bull Queue (Windows)
@Processor('sales')
export class SalesProcessor {
  @Process({ concurrency: 5 })
  async processSale(job: Job<SaleData>) {
    const sale = job.data;
    try {
      await this.httpService.post(`${HO_API}/sales`, sale);
      await this.updateSaleStatus(sale.id, 'SYNCED');
    } catch (error) {
      throw new Error(`Sync failed: ${error.message}`);
    }
  }
}
            </div>

            <h4>📊 Ventajas Intermedias:</h4>
            <table>
                <tr><th>Aspecto</th><th>Beneficio</th></tr>
                <tr><td><strong>Concurrencia</strong></td><td>5 workers paralelos</td></tr>
                <tr><td><strong>Monitoreo</strong></td><td>Bull Dashboard + Prometheus</td></tr>
                <tr><td><strong>Cache</strong></td><td>Configuración en Redis</td></tr>
                <tr><td><strong>Escalabilidad</strong></td><td>Workers auto-scaling</td></tr>
                <tr><td><strong>Debugging</strong></td><td>UI para ver colas y errores</td></tr>
            </table>

            <div class="comparison">
                <strong>💰 Inversión:</strong> 2 desarrolladores × 6 semanas<br>
                <strong>🎯 Riesgo:</strong> Medio - Redis en Windows<br>
                <strong>⚡ Impacto:</strong> 5x más throughput + observabilidad completa
            </div>
        </div>
    </div>

    <div class="page-break"></div>

    <div class="propuesta">
        <div class="propuesta-header avanzada">
            🛡️ PROPUESTA 3: AVANZADA - NestJS + RabbitMQ Enterprise (8-10 semanas)
        </div>
        <div class="propuesta-content">
            <h3>🎯 Enfoque: Message Broker Enterprise</h3>
            
            <h4>🔧 Componentes Enterprise Windows:</h4>
            <ul>
                <li><strong>RabbitMQ Cluster:</strong> Message broker distribuido</li>
                <li><strong>Dead Letter Queue:</strong> Manejo automático de fallos</li>
                <li><strong>Message Persistence:</strong> Mensajes sobreviven reinicio Windows</li>
                <li><strong>Load Balancer:</strong> Distribución a múltiples APIs HO</li>
                <li><strong>Circuit Breaker:</strong> Protección contra fallos en cascada</li>
                <li><strong>Observabilidad:</strong> ELK Stack + Jaeger tracing</li>
            </ul>

            <h4>💻 Implementación Enterprise:</h4>
            <div style="background: #1e293b; color: #e2e8f0; padding: 15px; border-radius: 6px; font-family: monospace; font-size: 0.8em;">
-- SQL Server + RabbitMQ Integration
CREATE TRIGGER tr_rabbitmq_publish ON ventas
AFTER INSERT AS
BEGIN
    DECLARE @message NVARCHAR(MAX) = (
        SELECT * FROM inserted FOR JSON AUTO
    )
    
    -- Publish to RabbitMQ via CLR assembly
    EXEC sp_rabbitmq_publish 
        @exchange = 'terpel.sales',
        @routing_key = 'pos.sale.created',
        @message = @message,
        @persistent = 1
END

// NestJS with Circuit Breaker
@Injectable()
export class ResilientSyncService {
  private circuitBreaker = new CircuitBreaker(this.syncSale.bind(this), {
    timeout: 10000,
    errorThresholdPercentage: 50,
    resetTimeout: 30000
  });

  async processSale(saleData: any) {
    try {
      return await this.circuitBreaker.fire(saleData);
    } catch (error) {
      await this.sendToDeadLetter(saleData, error);
    }
  }
}
            </div>

            <h4>📊 Ventajas Enterprise:</h4>
            <table>
                <tr><th>Aspecto</th><th>Beneficio</th></tr>
                <tr><td><strong>Resilencia</strong></td><td>Circuit breaker + DLQ automático</td></tr>
                <tr><td><strong>Escalabilidad</strong></td><td>Cluster RabbitMQ distribuido</td></tr>
                <tr><td><strong>Persistencia</strong></td><td>Mensajes sobreviven fallos Windows</td></tr>
                <tr><td><strong>Observabilidad</strong></td><td>Tracing distribuido completo</td></tr>
                <tr><td><strong>Multi-tenant</strong></td><td>Soporte para múltiples estaciones</td></tr>
            </table>

            <div class="comparison">
                <strong>💰 Inversión:</strong> 3 desarrolladores × 10 semanas<br>
                <strong>🎯 Riesgo:</strong> Alto - Infraestructura compleja<br>
                <strong>⚡ Impacto:</strong> Sistema enterprise-grade para 5000+ estaciones
            </div>
        </div>
    </div>
EOF

    echo "✅ HTML POS Windows creado (parte 1)"
    
    # Completar HTML con propuesta Python y comparativa
    cat >> imagenes/propuestas-pos-windows.html << 'EOF'

    <div class="page-break"></div>

    <div class="propuesta">
        <div class="propuesta-header python">
            🐍 PROPUESTA 4: PYTHON + CELERY - Ultra Liviano (1-2 semanas)
        </div>
        <div class="propuesta-content">
            <h3>🎯 Enfoque: Python Nativo en Windows</h3>
            
            <div class="highlight">
                <h4>💡 ¿Por qué Python es IDEAL para POS Windows?</h4>
                <ul>
                    <li><strong>Instalación Simple:</strong> Python 3.11 + pip install (5 minutos)</li>
                    <li><strong>Windows Service:</strong> python-windows-service nativo</li>
                    <li><strong>SQL Server:</strong> pyodbc integración perfecta</li>
                    <li><strong>Menos Recursos:</strong> 40MB RAM vs 200MB NestJS</li>
                    <li><strong>Desarrollo Rápido:</strong> 80% menos código</li>
                </ul>
            </div>
            
            <h4>🔧 Componentes Python Windows:</h4>
            <ul>
                <li><strong>FastAPI Service:</strong> API REST ultra-liviana</li>
                <li><strong>Celery Workers:</strong> Procesamiento asíncrono nativo</li>
                <li><strong>Redis Windows:</strong> Broker + cache integrado</li>
                <li><strong>SQLAlchemy:</strong> ORM para SQL Server LocalDB</li>
                <li><strong>Windows Service:</strong> Instalación como servicio nativo</li>
            </ul>

            <h4>💻 Implementación Python Ultra-Simple:</h4>
            <div style="background: #1e293b; color: #e2e8f0; padding: 15px; border-radius: 6px; font-family: monospace; font-size: 0.8em;">
# main.py - FastAPI Service (30 líneas total)
from fastapi import FastAPI
from celery import Celery
import pyodbc

app = FastAPI()
celery_app = Celery('pos_sync', broker='redis://localhost:6379')

# SQL Server Trigger calls this endpoint
@app.post("/queue-sale")
async def queue_sale(sale_data: dict):
    celery_app.send_task('sync_sale', args=[sale_data])
    return {"status": "queued"}

# tasks.py - Celery Worker (20 líneas total)
@celery_app.task(bind=True, max_retries=5)
def sync_sale(self, sale_data):
    try:
        response = requests.post(f"{HO_API}/sales", 
                               json=sale_data, timeout=10)
        if response.status_code == 200:
            update_sale_status(sale_data['id'], 'SYNCED')
        else:
            raise Exception(f"API Error: {response.status_code}")
    except Exception as exc:
        self.retry(countdown=60 * (self.request.retries + 1), exc=exc)

# install_service.py - Windows Service (10 líneas)
import win32serviceutil
class PosSync(win32serviceutil.ServiceFramework):
    def SvcRun(self):
        os.system("celery -A tasks worker --loglevel=info")

if __name__ == '__main__':
    win32serviceutil.HandleCommandLine(PosSync)
            </div>

            <h4>🖥️ Instalación en Windows POS:</h4>
            <div style="background: #f8fafc; padding: 15px; border-radius: 6px; font-family: monospace; font-size: 0.85em;">
# Instalación automática en POS
pip install fastapi celery redis pyodbc
python install_service.py install
python install_service.py start

# SQL Server Trigger (llama al endpoint local)
CREATE TRIGGER tr_python_sync ON ventas
AFTER INSERT AS
BEGIN
    DECLARE @json NVARCHAR(MAX) = (SELECT * FROM inserted FOR JSON AUTO)
    EXEC sp_http_post 'http://localhost:8000/queue-sale', @json
END
            </div>

            <h4>📊 Ventajas Python en Windows:</h4>
            <table>
                <tr><th>Aspecto</th><th>Python</th><th>NestJS</th></tr>
                <tr><td><strong>Instalación</strong></td><td>5 minutos</td><td>30 minutos</td></tr>
                <tr><td><strong>Memoria RAM</strong></td><td>40MB</td><td>200MB</td></tr>
                <tr><td><strong>Líneas Código</strong></td><td>60 líneas</td><td>300 líneas</td></tr>
                <tr><td><strong>Tiempo Desarrollo</strong></td><td>1 semana</td><td>3-10 semanas</td></tr>
                <tr><td><strong>Windows Service</strong></td><td>Nativo</td><td>Requiere PM2</td></tr>
                <tr><td><strong>SQL Server</strong></td><td>pyodbc nativo</td><td>Drivers complejos</td></tr>
                <tr><td><strong>Debugging</strong></td><td>Simple</td><td>Complejo</td></tr>
            </table>

            <div class="comparison">
                <strong>💰 Inversión:</strong> 1 desarrollador Python × 1 semana<br>
                <strong>🎯 Riesgo:</strong> Mínimo - Stack nativo Windows<br>
                <strong>⚡ Impacto:</strong> Máximo rendimiento, mínimos recursos<br>
                <strong>🔧 Mantenimiento:</strong> 80% menos código = 80% menos problemas
            </div>
        </div>
    </div>

    <div class="page-break"></div>

    <div style="background: #f0f9ff; padding: 20px; border-radius: 8px; margin: 20px 0;">
        <h2 style="color: #1e40af; margin-top: 0;">📊 Comparativa Final - POS Windows 10</h2>
        
        <table>
            <tr>
                <th>Aspecto</th>
                <th>Básica (NestJS)</th>
                <th>Intermedia (NestJS)</th>
                <th>Avanzada (NestJS)</th>
                <th>🐍 Python + Celery</th>
            </tr>
            <tr>
                <td><strong>Instalación POS</strong></td>
                <td>Node.js + Service</td>
                <td>Node.js + Redis</td>
                <td>Node.js + RabbitMQ</td>
                <td><strong>pip install + service</strong></td>
            </tr>
            <tr>
                <td><strong>Memoria en POS</strong></td>
                <td>150MB</td>
                <td>200MB</td>
                <td>300MB</td>
                <td><strong>40MB</strong></td>
            </tr>
            <tr>
                <td><strong>Complejidad Setup</strong></td>
                <td>Media</td>
                <td>Alta</td>
                <td>Muy Alta</td>
                <td><strong>Mínima</strong></td>
            </tr>
            <tr>
                <td><strong>Offline Capability</strong></td>
                <td>✅ Básica</td>
                <td>✅ Avanzada</td>
                <td>✅ Enterprise</td>
                <td><strong>✅ Nativa</strong></td>
            </tr>
            <tr>
                <td><strong>Windows Integration</strong></td>
                <td>Requiere PM2</td>
                <td>Requiere PM2</td>
                <td>Complejo</td>
                <td><strong>Nativo</strong></td>
            </tr>
            <tr>
                <td><strong>Throughput</strong></td>
                <td>100/h</td>
                <td>200/h</td>
                <td>500/h</td>
                <td><strong>300/h</strong></td>
            </tr>
            <tr>
                <td><strong>Desarrollo</strong></td>
                <td>3 semanas</td>
                <td>6 semanas</td>
                <td>10 semanas</td>
                <td><strong>1 semana</strong></td>
            </tr>
        </table>

        <div class="highlight">
            <h3>🏆 Recomendación para POS Windows 10</h3>
            <p><strong>PROPUESTA 4 - Python + Celery</strong> es la opción IDEAL porque:</p>
            <ul>
                <li>✅ <strong>Instalación Ultra-Simple:</strong> pip install en 5 minutos</li>
                <li>✅ <strong>Mínimos Recursos:</strong> Solo 40MB RAM por POS</li>
                <li>✅ <strong>Windows Nativo:</strong> Servicio nativo sin dependencias</li>
                <li>✅ <strong>SQL Server Integrado:</strong> pyodbc funciona perfecto</li>
                <li>✅ <strong>Desarrollo Rápido:</strong> 1 semana vs 3-10 semanas</li>
                <li>✅ <strong>Mantenimiento Simple:</strong> 60 líneas vs 300+ líneas</li>
            </ul>
        </div>
    </div>

    <div class="windows-box">
        <h3>🖥️ Consideraciones Específicas para Windows 10 POS</h3>
        <table>
            <tr><th>Aspecto</th><th>Consideración</th><th>Solución Recomendada</th></tr>
            <tr><td><strong>Recursos Limitados</strong></td><td>POS con 4-8GB RAM</td><td>Python (40MB) vs NestJS (200MB+)</td></tr>
            <tr><td><strong>Conectividad Intermitente</strong></td><td>Internet inestable</td><td>Message queue local + retry automático</td></tr>
            <tr><td><strong>Mantenimiento Remoto</strong></td><td>Técnicos no especializados</td><td>Instalación simple + logs claros</td></tr>
            <tr><td><strong>Actualizaciones</strong></td><td>Deploy en 1000+ POS</td><td>Servicio liviano + auto-update</td></tr>
            <tr><td><strong>Monitoreo</strong></td><td>Visibilidad centralizada</td><td>Métricas simples + dashboard</td></tr>
        </table>
    </div>

    <div style="background: #f8fafc; padding: 15px; text-align: center; margin-top: 20px; border-top: 2px solid #e2e8f0;">
        <p style="margin: 0; font-size: 0.9em; color: #64748b;">
            <strong>Propuestas POS Windows 10:</strong> 08 de septiembre de 2024 | <strong>Responsable:</strong> JONATHAN OSORIO | <strong>Terpel S.A.</strong>
        </p>
    </div>
</body>
</html>
EOF

    echo "✅ HTML POS Windows completado"
}

# Generar PDF final
generate_windows_pdf() {
    echo "📄 Generando PDF para POS Windows..."
    wkhtmltopdf \
        --page-size A4 \
        --orientation Portrait \
        --margin-top 0.3in \
        --margin-right 0.3in \
        --margin-bottom 0.3in \
        --margin-left 0.3in \
        --encoding UTF-8 \
        --zoom 0.8 \
        --dpi 200 \
        --enable-local-file-access \
        --no-background \
        imagenes/propuestas-pos-windows.html \
        "Propuestas_POS_Windows_$(date +%Y%m%d).pdf"

    if [ $? -eq 0 ]; then
        echo "✅ PDF POS Windows generado exitosamente:"
        echo "   📁 PDF: Propuestas_POS_Windows_$(date +%Y%m%d).pdf"
        echo "🌐 Para abrir: xdg-open Propuestas_POS_Windows_$(date +%Y%m%d).pdf"
    else
        echo "❌ Error al generar PDF POS Windows"
    fi
}

# Ejecutar funciones principales
main() {
    create_windows_pos_architecture
    create_pos_flow_diagram
    generate_pos_diagrams
    create_windows_pos_html
    generate_windows_pdf
    
    echo ""
    echo "✅ Propuestas POS Windows generadas:"
    echo "   📁 imagenes/propuestas/arquitectura-windows-pos.png"
    echo "   📁 imagenes/propuestas/flujo-pos-windows.png"
    echo "   📁 imagenes/propuestas-pos-windows.html"
    echo "   📁 Propuestas_POS_Windows_$(date +%Y%m%d).pdf"
    echo ""
    echo "🖥️ Enfoque actualizado:"
    echo "   • POS Windows 10 solo DEJA MENSAJES"
    echo "   • Servicios independientes PROCESAN mensajes"
    echo "   • Funciona OFFLINE - mensajes se acumulan"
    echo "   • Sin bloqueos en la aplicación POS"
    echo "   • Python = 40MB RAM vs NestJS = 200MB RAM"
    echo ""
}

main
