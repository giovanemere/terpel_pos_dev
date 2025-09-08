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
