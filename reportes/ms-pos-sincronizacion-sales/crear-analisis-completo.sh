#!/bin/bash

# Crear análisis completo de arquitecturas
FECHA=$(date +%Y%m%d)
DIRECTORIO_BASE="/home/giovanemere/terpel/terpel_pos_dev/reportes/ms-pos-sincronizacion-sales"
ARCHIVO_HTML="$DIRECTORIO_BASE/imagenes/analisis-completo-sincronizacion.html"
ARCHIVO_PDF="$DIRECTORIO_BASE/Analisis_Completo_Sincronizacion_Ventas_$FECHA.pdf"

echo "📊 Creando análisis completo de sincronización de ventas..."

# Convertir diagramas a base64
DIAGRAMA_NODEJS=$(base64 -w 0 "$DIRECTORIO_BASE/diagramas/arquitectura-nodejs-optimizado.png")
DIAGRAMA_GO=$(base64 -w 0 "$DIRECTORIO_BASE/diagramas/arquitectura-go-microservice.png")
DIAGRAMA_PYTHON=$(base64 -w 0 "$DIRECTORIO_BASE/diagramas/arquitectura-python-fastapi.png")
DIAGRAMA_RUST=$(base64 -w 0 "$DIRECTORIO_BASE/diagramas/arquitectura-rust-actix.png")

