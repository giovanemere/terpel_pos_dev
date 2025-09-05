# MS Conciliación Medios de Pago

## Descripción

Microservicio especializado en la conciliación automática de medios de pago entre las transacciones POS y los reportes de entidades financieras. Identifica diferencias y facilita la reconciliación contable.

## Información Técnica

| Atributo | Valor |
|----------|-------|
| **Nombre del Proyecto** | ap31tpt-terpelpos-transicion-ms-conciliacion-medios-pago |
| **Tecnología** | Node.js + NestJS |
| **Base de Datos** | PostgreSQL |
| **Puerto** | 3008 (configurable) |

## Funcionalidades Principales

### 1. Conciliación Automática
- Comparación de transacciones POS vs reportes bancarios
- Identificación de diferencias
- Matching automático por monto y fecha
- Generación de reportes de conciliación

### 2. Gestión de Medios de Pago
- Tarjetas de crédito y débito
- Transferencias bancarias
- Pagos móviles
- Vales y cupones

### 3. Reportería
- Reportes de diferencias
- Estados de conciliación
- Análisis de tendencias
- Alertas automáticas

## Endpoints API

### POST /conciliacion/procesar
Ejecuta proceso de conciliación.

### GET /conciliacion/diferencias
Lista diferencias encontradas.

### POST /conciliacion/ajustar
Registra ajustes manuales.

### GET /conciliacion/reporte/{fecha}
Genera reporte de conciliación.

## Configuración

### Variables de Entorno
```bash
DB_HOST=localhost
DB_NAME=terpel_pos_conciliacion
BANK_API_URL=https://api.banco.com
TOLERANCE_AMOUNT=100
CONCILIATION_SCHEDULE=0 2 * * *
```

## Reglas de Conciliación

### Matching Automático
- Coincidencia exacta de monto
- Diferencia de fecha máxima: 2 días
- Referencia de transacción
- Número de autorización

### Tolerancias
- Diferencias menores a $100: Auto-aprobadas
- Diferencias mayores: Revisión manual
- Transacciones duplicadas: Alerta automática

## Instalación y Ejecución

```bash
yarn install
yarn start:dev
yarn test
```

## Integración

### APIs Externas
- Bancos y entidades financieras
- Procesadores de pago
- Sistemas contables

### Servicios Internos
- MS Sincronización Ventas
- APIs Frontend
- Sistema de reportes
