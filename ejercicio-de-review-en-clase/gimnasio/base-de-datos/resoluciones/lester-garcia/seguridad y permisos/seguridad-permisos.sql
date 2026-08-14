SELECT user, host FROM mysql.user;
-- crear los usurios que tendran acceso a la base de datos, cada uno tendra limitaciones, excepto el admin.
-- 1. consultara unicamente

CREATE USER 'usuario_recepcion'@'localhost' IDENTIFiED BY 'ReceptPass321!';
-- 2. lectura general e insercion/qctualizacion en asignaciones.

CREATE USER 'usuario_entrenador'@'localhost' IDENTIFIED BY 'TrainerPass312!';

 -- 3. Acceso total y ejecucion de procedimientos
CREATE USER 'usuario_admin'@'localhost' IDENTIFIED BY 'Admin123!!';

-- Privilegios de cada usuario creado.---

-- 1. LECTURA SOBRE TODAS LAS TABLAS
GRANT SELECT ON *.* TO 'usuario_recepcion'@'localhost';

-- 2. LECTURA SOBRE TABLAS MAESTRAS. 
GRANT SELECT ON socios TO 'usuario_entrenador'@'localhost';
GRANT SELECT ON entrenadores TO 'usuario_entrenador'@'localhost';
GRANT SELECT ON planes_entrenamiento TO 'usuario_entrenador'@'localhost';
-- LECTURA, INSERCION Y MODIFICACION  SOBRE LA GESTION DE PLAN DE SOCIOS.
GRANT SELECT, INSERT, UPDATE ON  socio_plan_entrenamiento TO 'usuario_entrenador'@'localhost';

-- 3.CONCEDER TODOS LOS PRIVILEGIOS SOBRE LAS TABLAS.

GRANT ALL PRIVILEGES ON *.* TO 'usuario_admin'@'localhost' WITH GRANT OPTION;
-- Permiso explicito para ejecutar procedimientos almacenados

GRANT EXECUTE ON PROCEDURE sp_registrar_plan_socio TO 'usuario_admin'@'localhost';
GRANT EXECUTE ON PROCEDURE sp_insertar_socio_seguro TO 'usuario_admin'@'localhost';
GRANT EXECUTE ON PROCEDURE sp_alta_socio_con_plan TO 'usuario_admin'@'localhost';

-- Recargar permisos en el motor de MYSQL
FLUSH PRIVILEGES;
