USE gimnasio;

INSERT INTO socios(socio_id, nombre, apellido, telefono) VALUES
('101', 'Ana' , 'Perez', 5555-1234),
('102', 'Luis' , 'Gomez', 5555-5678),
('103', 'Carla' , 'Ruiz', 5555-9012);

INSERT INTO ciudades(ciudad_id, nombre_ciudad) VALUES
('201', 'madrid');


INSERT INTO sedes (sede_id, nombre, ciudad_id) VALUES
('501', 'sede Norte', '201'),
('502', 'sede Sur', '201');

INSERT INTO especilidades_entrenadores( especialidad_id, nombre_especialidad) VALUES
('3301', 'yoga'),
('3302', 'musculacion'),
('3303', 'funcional'),
('3304', 'boxeo');

INSERT INTO entrenadores (entrenador_id, nombre_entrenador, especialidad_id) VALUES
('301', 'Carlos', '3301'),
('302', 'Marta', '3302'),
('303', 'Ivan', '3303'),
('304', 'Diego', '3304');

INSERT INTO planes_entrenamiento(plan_entrenamiento_id, plan_entrenamiento) VALUES
('6301', 'Yoga'),
('6302', 'Pesas'),
('6303', 'Crossfit'),
('6304', 'Boxeo');

INSERT INTO socio_plan_entrenamiento(socio_paln_entrenamiento_id, socio_id, plan_entrenamiento_id, entrenador_id, sede_id) VALUES
('1001', '101', '6301', '301', '501'),
('1002', '101', '6302', '302', '501'),
('1003', '102', '6303', '303', '502'),
('1004', '103', '6302', '302', '501'),
('1005', '103', '6304', '304', '501');
