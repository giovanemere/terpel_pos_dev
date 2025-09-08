#!/bin/bash

# Generar reporte final completo con todas las recomendaciones
FECHA=$(date +%Y%m%d)
DIRECTORIO_BASE="/home/giovanemere/terpel/terpel_pos_dev/reportes/ms-pos-sincronizacion-sales"
ARCHIVO_HTML="$DIRECTORIO_BASE/imagenes/reporte-final-todas-recomendaciones.html"
ARCHIVO_PDF="$DIRECTORIO_BASE/Reporte_Final_Todas_Recomendaciones_$FECHA.pdf"

echo "📊 Generando reporte final con TODAS las recomendaciones..."

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
    <title>Reporte Final - Todas las Recomendaciones MS POS Sincronización</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; line-height: 1.6; }
        .header { background: linear-gradient(135deg, #1e40af, #3b82f6); color: white; padding: 30px; text-align: center; }
        .section { margin: 30px 0; padding: 20px; border-left: 4px solid #3b82f6; }
        .recomendada { border-left: 4px solid #16a34a; background: #f0fdf4; }
        .problema { background: #fecaca; padding: 15px; margin: 10px 0; border-radius: 5px; }
        .solucion { background: #dcfce7; padding: 15px; margin: 10px 0; border-radius: 5px; }
        .arquitectura { background: #f8fafc; padding: 20px; margin: 15px 0; border-radius: 8px; border: 2px solid #e2e8f0; }
        .diagram { text-align: center; margin: 20px 0; }
        .diagram img { max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 8px; }
        .codigo { background: #1e293b; color: #e2e8f0; padding: 15px; border-radius: 5px; font-family: monospace; font-size: 10px; overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; margin: 15px 0; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; font-weight: bold; }
        .memoria-critica { background: #fecaca; }
        .memoria-aceptable { background: #fed7aa; }
        .memoria-optima { background: #bbf7d0; }
        .riesgo-alto { background: #fecaca; }
        .riesgo-medio { background: #fed7aa; }
        .riesgo-bajo { background: #bbf7d0; }
        .page-break { page-break-before: always; }
        .toc { background: #f8fafc; padding: 20px; margin: 20px 0; border-radius: 8px; }
        .toc ol { margin: 0; padding-left: 20px; }
        .toc li { margin: 5px 0; }
    </style>
</head>
<body>
    <div class="header">
        <h1>📊 Reporte Final Completo</h1>
        <h2>MS POS Sincronización de Ventas</h2>
        <p>Análisis exhaustivo de todas las arquitecturas y recomendaciones finales</p>
        <p><strong>Fecha:</strong> $(date +"%d de %B de %Y")</p>
    </div>

    <div class="toc">
        <h2>📋 Índice de Contenidos</h2>
        <ol>
            <li><a href="#problema">Problema Crítico Identificado</a></li>
            <li><a href="#arquitecturas">Análisis de 4 Arquitecturas</a>
                <ul>
                    <li>Node.js Optimizado (Corregido)</li>
                    <li>Go Microservice (Recomendada)</li>
                    <li>Python FastAPI</li>
                    <li>Rust Actix-Web</li>
                </ul>
            </li>
            <li><a href="#comparativa">Comparativa Final</a></li>
            <li><a href="#recomendacion">Recomendación Final</a></li>
            <li><a href="#implementacion">Plan de Implementación</a></li>
            <li><a href="#roi">Análisis de ROI</a></li>
        </ol>
    </div>

    <div class="section" id="problema">
        <h2>⚠️ Problema Crítico Identificado</h2>
        
        <div class="problema">
            <h3>Situación Actual:</h3>
            <ul>
                <li><strong>Microservicio Node.js consume 150MB+ RAM</strong></li>
                <li><strong>POS con 512MB-1GB total disponible</strong></li>
                <li><strong>Windows + apps legacy consumen 400-600MB</strong></li>
                <li><strong>Disponible para nuestro MS: 50-200MB máximo</strong></li>
            </ul>
        </div>

        <div class="problema">
            <h3>Problema Adicional Detectado:</h3>
            <p><strong>Queue en memoria = Pérdida de datos al reiniciar POS</strong></p>
            <ul>
                <li>Reinicio por actualizaciones Windows</li>
                <li>Cortes de luz frecuentes</li>
                <li>Crashes del sistema POS</li>
                <li>Bloqueos que requieren restart</li>
            </ul>
        </div>

        <div class="solucion">
            <h3>Requisitos Críticos:</h3>
            <ul>
                <li><strong>Memoria:</strong> < 50MB para 90%+ cobertura POS</li>
                <li><strong>Persistencia:</strong> Cero pérdida de datos</li>
                <li><strong>Recovery:</strong> Automático al reiniciar</li>
                <li><strong>Performance:</strong> 1000+ ventas/hora</li>
                <li><strong>Confiabilidad:</strong> 99.9% uptime</li>
            </ul>
        </div>
    </div>

    <div class="section" id="arquitecturas">
        <h2>🏗️ Análisis de 4 Arquitecturas</h2>

        <div class="arquitectura">
            <h3>🔧 Arquitectura 1: Node.js Optimizado (Corregido)</h3>
            <div class="diagram">
                <img src="data:image/png;base64,$DIAGRAMA_NODEJS" alt="Node.js Optimizado">
            </div>
            
            <h4>Implementación Corregida (Sin pérdida de datos):</h4>
            <div class="codigo">
// Versión corregida con persistencia en BD
const fastify = require('fastify')({ logger: false });
const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  max: 3, // Mínimas conexiones
  idleTimeoutMillis: 30000
});

// Tabla persistente para queue
async function initDatabase() {
  await pool.query(\`
    CREATE TABLE IF NOT EXISTS sales (
      id SERIAL PRIMARY KEY,
      pos_id VARCHAR(50) NOT NULL,
      items JSONB NOT NULL,
      total DECIMAL(10,2) NOT NULL,
      status VARCHAR(20) DEFAULT 'pending',
      created_at TIMESTAMP DEFAULT NOW(),
      synced_at TIMESTAMP NULL,
      retry_count INTEGER DEFAULT 0
    );
    CREATE INDEX IF NOT EXISTS idx_sales_status ON sales(status);
  \`);
}

fastify.post('/sales', async (request, reply) => {
  const { pos_id, items, total } = request.body;
  
  try {
    // Insertar directamente como 'pending' (persistente)
    const result = await pool.query(
      'INSERT INTO sales (pos_id, items, total) VALUES (\$1, \$2, \$3) RETURNING id',
      [pos_id, JSON.stringify(items), total]
    );
    
    // Disparar procesamiento asíncrono
    setImmediate(processPendingSales);
    
    return { success: true, id: result.rows[0].id };
  } catch (error) {
    return reply.code(500).send({ error: 'Database error' });
  }
});

// Recovery automático al reiniciar
async function recoverPendingSales() {
  // Cambiar 'processing' → 'pending' (crash recovery)
  await pool.query("UPDATE sales SET status = 'pending' WHERE status = 'processing'");
  processPendingSales();
}
            </div>

            <table>
                <tr><th>Aspecto</th><th>Valor</th><th>Evaluación</th></tr>
                <tr><td>Memoria</td><td>45-55MB</td><td class="memoria-aceptable">Aceptable</td></tr>
                <tr><td>Tiempo desarrollo</td><td>1-2 semanas</td><td class="riesgo-bajo">Muy Bajo</td></tr>
                <tr><td>Pérdida de datos</td><td>NO</td><td class="riesgo-bajo">Resuelto</td></tr>
                <tr><td>Cobertura POS</td><td>85%</td><td class="memoria-aceptable">Buena</td></tr>
                <tr><td>Riesgo</td><td>Bajo</td><td class="riesgo-bajo">Controlado</td></tr>
            </table>
        </div>

        <div class="page-break"></div>

        <div class="arquitectura recomendada">
            <h3>🚀 Arquitectura 2: Go Microservice (RECOMENDADA)</h3>
            <div class="diagram">
                <img src="data:image/png;base64,$DIAGRAMA_GO" alt="Go Microservice">
            </div>
            
            <h4>Implementación Go con Persistencia Nativa:</h4>
            <div class="codigo">
package main

import (
    "database/sql"
    "encoding/json"
    "log"
    "net/http"
    "sync"
    "time"
    _ "github.com/lib/pq"
)

type SyncService struct {
    db    *sql.DB
    queue chan Sale
    wg    sync.WaitGroup
}

func main() {
    db, _ := sql.Open("postgres", os.Getenv("DATABASE_URL"))
    db.SetMaxOpenConns(3)
    db.SetMaxIdleConns(1)
    
    syncService := &SyncService{
        db:    db,
        queue: make(chan Sale, 500),
    }
    
    // Recovery automático
    syncService.recoverPendingSales()
    
    // Workers de sincronización
    for i := 0; i < 2; i++ {
        go syncService.syncWorker()
    }
    
    http.HandleFunc("/sales", syncService.handleSales)
    http.HandleFunc("/health", syncService.healthCheck)
    
    log.Fatal(http.ListenAndServe(":3000", nil))
}

func (s *SyncService) handleSales(w http.ResponseWriter, r *http.Request) {
    var sale Sale
    json.NewDecoder(r.Body).Decode(&sale)
    
    // Insertar en BD (persistente)
    err := s.db.QueryRow(
        "INSERT INTO sales (pos_id, items, total, status) VALUES (\$1, \$2, \$3, 'pending') RETURNING id",
        sale.PosID, sale.Items, sale.Total,
    ).Scan(&sale.ID)
    
    if err != nil {
        http.Error(w, "Database error", 500)
        return
    }
    
    // Enviar a queue (non-blocking)
    select {
    case s.queue <- sale:
    default:
        log.Println("Queue full, will process from DB")
    }
    
    json.NewEncoder(w).Encode(map[string]interface{}{
        "success": true,
        "id":      sale.ID,
    })
}

func (s *SyncService) recoverPendingSales() {
    // Recovery automático de ventas pendientes
    s.db.Exec("UPDATE sales SET status = 'pending' WHERE status = 'processing'")
    
    rows, _ := s.db.Query("SELECT id, pos_id, items, total FROM sales WHERE status = 'pending' LIMIT 100")
    defer rows.Close()
    
    for rows.Next() {
        var sale Sale
        rows.Scan(&sale.ID, &sale.PosID, &sale.Items, &sale.Total)
        
        select {
        case s.queue <- sale:
        default:
            break // Queue llena, se procesará después
        }
    }
}
            </div>

            <table>
                <tr><th>Aspecto</th><th>Valor</th><th>Evaluación</th></tr>
                <tr><td>Memoria</td><td>10-15MB</td><td class="memoria-optima">Excelente</td></tr>
                <tr><td>Tiempo desarrollo</td><td>3 semanas</td><td class="riesgo-bajo">Bajo</td></tr>
                <tr><td>Pérdida de datos</td><td>NO</td><td class="riesgo-bajo">Garantizado</td></tr>
                <tr><td>Cobertura POS</td><td>95%</td><td class="memoria-optima">Excelente</td></tr>
                <tr><td>Riesgo</td><td>Bajo</td><td class="riesgo-bajo">Controlado</td></tr>
            </table>
        </div>
EOF

echo "Parte 1 creada, continuando con parte 2..."