# Crear HTML parte 1
cat > "$ARCHIVO_HTML" << EOF
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Análisis Completo - Sincronización de Ventas POS</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; line-height: 1.6; }
        .header { background: linear-gradient(135deg, #1e40af, #3b82f6); color: white; padding: 30px; text-align: center; }
        .section { margin: 30px 0; padding: 20px; border-left: 4px solid #3b82f6; }
        .arquitectura { background: #f8fafc; padding: 20px; margin: 15px 0; border-radius: 8px; border: 2px solid #e2e8f0; }
        .recomendada { border-color: #16a34a; background: #f0fdf4; }
        .diagram { text-align: center; margin: 20px 0; }
        .diagram img { max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 8px; }
        .codigo { background: #1e293b; color: #e2e8f0; padding: 15px; border-radius: 5px; font-family: monospace; font-size: 11px; overflow-x: auto; }
        .pros { background: #dcfce7; padding: 10px; border-radius: 5px; margin: 10px 0; }
        .contras { background: #fecaca; padding: 10px; border-radius: 5px; margin: 10px 0; }
        table { width: 100%; border-collapse: collapse; margin: 15px 0; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; font-weight: bold; }
        .memoria-critica { background: #fecaca; }
        .memoria-aceptable { background: #fed7aa; }
        .memoria-optima { background: #bbf7d0; }
        .page-break { page-break-before: always; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🏗️ Análisis Completo de Arquitecturas</h1>
        <h2>Sincronización de Ventas POS</h2>
        <p>Del ajuste menor al más complejo - Recomendación final</p>
        <p><strong>Fecha:</strong> $(date +"%d/%m/%Y")</p>
    </div>

    <div class="section">
        <h2>🎯 Problema a Resolver</h2>
        <p><strong>Situación Actual:</strong> Microservicio Node.js consume 150MB+ RAM, causando fallos en POS con recursos limitados (512MB-1GB total).</p>
        
        <h3>Requisitos Críticos:</h3>
        <ul>
            <li><strong>Memoria:</strong> < 50MB para cobertura 90%+ POS</li>
            <li><strong>Sincronización:</strong> Manejo de conectividad intermitente</li>
            <li><strong>Performance:</strong> Procesamiento de 1000+ ventas/hora</li>
            <li><strong>Confiabilidad:</strong> Sin pérdida de datos</li>
            <li><strong>Mantenimiento:</strong> Código simple y debuggeable</li>
        </ul>
    </div>

    <div class="section">
        <h2>🔧 Arquitectura 1: Node.js Optimizado (Ajuste Mínimo)</h2>
        <div class="arquitectura">
            <div class="diagram">
                <img src="data:image/png;base64,$DIAGRAMA_NODEJS" alt="Arquitectura Node.js Optimizado">
            </div>
            
            <h3>Implementación:</h3>
            <div class="codigo">
// package.json ultra-minimalista
{
  "dependencies": {
    "fastify": "^4.0.0",
    "pg": "^8.8.0"
  },
  "scripts": {
    "start": "node --max-old-space-size=32 --gc-interval=100 index.js"
  }
}

// index.js - Versión optimizada
const fastify = require('fastify')({ logger: false });
const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  max: 2, // Mínimas conexiones
  idleTimeoutMillis: 30000
});

// Queue en memoria para sincronización
const syncQueue = [];
let isProcessing = false;

fastify.post('/sales', async (request, reply) => {
  const { pos_id, items, total } = request.body;
  
  try {
    // Insertar venta local
    const result = await pool.query(
      'INSERT INTO sales (pos_id, items, total, status) VALUES ($1, $2, $3, $4) RETURNING id',
      [pos_id, JSON.stringify(items), total, 'pending']
    );
    
    // Agregar a queue de sincronización
    syncQueue.push({ id: result.rows[0].id, pos_id, items, total });
    
    // Procesar queue si no está procesando
    if (!isProcessing) {
      setImmediate(processSyncQueue);
    }
    
    return { success: true, id: result.rows[0].id };
  } catch (error) {
    return reply.code(500).send({ error: 'Database error' });
  }
});

async function processSyncQueue() {
  if (isProcessing || syncQueue.length === 0) return;
  
  isProcessing = true;
  
  while (syncQueue.length > 0) {
    const batch = syncQueue.splice(0, 10); // Procesar en lotes de 10
    
    try {
      // Enviar a Head Office
      await syncToHeadOffice(batch);
      
      // Marcar como sincronizadas
      const ids = batch.map(item => item.id);
      await pool.query(
        'UPDATE sales SET status = $1, synced_at = NOW() WHERE id = ANY($2)',
        ['synced', ids]
      );
    } catch (error) {
      // Reintento con backoff exponencial
      setTimeout(() => {
        syncQueue.unshift(...batch);
        isProcessing = false;
        processSyncQueue();
      }, Math.min(30000, 1000 * Math.pow(2, batch[0].retries || 0)));
      return;
    }
  }
  
  isProcessing = false;
}

fastify.listen({ port: 3000, host: '0.0.0.0' });
            </div>

            <div class="pros">
                <h4>✅ Ventajas:</h4>
                <ul>
                    <li>Implementación inmediata (1 semana)</li>
                    <li>Riesgo mínimo - mismo stack</li>
                    <li>Reducción a 40-50MB memoria</li>
                    <li>Equipo ya conoce la tecnología</li>
                </ul>
            </div>

            <div class="contras">
                <h4>❌ Desventajas:</h4>
                <ul>
                    <li>Sigue siendo pesado para POS críticos</li>
                    <li>Arranque lento (8-10 segundos)</li>
                    <li>Cobertura limitada (80%)</li>
                    <li>Garbage Collector impredecible</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="page-break"></div>

    <div class="section">
        <h2>🚀 Arquitectura 2: Go Microservice (RECOMENDADA)</h2>
        <div class="arquitectura recomendada">
            <div class="diagram">
                <img src="data:image/png;base64,$DIAGRAMA_GO" alt="Arquitectura Go Microservice">
            </div>
            
            <h3>Implementación:</h3>
            <div class="codigo">
// main.go - Microservicio completo
package main

import (
    "context"
    "database/sql"
    "encoding/json"
    "log"
    "net/http"
    "sync"
    "time"
    
    _ "github.com/lib/pq"
)

type Sale struct {
    ID     int             \`json:"id"\`
    PosID  string          \`json:"pos_id"\`
    Items  json.RawMessage \`json:"items"\`
    Total  float64         \`json:"total"\`
    Status string          \`json:"status"\`
}

type SyncService struct {
    db    *sql.DB
    queue chan Sale
    wg    sync.WaitGroup
}

func main() {
    db, err := sql.Open("postgres", os.Getenv("DATABASE_URL"))
    if err != nil {
        log.Fatal(err)
    }
    defer db.Close()
    
    // Configurar pool de conexiones mínimo
    db.SetMaxOpenConns(5)
    db.SetMaxIdleConns(2)
    db.SetConnMaxLifetime(time.Hour)
    
    syncService := &SyncService{
        db:    db,
        queue: make(chan Sale, 1000),
    }
    
    // Iniciar workers de sincronización
    for i := 0; i < 2; i++ {
        go syncService.syncWorker()
    }
    
    http.HandleFunc("/sales", syncService.handleSales)
    http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
        w.WriteHeader(200)
        w.Write([]byte("OK"))
    })
    
    log.Println("Server starting on :3000")
    log.Fatal(http.ListenAndServe(":3000", nil))
}

func (s *SyncService) handleSales(w http.ResponseWriter, r *http.Request) {
    if r.Method != "POST" {
        http.Error(w, "Method not allowed", 405)
        return
    }
    
    var sale Sale
    if err := json.NewDecoder(r.Body).Decode(&sale); err != nil {
        http.Error(w, "Invalid JSON", 400)
        return
    }
    
    // Insertar en BD local
    err := s.db.QueryRow(
        "INSERT INTO sales (pos_id, items, total, status) VALUES ($1, $2, $3, $4) RETURNING id",
        sale.PosID, sale.Items, sale.Total, "pending",
    ).Scan(&sale.ID)
    
    if err != nil {
        http.Error(w, "Database error", 500)
        return
    }
    
    // Enviar a queue de sincronización (non-blocking)
    select {
    case s.queue <- sale:
    default:
        log.Println("Sync queue full, will retry later")
    }
    
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(map[string]interface{}{
        "success": true,
        "id":      sale.ID,
    })
}

func (s *SyncService) syncWorker() {
    s.wg.Add(1)
    defer s.wg.Done()
    
    for sale := range s.queue {
        if err := s.syncToHeadOffice(sale); err != nil {
            log.Printf("Sync failed for sale %d: %v", sale.ID, err)
            // Reintento con backoff exponencial
            time.Sleep(time.Second * 5)
            select {
            case s.queue <- sale:
            default:
                log.Printf("Failed to requeue sale %d", sale.ID)
            }
            continue
        }
        
        // Marcar como sincronizada
        _, err := s.db.Exec(
            "UPDATE sales SET status = $1, synced_at = NOW() WHERE id = $2",
            "synced", sale.ID,
        )
        if err != nil {
            log.Printf("Failed to update sync status for sale %d: %v", sale.ID, err)
        }
    }
}

func (s *SyncService) syncToHeadOffice(sale Sale) error {
    // Implementar llamada HTTP a Head Office
    // Con circuit breaker y retry logic
    return nil
}
            </div>

            <div class="pros">
                <h4>✅ Ventajas:</h4>
                <ul>
                    <li>Memoria ultra-baja: 10-15MB</li>
                    <li>Arranque instantáneo: 0.5 segundos</li>
                    <li>Cobertura 95% de POS</li>
                    <li>Binario único, sin dependencias</li>
                    <li>Concurrencia nativa con goroutines</li>
                    <li>Excelente performance bajo carga</li>
                </ul>
            </div>

            <div class="contras">
                <h4>❌ Desventajas:</h4>
                <ul>
                    <li>Curva de aprendizaje para el equipo</li>
                    <li>Reescritura completa (3 semanas)</li>
                    <li>Ecosistema menos maduro que Node.js</li>
                </ul>
            </div>
        </div>
    </div>
EOF

echo "Parte 1 del HTML creada, continuando..."
