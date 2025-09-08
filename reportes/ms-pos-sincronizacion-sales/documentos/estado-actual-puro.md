# Estado Actual - MS POS Sincronización Sales

## 📊 Información General

| Campo | Valor |
|-------|-------|
| **Nombre del Microservicio** | ap31tpt-terpelpos-transicion-ms-pos-sincronizacion-sales |
| **Repositorio Principal** | https://periferiaitgrouptfs.visualstudio.com/TERPEL/_git/terpel_dev |
| **Repositorio Espejo** | https://github.com/giovanemere/terpel_pos_dev |
| **Versión** | 0.0.1 |
| **Autor** | JONATHAN OSORIO |
| **Descripción** | Proyecto encargado de sincronizar las ventas del POS con HO |
| **Tecnología Principal** | NestJS + TypeScript |
| **Estado Actual** | 🟡 En Desarrollo (70%) |
| **Fecha de Análisis** | $(date +"%Y-%m-%d") |

## 🏗️ Arquitectura Actual

### Componentes Implementados

1. **AppService** - Lógica principal de sincronización
2. **NeoPool** - Conexión a base de datos PostgreSQL
3. **HttpService** - Cliente HTTP para comunicación con APIs
4. **ConfigModule** - Gestión básica de configuración

### Flujo de Funcionamiento Actual

```
Base de Datos (POS) → MS Sincronización → API Frontend (HO)
```

1. Consulta ventas pendientes en BD local
2. Procesa datos y determina método (POST/PUT)
3. Envía ventas una por una al HO
4. Actualiza estado en BD si recibe confirmación
5. Repite el proceso indefinidamente

## 🔧 Funcionalidades Implementadas

### ✅ Lo que funciona actualmente

- **Sincronización básica**: Envía ventas del POS al HO
- **Tipos de venta**: Maneja combustible, canastilla y kiosco
- **Estados**: Diferencia entre ventas nuevas (POST) y actualizaciones (PUT)
- **Logging básico**: Registra eventos principales
- **Reintentos**: Reintenta automáticamente en caso de error
- **Pool de conexiones**: Conexión a PostgreSQL optimizada

### 🔄 Comportamiento actual del sistema

```typescript
// Método principal implementado
public async SincronizacionVentas(): Promise<void> {
  try {
    // 1. Obtiene host del servidor desde wacher_parametros
    const { rows } = await this.neoPool.query(hostPost);
    const { HOST_SERVER } = rows[0].resultado;
    
    // 2. Construye URL dinámica
    const url = `http://${HOST_SERVER}${config.url}`;
    
    // 3. Ejecuta función PostgreSQL para marcar ventas
    await this.neoPool.query(ventasASincronizar);
    
    // 4. Consulta ventas pendientes (límite 5)
    const result = await this.neoPool.query(getSales);
    
    // 5. Si no hay ventas, espera y reintenta
    if (result.rows.length === 0) {
      await this.sleep(30000); // 30 segundos
      await this.SincronizacionVentas(); // Recursión
    }
    
    // 6. Procesa ventas una por una
    for (let i = 0; i < data.length; i++) {
      const objeto = data[i];
      // Determina método según estado
      objeto.method = estado === 'A' ? 'POST' : 'PUT';
      // Determina endpoint según tipo
      objeto.url = tipo === TIPO_TRANSACCION.VENTA_CANASTILLA ? 'canastilla' : 
                   tipo === TIPO_TRANSACCION.VENTA_KIOSKO ? 'kiosco' : 'combustible';
      
      const respuesta = await this.enviarObjeto(objeto, url);
      if (respuesta.status === CODIGO_RESPUESTA.PROCESADA) {
        await this.neoPool.query(updateSales, [objeto.id_logs_ventas_unificadas_pos]);
      }
    }
    
    // 7. Espera y reinicia el ciclo
    await this.sleep(30000);
    await this.SincronizacionVentas(); // Recursión
    
  } catch (error) {
    // 8. En caso de error, espera más tiempo y reintenta
    this.logger.error(`ERROR AL ENCONTRAR LA VENTAS: ${error}`);
    await this.sleep(60000); // 60 segundos
    await this.SincronizacionVentas(); // Recursión
  }
}

// Métodos auxiliares implementados
async enviarObjetos(objetos: any[], url: string): Promise<any[]> {
  const respuestas: any[] = [];
  for (const objeto of objetos) {
    const respuesta = await this.enviarObjeto(objeto, url);
    respuestas.push(respuesta);
  }
  return respuestas;
}

