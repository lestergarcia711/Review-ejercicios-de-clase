# Trabajo realizado en la base de datos

## 1. Introducción

En este proyecto se desarrolló y configuró una base de datos orientada a la gestión de un gimnasio. La estructura permite administrar información relacionada con socios, ciudades, sedes, especialidades de entrenadores, entrenadores, planes de entrenamiento y las asignaciones entre socios y planes.

Además de la creación y carga inicial de las tablas, se implementaron diferentes funcionalidades de MySQL para mejorar la organización, seguridad, automatización e integridad de la información.

Las funcionalidades trabajadas fueron:

* Procedimientos almacenados.
* Funciones.
* Triggers.
* Eventos programados.
* Seguridad y permisos.
* Transacciones.
* Consultas para verificar el funcionamiento de cada componente.

El objetivo principal fue aplicar herramientas de MySQL que permitan construir una base de datos más completa, segura y automatizada.

---

# 2. Estructura general de la base de datos

La base de datos está compuesta principalmente por las siguientes tablas:

| Tabla                         | Descripción                                                    |
| ----------------------------- | -------------------------------------------------------------- |
| `socios`                      | Almacena la información de los socios del gimnasio.            |
| `ciudades`                    | Contiene las ciudades donde existen sedes.                     |
| `sedes`                       | Registra las diferentes sedes del gimnasio.                    |
| `especialidades_entrenadores` | Almacena las especialidades disponibles para los entrenadores. |
| `entrenadores`                | Contiene la información de los entrenadores.                   |
| `planes_entrenamiento`        | Registra los planes de entrenamiento disponibles.              |
| `socio_plan_entrenamiento`    | Relaciona socios, planes, entrenadores y sedes.                |

La tabla `socio_plan_entrenamiento` funciona como una tabla de relación, permitiendo conocer qué plan tiene asignado cada socio, qué entrenador lo atiende y en qué sede se realiza.

---

# 3. Procedimientos almacenados

## Descripción

Se implementaron procedimientos almacenados para encapsular operaciones frecuentes de la base de datos.

Un procedimiento almacenado permite guardar un conjunto de instrucciones SQL dentro del servidor y ejecutarlas posteriormente mediante una llamada.

Esto permite evitar repetir consultas y centralizar determinadas operaciones.

## Procedimientos realizados

Entre los procedimientos desarrollados se encuentran operaciones relacionadas con:

* Consulta de información de socios.
* Consulta de planes de entrenamiento.
* Consulta de entrenadores.
* Registro o actualización de información.
* Consultas que relacionan varias tablas.

## Evidencia

La evidencia de esta sección debe mostrar:

1. El código utilizado para crear los procedimientos.
2. La ejecución mediante `CALL`.
3. El resultado obtenido.

Ejemplo de evidencia:

```sql
CALL nombre_del_procedimiento();
```

---

# 4. Funciones

## Descripción

Se implementaron funciones almacenadas para realizar cálculos o devolver información específica relacionada con la base de datos.

A diferencia de un procedimiento, una función debe devolver un valor.

Las funciones permiten reutilizar operaciones y pueden ser utilizadas directamente dentro de consultas SQL.

## Funciones realizadas

Las funciones desarrolladas pueden estar relacionadas con:

* Cantidad de planes asignados a un socio.
* Cantidad de socios atendidos por un entrenador.
* Consulta de información calculada.
* Cálculos relacionados con los registros almacenados.

Ejemplo de utilización:

```sql
SELECT nombre_funcion(101);
```

También pueden utilizarse dentro de una consulta:

```sql
SELECT 
    socio_id,
    nombre,
    nombre_funcion(socio_id) AS cantidad_planes
FROM socios;
```

## Evidencia

La evidencia debe incluir:

* Código de creación de cada función.
* Ejecución de las funciones.
* Resultado obtenido.


---

# 5. Triggers

## Descripción

Los triggers fueron implementados para automatizar validaciones y controlar determinadas operaciones realizadas sobre las tablas.

Un trigger se ejecuta automáticamente cuando ocurre una operación como:

