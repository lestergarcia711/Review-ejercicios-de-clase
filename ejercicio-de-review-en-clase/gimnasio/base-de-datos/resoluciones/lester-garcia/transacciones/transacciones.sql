USE gimnasio;
-- TRANSACCIONES.
-- --------------------------------------------------
-- 1.Registrar un nuevo socio y asignarle un plan.
-- --------------------------------------------------
START TRANSACTION;

INSERT INTO socios
(socio_id, nombre, apellido, telefono)
VALUES
(107, 'Pedro', 'Martinez', '55553456');

INSERT INTO socio_plan_entrenamiento
(socio_paln_entrenamiento_id, socio_id, plan_entrenamiento_id,entrenador_id, sede_id)
VALUES
(1007, 107, 6301, 301, 501);

-- EL COMMIT ES PAR ENVIAR ESOS NUEVOS CAMBIOS CONFIRMADOS.
COMMIT;

describe socio_plan_entrenamiento;

-- SIN EN DADO CASO SE ASIGNO UN ENTRENADOR QUE NO EXISTE,
-- SE REVIERTE LA TRANSACCION CON EL ROLLBACK
ROLLBACK;

SELECT socio_id, nombre, apellido, telefono
FROM socios s
WHERE s.socio_id = 106;

SELECt *
FROM socio_plan_entrenamiento sp
WHERE sp.socio_id = 107;

SELECT * FROM socio_plan_entrenamiento;

-- ----------------------------------------
-- 2.Cambiar el plan de un socio
-- ----------------------------------------
START TRANSACTION;

DELETE FROM socio_plan_entrenamiento
WHERE socio_paln_entrenamiento_id = 1001
AND socio_id = 101;

INSERT INTO socio_plan_entrenamiento
(socio_paln_entrenamiento_id, socio_id, plan_entrenamiento_id, entrenador_id, sede_id)
VALUES
(1009, 101, 6304, 304, 501);

COMMIT;

ROLLBACK;
-- verificar si en socio_plan_entrenamiento esta el nuevo plan.
SELECT * FROM 
socio_plan_entrenamiento;

-- --------------------------------------------------------
-- 3. Eliminar una asignación de forma segura
-- --------------------------------------------------------
START TRANSACTION;

DELETE FROM socio_plan_entrenamiento
WHERE socio_paln_entrenamiento_id = 1009
AND socio_id = 101;

COMMIT;

ROLLBACK;