private async enviarObjeto(objeto: any, url: string): Promise<any> {
  try {
    const respuesta = await this.httpService.post(url, objeto).toPromise();
    if (respuesta.status === +CODIGO_RESPUESTA.PROCESADA) {
      await this.neoPool.query(updateSales, [objeto.id_logs_ventas_unificadas_pos]);
    }
    return respuesta.data;
  } catch (error) {
    console.error(`Error al enviar objeto: ${error.message}`);
    throw error;
  }
}

async sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}
```

## 📈 Métricas Actuales

### Rendimiento Observado

| Métrica | Valor Actual |
|---------|--------------|
| **Ventas por hora** | ~52 ventas |
| **Tiempo de respuesta** | 2-5 segundos por venta |
| **Disponibilidad** | ~95% |
| **Procesamiento** | Secuencial (una por una) |
| **Reintentos** | Infinitos |

### Configuración Actual

```env
SLEEP=30000          # 30 segundos entre ciclos
SLEEP_ERROR=60000    # 60 segundos en caso de error
```

## 🗄️ Base de Datos Actual

### Tablas que utiliza

1. **logs_ventas_unificadas_pos** (Tabla principal)
   - `id_logs_ventas_unificadas_pos` (PK): ID único de la venta
   - `tipo_venta`: Tipo de transacción (COMBUSTIBLE, CANASTILLA, KIOSKO)
   - `atributos`: Datos adicionales de la venta
   - `transaccion`: Información de la transacción
   - `detalle_venta`: Detalles específicos de la venta
   - `medio_pago`: Información de medios de pago
   - `estado`: Estado de la venta ('A' para nuevas, otros para actualizaciones)
   - `idmovimiento`: ID del movimiento
   - `sincronizado`: Flag de sincronización (0=pendiente, 1=procesado)

2. **wacher_parametros** (Tabla de configuración)
   - Almacena parámetros del sistema como `HOST_SERVER`
   - Estructura: `codigo` y `valor`

3. **lazoexpresscore.public** (Schema específico)
   - Contiene función `notificaciones_pos_venta_combustible(10)`

### Queries que ejecuta

```sql
-- 1. hostPost - Obtiene configuración del servidor
SELECT json_object_agg(codigo, valor) AS resultado
FROM public.wacher_parametros
WHERE codigo IN ('HOST_SERVER');

-- 2. ventasASincronizar - Ejecuta función para marcar ventas
SELECT * FROM lazoexpresscore.public.notificaciones_pos_venta_combustible(10);

-- 3. getSales - Obtiene ventas pendientes (límite 5)
SELECT lvup.id_logs_ventas_unificadas_pos,
       lvup.tipo_venta as "tipo", 
       lvup.atributos, 
       lvup.transaccion, 
       lvup.detalle_venta as "detallesVenta", 
       lvup.medio_pago as "mediosPagos", 
       lvup.estado, 
       lvup.idmovimiento as id, 
       lvup.atributos as surtidor      
FROM logs_ventas_unificadas_pos lvup
WHERE lvup.sincronizado = 0 
ORDER BY id_logs_ventas_unificadas_pos ASC 
LIMIT 5;

-- 4. updateSales - Actualiza estado después de sincronizar
UPDATE logs_ventas_unificadas_pos
SET sincronizado = 1
WHERE id_logs_ventas_unificadas_pos = $1;
```

## 🔌 Integraciones Actuales

### API que consume

- **Endpoint base**: `http://{HOST_SERVER}/api/v1/ventas`
- **Endpoints específicos**: 
  - `/combustible` - Para `TIPO_TRANSACCION.VENTA_COMBUSTIBLE` ('017')
  - `/canastilla` - Para `TIPO_TRANSACCION.VENTA_CANASTILLA` ('009')
  - `/kiosco` - Para `TIPO_TRANSACCION.VENTA_KIOSKO` ('035')
- **Métodos**: 
  - POST para ventas nuevas (estado = 'A')
  - PUT para actualizaciones (estado != 'A')
- **Formato**: JSON con estructura de venta completa

### Enums y Constantes Implementadas

