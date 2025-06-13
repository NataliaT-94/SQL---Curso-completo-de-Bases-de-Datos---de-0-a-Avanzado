-- Creacion de Tablas

-- Tabla INNODB
-- Usar un nombre descriptivo
-- Usar un nombre en ingles
-- Usar Primary Key numerica y Autonumerica
-- No usar nombes propios en la tabla
-- No replicar datos que esten en otras tablas
-- evitar datos alfanumericos repetidos sistematicamente

--Creacion de Campos

-- Campo con nombre descriptivo
-- Nombre en Ingles
-- No usar nombres propios 
-- Debe respetar el tipo de datos del valor que alojara
-- Usar DATETIME solo si es necesario alojar la hora
-- Respetar la longitud maxima esperada para el campo 
-- Evitar los datos de tipo TEXT, MEDIUMTEXT y LONGTEXT
-- No Duplicar datos que se encuentren en otras tablas
-- Indexar los campos de consultas frecuentes

--Consultas SQL optimizadas

-- Evitar las SubConsultas todo lo que  sea posible
-- Unir tablas solo por campos indice
-- Evitar las funciones sobre campos indexados en lel WHERE o JOINS sde tablas
