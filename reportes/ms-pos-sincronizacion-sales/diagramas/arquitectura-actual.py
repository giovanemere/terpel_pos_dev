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