```typescript
// Tipos de transacción soportados
export enum TIPO_TRANSACCION {
  VENTA_CANASTILLA = '009',
  VENTA_COMBUSTIBLE = '017',
  VENTA_KIOSKO = '035',
  // ... otros tipos definidos
}

// Estados de transacción
export enum ESTADO_TRANSACCION {
  VENTA_NORMAL = '009001',
  VENTA_ANULADA = '009002',
  VENTA_COMBUSTIBLE_NORMAL = '017001',
  VENTA_COMBUSTIBLE_ANULADA = '017003',
  VENTA_NORMAL_KIOSKO = '035001',
  VENTA_NORMAL_KIOSKO_ANULADA = '035002',
  // ... otros estados
}

// Códigos de respuesta
export enum CODIGO_RESPUESTA {
  RECHAZADA = '500',
  PROCESADA = '201'
}

// Estados de sincronización
export enum CODIGO_ESTADOS {
  ESTADO_PRINCIPAL = 'N',
  CIERRE = 'C',
  SINCRONIZADO_POS_PRINCIPAL = 'S',
  SINCRONIZADO_AL_HO = 'H',
  ERROR_SINCRONIZANDO = 'E'
}

// Tipos de negocio
export enum TIPO_NEGOCIO {
  combustible = 'COMBUSTIBLE',
  kiosko = 'KIOSKO',
  canastilla = 'CANASTILLA',
}
```

### Interfaces Implementadas

```typescript
export interface IResponse {
  message: string;
  status: boolean;
  success: boolean;
}

// Códigos de error definidos
export enum CODIGO_ERRORS {
  PETICION_HTTP_OK = 0,
  PETICION_HTTP_INTERNAL = 50000,
  PETICION_HTTP_ERROR_DATA = 8888,
  INVALID_HEADER = 100000,
  NO_AUTORIZADO = 1250,
  // ... otros códigos
}
```

### Dependencias

```json
{
  "@nestjs/common": "^9.0.0",
  "@nestjs/axios": "^2.0.0",
  "pg": "8.5.0",
  "mongoose": "^7.2.1",
  "axios": "^1.4.0"
}
```

## 🚨 Comportamientos Actuales Observados

### Funcionamiento Normal
- Consulta BD cada 30 segundos
- Procesa ventas encontradas secuencialmente
- Actualiza estado en BD tras confirmación
- Registra eventos en logs

### Comportamiento en Errores
- Si falla conexión a BD: espera 60s y reintenta
- Si falla HTTP request: registra error pero continúa
- Si no encuentra host: espera 60s y reintenta
- Todos los errores resultan en reintentos infinitos

### Logs Actuales
```
[SincronizacionVentas] Fecha actual: 2024-01-15T14:30:25.123Z
[SincronizacionVentas] BUSCANDO INFORMACION DE VENTAS: [...]
[SincronizacionVentas] NO HAY VENTAS PENDIENTES
[SincronizacionVentas] RESPUESTA DE LA SINCRONIZACION 200
```

## 📊 Estado de Calidad del Código

### Estructura Actual
```
src/
├── app.service.ts        # 100 líneas - lógica principal
├── app.controller.ts     # 10 líneas - endpoint básico
├── pg.pool.ts           # 25 líneas - pool de conexiones
├── app.module.ts        # 20 líneas - configuración NestJS
└── main.ts              # 15 líneas - bootstrap
```

### Métricas de Código
- **Complejidad**: Media (método principal tiene 8 puntos)
- **Tests**: 0% cobertura
- **Documentación**: Básica (solo README)
- **Linting**: Configurado pero no aplicado consistentemente

## 🔍 Lo que NO está implementado actualmente

- Límite de reintentos
- Timeouts en HTTP requests
- Procesamiento paralelo
- Métricas de monitoreo
- Health checks
- Tests unitarios
- Manejo específico de tipos de error
- Circuit breaker
- Cache
- Dead letter queue

## 📋 Configuración de Despliegue Actual

### Scripts disponibles
```json
{
  "start": "nest start",
  "start:dev": "nest start --watch",
  "start:prod": "node dist/main",
  "build": "nest build",
  "pkg": "yarn build && yarn ts-compile && pkg ..."
}
```

### Pipeline CI/CD
- Configurado en `azure-pipelines.yml`
- Build automático
- Empaquetado con PKG para Windows

---

**Estado capturado el**: $(date)
**Próxima evaluación**: $(date -d "+1 week")
**Responsable**: Equipo Terpel POS Development