* `INSERT`
* `UPDATE`
* `DELETE`

En el proyecto se utilizaron principalmente triggers `BEFORE INSERT` para validar información antes de almacenarla.

## Triggers realizados

### Validación de cantidad de planes por socio

Se implementó un trigger encargado de controlar la cantidad máxima de planes que puede tener un socio.

Si el socio alcanza el límite establecido, el trigger impide registrar una nueva asignación.

### Validación de carga del entrenador

Se implementó un trigger para controlar la cantidad de asignaciones que puede tener un entrenador.

Esto permite evitar que un entrenador tenga una cantidad excesiva de socios asignados.

### Prevención de planes duplicados

Se implementó una validación para evitar que un mismo socio tenga registrado el mismo plan de entrenamiento más de una vez.

## Evidencia

Para demostrar el funcionamiento de los triggers se realizaron pruebas exitosas y pruebas donde la operación debía ser rechazada.

### Prueba exitosa

Se realizó una inserción válida:

```sql
INSERT INTO socio_plan_entrenamiento
(socio_paln_entrenamiento_id, socio_id, plan_entrenamiento_id, entrenador_id, sede_id)
VALUES
(1006, 102, 6301, 301, 501);
```

La operación fue aceptada porque cumplía con las reglas establecidas.

### Prueba de validación

Se realizó una inserción que incumplía una regla de negocio.

El trigger detectó la condición y generó un mensaje de error mediante `SIGNAL`.

---

# 6. Eventos

## Descripción

Los eventos permiten ejecutar automáticamente instrucciones SQL de acuerdo con una programación determinada.

A diferencia de los triggers, los eventos no dependen de que un usuario realice un `INSERT`, `UPDATE` o `DELETE`.

Los eventos pueden ejecutarse:

* Una vez.
* Diariamente.
* Semanalmente.
* Mensualmente.
* En intervalos determinados.

## Eventos realizados

Se trabajaron eventos orientados a la automatización y mantenimiento de la información.

Entre las operaciones consideradas se encuentran:

* Actualización automática de registros.
* Limpieza de información antigua.
* Generación periódica de información estadística.

Ejemplo:

```sql
CREATE EVENT generar_reporte_planes
ON SCHEDULE EVERY 1 DAY
DO
INSERT INTO reporte_planes(fecha_reporte, cantidad_planes)
SELECT NOW(), COUNT(*)
FROM socio_plan_entrenamiento;
```

Este evento permite almacenar periódicamente la cantidad de planes registrados.

## Evidencia

Para esta sección se debe demostrar:

1. Creación del evento.
2. Activación del programador de eventos.
3. Consulta de los eventos existentes.
4. Resultado generado por el evento.

Comandos utilizados:

```sql
SET GLOBAL event_scheduler = ON;
```

```sql
SHOW EVENTS;
```

---

# 7. Seguridad y permisos

## Descripción

Se implementó una estructura básica de seguridad utilizando usuarios y privilegios de MySQL.

El objetivo es controlar qué operaciones puede realizar cada usuario sobre la base de datos.

No todos los usuarios deberían tener acceso completo a todas las operaciones.

## Usuarios y permisos

Se pueden establecer diferentes niveles de acceso, por ejemplo:

### Usuario administrador

Puede realizar todas las operaciones necesarias:

* `SELECT`
* `INSERT`
* `UPDATE`
* `DELETE`
* `CREATE`
* `ALTER`
* `DROP`

### Usuario de consulta

Puede consultar información pero no modificarla.

```sql
GRANT SELECT
ON gimnasio.*
TO 'usuario_consulta'@'localhost';
```

### Usuario operativo

Puede consultar y modificar información:

```sql
GRANT SELECT, INSERT, UPDATE
ON gimnasio.*
TO 'usuario_operativo'@'localhost';
```

## Verificación de permisos

Los permisos pueden verificarse mediante:

```sql
SHOW GRANTS FOR 'usuario_consulta'@'localhost';
```
---

# 8. Transacciones

## Descripción

Las transacciones permiten ejecutar varias operaciones como una sola unidad de trabajo.

