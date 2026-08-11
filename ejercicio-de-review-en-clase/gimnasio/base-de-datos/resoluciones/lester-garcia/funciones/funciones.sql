-- 1. Función para obtener el nombre completo de un socio
-- Sirve para no tener que repetir CONCAT(nombre, apellido) en todas las consultas.

DELIMITER //

CREATE FUNCTION nombre_completo_socio(
    p_socio_id INT
)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(100);

    SELECT CONCAT(nombre, ' ', apellido)
    INTO nombre_completo
    FROM socios
    WHERE socio_id = p_socio_id;

    RETURN nombre_completo;
END //

DELIMITER ;

-- uso
SELECT nombre_completo_socio(101) AS socio;


-- 2. Función para contar los planes de un socio
-- Permite saber cuántos planes de entrenamiento tiene asignados un socio.

DELIMITER //

CREATE FUNCTION cantidad_planes_socio(
    p_socio_id INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;

    SELECT COUNT(*)
    INTO cantidad
    FROM socio_plan_entrenamiento
    WHERE socio_id = p_socio_id;

    RETURN cantidad;
END //

DELIMITER ;

-- uso

SELECT
    socio_id,nombre,apellido,cantidad_planes_socio(socio_id) AS cantidad_planes
FROM socios;

-- 3. Función para saber cuántos socios tiene un entrenador
-- Esta es bastante útil para controlar la carga de trabajo de los entrenadores.

DELIMITER //

CREATE FUNCTION cantidad_socios_entrenador(
    p_entrenador_id INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;

    SELECT COUNT(DISTINCT socio_id)
    INTO cantidad
    FROM socio_plan_entrenamiento
    WHERE entrenador_id = p_entrenador_id;

    RETURN cantidad;
END //

DELIMITER ;

-- uso

SELECT
    entrenador_id,nombre_entrenador,cantidad_socios_entrenador(entrenador_id) AS cantidad_socios
FROM entrenadores;

--4. Función para obtener la ciudad de una sede
-- Esta función permite consultar la ciudad donde está ubicada una sede sin tener que escribir el JOIN cada

DELIMITER //

CREATE FUNCTION ciudad_de_sede(
    p_sede_id INT
)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE ciudad VARCHAR(100);

    SELECT c.nombre_ciudad
    INTO ciudad
    FROM sedes s
    INNER JOIN ciudades c
        ON s.ciudad_id = c.ciudad_id
    WHERE s.sede_id = p_sede_id;

    RETURN ciudad;
END //

DELIMITER ;

SELECT
    sede_id,nombre,ciudad_de_sede(sede_id) AS ciudad
FROM sedes;
