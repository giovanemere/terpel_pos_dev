#!/bin/bash

# Análisis completo de arquitecturas para sincronización de ventas
FECHA=$(date +%Y%m%d)
DIRECTORIO_BASE="/home/giovanemere/terpel/terpel_pos_dev/reportes/ms-pos-sincronizacion-sales"
DIRECTORIO_DIAGRAMAS="$DIRECTORIO_BASE/diagramas"
ARCHIVO_HTML="$DIRECTORIO_BASE/imagenes/analisis-arquitecturas-sincronizacion.html"
ARCHIVO_PDF="$DIRECTORIO_BASE/Analisis_Arquitecturas_Sincronizacion_Ventas_$FECHA.pdf"

echo "🏗️ Generando análisis de arquitecturas para sincronización de ventas..."

# Crear diagramas de arquitectura específicos
mkdir -p "$DIRECTORIO_DIAGRAMAS"

# 1. Diagrama Node.js Optimizado
python3 << EOF
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch, Rectangle
import numpy as np

fig, ax = plt.subplots(1, 1, figsize=(16, 10))
ax.set_xlim(0, 12)
ax.set_ylim(0, 8)
ax.axis('off')

# Título
ax.text(6, 7.5, 'Arquitectura 1: Node.js Optimizado (Ajuste Mínimo)', 
        fontsize=16, fontweight='bold', ha='center')

# POS Terminal
pos_box = FancyBboxPatch((0.5, 5), 2.5, 2, boxstyle="round,pad=0.1", 
                         facecolor='#fef3c7', edgecolor='black', linewidth=2)
ax.add_patch(pos_box)
ax.text(1.75, 6, 'POS Terminal\n512MB-1GB RAM\nWindows 7/10', fontsize=10, ha='center', fontweight='bold')

# Node.js Optimizado
node_box = FancyBboxPatch((4, 5), 3, 2, boxstyle="round,pad=0.1", 
                          facecolor='#dbeafe', edgecolor='black', linewidth=2)
ax.add_patch(node_box)
ax.text(5.5, 6.3, 'Node.js MS Optimizado', fontsize=12, ha='center', fontweight='bold')
ax.text(5.5, 5.8, '• Fastify (vs Express)', fontsize=9, ha='center')
ax.text(5.5, 5.5, '• Memory limit 40MB', fontsize=9, ha='center')
ax.text(5.5, 5.2, '• Minimal dependencies', fontsize=9, ha='center')

# Cache Local
cache_box = FancyBboxPatch((8, 6), 2, 0.8, boxstyle="round,pad=0.1", 
                           facecolor='#fce7f3', edgecolor='black', linewidth=1)
ax.add_patch(cache_box)
ax.text(9, 6.4, 'Memory Cache\n5MB', fontsize=9, ha='center')

# PostgreSQL
db_box = FancyBboxPatch((8, 4.5), 2, 1.2, boxstyle="round,pad=0.1", 
                        facecolor='#dcfce7', edgecolor='black', linewidth=2)
ax.add_patch(db_box)
ax.text(9, 5.1, 'PostgreSQL\n+ Indexes', fontsize=10, ha='center', fontweight='bold')

# Queue de Sincronización
queue_box = FancyBboxPatch((4, 2.5), 3, 1.5, boxstyle="round,pad=0.1", 
                           facecolor='#fef3c7', edgecolor='black', linewidth=2)
ax.add_patch(queue_box)
ax.text(5.5, 3.5, 'Sync Queue', fontsize=11, ha='center', fontweight='bold')
ax.text(5.5, 3.1, '• Batch processing', fontsize=9, ha='center')
ax.text(5.5, 2.8, '• Retry logic', fontsize=9, ha='center')

# HO System
ho_box = FancyBboxPatch((8, 2.5), 2, 1.5, boxstyle="round,pad=0.1", 
                        facecolor='#fed7aa', edgecolor='black', linewidth=2)
ax.add_patch(ho_box)
ax.text(9, 3.2, 'Head Office\nAPI', fontsize=10, ha='center', fontweight='bold')

# Conexiones
ax.arrow(3, 6, 0.8, 0, head_width=0.1, head_length=0.1, fc='blue', ec='blue')
ax.text(3.5, 6.3, 'HTTP', fontsize=8, ha='center')

