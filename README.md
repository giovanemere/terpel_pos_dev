# Terpel POS - Ecosistema de Transición

![Terpel Logo](https://portalcolombia.terpel.com/static/images/terpel_logo_og.png)

## 📋 Descripción

Este repositorio contiene el ecosistema completo de aplicaciones Terpel POS en proceso de transición hacia una arquitectura de microservicios moderna. El proyecto incluye múltiples componentes que trabajan en conjunto para gestionar las operaciones de punto de venta en las estaciones de servicio Terpel.

## 📂 Repositorios

El proyecto está disponible en dos repositorios:

### Repositorio Principal - Azure DevOps
- **URL**: https://periferiaitgrouptfs.visualstudio.com/TERPEL/_git/terpel_dev
- **Propósito**: Repositorio oficial para desarrollo y despliegue
- **Acceso**: Equipo Terpel con credenciales corporativas

### Repositorio Espejo - GitHub
- **URL**: https://github.com/giovanemere/terpel_pos_dev
- **Propósito**: Repositorio de respaldo y colaboración externa
- **Acceso**: Público para consulta

### Sincronización
Los cambios se sincronizan entre ambos repositorios. El repositorio de Azure DevOps es la fuente de verdad para el desarrollo activo.

## 🏗️ Arquitectura del Sistema

El ecosistema está compuesto por:

- **8 Microservicios Backend** para sincronización y procesamiento
- **2 ETLs** para procesamiento de datos
- **3 APIs Frontend** para interfaces de usuario
- **1 Aplicación Frontend** de escritorio (Electron)
- **1 Servicio Auxiliar** para funcionalidades específicas

## 📊 Estado del Proyecto

| Componente | Estado | Progreso |
|------------|--------|----------|
| Microservicios Backend | 🟡 En desarrollo | 70% |
| ETL y Procesamiento | 🟡 En desarrollo | 60% |
| APIs Frontend | 🟢 Estable | 80% |
| Frontend Desktop | 🟡 En desarrollo | 65% |
| Servicios Auxiliares | 🔴 Inicial | 40% |

## 🚀 Componentes del Sistema

### Microservicios Backend
- `ap31tpt-terpelpos-transicion-ms-pos-sincronizacion-jornadas` - Sincronización de jornadas laborales
- `ap31tpt-terpelpos-transicion-ms-pos-sincronizacion-sales` - Sincronización de ventas
- `ap31tpt-terpelpos-transicion-ms-pos-sincronizacion-anulaciones` - Sincronización de anulaciones
- `ap31tpt-terpelpos-transicion-ms-pos-sincronizador-turnos-ho` - Sincronización de turnos con HO
- `ap31tpt-terpelpos-transicion-ms-pos-sync-cierre-turno` - Sincronización de cierre de turno
- `ap31tpt-terpelpos-transicion-ms-pos-microcierrebackend` - Backend para microcierres
- `ap31tpt-terpelpos-transicion-ms-pos-synchronizer-pos-web` - Sincronizador POS-Web
- `ap31tpt-terpelpos-transicion-ms-pos-node-turnos` - Gestión de turnos

### ETL y Procesamiento
- `ap31tpt-terpelpos-transicion-ms-ho-etl-ventas` - ETL de ventas
- `ap31tpt-terpelpos-transicion-ms-ho-etl-venta-historica` - ETL de ventas históricas

### APIs Frontend
- `ap31tpt-terpelpos-transicion-ms-ho-frontal-node-ventas` - API para consultas de ventas
- `ap31tpt-terpelpos-transicion-ms-ho-frontal-node-cierres` - API para gestión de cierres
- `ap31tpt-terpelpos-transicion-ms-ho-frontal-node-anulacion` - API para anulaciones

### Frontend
- `ap31tpt-terpelpos-transicion-ft-pos-microcierrefront` - Aplicación Electron para microcierres

### Servicios Auxiliares
- `ap31tpt-terpelpos-transicion-ms-conciliacion-medios-pago` - Conciliación de medios de pago

## 🛠️ Tecnologías Utilizadas

- **Backend**: Node.js, NestJS, TypeScript
- **Frontend**: React, Electron, TypeScript
- **Base de Datos**: PostgreSQL
- **DevOps**: Azure DevOps, Docker
- **Testing**: Jest, Supertest
- **Documentación**: MkDocs Material

## 📚 Documentación

### Acceso a la Documentación

La documentación completa del proyecto está disponible en formato MkDocs. Para acceder a ella:

#### Opción 1: Visualización Local

```bash
# Instalar MkDocs Material
pip install mkdocs-material

# Instalar plugins adicionales
pip install mkdocs-git-revision-date-localized-plugin

# Navegar al directorio del proyecto
cd /home/giovanemere/terpel/terpel_pos_dev

# Servir la documentación localmente
mkdocs serve

# Acceder en el navegador
# http://localhost:8000
```

#### Opción 2: Build para Producción

```bash
# Generar sitio estático
mkdocs build

# Los archivos se generan en ./site/
# Pueden ser servidos por cualquier servidor web
```

### Estructura de la Documentación

```
docs/
├── index.md                    # Página principal
├── arquitectura/               # Documentación de arquitectura
│   ├── vision-general.md       # Visión general del sistema
│   ├── diagrama-componentes.md # Diagramas de componentes
│   └── flujos-datos.md         # Flujos de datos
├── microservicios/             # Documentación de microservicios
│   ├── ms-pos-sincronizacion-jornadas.md
│   ├── ms-pos-sincronizacion-sales.md
│   └── ...
├── etl/                        # Documentación de ETLs
├── apis/                       # Documentación de APIs
├── frontend/                   # Documentación de frontend
├── servicios/                  # Servicios auxiliares
├── despliegue/                 # CI/CD y despliegue
│   ├── cicd.md                 # Pipelines CI/CD
│   ├── azure-config.md         # Configuración Azure
│   └── variables-entorno.md    # Variables de entorno
└── estado/                     # Estado del proyecto
    ├── roadmap.md              # Roadmap y planificación
    ├── issues.md               # Issues conocidos
    └── plan-migracion.md       # Plan de migración
```

### Contenido Disponible

#### ✅ Documentación Completada
- **Página Principal**: Visión general del ecosistema
- **Arquitectura General**: Principios y patrones arquitectónicos
- **MS Sincronización Jornadas**: Documentación completa del microservicio
- **MS Sincronización Sales**: Documentación completa del microservicio
- **Frontend Microcierre**: Documentación de la aplicación Electron
- **CI/CD**: Estrategia completa de despliegue
- **Roadmap**: Plan de desarrollo 2024

#### 🔄 En Progreso
- Documentación de microservicios restantes
- Diagramas de componentes detallados
- Guías de configuración específicas
- Documentación de APIs

#### 📋 Pendiente
- Documentación de ETLs
- Guías de troubleshooting
- Documentación de operaciones
- Métricas y monitoreo

## 🚀 Inicio Rápido

### Prerrequisitos
- Node.js 18.17.1+
- PostgreSQL 12+
- Yarn
- Docker (opcional)

### Configuración del Entorno

1. **Clonar el repositorio**
```bash
git clone <repository-url>
cd terpel_pos_dev
```

2. **Configurar cada microservicio**
```bash
# Para cada directorio de microservicio
cd ap31tpt-terpelpos-transicion-ms-pos-sincronizacion-jornadas
yarn install
cp .env.example .env
# Configurar variables de entorno
```

3. **Configurar base de datos**
```bash
# Crear bases de datos necesarias
createdb terpel_pos_jornadas
createdb terpel_pos_sales
# ... etc
```

4. **Ejecutar servicios**
```bash
# En cada directorio de servicio
yarn start:dev
```

## 📋 Plan de Documentación

### Fase 1: Documentación Base (Completada)
- [x] Configuración MkDocs
- [x] Estructura de navegación
- [x] Documentación de arquitectura
- [x] Documentación de servicios principales
- [x] CI/CD y despliegue

### Fase 2: Documentación Detallada (En Progreso)
- [ ] Documentación de todos los microservicios
- [ ] Guías de configuración
- [ ] Documentación de APIs
- [ ] Diagramas técnicos

### Fase 3: Documentación Operativa (Pendiente)
- [ ] Guías de troubleshooting
- [ ] Runbooks operativos
- [ ] Métricas y alertas
- [ ] Procedimientos de emergencia

## 🔗 Enlaces Útiles

- **Wiki DevSecOps**: [DevSecOps Terpel](https://dev.azure.com/organizacionterpel/ProjectDevSecOps/_wiki/wikis/ProjectDevSecOps.wiki/269/DevSecOps-Terpel)
- **CI/CD Guidelines**: [Continuous Integration](https://dev.azure.com/organizacionterpel/ProjectDevSecOps/_wiki/wikis/ProjectDevSecOps.wiki/611/Continuous-Integration-(CI))
- **SonarCloud**: [Proyectos SonarCloud](https://dev.azure.com/organizacionterpel/ProjectDevSecOps/_wiki/wikis/ProjectDevSecOps.wiki/658/Creaci%C3%B3n-de-proyecto-de-SonarCloud)

## 🤝 Contribuir

### Contribuir al Código
1. Fork el repositorio
2. Crear feature branch (`git checkout -b feature/nueva-funcionalidad`)
3. Commit cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push al branch (`git push origin feature/nueva-funcionalidad`)
5. Crear Pull Request

### Contribuir a la Documentación
1. Editar archivos en `/docs`
2. Probar localmente con `mkdocs serve`
3. Seguir el mismo proceso de PR

### Estándares de Contribución
- Seguir convenciones de naming
- Incluir tests para nuevo código
- Actualizar documentación
- Pasar quality gates (SonarCloud)

## 📞 Contacto y Soporte

- **Equipo Técnico**: Terpel POS Development Team
- **Slack**: #terpel-pos-dev
- **Email**: pos-dev@terpel.com
- **Azure DevOps**: [Proyecto Terpel POS](https://dev.azure.com/organizacionterpel/TerpelPOS)

## 📄 Licencia

Este proyecto es propiedad de Terpel S.A. y está sujeto a las políticas internas de la organización.

---

*Última actualización: Enero 2024*
*Documentación generada con MkDocs Material*
