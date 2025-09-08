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
