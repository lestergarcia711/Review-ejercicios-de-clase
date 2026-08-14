USE gimnasio;
drop procedure if exists verificar_entrenador;
DELIMITER //
-- DDL DATA DEFINITION LANGUAGE
CREATE PROCEDURE verificar_entrenador(IN entrenador_id INT)
BEGIN
  SELECT 
  E.entrenador_id,
  E.nombre_entrenador,
  E.especialidad_id
  FROM entrenadores E 
  WHERE E.entrenador_id = entrenador_id;
END //
DELIMITER ;

CALL verificar_entrenador('301');

-- 1. PARAMETROS IN, OUT CON IF-THEN-ELSE
-- VERIFICAR SI UNA SEDE EXISTE ANTES DE INSCRIBIR A UN SOCIO EN UN PLAN.

DROP PROCEDURE IF EXISTS sp_registrar_plan_socio;

DELIMITER //
CREATE PROCEDURE sp_registrar_plan_socio (
IN p_relacion_id VARCHAR (10),
IN p_socio_id VARCHAR(10),
IN p_plan_id VARCHAR(10),
IN p_entrenador_id VARCHAR(10),
IN p_sede_id VARCHAR(10),
OUT p_mensaje VARCHAR(100)
)
BEGIN
DECLARE v_existe_sede INT DEFAULT 0;
-- VERIFICAR SI LA SEDE EXISTE
SELECT COUNT(*) INTO v_existe_sede
FROM sedes
WHERE sede_id = p_sede_id;

-- condicion IF-THEN-ELSE
IF v_existe_sede > 0 THEN
INSERT INTO socio_plan_entrenamiento(socio_paln_entrenamiento_id, socio_id, plan_entrenamiento_id, entrenador_id, sede_id)
VALUES (p_relacion_id, p_socio_id, p_plan_id, p_entrenador_id, p_sede_id);

   SET p_mensaje = 'EXITO: plan asignado correctamente.';
ELSE 
   SET p_mensaje = 'ERROR: La sede especificada no existe';
   END IF;
END //
DELIMITER ;

 -- LA PRUEBA LLAMANDO A LA FUNCION CON CALL Y EL NOMBRE DE LA FUNCION- caso exitoso
 
 CALL sp_registrar_plan_socio('1008', '102', '6301','301', '501', @respuesta);
 SELECT @respuesta;

-- prueba del caso ERROR (SEDE 999 NO EXISTE)

CALL sp_registrar_plan_socio('1007', '102', '6301', '301', '999', @respuesta);
SELECT @respuesta;

-- 2. Insertar multiples servicios ficticios de planes para un socio en un bucle mientras el contador sea menor que el limite.alter

DELIMITER //
 CREATE PROCEDURE sp_generar_planes_demo (
 IN p_socio_id VARCHAR (10),
 IN p_cantidad INT
 )
 BEGIN
 DECLARE v_contador INT DEFAULT 1;
 DECLARE V_nuevo_id INT DEFAULT 2000;
  -- BUCLE WHILE EVALUA LA CANTIDAD ANTES DE EJECUTAR)
 WHILE v_contador <= p_cantidad DO
 INSERT INTO socio_plan_entrenamiento ( socio_paln_entrenamiento_id, socio_id, plan_entrenamiento_id,
 entrenador_id, sede_id)
 VALUES( CAST(Vv_nuevo_id + v_contador AS CHAR) , percent_socio_id, '6301', '301', '501');
 
 SET v_contador = v_contador + 1 ;
 END WHILE;
 END //
 DELIMITER ;
 
 -- LLAMAR AL PROCEDIMIENTO PARA generar 3 registros automaticos para el socio 102
  CALL sp_generar_planes_demo ('102', 3);
  
-- comprobar registros 
SELECT * FROM socio_plan_entrenamiento WHERE socio_id = '102';

-- 3. parametro INOUT CON CASE
-- Objetivo: Recibir una variable con el estado previo del socio,
-- contar sus planes actuales y actualizar esa misma variable con su nuevo nivel.

DELIMITER // 
CREATE PROCEDURE sp_evaluar_nivel_socio (
IN p_socio_id VARCHAR (10),
INOUT p_nivel VARCHAR(50)
)
BEGIN
DECLARE v_total_planes INT DEFAULT 0;

SELECT COUNT(*) INTO v_total_planes
FROM socio_plan_entrenamiento
WHERE socio_id = p_socio_id;

CASE v_total_planes
     WHEN 0 THEN
         SET p_nivel = CONCAT(p_nivel, ' -> Estado: Sin Actividad');
	 WHEN 1 THEN
         SET p_nivel = CONCAT(p_nivel, ' -> Principiante(1 Plan)');
	 WHEN 2 THEN
         SET p_nivel = CONCAT(p_nivel, ' -> Estado: Intermedio (2 planes)');
	 ELSE
         SET p_nivel = CONCAT(p_nivel, ' -> Estado: Avanzado (3+ planes)');
	END CASE;

END //
DELIMITER ;

SET @mi_nivel = 'Evaluacion Inicial';
CALL sp_evaluar_nivel_socio('101', @mi_nivel);
SELECT @mi_nivel;

-- 4. Bucle REPEAT
-- Objetivo: Buscar e incrementar secuencialmente un ID de entrenador hasta encontrar uno que pertenezca a la especialidad de "Musculación" (ID 3302). 
-- Se ejecuta al menos una vez (UNTIL).
DROP PROCEDURE IF EXISTS sp_buscar_entrenador_especialidad;
DELIMITER //
 CREATE PROCEDURE sp_buscar_entrenador_especialidad (
 IN p_id_inicio INT,
 OUT p_entrenador_encontrado VARCHAR(50)
 )
 BEGIN
 DECLARE v_actual INT DEFAULT p_id_inicio;
 DECLARE v_especialidad VARCHAR(10) DEFAULT '';
 DECLARE v_nombre VARCHAR (50) DEFAULT '';
 
 REPEAT
     SELECT especialidad_id, nombre_entrenador
     INTO v_especialidad, v_nombre
     FROM entrenadores
     WHERE entrenador_id = CAST(v_actual AS CHAR);
     
     SET v_actual = v_actual + 1;
     
     UNTIL v_especialidad= '33002' OR v_actual > 310
     END REPEAT;
     
	IF v_especialidad = '3302' THEN
        SET p_entrenador_encontrado = CONCAT('Encontrado: ', v_nombre);
	ELSE 
       SET p_entrenador_encontrado = 'NO se encontro ningun entrenador con esa especialidad en el rango.';
	END IF ;
 
 END // 
 DELIMITER;
 
 CALL sp_buscar_entrenador_especialidad(301, @resultado_busqueda);
 SELECT @resutado_busqueda;