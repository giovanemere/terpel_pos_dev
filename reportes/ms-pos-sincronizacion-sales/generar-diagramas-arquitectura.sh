#!/bin/bash

# Generar diagramas de arquitectura para todas las propuestas
DIRECTORIO_BASE="/home/giovanemere/terpel/terpel_pos_dev/reportes/ms-pos-sincronizacion-sales"
DIRECTORIO_DIAGRAMAS="$DIRECTORIO_BASE/diagramas"

echo "🎨 Generando diagramas de arquitectura..."

# Crear directorio si no existe
mkdir -p "$DIRECTORIO_DIAGRAMAS"

# 1. Diagrama Arquitectura Actual
cat > "$DIRECTORIO_DIAGRAMAS/arquitectura-actual.py" << 'EOF'
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch
import numpy as np

fig, ax = plt.subplots(1, 1, figsize=(14, 10))
ax.set_xlim(0, 10)
ax.set_ylim(0, 8)
ax.axis('off')

# Título
ax.text(5, 7.5, 'Arquitectura Actual - MS POS Sincronización Sales', 
        fontsize=16, fontweight='bold', ha='center')

# POS Terminal
pos_box = FancyBboxPatch((0.5, 5.5), 2, 1.5, boxstyle="round,pad=0.1", 
                         facecolor='#ffcccb', edgecolor='black', linewidth=2)
ax.add_patch(pos_box)
ax.text(1.5, 6.2, 'POS Terminal\n(Windows)', fontsize=10, ha='center', fontweight='bold')

# Microservicio
ms_box = FancyBboxPatch((4, 5.5), 2.5, 1.5, boxstyle="round,pad=0.1", 
                        facecolor='#add8e6', edgecolor='black', linewidth=2)
ax.add_patch(ms_box)
ax.text(5.25, 6.2, 'MS Sync Sales\n(Node.js + NestJS)', fontsize=10, ha='center', fontweight='bold')

# Base de Datos
db_box = FancyBboxPatch((7.5, 5.5), 2, 1.5, boxstyle="round,pad=0.1", 
                        facecolor='#90ee90', edgecolor='black', linewidth=2)
ax.add_patch(db_box)
ax.text(8.5, 6.2, 'PostgreSQL\nDatabase', fontsize=10, ha='center', fontweight='bold')

# HO System
ho_box = FancyBboxPatch((4, 3), 2.5, 1.5, boxstyle="round,pad=0.1", 
                        facecolor='#ffd700', edgecolor='black', linewidth=2)
ax.add_patch(ho_box)
ax.text(5.25, 3.7, 'Head Office\nSystem', fontsize=10, ha='center', fontweight='bold')

# Conexiones
ax.arrow(2.5, 6.2, 1.3, 0, head_width=0.1, head_length=0.1, fc='red', ec='red')
ax.text(3.2, 6.5, 'HTTP/REST', fontsize=8, ha='center')

ax.arrow(6.5, 6.2, 0.8, 0, head_width=0.1, head_length=0.1, fc='blue', ec='blue')
ax.text(7, 6.5, 'SQL', fontsize=8, ha='center')

ax.arrow(5.25, 5.5, 0, -0.8, head_width=0.1, head_length=0.1, fc='green', ec='green')
ax.text(5.7, 4.7, 'Sync', fontsize=8, ha='center')

# Problemas identificados
problems_box = FancyBboxPatch((0.5, 0.5), 9, 1.5, boxstyle="round,pad=0.1", 
                              facecolor='#ffe4e1', edgecolor='red', linewidth=2)
ax.add_patch(problems_box)
ax.text(5, 1.6, 'PROBLEMAS IDENTIFICADOS', fontsize=12, ha='center', fontweight='bold', color='red')
ax.text(5, 1.2, '• Performance limitada en POS con pocos recursos', fontsize=10, ha='center')
ax.text(5, 0.9, '• Dependencia de conectividad constante', fontsize=10, ha='center')
ax.text(5, 0.6, '• Alto consumo de memoria (150MB+)', fontsize=10, ha='center')

