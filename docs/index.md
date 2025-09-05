# Documentación Terpel POS - Transición

![Terpel Logo](https://portalcolombia.terpel.com/static/images/terpel_logo_og.png)

## Bienvenido a la Documentación del Ecosistema Terpel POS

Esta documentación contiene toda la información técnica del ecosistema de aplicaciones Terpel POS en proceso de transición. El proyecto incluye múltiples microservicios, APIs, ETLs y aplicaciones frontend que trabajan en conjunto para gestionar las operaciones de punto de venta.

## 🏗️ Arquitectura del Sistema

El ecosistema Terpel POS está compuesto por:

- **15 Microservicios** distribuidos en diferentes responsabilidades
- **3 ETLs** para procesamiento de datos
- **3 APIs Frontend** para interfaz de usuario
- **1 Aplicación Frontend** de escritorio
- **Servicios auxiliares** para funcionalidades específicas

## 📊 Estado Actual del Proyecto

### Resumen Ejecutivo
El proyecto Terpel POS se encuentra en fase de **desarrollo activo** con múltiples componentes en diferentes etapas de madurez. La arquitectura de microservicios está siendo implementada progresivamente, con un enfoque en la estabilidad y la escalabilidad.

### Métricas Generales
| Métrica | Valor | Estado |
|---------|-------|--------|
| **Componentes Totales** | 15 | 📊 En desarrollo |
| **Microservicios** | 8 | 🟡 70% completado |
| **ETLs** | 2 | 🟡 60% completado |
| **APIs Frontend** | 3 | 🟢 80% completado |
| **Frontend Apps** | 1 | 🟡 65% completado |
| **Servicios Auxiliares** | 1 | 🔴 40% completado |
| **Cobertura de Tests** | 65% | 🟡 En progreso |
| **Documentación** | 22% | 🔴 En progreso |

## 📋 Estado Detallado por Repositorio

### 🔧 Microservicios Backend

| Repositorio | Estado | Progreso | Documentación | Última Actualización |
|-------------|--------|----------|---------------|---------------------|
| **ms-pos-sincronizacion-jornadas** | 🟡 Desarrollo | 75% | ✅ Completa | 2024-01-15 |
| **ms-pos-sincronizacion-sales** | 🟢 Estable | 85% | ✅ Completa | 2024-01-10 |
| **ms-pos-sincronizacion-anulaciones** | 🟡 Desarrollo | 80% | ❌ Pendiente | 2024-01-12 |
| **ms-pos-sincronizador-turnos-ho** | 🟡 Desarrollo | 70% | ❌ Pendiente | 2024-01-08 |
| **ms-pos-sync-cierre-turno** | 🟡 Desarrollo | 65% | ❌ Pendiente | 2024-01-14 |
| **ms-pos-microcierrebackend** | 🟡 Desarrollo | 70% | ❌ Pendiente | 2024-01-11 |
| **ms-pos-synchronizer-pos-web** | 🔴 Inicial | 45% | ❌ Pendiente | 2024-01-09 |
| **ms-pos-node-turnos** | 🔴 Inicial | 40% | ❌ Pendiente | 2024-01-13 |

### 📊 ETL y Procesamiento

| Repositorio | Estado | Progreso | Documentación | Última Actualización |
|-------------|--------|----------|---------------|---------------------|
| **ms-ho-etl-ventas** | 🟡 Desarrollo | 60% | ❌ Pendiente | 2024-01-12 |
| **ms-ho-etl-venta-historica** | 🔴 Inicial | 35% | ❌ Pendiente | 2024-01-10 |

### 🌐 APIs Frontend

| Repositorio | Estado | Progreso | Documentación | Última Actualización |
|-------------|--------|----------|---------------|---------------------|
| **ms-ho-frontal-node-ventas** | 🟢 Estable | 85% | ❌ Pendiente | 2024-01-08 |
| **ms-ho-frontal-node-cierres** | 🟢 Estable | 80% | ❌ Pendiente | 2024-01-12 |
| **ms-ho-frontal-node-anulacion** | 🟡 Desarrollo | 50% | ❌ Pendiente | 2024-01-14 |

### 💻 Frontend Applications

| Repositorio | Estado | Progreso | Documentación | Última Actualización |
|-------------|--------|----------|---------------|---------------------|
| **ft-pos-microcierrefront** | 🟡 Desarrollo | 65% | ✅ Completa | 2024-01-15 |

### 🛠️ Servicios Auxiliares

| Repositorio | Estado | Progreso | Documentación | Última Actualización |
|-------------|--------|----------|---------------|---------------------|
| **ms-conciliacion-medios-pago** | 🔴 Inicial | 40% | ❌ Pendiente | 2024-01-11 |

### 📈 Resumen por Estado

#### 🟢 Componentes Estables (3)
- ms-pos-sincronizacion-sales
- ms-ho-frontal-node-ventas  
- ms-ho-frontal-node-cierres

#### 🟡 Componentes en Desarrollo (8)
- ms-pos-sincronizacion-jornadas
- ms-pos-sincronizacion-anulaciones
- ms-pos-sincronizador-turnos-ho
- ms-pos-sync-cierre-turno
- ms-pos-microcierrebackend
- ms-ho-etl-ventas
- ms-ho-frontal-node-anulacion
- ft-pos-microcierrefront

#### 🔴 Componentes en Fase Inicial (4)
- ms-pos-synchronizer-pos-web
- ms-pos-node-turnos
- ms-ho-etl-venta-historica
- ms-conciliacion-medios-pago

## 🚀 Componentes Principales

### Microservicios de Sincronización
- **Sincronización Jornadas**: Gestión de jornadas laborales
- **Sincronización Ventas**: Procesamiento de transacciones de venta
- **Sincronización Anulaciones**: Manejo de anulaciones de transacciones
- **Sincronizador Turnos HO**: Coordinación de turnos con Head Office

### ETL y Procesamiento de Datos
- **ETL Ventas**: Extracción, transformación y carga de datos de ventas
- **ETL Venta Histórica**: Procesamiento de datos históricos

### APIs y Frontend
- **APIs Node.js**: Interfaces para ventas, cierres y anulaciones
- **Frontend Electron**: Aplicación de escritorio para microcierre

## 🛠️ Tecnologías Utilizadas

- **Backend**: Node.js, NestJS, TypeScript
- **Frontend**: React, Electron, TypeScript
- **Base de Datos**: PostgreSQL
- **DevOps**: Azure DevOps, Docker
- **Testing**: Jest, Supertest

## 📋 Plan de Documentación

Este sitio está en construcción activa. El plan incluye:

1. **Documentación de Arquitectura** - Diagramas y flujos del sistema
2. **Documentación Individual** - Cada microservicio y componente
3. **Guías de Despliegue** - CI/CD y configuración
4. **Estado del Proyecto** - Roadmap y issues conocidos

## 🔗 Enlaces Útiles

- [Wiki DevSecOps Terpel](https://dev.azure.com/organizacionterpel/ProjectDevSecOps/_wiki/wikis/ProjectDevSecOps.wiki/269/DevSecOps-Terpel)
- [Continuous Integration](https://dev.azure.com/organizacionterpel/ProjectDevSecOps/_wiki/wikis/ProjectDevSecOps.wiki/611/Continuous-Integration-(CI))
- [Continuous Delivery](https://dev.azure.com/organizacionterpel/ProjectDevSecOps/_wiki/wikis/ProjectDevSecOps.wiki/433/Continuous-Delivery-y-Continous-Deployment-(CD))

## 📝 Contribuir a la Documentación

Para contribuir a esta documentación:

1. Clona el repositorio
2. Instala MkDocs: `pip install mkdocs-material`
3. Ejecuta localmente: `mkdocs serve`
4. Edita los archivos en `/docs`
5. Envía un pull request

---

*Última actualización: $(date)*
*Mantenido por: Equipo Terpel POS*
