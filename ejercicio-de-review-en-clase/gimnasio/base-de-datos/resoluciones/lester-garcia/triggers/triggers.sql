USE gimnasio;

-- TRIGGERS
-- ----------------------------------------------------------------
-- 1. Trigger: validar que un socio no tenga demasiados planes
-- ----------------------------------------------------------------

DROP TRIGGER IF EXISTS tr_validar_planes_socio;
DELIMITER //

CREATE TRIGGER tr_validar_planes_socio
BEFORE INSERT ON socio_plan_entrenamiento
FOR EACH ROW
BEGIN
    DECLARE cantidad_planes INT;

    SELECT COUNT(*)
    INTO cantidad_planes
    FROM socio_plan_entrenamiento
    WHERE socio_id = NEW.socio_id;

    IF cantidad_planes >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El socio no puede tener más de 3 planes de entrenamiento';
    END IF;
END //

DELIMITER ;
-- Pruebas del trigger.
INSERT INTO socio_plan_entrenamiento
(socio_paln_entrenamiento_id, socio_id, plan_entrenamiento_id, entrenador_id, sede_id)
VALUES
('1009', '101', '6303', '303', '502');


-- --------------------------------------------------------------------------
-- 2. Evitar que un entrenador tenga demasiados socios
-- --------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tr_validar_carga_entrenador;
DELIMITER //

CREATE TRIGGER tr_validar_carga_entrenador
BEFORE INSERT ON socio_plan_entrenamiento
FOR EACH ROW
BEGIN
    DECLARE cantidad_socios INT;

    SELECT COUNT(*)
    INTO cantidad_socios
    FROM socio_plan_entrenamiento
    WHERE entrenador_id = NEW.entrenador_id;

    IF cantidad_socios >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El entrenador ya tiene el máximo de 5 asignaciones';
    END IF;
END //

DELIMITER ;

-- Pruebas del trigger.
INSERT INTO socio_plan_entrenamiento
(socio_paln_entrenamiento_id, socio_id, plan_entrenamiento_id, entrenador_id, sede_id)
VALUES
('1006', '102', '6302', '302', '501');

-- --------------------------------------------------------------------------
-- 3.Impedir que un socio tenga el mismo plan dos veces
-- --------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tr_evitar_plan_duplicado;
DELIMITER //

CREATE TRIGGER tr_evitar_plan_duplicado
BEFORE INSERT ON socio_plan_entrenamiento
FOR EACH ROW
BEGIN
    DECLARE plan_existente INT;

    SELECT COUNT(*)
    INTO plan_existente
    FROM socio_plan_entrenamiento
    WHERE socio_id = NEW.socio_id
    AND plan_entrenamiento_id = NEW.plan_entrenamiento_id;

    IF plan_existente > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El socio ya tiene asignado este plan de entrenamiento';
    END IF;
END //

DELIMITER ;

-- Pruebas del trigger.
INSERT INTO socio_plan_entrenamiento
(socio_paln_entrenamiento_id, socio_id, plan_entrenamiento_id, entrenador_id, sede_id)
VALUES
('1006', '101', '6301', '301', '501');
