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
