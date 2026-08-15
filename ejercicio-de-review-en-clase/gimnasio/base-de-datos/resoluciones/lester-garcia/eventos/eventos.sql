USE gimnasio;
 
 -- Eventos :
 -- Pero los eventos no se ejecutaran automaticamente, es necesario levantar el entorno 
 -- de desarrollo o activarlo.
 -- Comprobar si esta activado.
 SHOW VARIABLES LIKE 'event_scheduler';
 -- Comando para activarlo.
 SET GLOBAL event_scheduler = ON;
 
ALTER TABLE socio_plan_entrenamiento
ADD COLUMN fecha_asignacion DATETIME DEFAULT CURRENT_TIMESTAMP;
 
ALTER TABLE socio_plan_entrenamiento
ADD COLUMN estado VARCHAR(20) DEFAULT 'Activo';
-- ----------------------------------------------------
-- 1. Desactivar los planes despuesde cierto tiempo
-- ----------------------------------------------------

CREATE EVENT actualizar_planes_vencidos
ON SCHEDULE EVERY 1 DAY
DO
UPDATE socio_plan_entrenamiento
SET estado = 'Vencido'
WHERE fecha_asignacion < DATE_SUB(NOW(), INTERVAL 30 DAY)
AND estado = 'Activo';
-- --------------------------------------------------
-- 2.Evento para eliminar registros antiguos
-- --------------------------------------------------
CREATE EVENT eliminar_planes_antiguos
ON SCHEDULE EVERY 1 MONTH
DO
DELETE FROM socio_plan_entrenamiento
WHERE estado = 'Vencido'
AND fecha_asignacion < DATE_SUB(NOW(), INTERVAL 1 YEAR);

-- -------------------------------------------------------
-- 3. Evento para generar un reporte de cantidad de planes
-- -------------------------------------------------------
CREATE TABLE reporte_planes (
    reporte_id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_reporte DATETIME,
    cantidad_planes INT
);
CREATE EVENT generar_reporte_planes
ON SCHEDULE EVERY 1 DAY
DO
INSERT INTO reporte_planes(fecha_reporte, cantidad_planes)
SELECT NOW(), COUNT(*)
FROM socio_plan_entrenamiento;