ax.arrow(7, 6, 0.8, 0, head_width=0.1, head_length=0.1, fc='green', ec='green')
ax.text(7.5, 6.3, 'SQL', fontsize=8, ha='center')

ax.arrow(5.5, 5, 0, -1.3, head_width=0.1, head_length=0.1, fc='orange', ec='orange')
ax.text(6, 4.2, 'Queue', fontsize=8, ha='center')

ax.arrow(7, 3.2, 0.8, 0, head_width=0.1, head_length=0.1, fc='red', ec='red')
ax.text(7.5, 3.5, 'Batch', fontsize=8, ha='center')

# Métricas
metrics_box = FancyBboxPatch((0.5, 0.5), 11, 1.5, boxstyle="round,pad=0.1", 
                             facecolor='#f0f9ff', edgecolor='blue', linewidth=2)
ax.add_patch(metrics_box)
ax.text(6, 1.6, 'MÉTRICAS ESPERADAS', fontsize=12, ha='center', fontweight='bold', color='blue')
ax.text(3, 1.2, 'Memoria: 40-50MB', fontsize=10, ha='center')
ax.text(6, 1.2, 'Arranque: 8-10s', fontsize=10, ha='center')
ax.text(9, 1.2, 'Cobertura: 80%', fontsize=10, ha='center')
ax.text(6, 0.8, 'Tiempo desarrollo: 1 semana | Riesgo: Muy Bajo', fontsize=10, ha='center', fontweight='bold')

plt.tight_layout()
plt.savefig('$DIRECTORIO_DIAGRAMAS/arquitectura-nodejs-optimizado.png', dpi=300, bbox_inches='tight')
plt.close()
print("✅ Diagrama Node.js optimizado generado")
EOF

# 2. Diagrama Go Microservice
python3 << EOF
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch
import numpy as np

fig, ax = plt.subplots(1, 1, figsize=(16, 10))
ax.set_xlim(0, 12)
ax.set_ylim(0, 8)
ax.axis('off')

# Título
ax.text(6, 7.5, 'Arquitectura 2: Go Microservice (Recomendada)', 
        fontsize=16, fontweight='bold', ha='center', color='green')

# POS Terminal
pos_box = FancyBboxPatch((0.5, 5), 2.5, 2, boxstyle="round,pad=0.1", 
                         facecolor='#dcfce7', edgecolor='black', linewidth=2)
ax.add_patch(pos_box)
ax.text(1.75, 6, 'POS Terminal\n512MB-1GB RAM\nWindows 7/10', fontsize=10, ha='center', fontweight='bold')

# Go Microservice
go_box = FancyBboxPatch((4, 5), 3, 2, boxstyle="round,pad=0.1", 
                        facecolor='#bfdbfe', edgecolor='green', linewidth=3)
ax.add_patch(go_box)
ax.text(5.5, 6.3, 'Go Microservice', fontsize=12, ha='center', fontweight='bold')
ax.text(5.5, 5.9, '• Single binary 8MB', fontsize=9, ha='center')
ax.text(5.5, 5.6, '• Memory: 10-15MB', fontsize=9, ha='center')
ax.text(5.5, 5.3, '• Goroutines sync', fontsize=9, ha='center')
ax.text(5.5, 5.0, '• Built-in HTTP server', fontsize=9, ha='center')

# Connection Pool
pool_box = FancyBboxPatch((8, 6), 2, 0.8, boxstyle="round,pad=0.1", 
                          facecolor='#e0e7ff', edgecolor='black', linewidth=1)
ax.add_patch(pool_box)
ax.text(9, 6.4, 'Connection Pool\n2-5 conns', fontsize=9, ha='center')

# PostgreSQL
db_box = FancyBboxPatch((8, 4.5), 2, 1.2, boxstyle="round,pad=0.1", 
                        facecolor='#dcfce7', edgecolor='black', linewidth=2)
ax.add_patch(db_box)
ax.text(9, 5.1, 'PostgreSQL\nOptimized', fontsize=10, ha='center', fontweight='bold')

# Sync Worker
worker_box = FancyBboxPatch((4, 2.5), 3, 1.5, boxstyle="round,pad=0.1", 
                            facecolor='#fef3c7', edgecolor='black', linewidth=2)