Esto es importante cuando varias modificaciones dependen unas de otras.

Los principales comandos utilizados son:

```sql
START TRANSACTION;
```

```sql
COMMIT;
```

```sql
ROLLBACK;
```

`COMMIT` confirma los cambios realizados.

`ROLLBACK` permite deshacer los cambios realizados durante la transacción.

## Ejemplo

Una asignación de un plan puede involucrar diferentes operaciones.

```sql
START TRANSACTION;

INSERT INTO socio_plan_entrenamiento
(socio_paln_entrenamiento_id, socio_id, plan_entrenamiento_id, entrenador_id, sede_id)
VALUES
(1010, 103, 6301, 301, 501);

UPDATE socios
SET telefono = '5555-9999'
WHERE socio_id = 103;

COMMIT;
```

Si durante el proceso ocurre un problema y se desea cancelar la operación:

```sql
ROLLBACK;
```

## Evidencia

Para demostrar el funcionamiento de las transacciones se deben presentar dos escenarios.

### Caso 1: COMMIT

1. Iniciar transacción.
2. Realizar operaciones.
3. Ejecutar `COMMIT`.
4. Consultar los datos.
5. Comprobar que los cambios permanecen.

### Caso 2: ROLLBACK

1. Iniciar transacción.
2. Realizar una modificación.
3. Ejecutar `ROLLBACK`.
4. Consultar los datos.
5. Comprobar que la modificación fue revertida.

---

# 9. Resumen de funcionalidades

| Funcionalidad              | Propósito                                     |
| -------------------------- | --------------------------------------------- |
| Procedimientos almacenados | Reutilizar operaciones SQL frecuentes.        |
| Funciones                  | Realizar cálculos y devolver valores.         |
| Triggers                   | Automatizar validaciones y reglas de negocio. |
| Eventos                    | Automatizar tareas programadas.               |
| Seguridad y permisos       | Controlar el acceso a la información.         |
| Transacciones              | Garantizar operaciones seguras y reversibles. |

---

# 10. Evidencias del proyecto

Las evidencias del proyecto deben demostrar tanto la creación como la ejecución de cada funcionalidad.

## Procedimientos almacenados

* [ ] Captura de creación.
* [ ] Captura de ejecución.
* [ ] Captura del resultado.

## Funciones

* [ ] Captura de creación.
* [ ] Captura de ejecución.
* [ ] Captura del resultado.

## Triggers

* [ ] Captura de creación.
* [ ] Prueba exitosa.
* [ ] Prueba de una operación inválida.
* [ ] Mensaje de validación generado.

## Eventos

* [ ] Captura de creación.
* [ ] `SHOW EVENTS`.
* [ ] Evidencia de ejecución automática.
* [ ] Resultado generado.

## Seguridad y permisos

* [ ] Creación de usuarios.
* [ ] Asignación de permisos.
* [ ] `SHOW GRANTS`.
* [ ] Prueba de acceso permitido.
* [ ] Prueba de acceso restringido.

## Transacciones

* [ ] Prueba utilizando `START TRANSACTION`.
* [ ] Prueba utilizando `COMMIT`.
* [ ] Prueba utilizando `ROLLBACK`.
* [ ] Verificación de los resultados.

---

# 11. Conclusión

El desarrollo de estas funcionalidades permitió complementar la estructura básica de la base de datos del gimnasio con herramientas propias de MySQL orientadas a la automatización, seguridad, integridad y reutilización de operaciones.

Los procedimientos almacenados y las funciones permiten centralizar operaciones frecuentes. Los triggers permiten controlar reglas de negocio automáticamente, mientras que los eventos facilitan la ejecución programada de tareas.

Por otra parte, la configuración de usuarios y permisos permite controlar el acceso a la información, y las transacciones proporcionan una forma segura de ejecutar varias operaciones manteniendo la integridad de los datos.

En conjunto, estas funcionalidades permiten que la base de datos tenga un comportamiento más cercano al de un sistema real, donde no solamente se almacenan datos, sino que también existen mecanismos para validarlos, protegerlos, automatizarlos y administrarlos correctamente.
