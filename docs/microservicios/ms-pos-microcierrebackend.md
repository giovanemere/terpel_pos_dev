# MS POS Microcierre Backend

## Descripción

Microservicio backend que proporciona la lógica de negocio para la aplicación de microcierre. Procesa solicitudes de microcierre, calcula totales y genera reportes para los operadores de estación.

## Información Técnica

| Atributo | Valor |
|----------|-------|
| **Nombre del Proyecto** | ap31tpt-terpelpos-transicion-ms-pos-microcierrebackend |
| **Tecnología** | Node.js + TypeScript |
| **Base de Datos** | PostgreSQL |
| **Puerto** | 3005 (configurable) |
| **Arquitectura** | Clean Architecture |

## Estructura del Proyecto

```
src/
├── Application/        # Casos de uso
├── Domain/            # Entidades y reglas de negocio
├── Infrastructure/    # Implementaciones técnicas
├── Presentation/      # Controladores y DTOs
└── Config/           # Configuraciones
```

## Funcionalidades Principales

### 1. Procesamiento de Microcierres
- Cálculo de ventas por período
- Consolidación de medios de pago
- Validación de diferencias
- Generación de reportes

### 2. Consultas de Datos
- Ventas por producto
- Transacciones por operador
- Resúmenes por turno
- Históricos de microcierre

## Endpoints API

### POST /microcierre/generar
Genera un nuevo microcierre.

### GET /microcierre/datos/{estacionId}
Obtiene datos para microcierre de una estación.

### GET /microcierre/reporte/{microcierreId}
Genera reporte de microcierre.

## Configuración

### Variables de Entorno
```bash
DB_HOST=localhost
DB_NAME=terpel_pos_microcierre
REPORT_TEMPLATE_PATH=./templates
CACHE_TTL=300
```

## Instalación y Ejecución

```bash
yarn install
yarn build
yarn start:prod
yarn test
```