ax.add_patch(worker_box)
ax.text(5.5, 3.5, 'Sync Worker', fontsize=11, ha='center', fontweight='bold')
ax.text(5.5, 3.1, '• Concurrent goroutines', fontsize=9, ha='center')
ax.text(5.5, 2.8, '• Circuit breaker', fontsize=9, ha='center')

# HO System
ho_box = FancyBboxPatch((8, 2.5), 2, 1.5, boxstyle="round,pad=0.1", 
                        facecolor='#fed7aa', edgecolor='black', linewidth=2)
ax.add_patch(ho_box)
ax.text(9, 3.2, 'Head Office\nAPI', fontsize=10, ha='center', fontweight='bold')

# Conexiones
ax.arrow(3, 6, 0.8, 0, head_width=0.1, head_length=0.1, fc='green', ec='green', linewidth=2)
ax.text(3.5, 6.3, 'HTTP/2', fontsize=8, ha='center')

ax.arrow(7, 5.5, 0.8, 0, head_width=0.1, head_length=0.1, fc='blue', ec='blue')
ax.text(7.5, 5.8, 'pgx', fontsize=8, ha='center')

ax.arrow(5.5, 5, 0, -1.3, head_width=0.1, head_length=0.1, fc='orange', ec='orange')
ax.text(6, 4.2, 'Channel', fontsize=8, ha='center')

ax.arrow(7, 3.2, 0.8, 0, head_width=0.1, head_length=0.1, fc='red', ec='red')
ax.text(7.5, 3.5, 'gRPC', fontsize=8, ha='center')

# Métricas
metrics_box = FancyBboxPatch((0.5, 0.5), 11, 1.5, boxstyle="round,pad=0.1", 
                             facecolor='#f0fdf4', edgecolor='green', linewidth=2)
ax.add_patch(metrics_box)
ax.text(6, 1.6, 'MÉTRICAS ESPERADAS', fontsize=12, ha='center', fontweight='bold', color='green')
ax.text(3, 1.2, 'Memoria: 10-15MB', fontsize=10, ha='center')
ax.text(6, 1.2, 'Arranque: 0.5s', fontsize=10, ha='center')
ax.text(9, 1.2, 'Cobertura: 95%', fontsize=10, ha='center')
ax.text(6, 0.8, 'Tiempo desarrollo: 3 semanas | Riesgo: Bajo', fontsize=10, ha='center', fontweight='bold')

plt.tight_layout()
plt.savefig('$DIRECTORIO_DIAGRAMAS/arquitectura-go-microservice.png', dpi=300, bbox_inches='tight')
plt.close()
print("✅ Diagrama Go microservice generado")
EOF

# 3. Diagrama Python FastAPI
python3 << EOF
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch
import numpy as np

fig, ax = plt.subplots(1, 1, figsize=(16, 10))
ax.set_xlim(0, 12)
ax.set_ylim(0, 8)
ax.axis('off')

# Título
ax.text(6, 7.5, 'Arquitectura 3: Python FastAPI + AsyncIO', 
        fontsize=16, fontweight='bold', ha='center', color='purple')

# POS Terminal
pos_box = FancyBboxPatch((0.5, 5), 2.5, 2, boxstyle="round,pad=0.1", 
                         facecolor='#fef3c7', edgecolor='black', linewidth=2)
ax.add_patch(pos_box)
ax.text(1.75, 6, 'POS Terminal\n512MB-1GB RAM\nWindows 7/10', fontsize=10, ha='center', fontweight='bold')

# Python FastAPI
python_box = FancyBboxPatch((4, 5), 3, 2, boxstyle="round,pad=0.1", 
                            facecolor='#e0e7ff', edgecolor='purple', linewidth=2)
ax.add_patch(python_box)
ax.text(5.5, 6.3, 'FastAPI + Uvicorn', fontsize=12, ha='center', fontweight='bold')
ax.text(5.5, 5.9, '• Async/await native', fontsize=9, ha='center')
ax.text(5.5, 5.6, '• Pydantic validation', fontsize=9, ha='center')
ax.text(5.5, 5.3, '• Memory: 30-50MB', fontsize=9, ha='center')
ax.text(5.5, 5.0, '• Auto OpenAPI docs', fontsize=9, ha='center')

# Redis Cache
redis_box = FancyBboxPatch((8, 6), 2, 0.8, boxstyle="round,pad=0.1", 
                           facecolor='#fecaca', edgecolor='black', linewidth=1)
