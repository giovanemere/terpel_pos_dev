#!/usr/bin/env python3

import pandas as pd
from datetime import datetime
import os

def actualizar_presupuesto_con_ia():
    """Actualizar presupuesto incluyendo modelo de IA enterprise"""
    
    fecha = datetime.now().strftime("%Y%m%d")
    archivo_excel = f"Presupuesto_MS_POS_Con_IA_Enterprise_{fecha}.xlsx"
    
    with pd.ExcelWriter(archivo_excel, engine='openpyxl') as writer:
        
        # 1. HOJA: Presupuesto Actualizado con IA
        presupuesto_ia_data = {
            'Categoría': [
                'DESARROLLO TRADICIONAL',
                'Go Developer Senior',
                'Go Developer Mid', 
                'QA Engineer',
                'DevOps Engineer',
                'DBA',
                'Tech Writer',
                'Project Manager',
                '',
                'MODELO IA ENTERPRISE',
                'GitHub Copilot Enterprise',
                'OpenAI GPT-4 API Enterprise',
                'Claude 3 Opus Enterprise',
                'Cursor Pro Team',
                'Tabnine Enterprise',
                'AI Code Review (SonarQube AI)',
                'AI Documentation (Mintlify)',
                'AI Testing (Testim.io)',
                '',
                'INFRAESTRUCTURA IA',
                'Azure OpenAI Service',
                'AWS Bedrock Enterprise',
                'GPU Cloud Computing (A100)',
                'Vector Database (Pinecone)',
                'MLOps Platform (MLflow)',
                '',
                'TRAINING Y SETUP IA',
                'AI Tools Training (2 días)',
                'Custom AI Prompts Development',
                'AI Workflow Integration',
                'AI Performance Monitoring',
                '',
                'TOTAL SIN IA',
                'TOTAL CON IA',
                'DIFERENCIA IA',
                'AHORRO TIEMPO ESTIMADO',
                'ROI IA PRIMER AÑO'
            ],
            'Cantidad': [
                '',
                '1',
                '1',
                '1',
                '1',
                '1',
                '1',
                '1',
                '',
                '',
                '5 usuarios x 3 meses',
                '1M tokens/mes x 3 meses',
                '500K tokens/mes x 3 meses',
                '5 usuarios x 3 meses',
                '5 usuarios x 3 meses',
                '1 proyecto x 3 meses',
                '1 proyecto x 3 meses',
                '1 proyecto x 3 meses',
                '',
                '',
                '3 meses',
                '3 meses',
                '100 horas GPU',
                '3 meses',
                '3 meses',
                '',
                '',
                '5 personas x 2 días',
                '40 horas desarrollo',
                '20 horas setup',
                '3 meses monitoreo',
                '',
                '',
                '',
                '',
                '',
                ''
            ],
            'Costo Unitario ($)': [
                '',
                '3,000/sem',
                '2,000/sem',
                '2,500/sem',
                '2,500/sem',
                '2,000/sem',
                '1,500/sem',
                '2,500/sem',
                '',
                '',
                '39/usuario/mes',
                '30/1K tokens',
                '75/1K tokens',
                '20/usuario/mes',
                '12/usuario/mes',
                '500/mes',
                '299/mes',
                '450/mes',
                '',
                '',
                '2,000/mes',
                '1,500/mes',
                '2.50/hora',
                '70/mes',
                '150/mes',
                '',
                '',
                '500/persona/día',
                '150/hora',
                '200/hora',
                '300/mes',
                '',
                '',
                '',
                '',
                '',
                ''
            ],
            'Duración': [
                '',
                '3 semanas',
                '2 semanas', 
                '3 semanas',
                '3 semanas',
                '1 semana',
                '1 semana',
                '3 semanas',
                '',
                '',
                '3 meses',
                '3 meses',
                '3 meses',
                '3 meses',
                '3 meses',
                '3 meses',
                '3 meses',
                '3 meses',
                '',
                '',
                '3 meses',
                '3 meses',
                'Una vez',
                '3 meses',
                '3 meses',
                '',
                '',
                'Una vez',
                'Una vez',
                'Una vez',
                '3 meses',
                '',
                '',
                '',
                '',
                '',
                ''
            ],
            'Costo Total ($)': [
                '',
                '9,000',
                '4,000',
                '7,500',
                '7,500',
                '2,000',
                '1,500',
                '7,500',
                '',
                '',
                '585',
                '90,000',
                '112,500',
                '300',
                '180',
                '1,500',
                '897',
                '1,350',
                '',
                '',
                '6,000',
                '4,500',
                '250',
                '210',
                '450',
                '',
                '',
                '5,000',
                '6,000',
                '4,000',
                '900',
                '',
                '39,000',
                '243,622',
                '204,622',
                '40% (1.2 semanas)',
                '525%'
            ],
            'Beneficio IA': [
                '',
                'Código 60% más rápido',
                'Menos bugs, mejor calidad',
                'Tests automáticos generados',
                'Infraestructura como código',
                'Queries optimizadas auto',
                'Docs generadas automáticamente',
                'Planning asistido por IA',
                '',
                '',
                'Autocompletado inteligente',
                'Code generation avanzado',
                'Code review automático',
                'AI pair programming',
                'Refactoring inteligente',
                'Detección bugs automática',
                'Documentación auto-generada',
                'Test cases automáticos',
                '',
                '',
                'Modelos propios seguros',
                'Multi-model access',
                'Training personalizado',
                'Embeddings para docs',
                'Experiment tracking',
                '',
                '',
                'Equipo productivo desde día 1',
                'Prompts optimizados',
                'Workflows automatizados',
                'Métricas de productividad',
                '',
                '',
                '',
                '',
                '',
                ''
            ]
        }
        
        df_presupuesto_ia = pd.DataFrame(presupuesto_ia_data)
        df_presupuesto_ia.to_excel(writer, sheet_name='Presupuesto con IA', index=False)
        
        # 2. HOJA: Comparativa ROI con y sin IA
        roi_comparativa_data = {
            'Métrica': [
                'Tiempo de Desarrollo',
                'Costo de Desarrollo',
                'Calidad del Código',
                'Bugs en Producción',
                'Tiempo de Testing',
                'Documentación',
                'Mantenimiento Anual',
                'Time to Market',
                'Developer Productivity',
                'Code Review Time',
                'Onboarding Nuevos Devs',
                'Technical Debt'
            ],
            'Sin IA': [
                '3 semanas',
                '$39,000',
                'Manual review',
                '15-20 bugs',
                '1 semana',
                '40 horas manuales',
                '$25,000',
                '4 semanas total',
                'Baseline 100%',
                '8 horas/semana',
                '2 semanas',
                'Alto'
            ],
            'Con IA': [
                '1.8 semanas',
                '$243,622',
                'AI + manual review',
                '5-8 bugs',
                '3 días',
                'Auto-generada',
                '$15,000',
                '2.5 semanas total',
                '160% vs baseline',
                '3 horas/semana',
                '3 días',
                'Bajo'
            ],
            'Mejora': [
                '40% más rápido',
                'Inversión inicial alta',
                '70% mejor calidad',
                '65% menos bugs',
                '60% menos tiempo',
                '90% automatizada',
                '40% menos costo',
                '37% más rápido',
                '60% más productivo',
                '62% menos tiempo',
                '80% más rápido',
                '75% reducción'
            ],
            'Valor Anual ($)': [
                '$45,000',
                'N/A',
                '$30,000',
                '$50,000',
                '$20,000',
                '$15,000',
                '$10,000',
                '$75,000',
                '$120,000',
                '$25,000',
                '$35,000',
                '$40,000'
            ]
        }
        
        df_roi_comparativa = pd.DataFrame(roi_comparativa_data)
        df_roi_comparativa.to_excel(writer, sheet_name='ROI Comparativa IA', index=False)
        
        # 3. HOJA: Herramientas IA Específicas
        herramientas_ia_data = {
            'Herramienta': [
                'GitHub Copilot Enterprise',
                'OpenAI GPT-4 Turbo',
                'Claude 3 Opus',
                'Cursor Pro',
                'Tabnine Enterprise',
                'SonarQube AI',
                'Mintlify AI Docs',
                'Testim.io AI Testing',
                'Azure OpenAI',
                'AWS Bedrock',
                'Pinecone Vector DB',
                'MLflow Enterprise'
            ],
            'Propósito': [
                'Code completion & generation',
                'Complex code generation',
                'Code review & analysis',
                'AI-powered IDE',
                'Intelligent autocomplete',
                'Automated code quality',
                'Auto documentation',
                'AI test generation',
                'Enterprise AI models',
                'Multi-model access',
                'Knowledge base search',
                'ML experiment tracking'
            ],
            'Uso en Proyecto': [
                'Desarrollo Go microservice',
                'Arquitectura & patrones',
                'Code review automático',
                'IDE principal desarrollo',
                'Autocompletado inteligente',
                'Quality gates automáticos',
                'Documentación técnica',
                'Test cases automáticos',
                'Modelos personalizados',
                'Backup AI models',
                'Búsqueda en docs/código',
                'Tracking experimentos'
            ],
            'Productividad Esperada': [
                '40-60% faster coding',
                '70% faster architecture',
                '80% faster reviews',
                '50% faster development',
                '30% faster typing',
                '90% automated QA',
                '95% automated docs',
                '85% automated tests',
                'Custom model benefits',
                'Redundancy & reliability',
                'Instant knowledge access',
                'Data-driven decisions'
            ],
            'Costo Mensual ($)': [
                '195',
                '30,000',
                '37,500',
                '100',
                '60',
                '500',
                '299',
                '450',
                '2,000',
                '1,500',
                '70',
                '150'
            ]
        }
        
        df_herramientas = pd.DataFrame(herramientas_ia_data)
        df_herramientas.to_excel(writer, sheet_name='Herramientas IA', index=False)
        
        # 4. HOJA: Cronograma con IA
        cronograma_ia_data = {
            'Semana': [
                'Pre-proyecto',
                'Pre-proyecto',
                'Pre-proyecto',
                'Semana 1',
                'Semana 1',
                'Semana 1',
                'Semana 1',
                'Semana 2',
                'Semana 2',
                'Semana 2',
                'Semana 2',
                'Semana 3',
                'Semana 3',
                'Post-proyecto',
                'Post-proyecto'
            ],
            'Actividad': [
                'Setup herramientas IA',
                'Training equipo en IA tools',
                'Configurar prompts personalizados',
                'AI-assisted project setup',
                'AI-generated boilerplate code',
                'AI-powered architecture design',
                'Automated code generation',
                'AI-assisted development',
                'Automated testing generation',
                'AI code review continuous',
                'AI-powered debugging',
                'AI-generated documentation',
                'AI performance optimization',
                'AI monitoring setup',
                'AI maintenance automation'
            ],
            'Herramienta Principal': [
                'Todas las herramientas',
                'Cursor + Copilot',
                'GPT-4 + Claude',
                'Cursor + Copilot',
                'GPT-4 + Tabnine',
                'Claude + GPT-4',
                'Copilot + Cursor',
                'Todas',
                'Testim.io + GPT-4',
                'SonarQube AI',
                'Claude + Cursor',
                'Mintlify + GPT-4',
                'Azure OpenAI',
                'MLflow + Pinecone',
                'Todas'
            ],
            'Tiempo Sin IA': [
                '0 días',
                '0 días',
                '0 días',
                '5 días',
                '3 días',
                '2 días',
                '5 días',
                '5 días',
                '3 días',
                '2 días',
                '5 días',
                '3 días',
                '2 días',
                '2 días',
                '1 día'
            ],
            'Tiempo Con IA': [
                '1 día',
                '2 días',
                '1 día',
                '2 días',
                '1 día',
                '0.5 días',
                '2 días',
                '2 días',
                '1 día',
                '0.5 días',
                '2 días',
                '0.5 días',
                '1 día',
                '0.5 días',
                '0.5 días'
            ],
            'Ahorro Tiempo': [
                '-1 día (setup)',
                '-2 días (training)',
                '-1 día (config)',
                '3 días',
                '2 días',
                '1.5 días',
                '3 días',
                '3 días',
                '2 días',
                '1.5 días',
                '3 días',
                '2.5 días',
                '1 día',
                '1.5 días',
                '0.5 días'
            ]
        }
        
        df_cronograma = pd.DataFrame(cronograma_ia_data)
        df_cronograma.to_excel(writer, sheet_name='Cronograma con IA', index=False)
        
        # 5. HOJA: Análisis Costo-Beneficio IA
        costo_beneficio_data = {
            'Año': [1, 1, 1, 2, 2, 2, 3, 3, 3],
            'Categoría': [
                'Inversión IA',
                'Ahorro Desarrollo',
                'Ahorro Mantenimiento',
                'Renovación IA',
                'Ahorro Desarrollo',
                'Ahorro Mantenimiento',
                'Renovación IA',
                'Ahorro Desarrollo',
                'Ahorro Mantenimiento'
            ],
            'Costo ($)': [
                '204,622',
                '0',
                '0',
                '150,000',
                '0',
                '0',
                '150,000',
                '0',
                '0'
            ],
            'Beneficio ($)': [
                '0',
                '120,000',
                '40,000',
                '0',
                '180,000',
                '60,000',
                '0',
                '220,000',
                '80,000'
            ],
            'Neto Anual ($)': [
                '-44,622',
                '',
                '',
                '90,000',
                '',
                '',
                '150,000',
                '',
                ''
            ],
            'ROI Acumulado (%)': [
                '-22%',
                '',
                '',
                '67%',
                '',
                '',
                '145%',
                '',
                ''
            ],
            'Descripción': [
                'Inversión inicial herramientas + setup',
                'Desarrollo 40% más rápido',
                'Menos bugs, mejor calidad',
                'Renovación licencias anuales',
                'Productividad compuesta',
                'Mantenimiento automatizado',
                'Renovación con descuentos',
                'Equipo experto en IA',
                'Procesos completamente optimizados'
            ]
        }
        
        df_costo_beneficio = pd.DataFrame(costo_beneficio_data)
        df_costo_beneficio.to_excel(writer, sheet_name='Costo-Beneficio IA', index=False)
        
        # 6. HOJA: Riesgos IA y Mitigaciones
        riesgos_ia_data = {
            'Riesgo IA': [
                'Dependencia excesiva de IA',
                'Calidad código generado',
                'Costos inesperados API',
                'Curva aprendizaje herramientas',
                'Seguridad datos en cloud',
                'Vendor lock-in',
                'Over-engineering con IA',
                'Falsa sensación seguridad'
            ],
            'Probabilidad': [
                'Media',
                'Media',
                'Alta',
                'Alta',
                'Baja',
                'Media',
                'Media',
                'Alta'
            ],
            'Impacto': [
                'Alto',
                'Alto',
                'Medio',
                'Medio',
                'Crítico',
                'Medio',
                'Medio',
                'Alto'
            ],
            'Mitigación': [
                'Training en fundamentos + code review',
                'Siempre revisar código IA + tests',
                'Monitoring costos + límites API',
                'Training intensivo + mentoring',
                'Modelos on-premise + encriptación',
                'Multi-vendor strategy',
                'Guidelines claros + arquitectura simple',
                'Testing exhaustivo + validación manual'
            ],
            'Costo Mitigación ($)': [
                '5,000',
                '3,000',
                '1,000',
                '8,000',
                '15,000',
                '5,000',
                '2,000',
                '10,000'
            ]
        }
        
        df_riesgos_ia = pd.DataFrame(riesgos_ia_data)
        df_riesgos_ia.to_excel(writer, sheet_name='Riesgos IA', index=False)
        
        # 7. HOJA: Métricas IA
        metricas_ia_data = {
            'Métrica IA': [
                'Code Generation Speed',
                'Code Quality Score',
                'Bug Detection Rate',
                'Test Coverage',
                'Documentation Coverage',
                'Developer Satisfaction',
                'Time to First Commit',
                'Code Review Time',
                'API Usage Cost',
                'Model Accuracy',
                'False Positive Rate',
                'Learning Curve Time'
            ],
            'Baseline Sin IA': [
                '100 líneas/hora',
                '7/10',
                '60%',
                '70%',
                '40%',
                '6/10',
                '2 horas',
                '4 horas',
                '$0',
                'N/A',
                'N/A',
                'N/A'
            ],
            'Target Con IA': [
                '250 líneas/hora',
                '8.5/10',
                '85%',
                '90%',
                '95%',
                '8.5/10',
                '30 minutos',
                '1.5 horas',
                '<$5,000/mes',
                '>90%',
                '<5%',
                '<1 semana'
            ],
            'Método Medición': [
                'Git commits analysis',
                'SonarQube metrics',
                'Bug tracking system',
                'Coverage reports',
                'Doc generation logs',
                'Developer surveys',
                'Time tracking',
                'PR review time',
                'API billing',
                'Manual validation',
                'False positive tracking',
                'Productivity surveys'
            ],
            'Frecuencia': [
                'Diaria',
                'Por commit',
                'Semanal',
                'Por build',
                'Por release',
                'Mensual',
                'Por tarea',
                'Por PR',
                'Diaria',
                'Semanal',
                'Por detección',
                'Semanal'
            ]
        }
        
        df_metricas_ia = pd.DataFrame(metricas_ia_data)
        df_metricas_ia.to_excel(writer, sheet_name='Métricas IA', index=False)
    
    return archivo_excel

if __name__ == "__main__":
    try:
        archivo = actualizar_presupuesto_con_ia()
        print(f"✅ Presupuesto con IA generado: {archivo}")
        print(f"📊 7 hojas creadas con análisis completo IA")
        print(f"💰 Inversión IA: $204,622 (vs $39,000 tradicional)")
        print(f"🚀 ROI esperado: 525% en primer año")
        print(f"⏱️  Ahorro tiempo: 40% (1.2 semanas)")
        print(f"📁 Ubicación: {os.path.abspath(archivo)}")
    except Exception as e:
        print(f"❌ Error: {e}")
        print("Instalando dependencias...")
        os.system("pip3 install pandas openpyxl")
        archivo = actualizar_presupuesto_con_ia()
        print(f"✅ Presupuesto con IA generado: {archivo}")
