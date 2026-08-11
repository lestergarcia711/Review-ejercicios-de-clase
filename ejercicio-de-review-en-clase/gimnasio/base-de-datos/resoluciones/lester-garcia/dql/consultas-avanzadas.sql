USE gimnasio;
-- 1. Esta consulta permite saber qué 
-- está haciendo cada socio, quién lo entrena y dónde recibe el entrenamiento.
SELECT
    s.socio_id,
    CONCAT(s.nombre, ' ', s.apellido) AS socio,
    pe.plan_entrenamiento,
    CONCAT(e.nombre_entrenador) AS entrenador,
    ee.nombre_especialidad AS especialidad,
    se.nombre AS sede,
    c.nombre_ciudad AS ciudad
FROM socios s
INNER JOIN socio_plan_entrenamiento spe
    ON s.socio_id = spe.socio_id
INNER JOIN planes_entrenamiento pe
    ON spe.plan_entrenamiento_id = pe.plan_entrenamiento_id
INNER JOIN entrenadores e
    ON spe.entrenador_id = e.entrenador_id
INNER JOIN especilidades_entrenadores ee
    ON e.especialidad_id = ee.especialidad_id
INNER JOIN sedes se
    ON spe.sede_id = se.sede_id
INNER JOIN ciudades c
    ON se.ciudad_id = c.ciudad_id
ORDER BY s.apellido, s.nombre;

-- 2 .Esta consulta sirve para conocer la carga de trabajo de cada entrenador y detectar 
-- si alguno tiene demasiados socios asignados.

SELECT
    e.entrenador_id,
    e.nombre_entrenador,
    ee.nombre_especialidad AS especialidad,
    COUNT(DISTINCT spe.socio_id) AS cantidad_socios
FROM entrenadores e
INNER JOIN especilidades_entrenadores ee
    ON e.especialidad_id = ee.especialidad_id
LEFT JOIN socio_plan_entrenamiento spe
    ON e.entrenador_id = spe.entrenador_id
GROUP BY
    e.entrenador_id,
    e.nombre_entrenador,
    ee.nombre_especialidad
ORDER BY cantidad_socios DESC;

-- 3.Esta consulta permite comparar el movimiento de las diferentes sedes.

SELECT
    se.sede_id,
    se.nombre AS sede,
    c.nombre_ciudad AS ciudad,
    COUNT(DISTINCT spe.socio_id) AS cantidad_socios
FROM sedes se
INNER JOIN ciudades c
    ON se.ciudad_id = c.ciudad_id
LEFT JOIN socio_plan_entrenamiento spe
    ON se.sede_id = spe.sede_id
GROUP BY
    se.sede_id,
    se.nombre,
    c.nombre_ciudad
ORDER BY cantidad_socios DESC;