ax.add_patch(redis_box)
ax.text(9, 6.4, 'Redis Cache\n10MB', fontsize=9, ha='center')

# PostgreSQL + SQLAlchemy
db_box = FancyBboxPatch((8, 4.5), 2, 1.2, boxstyle="round,pad=0.1", 
                        facecolor='#dcfce7', edgecolor='black', linewidth=2)
ax.add_patch(db_box)
ax.text(9, 5.1, 'PostgreSQL\n+ SQLAlchemy', fontsize=10, ha='center', fontweight='bold')

# Celery Worker
celery_box = FancyBboxPatch((4, 2.5), 3, 1.5, boxstyle="round,pad=0.1", 
                            facecolor='#fef3c7', edgecolor='black', linewidth=2)
ax.add_patch(celery_box)
ax.text(5.5, 3.5, 'Celery Worker', fontsize=11, ha='center', fontweight='bold')
ax.text(5.5, 3.1, '• Background tasks', fontsize=9, ha='center')
ax.text(5.5, 2.8, '• Retry with backoff', fontsize=9, ha='center')

# Message Broker
broker_box = FancyBboxPatch((8, 2.5), 2, 1.5, boxstyle="round,pad=0.1", 
                            facecolor='#fed7aa', edgecolor='black', linewidth=2)
ax.add_patch(broker_box)
ax.text(9, 3.2, 'Redis Broker\n+ HO API', fontsize=10, ha='center', fontweight='bold')

# Conexiones
ax.arrow(3, 6, 0.8, 0, head_width=0.1, head_length=0.1, fc='purple', ec='purple')
ax.text(3.5, 6.3, 'HTTP', fontsize=8, ha='center')

ax.arrow(7, 5.5, 0.8, 0, head_width=0.1, head_length=0.1, fc='blue', ec='blue')
ax.text(7.5, 5.8, 'asyncpg', fontsize=8, ha='center')

ax.arrow(5.5, 5, 0, -1.3, head_width=0.1, head_length=0.1, fc='orange', ec='orange')
ax.text(6, 4.2, 'Queue', fontsize=8, ha='center')

ax.arrow(7, 3.2, 0.8, 0, head_width=0.1, head_length=0.1, fc='red', ec='red')
ax.text(7.5, 3.5, 'HTTP', fontsize=8, ha='center')

# Métricas
metrics_box = FancyBboxPatch((0.5, 0.5), 11, 1.5, boxstyle="round,pad=0.1", 
                             facecolor='#faf5ff', edgecolor='purple', linewidth=2)
ax.add_patch(metrics_box)
ax.text(6, 1.6, 'MÉTRICAS ESPERADAS', fontsize=12, ha='center', fontweight='bold', color='purple')
ax.text(3, 1.2, 'Memoria: 30-50MB', fontsize=10, ha='center')
ax.text(6, 1.2, 'Arranque: 2-3s', fontsize=10, ha='center')
ax.text(9, 1.2, 'Cobertura: 85%', fontsize=10, ha='center')
ax.text(6, 0.8, 'Tiempo desarrollo: 4 semanas | Riesgo: Medio', fontsize=10, ha='center', fontweight='bold')

plt.tight_layout()
plt.savefig('$DIRECTORIO_DIAGRAMAS/arquitectura-python-fastapi.png', dpi=300, bbox_inches='tight')
plt.close()
print("✅ Diagrama Python FastAPI generado")
EOF

# 4. Diagrama Rust Actix-Web
python3 << EOF
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch
import numpy as np

fig, ax = plt.subplots(1, 1, figsize=(16, 10))
ax.set_xlim(0, 12)
ax.set_ylim(0, 8)
ax.axis('off')

# Título
ax.text(6, 7.5, 'Arquitectura 4: Rust Actix-Web (Máximo Performance)', 
        fontsize=16, fontweight='bold', ha='center', color='#b45309')

# POS Terminal
pos_box = FancyBboxPatch((0.5, 5), 2.5, 2, boxstyle="round,pad=0.1", 
                         facecolor='#dcfce7', edgecolor='black', linewidth=2)
ax.add_patch(pos_box)
ax.text(1.75, 6, 'POS Terminal\n512MB-1GB RAM\nWindows 7/10', fontsize=10, ha='center', fontweight='bold')

