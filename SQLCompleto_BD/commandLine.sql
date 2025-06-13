--show database: Muestra todas las bases de datos del mismo servidor

--use Ejemplo: nos paramos sobre la base de datos que queremos utilizar

--show table: Muestra las tablas creadaas en la base de datos

--ALTER TABLE: alterar la tabla

--ADD COLUMN: agregar columna

--ZEROFILL: rellenar con 0

--AFTER: despues de

--DROP COLUMN: Eliminar columna

--ADD INDEX: Agregar un indice

--ADD UNIQUE: Agregar indice unico

--DROP INDEX: eliminar el indice

--ADD CONSTRAINT: Agregar llave foranea

----------------  EJEMPLOS   ---------------------------------

CREATE DATABASE Ejemplo /*!40100 COLLATE 'utf8mb4_0900_ai_ci' */;
--Crea la base de datos Ejemplo comentario 40100 con un comando de escritura especifico


CREATE TABLE TablaEjemplo (TA_Id BIGINT UNSIGNED NOT NULL AUTO INCREMENT, TA_Nombre VARCHAR(50) NOT NULLL DEFAULT '', PRIMARY KEY(TA_Id));
--Creamos la tabla TablaEjemplo con las columnas TA_Id y sus caracteristicas, TA_Nombre y sus caracteristicas, luego señalamos cual es la primary key el cual es TA_Id



ALTER TABLE TablaEjemplo ADD COLUMN TA_Cantidad INT(5) UNSIGNED ZEROFILL NULL DEFAULT 10 AFTER TA_Id;

ALTER TABLE TablaEjemplo DROP COLUMN TA_Cantidad;


ALTER TABLE TablaEjemplo ADD INDEX Nombre (TA_Nombre);


ALTER TABLE TablaEjemplo ADD COLUMN TA_IdUnico BIGINT UNSIGNED NOT NULL DEFAULT 0 AFTER TA_Nombre, ADD UNIQUE INDEX TA_IdUnico (TA_IdUnico);


ALTER TABLE TableEjemplo DROP INDEX TA_IdUnico;

CREATE TABLE TablaMaestra (TM_Id INT UNSIGNED NOT NULL AUTO_INCREMENT, PRIMARY KEY (TM_Id));
ALTER TABLE TablaEjemplo ADD COLUMN TA_TMId INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER TA_Id;


--ALTER TABLE TablaEjemplo ADD CONSTRAINT FK_Ejemplo_Maestra FOREIGN KEY (TA_TMId) REFERENCES TablaMAestra (TM_Id);


-----------------------------------------------------------------------------

--CREATE USER: crear usuario
--IDENTIFIED BY: contraseña
--GRANT: Otorgar
--REVOKE: Revocar
--FLUSH PRIVILEGES: Refrescar

---------- PERMISOS QUE SE LE PUEDEN OTORGAR A LOS USUARIOS --------------

--GRANT ALL PRIVILEGES ON:otorgar todos los pivilegios a
--CREATE
--DROP
--DELETE
--INSERT
--SELECT
--UPDATE
--GRANT OPTION: Permite remover los privilegios de usuarios


----------------  EJEMPLOS   ---------------------------------

CREATE USER curso@localhost IDENTIFIED BY '12345678';
--CREATE USER <nombre del usuario>@ <servidor o direccion IP> DENTIFIED BY '<contraseña>'


GRANT ALL PRIVILEGES ON * . * TO curso@localhost;
--GRANT <privilegios> ON <base de datos> . <tabla> TO <usuario>


REVOKE ALL PRIVILEGES ON * . * FROM curso@localhost;
--REVOKE <privilegios> ON <base de datos> . <tabla> FROM <usuario>

DROPP USER curso@localhost;
--Eliminamos un usuario

-------------------------------------------------


---------consola de la compu -----------------------------------

-- -u:Usuario
-- -p: Password
-- -h: Motor de base de datos

--DUMP: Backups. Se hacen fuera del motor (mysqldump)

mysqldump -u root -p -h localhost (nombre de la base de datos alcual vamos hacer el Backups) > (nombre del archivo donde se va a guradar el backap)
--Esto solo guarda tablas 

mysqldump -u root -p -h localhost --triggers --routines (nombre de la base de datos alcual vamos hacer el Backups) > (nombre del DUMP)
--Esto guarda tablas triggers y demas parametros

mysqldump -u root -p -h localhost --databases

mysqldump -u root -p -h localhost --databases curso sakila > d:\miBackup.sql

mysqldump -u root -p -h localhost --databases curso sakila --routines --triggers --events --no-data > d:\miBackup.sql

----------- restore---------------

mysql -u root -p -h localhost (nombre de la base de datos al cual vamos hacer el Backups) < (nombre del archivo del backap)

mysql -u root -p -h localhost < d:\miBackup.sql

