CREATE DATABASE gimnasio;
USE gimnasio;
drop database if exists gimnasio;

CREATE TABLE socios (
socio_id INT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(60) NOT NULL,
telefono INT NOT NULL
) ENGINE=INNODB;

CREATE TABLE ciudades (
ciudad_id INT PRIMARY KEY,
nombre_ciudad VARCHAR(80) NOT NULL
)ENGINE=INNODB;


CREATE TABLE sedes (
sede_id INT PRIMARY KEY,
nombre VARCHAR(80) NOT NULL,
ciudad_id INT NOT NULL,
FOREIGN KEY (ciudad_id) REFERENCES ciudades(ciudad_id)
) ENGINE = INNODB;

CREATE TABLE especilidades_entrenadores(
especialidad_id INT PRIMARY KEY,
nombre_especialidad VARCHAR(80)
)ENGINE=INNODB;

CREATE TABLE entrenadores(
entrenador_id INT PRIMARY KEY,
nombre_entrenador VARCHAR(80) NOT NULL,
especialidad_id INT NOT NULL
)ENGINE=INNODB;

CREATE TABLE planes_entrenamiento(
plan_entrenamiento_id INT PRIMARY KEY,
plan_entrenamiento VARCHAR(80) NOT NULL
) ENGINE = INNODB;


CREATE TABLE socio_plan_entrenamiento (
socio_paln_entrenamiento_id INT PRIMARY KEY,
socio_id INT NOT NULL,
plan_entrenamiento_id INT,
entrenador_id INT NOT NULL,
sede_id INT NOT NULL,
FOREIGN KEY (socio_id) REFERENCES socios(socio_id),
FOREIGN KEY (plan_entrenamiento_id) REFERENCES planes_entrenamiento(plan_entrenamiento_id),
FOREIGN KEY (entrenador_id) REFERENCES entrenadores(entrenador_id),
FOREIGN KEY (sede_id) REFERENCES sedes(sede_id)
)ENGINE = INNODB;