plt.tight_layout()
plt.savefig('$DIRECTORIO_DIAGRAMAS/arquitectura-actual.png', dpi=300, bbox_inches='tight')
plt.close()
EOF

# 2. Diagrama Recursos Limitados
cat > "$DIRECTORIO_DIAGRAMAS/arquitectura-recursos-limitados.py" << 'EOF'
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch
import numpy as np

fig, ax = plt.subplots(1, 1, figsize=(14, 10))
ax.set_xlim(0, 10)
ax.set_ylim(0, 8)
ax.axis('off')

# Título
ax.text(5, 7.5, 'Arquitectura Optimizada - Recursos Limitados', 
        fontsize=16, fontweight='bold', ha='center')

# POS Terminal Optimizado
pos_box = FancyBboxPatch((0.5, 5.5), 2, 1.5, boxstyle="round,pad=0.1", 
                         facecolor='#98fb98', edgecolor='black', linewidth=2)
ax.add_patch(pos_box)
ax.text(1.5, 6.2, 'POS Terminal\n(< 64MB RAM)', fontsize=10, ha='center', fontweight='bold')

# Microservicio Lite
ms_box = FancyBboxPatch((4, 5.5), 2.5, 1.5, boxstyle="round,pad=0.1", 
                        facecolor='#87ceeb', edgecolor='black', linewidth=2)
ax.add_patch(ms_box)
ax.text(5.25, 6.2, 'MS Sync Lite\n(Node.js Optimized)', fontsize=10, ha='center', fontweight='bold')

# SQLite Local
sqlite_box = FancyBboxPatch((7.5, 5.5), 2, 1.5, boxstyle="round,pad=0.1", 
                            facecolor='#dda0dd', edgecolor='black', linewidth=2)
ax.add_patch(sqlite_box)
ax.text(8.5, 6.2, 'SQLite\nLocal DB', fontsize=10, ha='center', fontweight='bold')

# Offline Queue
queue_box = FancyBboxPatch((4, 3.5), 2.5, 1, boxstyle="round,pad=0.1", 
                           facecolor='#f0e68c', edgecolor='black', linewidth=2)
ax.add_patch(queue_box)
ax.text(5.25, 4, 'Offline Queue\n(Compressed)', fontsize=10, ha='center', fontweight='bold')

# HO System
ho_box = FancyBboxPatch((4, 1.5), 2.5, 1, boxstyle="round,pad=0.1", 
                        facecolor='#ffd700', edgecolor='black', linewidth=2)
ax.add_patch(ho_box)
ax.text(5.25, 2, 'Head Office\n(Batch Sync)', fontsize=10, ha='center', fontweight='bold')

# Conexiones
ax.arrow(2.5, 6.2, 1.3, 0, head_width=0.1, head_length=0.1, fc='green', ec='green')
ax.text(3.2, 6.5, 'Local API', fontsize=8, ha='center')

ax.arrow(6.5, 6.2, 0.8, 0, head_width=0.1, head_length=0.1, fc='purple', ec='purple')
ax.text(7, 6.5, 'File-based', fontsize=8, ha='center')

ax.arrow(5.25, 5.5, 0, -0.8, head_width=0.1, head_length=0.1, fc='orange', ec='orange')
ax.text(5.7, 4.7, 'Queue', fontsize=8, ha='center')

# Conexión intermitente
ax.plot([5.25, 5.25], [3.5, 2.5], 'r--', linewidth=3)
ax.text(5.7, 3, 'Intermittent\nConnection', fontsize=8, ha='center', color='red')

# Beneficios
benefits_box = FancyBboxPatch((0.5, 0.2), 9, 1, boxstyle="round,pad=0.1", 
                              facecolor='#e6ffe6', edgecolor='green', linewidth=2)