# Rust Actix-Web
rust_box = FancyBboxPatch((4, 5), 3, 2, boxstyle="round,pad=0.1", 
                          facecolor='#fed7aa', edgecolor='#b45309', linewidth=3)
ax.add_patch(rust_box)
ax.text(5.5, 6.3, 'Rust Actix-Web', fontsize=12, ha='center', fontweight='bold')
ax.text(5.5, 5.9, '• Zero-cost abstractions', fontsize=9, ha='center')
ax.text(5.5, 5.6, '• Memory: 5-10MB', fontsize=9, ha='center')
ax.text(5.5, 5.3, '• Tokio async runtime', fontsize=9, ha='center')
ax.text(5.5, 5.0, '• Memory-safe', fontsize=9, ha='center')

# Connection Pool
pool_box = FancyBboxPatch((8, 6), 2, 0.8, boxstyle="round,pad=0.1", 
                          facecolor='#fef3c7', edgecolor='black', linewidth=1)
ax.add_patch(pool_box)
ax.text(9, 6.4, 'SQLx Pool\nAsync', fontsize=9, ha='center')

# PostgreSQL
db_box = FancyBboxPatch((8, 4.5), 2, 1.2, boxstyle="round,pad=0.1", 
                        facecolor='#dcfce7', edgecolor='black', linewidth=2)
ax.add_patch(db_box)
ax.text(9, 5.1, 'PostgreSQL\nNative', fontsize=10, ha='center', fontweight='bold')

# Async Worker
worker_box = FancyBboxPatch((4, 2.5), 3, 1.5, boxstyle="round,pad=0.1", 
                            facecolor='#fef3c7', edgecolor='black', linewidth=2)
ax.add_patch(worker_box)
ax.text(5.5, 3.5, 'Async Worker', fontsize=11, ha='center', fontweight='bold')
ax.text(5.5, 3.1, '• Tokio tasks', fontsize=9, ha='center')
ax.text(5.5, 2.8, '• Zero-copy serialization', fontsize=9, ha='center')

# HO System
ho_box = FancyBboxPatch((8, 2.5), 2, 1.5, boxstyle="round,pad=0.1", 
                        facecolor='#fed7aa', edgecolor='black', linewidth=2)
ax.add_patch(ho_box)
ax.text(9, 3.2, 'Head Office\nAPI', fontsize=10, ha='center', fontweight='bold')

# Conexiones
ax.arrow(3, 6, 0.8, 0, head_width=0.1, head_length=0.1, fc='#b45309', ec='#b45309', linewidth=2)
ax.text(3.5, 6.3, 'HTTP/2', fontsize=8, ha='center')

ax.arrow(7, 5.5, 0.8, 0, head_width=0.1, head_length=0.1, fc='blue', ec='blue')
ax.text(7.5, 5.8, 'SQLx', fontsize=8, ha='center')

ax.arrow(5.5, 5, 0, -1.3, head_width=0.1, head_length=0.1, fc='orange', ec='orange')
ax.text(6, 4.2, 'Channel', fontsize=8, ha='center')

ax.arrow(7, 3.2, 0.8, 0, head_width=0.1, head_length=0.1, fc='red', ec='red')
ax.text(7.5, 3.5, 'Reqwest', fontsize=8, ha='center')

# Métricas
metrics_box = FancyBboxPatch((0.5, 0.5), 11, 1.5, boxstyle="round,pad=0.1", 
                             facecolor='#fefbf3', edgecolor='#b45309', linewidth=2)
ax.add_patch(metrics_box)
ax.text(6, 1.6, 'MÉTRICAS ESPERADAS', fontsize=12, ha='center', fontweight='bold', color='#b45309')
ax.text(3, 1.2, 'Memoria: 5-10MB', fontsize=10, ha='center')
ax.text(6, 1.2, 'Arranque: 0.2s', fontsize=10, ha='center')
ax.text(9, 1.2, 'Cobertura: 90%', fontsize=10, ha='center')
ax.text(6, 0.8, 'Tiempo desarrollo: 5 semanas | Riesgo: Alto', fontsize=10, ha='center', fontweight='bold')

plt.tight_layout()
plt.savefig('$DIRECTORIO_DIAGRAMAS/arquitectura-rust-actix.png', dpi=300, bbox_inches='tight')
plt.close()
print("✅ Diagrama Rust Actix-Web generado")
EOF

echo "✅ Todos los diagramas de arquitectura generados"
