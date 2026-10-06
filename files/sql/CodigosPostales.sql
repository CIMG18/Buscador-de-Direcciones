-- CREAR BASE DE DATOS Y TABLA PARA CÓDIGOS POSTALES
CREATE DATABASE CodigosPostales;
-- SELECCIONAR LA BASE DE DATOS
USE CodigosPostales;
-- CREAR TABLA PARA CÓDIGOS POSTALES
CREATE TABLE codigos_postales (
    d_codigo INT,
    d_asenta VARCHAR(150),
    d_tipo_asenta VARCHAR(60),
    D_mnpio VARCHAR(100),
    d_estado VARCHAR(60),
    d_ciudad VARCHAR(100),
    d_CP VARCHAR(5),
    c_estado VARCHAR(5),
    c_oficina VARCHAR(10),
    c_CP VARCHAR(5),
    c_tipo_asenta VARCHAR(5),
    c_mnpio VARCHAR(5),
    id_asenta_cpcons VARCHAR(10),
    d_zona VARCHAR(20),
    c_cve_ciudad VARCHAR(10),
    estado_hoja VARCHAR(60)
);
-- CARGAR DATOS DESDE EL ARCHIVO CSV A LA TABLA
LOAD DATA LOCAL INFILE '/ruta/completa/codigos_postales_mexico.csv'
INTO TABLE codigos_postales
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ELIMINAR COLUMNAS INNECESARIAS
ALTER TABLE codigos_postales DROP COLUMN d_CP;
ALTER TABLE codigos_postales DROP COLUMN c_oficina;
ALTER TABLE codigos_postales DROP COLUMN c_CP;
ALTER TABLE codigos_postales DROP COLUMN c_tipo_asenta;
ALTER TABLE codigos_postales DROP COLUMN c_mnpio;
ALTER TABLE codigos_postales DROP COLUMN id_asenta_cpcons;
ALTER TABLE codigos_postales DROP COLUMN c_cve_ciudad;
ALTER TABLE codigos_postales DROP COLUMN estado_hoja;

-- ALTERAR NOMBRES DE COLUMNAS PARA MEJORAR LA CLARIDAD
ALTER TABLE codigos_postales CHANGE COLUMN d_codigo CP CHAR(5);
ALTER TABLE codigos_postales CHANGE COLUMN d_asenta Asentamiento VARCHAR(150);
ALTER TABLE codigos_postales CHANGE COLUMN d_tipo_asenta Tipo_Asentamiento VARCHAR(60);
ALTER TABLE codigos_postales CHANGE COLUMN D_mnpio Municipio VARCHAR(100);
ALTER TABLE codigos_postales CHANGE COLUMN d_estado Estado VARCHAR(100);
ALTER TABLE codigos_postales CHANGE COLUMN d_ciudad Ciudad VARCHAR(100);