ax.add_patch(benefits_box)
ax.text(5, 0.9, 'BENEFICIOS: Memoria < 64MB | Operación 100% Offline | Sync Inteligente', 
        fontsize=11, ha='center', fontweight='bold', color='green')

plt.tight_layout()
plt.savefig('$DIRECTORIO_DIAGRAMAS/arquitectura-recursos-limitados.png', dpi=300, bbox_inches='tight')
plt.close()
EOF

# 3. Diagrama Ajustes Mínimos
cat > "$DIRECTORIO_DIAGRAMAS/arquitectura-ajustes-minimos.py" << 'EOF'
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch
import numpy as np

fig, ax = plt.subplots(1, 1, figsize=(14, 10))
ax.set_xlim(0, 10)
ax.set_ylim(0, 8)
ax.axis('off')

# Título
ax.text(5, 7.5, 'Arquitectura con Ajustes Mínimos', 
        fontsize=16, fontweight='bold', ha='center')

# POS Terminal
pos_box = FancyBboxPatch((0.5, 5.5), 2, 1.5, boxstyle="round,pad=0.1", 
                         facecolor='#ffcccb', edgecolor='black', linewidth=2)
ax.add_patch(pos_box)
ax.text(1.5, 6.2, 'POS Terminal\n(Sin cambios)', fontsize=10, ha='center', fontweight='bold')

# Microservicio Optimizado
ms_box = FancyBboxPatch((4, 5.5), 2.5, 1.5, boxstyle="round,pad=0.1", 
                        facecolor='#87ceeb', edgecolor='black', linewidth=2)
ax.add_patch(ms_box)
ax.text(5.25, 6.2, 'MS Sync Sales\n(Optimized)', fontsize=10, ha='center', fontweight='bold')

# Cache Layer
cache_box = FancyBboxPatch((4, 4), 2.5, 0.8, boxstyle="round,pad=0.1", 
                           facecolor='#ffb6c1', edgecolor='black', linewidth=1)
ax.add_patch(cache_box)
ax.text(5.25, 4.4, 'Memory Cache', fontsize=9, ha='center', fontweight='bold')

# Base de Datos Optimizada
db_box = FancyBboxPatch((7.5, 5.5), 2, 1.5, boxstyle="round,pad=0.1", 
                        facecolor='#98fb98', edgecolor='black', linewidth=2)
ax.add_patch(db_box)
ax.text(8.5, 6.2, 'PostgreSQL\n(+ Indexes)', fontsize=10, ha='center', fontweight='bold')

# Logger Optimizado
logger_box = FancyBboxPatch((7.5, 4), 2, 0.8, boxstyle="round,pad=0.1", 
                            facecolor='#f0e68c', edgecolor='black', linewidth=1)
ax.add_patch(logger_box)
ax.text(8.5, 4.4, 'Structured Logs', fontsize=9, ha='center', fontweight='bold')

# HO System
ho_box = FancyBboxPatch((4, 2.5), 2.5, 1, boxstyle="round,pad=0.1", 
                        facecolor='#ffd700', edgecolor='black', linewidth=2)
ax.add_patch(ho_box)
ax.text(5.25, 3, 'Head Office\nSystem', fontsize=10, ha='center', fontweight='bold')

# Conexiones optimizadas
ax.arrow(2.5, 6.2, 1.3, 0, head_width=0.1, head_length=0.1, fc='green', ec='green')
ax.text(3.2, 6.5, 'Validated', fontsize=8, ha='center')

ax.arrow(6.5, 6.2, 0.8, 0, head_width=0.1, head_length=0.1, fc='blue', ec='blue')
ax.text(7, 6.5, 'Optimized SQL', fontsize=8, ha='center')

ax.arrow(5.25, 5.5, 0, -1.8, head_width=0.1, head_length=0.1, fc='green', ec='green')
ax.text(5.7, 4.5, 'Enhanced', fontsize=8, ha='center')

