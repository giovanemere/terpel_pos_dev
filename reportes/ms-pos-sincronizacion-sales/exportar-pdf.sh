#!/bin/bash

# Script para exportar el reporte a PDF
echo "📄 Exportando reporte a PDF..."

# Verificar si wkhtmltopdf está instalado
if ! command -v wkhtmltopdf &> /dev/null; then
    echo "📦 Instalando wkhtmltopdf..."
    sudo apt-get update
    sudo apt-get install -y wkhtmltopdf
fi

# Crear PDF desde HTML con configuración optimizada
echo "🔄 Generando PDF desde HTML..."
wkhtmltopdf \
    --page-size A4 \
    --orientation Portrait \
    --margin-top 0.5in \
    --margin-right 0.5in \
    --margin-bottom 0.5in \
    --margin-left 0.5in \
    --encoding UTF-8 \
    --disable-smart-shrinking \
    --zoom 0.9 \
    --dpi 300 \
    --image-quality 100 \
    --enable-local-file-access \
    --no-background \
    --print-media-type \
    imagenes/reporte-visual.html \
    "MS_POS_Sincronizacion_Sales_Reporte_$(date +%Y%m%d).pdf"

if [ $? -eq 0 ]; then
    echo "✅ PDF generado exitosamente:"
    echo "   📁 MS_POS_Sincronizacion_Sales_Reporte_$(date +%Y%m%d).pdf"
    echo ""
    echo "🌐 Para abrir el PDF:"
    echo "   xdg-open MS_POS_Sincronizacion_Sales_Reporte_$(date +%Y%m%d).pdf"
else
    echo "❌ Error al generar PDF"
fi
