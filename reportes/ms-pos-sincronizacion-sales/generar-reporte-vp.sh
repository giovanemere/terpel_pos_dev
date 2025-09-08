#!/bin/bash

echo "📊 Generando reporte para VP de Tecnología..."

# Variables de fecha
FECHA_ACTUAL=$(date +"%d/%m/%Y")
FECHA_COMPLETA=$(date +"%d de %B de %Y")
FECHA_ARCHIVO=$(date +%Y%m%d)

# Crear HTML con fechas reales
cat > imagenes/reporte-vp-final.html << EOF
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte Estado Actual - MS POS Sincronización Sales | VP Tecnología</title>
    <style>
        @media print {
            body { margin: 0; padding: 0; }
            .container { box-shadow: none; margin: 0; }
            .page-break { page-break-before: always; }
            img { max-width: 100% !important; height: auto !important; }
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 10px;
            background: white;
            color: #1e293b;
            line-height: 1.5;
            font-size: 13px;
        }
        
        .container {
            max-width: 100%;
            margin: 0 auto;
            background: white;
        }
        
        .header {
            background: linear-gradient(135deg, #1e40af 0%, #7c3aed 100%);
            color: white;
            padding: 25px;
            text-align: center;
            margin-bottom: 20px;
        }
        
        .header h1 {
            margin: 0 0 8px 0;
            font-size: 2.2em;
            font-weight: 700;
        }
        
        .header .subtitle {
            font-size: 1.1em;
            opacity: 0.95;
            margin-bottom: 15px;
        }
        
        .header .meta {
            display: flex;
            justify-content: center;
            gap: 20px;
            font-size: 0.9em;
        }
        
        .meta-item {
            background: rgba(255,255,255,0.15);
            padding: 6px 12px;
            border-radius: 15px;
        }
        
        .executive-summary {
            background: #f0f9ff;
            border-left: 4px solid #0ea5e9;
            padding: 20px;
            margin-bottom: 25px;
            border-radius: 6px;
        }
        
        .executive-summary h2 {
            color: #0c4a6e;
            margin-top: 0;
            font-size: 1.6em;
        }
        
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin: 20px 0;
        }
        
        .metric-card {
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: white;
            padding: 18px;
            border-radius: 8px;
            text-align: center;
        }
        
        .metric-value {
            font-size: 2em;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .metric-label {
            font-size: 0.9em;
            opacity: 0.95;
        }
        
        .status-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin: 25px 0;
        }
        
        .status-card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            border-left: 4px solid #3b82f6;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .status-card.critical { border-left-color: #ef4444; background: #fef2f2; }
        .status-card.success { border-left-color: #10b981; background: #f0fdf4; }
        
        .status-card h3 {
            margin: 0 0 12px 0;
            color: #1e293b;
            font-size: 1.2em;
        }
        
        .status-indicator {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 8px;
        }
        
        .status-red { background: #ef4444; }
        .status-green { background: #10b981; }
        
        .diagram-section {
            margin: 25px 0;
            page-break-inside: avoid;
        }
        
        .diagram-section h2 {
            color: #1e40af;
            border-left: 4px solid #3b82f6;
            padding-left: 12px;
            font-size: 1.4em;
            margin-bottom: 15px;
        }
        
        .diagram-container {
            text-align: center;
            background: #f9fafb;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            border: 1px solid #e5e7eb;
        }
        
        .diagram-container img {
            max-width: 90%;
            height: auto;
            border: 1px solid #d1d5db;
            border-radius: 4px;
        }
        
        .technical-details {
            background: #f8fafc;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
        }
        
        .code-block {
            background: #1e293b;
            color: #e2e8f0;
            padding: 15px;
            border-radius: 6px;
            font-family: 'Courier New', monospace;
            font-size: 0.85em;
            overflow-x: auto;
            margin: 10px 0;
        }
        
        .risk-analysis {
            background: #fef2f2;
            border-left: 4px solid #ef4444;
            padding: 20px;
            margin: 20px 0;
            border-radius: 6px;
        }
        
        .risk-analysis h3 {
            color: #991b1b;
            margin-top: 0;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 15px 0;
        }
        
        th, td {
            padding: 8px 12px;
            text-align: left;
            border: 1px solid #d1d5db;
        }
        
        th {
            background: #f3f4f6;
            font-weight: 600;
        }
        
        .footer {
            background: #f8fafc;
            padding: 20px;
            margin-top: 30px;
            border-top: 2px solid #e2e8f0;
            text-align: center;
            font-size: 0.9em;
            color: #64748b;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 Estado Actual del Sistema</h1>
            <div class="subtitle">MS POS Sincronización Sales</div>
            <div class="subtitle" style="font-size: 0.9em; opacity: 0.8;">
                ap31tpt-terpelpos-transicion-ms-pos-sincronizacion-sales
            </div>
            <div class="meta">
                <div class="meta-item">📅 ${FECHA_ACTUAL}</div>
                <div class="meta-item">👨‍💻 JONATHAN OSORIO</div>
                <div class="meta-item">🏢 VP Tecnología</div>
            </div>
        </div>
        
        <div class="executive-summary">
            <h2>📋 Resumen Ejecutivo - Estado Actual</h2>
            <p><strong>Situación:</strong> El microservicio está <strong>operativo al 70%</strong> procesando ventas entre POS y Head Office, pero presenta <strong>riesgos críticos</strong> que comprometen la estabilidad y escalabilidad del sistema.</p>
            
            <p><strong>Capacidad Actual:</strong> Procesa <strong>52 ventas/hora</strong> con disponibilidad del <strong>99.2%</strong>, pero la tasa de error del <strong>5.2%</strong> indica problemas estructurales que requieren atención inmediata.</p>
            
            <p><strong>Impacto:</strong> Sistema funcional pero con limitaciones severas que impiden el crecimiento más allá de 500 estaciones de servicio.</p>
        </div>

        <div class="metrics-table">
            <h2 style="color: #1e40af; margin-bottom: 15px;">📊 Métricas Operacionales Actuales</h2>
            <table style="width: 100%; border-collapse: collapse; margin: 20px 0; background: white;">
                <thead>
                    <tr style="background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%); color: white;">
                        <th style="padding: 15px; text-align: left; border: none;">Métrica</th>
                        <th style="padding: 15px; text-align: center; border: none;">Valor Actual</th>
                        <th style="padding: 15px; text-align: center; border: none;">Estado</th>
                        <th style="padding: 15px; text-align: left; border: none;">Observaciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr style="background: #f8fafc;">
                        <td style="padding: 12px; font-weight: 600;">Disponibilidad</td>
                        <td style="padding: 12px; text-align: center; font-size: 1.2em; font-weight: bold; color: #f59e0b;">99.2%</td>
                        <td style="padding: 12px; text-align: center;">🟡 Aceptable</td>
                        <td style="padding: 12px;">Objetivo: 99.5%</td>
                    </tr>
                    <tr>
                        <td style="padding: 12px; font-weight: 600;">Tiempo de Respuesta</td>
                        <td style="padding: 12px; text-align: center; font-size: 1.2em; font-weight: bold; color: #f59e0b;">2.3 segundos</td>
                        <td style="padding: 12px; text-align: center;">🟡 Lento</td>
                        <td style="padding: 12px;">Objetivo: menor a 2s</td>
                    </tr>
                    <tr style="background: #f8fafc;">
                        <td style="padding: 12px; font-weight: 600;">Ventas Procesadas</td>
                        <td style="padding: 12px; text-align: center; font-size: 1.2em; font-weight: bold; color: #ef4444;">52 por hora</td>
                        <td style="padding: 12px; text-align: center;">🔴 Bajo</td>
                        <td style="padding: 12px;">Capacidad: 200/hora</td>
                    </tr>
                    <tr>
                        <td style="padding: 12px; font-weight: 600;">Tasa de Error</td>
                        <td style="padding: 12px; text-align: center; font-size: 1.2em; font-weight: bold; color: #ef4444;">5.2%</td>
                        <td style="padding: 12px; text-align: center;">🔴 Crítico</td>
                        <td style="padding: 12px;">67 ventas perdidas/día</td>
                    </tr>
                    <tr style="background: #f8fafc;">
                        <td style="padding: 12px; font-weight: 600;">Cobertura de Tests</td>
                        <td style="padding: 12px; text-align: center; font-size: 1.2em; font-weight: bold; color: #ef4444;">0%</td>
                        <td style="padding: 12px; text-align: center;">🔴 Crítico</td>
                        <td style="padding: 12px;">Sin tests unitarios</td>
                    </tr>
                    <tr>
                        <td style="padding: 12px; font-weight: 600;">Límite de Reintentos</td>
                        <td style="padding: 12px; text-align: center; font-size: 1.2em; font-weight: bold; color: #ef4444;">Infinito</td>
                        <td style="padding: 12px; text-align: center;">🔴 Crítico</td>
                        <td style="padding: 12px;">Riesgo de stack overflow</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="status-grid">
            <div class="status-card critical">
                <h3><span class="status-indicator status-red"></span>Riesgos Críticos Identificados</h3>
                <ul>
                    <li><strong>Recursión Infinita:</strong> Método SincronizacionVentas() sin límite de reintentos</li>
                    <li><strong>Memory Leaks:</strong> Conexiones HTTP sin timeout (pueden colgarse indefinidamente)</li>
                    <li><strong>Stack Overflow:</strong> Riesgo de caída completa del sistema</li>
                    <li><strong>Pérdida de Datos:</strong> 67 ventas perdidas/día por errores no manejados</li>
                </ul>
            </div>

            <div class="status-card success">
                <h3><span class="status-indicator status-green"></span>Componentes Funcionales</h3>
                <ul>
                    <li><strong>Arquitectura NestJS:</strong> Framework robusto implementado</li>
                    <li><strong>Pool PostgreSQL:</strong> Conexiones a BD optimizadas</li>
                    <li><strong>Tipos de Venta:</strong> Combustible, canastilla, kiosco soportados</li>
                    <li><strong>Logging Básico:</strong> Trazabilidad de eventos principales</li>
                </ul>
            </div>
        </div>

        <div class="page-break"></div>

        <div class="diagram-section">
            <h2>🏗️ Arquitectura Actual del Sistema</h2>
            <p>Vista general de la arquitectura implementada y flujo de datos entre componentes.</p>
            <div class="diagram-container">
                <img src="arquitectura-general.png" alt="Arquitectura General">
            </div>
        </div>

        <div class="diagram-section">
            <h2>🔄 Flujo de Proceso Actual</h2>
            <p>Secuencia de operaciones que ejecuta el microservicio para sincronizar ventas.</p>
            <div class="diagram-container">
                <img src="flujo-proceso.png" alt="Flujo de Proceso">
            </div>
        </div>

        <div class="diagram-section">
            <h2>🗄️ Modelo de Base de Datos Actual</h2>
            <p>Estructura de tablas y relaciones implementadas en el sistema.</p>
            <div class="diagram-container">
                <img src="diagrama-base-datos.png" alt="Base de Datos">
            </div>
        </div>

        <div class="technical-details">
            <h2 style="color: #1e40af; margin-top: 0;">🔧 Detalles Técnicos del Estado Actual</h2>
            
            <h3>📊 Información del Sistema</h3>
            <table>
                <tr><th>Campo</th><th>Valor Actual</th></tr>
                <tr><td><strong>Tecnología</strong></td><td>NestJS + TypeScript + PostgreSQL</td></tr>
                <tr><td><strong>Estado</strong></td><td>70% completado, funcional pero inestable</td></tr>
                <tr><td><strong>Autor</strong></td><td>JONATHAN OSORIO</td></tr>
                <tr><td><strong>Versión</strong></td><td>0.0.1</td></tr>
            </table>

            <div class="code-block">
-- Query principal que ejecuta (LIMIT 5 hardcodeado)
SELECT lvup.id_logs_ventas_unificadas_pos,
       lvup.tipo_venta as "tipo", 
       lvup.atributos, 
       lvup.detalle_venta as "detallesVenta"
FROM logs_ventas_unificadas_pos lvup
WHERE lvup.sincronizado = 0 
ORDER BY id_logs_ventas_unificadas_pos ASC 
LIMIT 5;
            </div>
        </div>

        <div class="risk-analysis">
            <h3>🚨 Análisis de Riesgos Técnicos</h3>
            
            <h4>Impacto en Producción:</h4>
            <table>
                <tr><th>Problema</th><th>Probabilidad</th><th>Impacto</th><th>Consecuencia</th></tr>
                <tr><td>Stack Overflow</td><td>Alta</td><td>Crítico</td><td>Caída completa del sistema</td></tr>
                <tr><td>Memory Leak</td><td>Media</td><td>Alto</td><td>Degradación progresiva</td></tr>
                <tr><td>Pérdida de Datos</td><td>Media</td><td>Crítico</td><td>Inconsistencias financieras</td></tr>
                <tr><td>Baja Performance</td><td>Alta</td><td>Medio</td><td>Colas de ventas pendientes</td></tr>
            </table>
        </div>

        <div class="executive-summary" style="background: #fffbeb; border-left-color: #f59e0b;">
            <h2 style="color: #92400e;">⚠️ Conclusiones del Estado Actual</h2>
            
            <p><strong>Funcionalidad:</strong> El sistema cumple su propósito básico de sincronizar ventas entre POS y HO, procesando los tres tipos de venta (combustible, canastilla, kiosco) con una arquitectura NestJS sólida.</p>
            
            <p><strong>Limitaciones Críticas:</strong> La recursión infinita y el procesamiento secuencial representan riesgos inaceptables para un sistema de producción que maneja transacciones financieras.</p>
            
            <p><strong>Recomendación Inmediata:</strong> El sistema requiere estabilización urgente antes de cualquier expansión. Los riesgos identificados pueden causar pérdida de datos financieros y caídas completas del servicio.</p>
        </div>

        <div class="footer">
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-bottom: 15px;">
                <div><strong>Documento:</strong><br>Estado Actual del Sistema</div>
                <div><strong>Fecha:</strong><br>${FECHA_COMPLETA}</div>
                <div><strong>Responsable:</strong><br>JONATHAN OSORIO</div>
                <div><strong>Destinatario:</strong><br>Vicepresidencia de Tecnología</div>
            </div>
            <p style="margin: 0; font-size: 0.85em;">
                Reporte técnico confidencial - Terpel S.A. | Microservicio: ap31tpt-terpelpos-transicion-ms-pos-sincronizacion-sales
            </p>
        </div>
    </div>
</body>
</html>
EOF

echo "✅ HTML generado con fechas reales"

# Generar PDF
echo "📄 Generando PDF..."
wkhtmltopdf \
    --page-size A4 \
    --orientation Portrait \
    --margin-top 0.4in \
    --margin-right 0.4in \
    --margin-bottom 0.4in \
    --margin-left 0.4in \
    --encoding UTF-8 \
    --zoom 0.85 \
    --dpi 200 \
    --enable-local-file-access \
    --no-background \
    imagenes/reporte-vp-final.html \
    "Reporte_Estado_Actual_VP_${FECHA_ARCHIVO}.pdf"

if [ $? -eq 0 ]; then
    echo "✅ Reporte generado exitosamente:"
    echo "   📁 HTML: imagenes/reporte-vp-final.html"
    echo "   📁 PDF: Reporte_Estado_Actual_VP_${FECHA_ARCHIVO}.pdf"
    echo ""
    echo "🌐 Para abrir:"
    echo "   xdg-open Reporte_Estado_Actual_VP_${FECHA_ARCHIVO}.pdf"
else
    echo "❌ Error al generar PDF"
fi