# Mejoras implementadas
improvements_box = FancyBboxPatch((0.5, 0.5), 9, 1.5, boxstyle="round,pad=0.1", 
                                  facecolor='#e6f3ff', edgecolor='blue', linewidth=2)
ax.add_patch(improvements_box)
ax.text(5, 1.6, 'MEJORAS IMPLEMENTADAS', fontsize=12, ha='center', fontweight='bold', color='blue')
ax.text(5, 1.2, '• Cache en memoria para consultas frecuentes', fontsize=10, ha='center')
ax.text(5, 0.9, '• Índices optimizados en base de datos', fontsize=10, ha='center')
ax.text(5, 0.6, '• Logging estructurado y validaciones mejoradas', fontsize=10, ha='center')

plt.tight_layout()
plt.savefig('$DIRECTORIO_DIAGRAMAS/arquitectura-ajustes-minimos.png', dpi=300, bbox_inches='tight')
plt.close()
EOF

# 4. Diagrama Comparativo
cat > "$DIRECTORIO_DIAGRAMAS/comparativo-arquitecturas.py" << 'EOF'
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch
import numpy as np

fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(16, 12))

# Configurar todos los ejes
for ax in [ax1, ax2, ax3, ax4]:
    ax.set_xlim(0, 10)
    ax.set_ylim(0, 6)
    ax.axis('off')

# 1. Arquitectura Actual
ax1.text(5, 5.5, 'ACTUAL', fontsize=14, fontweight='bold', ha='center', color='red')
pos1 = FancyBboxPatch((1, 3.5), 2, 1, boxstyle="round,pad=0.1", facecolor='#ffcccb', edgecolor='black')
ms1 = FancyBboxPatch((4, 3.5), 2, 1, boxstyle="round,pad=0.1", facecolor='#add8e6', edgecolor='black')
db1 = FancyBboxPatch((7, 3.5), 2, 1, boxstyle="round,pad=0.1", facecolor='#90ee90', edgecolor='black')
ax1.add_patch(pos1)
ax1.add_patch(ms1)
ax1.add_patch(db1)
ax1.text(2, 4, 'POS', fontsize=10, ha='center', fontweight='bold')
ax1.text(5, 4, 'Node.js', fontsize=10, ha='center', fontweight='bold')
ax1.text(8, 4, 'PostgreSQL', fontsize=10, ha='center', fontweight='bold')
ax1.text(5, 2.5, 'Memoria: 150MB+\nOffline: No\nPerformance: Básico', fontsize=9, ha='center')

# 2. Ajustes Mínimos
ax2.text(5, 5.5, 'AJUSTES MÍNIMOS', fontsize=14, fontweight='bold', ha='center', color='blue')
pos2 = FancyBboxPatch((1, 3.5), 2, 1, boxstyle="round,pad=0.1", facecolor='#ffcccb', edgecolor='black')
ms2 = FancyBboxPatch((4, 3.5), 2, 1, boxstyle="round,pad=0.1", facecolor='#87ceeb', edgecolor='black')
db2 = FancyBboxPatch((7, 3.5), 2, 1, boxstyle="round,pad=0.1", facecolor='#98fb98', edgecolor='black')
cache2 = FancyBboxPatch((4, 2.5), 2, 0.5, boxstyle="round,pad=0.1", facecolor='#ffb6c1', edgecolor='black')
ax2.add_patch(pos2)
ax2.add_patch(ms2)
ax2.add_patch(db2)
ax2.add_patch(cache2)
ax2.text(2, 4, 'POS', fontsize=10, ha='center', fontweight='bold')
ax2.text(5, 4, 'Node.js+', fontsize=10, ha='center', fontweight='bold')
ax2.text(8, 4, 'PostgreSQL+', fontsize=10, ha='center', fontweight='bold')
ax2.text(5, 2.75, 'Cache', fontsize=8, ha='center')
ax2.text(5, 1.5, 'Memoria: 120MB\nOffline: No\nPerformance: +40%', fontsize=9, ha='center')

# 3. Recursos Limitados
ax3.text(5, 5.5, 'RECURSOS LIMITADOS', fontsize=14, fontweight='bold', ha='center', color='green')
pos3 = FancyBboxPatch((1, 3.5), 2, 1, boxstyle="round,pad=0.1", facecolor='#98fb98', edgecolor='black')
ms3 = FancyBboxPatch((4, 3.5), 2, 1, boxstyle="round,pad=0.1", facecolor='#87ceeb', edgecolor='black')
db3 = FancyBboxPatch((7, 3.5), 2, 1, boxstyle="round,pad=0.1", facecolor='#dda0dd', edgecolor='black')
queue3 = FancyBboxPatch((4, 2.5), 2, 0.5, boxstyle="round,pad=0.1", facecolor='#f0e68c', edgecolor='black')
ax3.add_patch(pos3)
ax3.add_patch(ms3)
ax3.add_patch(db3)
ax3.add_patch(queue3)
ax3.text(2, 4, 'POS Lite', fontsize=10, ha='center', fontweight='bold')
ax3.text(5, 4, 'Node.js Lite', fontsize=10, ha='center', fontweight='bold')
ax3.text(8, 4, 'SQLite', fontsize=10, ha='center', fontweight='bold')
ax3.text(5, 2.75, 'Queue', fontsize=8, ha='center')
ax3.text(5, 1.5, 'Memoria: <64MB\nOffline: Sí\nPerformance: +70%', fontsize=9, ha='center')

# 4. Migración Python
ax4.text(5, 5.5, 'MIGRACIÓN PYTHON', fontsize=14, fontweight='bold', ha='center', color='purple')
pos4 = FancyBboxPatch((1, 3.5), 2, 1, boxstyle="round,pad=0.1", facecolor='#ffcccb', edgecolor='black')
ms4 = FancyBboxPatch((4, 3.5), 2, 1, boxstyle="round,pad=0.1", facecolor='#dda0dd', edgecolor='black')
db4 = FancyBboxPatch((7, 3.5), 2, 1, boxstyle="round,pad=0.1", facecolor='#90ee90', edgecolor='black')
redis4 = FancyBboxPatch((4, 2.5), 2, 0.5, boxstyle="round,pad=0.1", facecolor='#ff6347', edgecolor='black')
ax4.add_patch(pos4)
ax4.add_patch(ms4)
ax4.add_patch(db4)
ax4.add_patch(redis4)
ax4.text(2, 4, 'POS', fontsize=10, ha='center', fontweight='bold')
ax4.text(5, 4, 'FastAPI', fontsize=10, ha='center', fontweight='bold')
ax4.text(8, 4, 'PostgreSQL', fontsize=10, ha='center', fontweight='bold')
ax4.text(5, 2.75, 'Redis', fontsize=8, ha='center')
ax4.text(5, 1.5, 'Memoria: 100MB\nOffline: Parcial\nPerformance: +60%', fontsize=9, ha='center')

plt.suptitle('Comparativo de Arquitecturas Propuestas', fontsize=16, fontweight='bold')
plt.tight_layout()
plt.savefig('$DIRECTORIO_DIAGRAMAS/comparativo-arquitecturas.png', dpi=300, bbox_inches='tight')
plt.close()
EOF

# Ejecutar todos los scripts de Python
echo "Generando diagramas..."
cd "$DIRECTORIO_DIAGRAMAS"

python3 arquitectura-actual.py
python3 arquitectura-recursos-limitados.py  
python3 arquitectura-ajustes-minimos.py
python3 comparativo-arquitecturas.py

echo "✅ Diagramas de arquitectura generados:"
echo "   - arquitectura-actual.png"
echo "   - arquitectura-recursos-limitados.png"
echo "   - arquitectura-ajustes-minimos.png"
echo "   - comparativo-arquitecturas.png"
