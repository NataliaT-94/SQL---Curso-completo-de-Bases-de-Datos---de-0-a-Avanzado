--WyISAM

-- Es mas rapido que INNOBD para las operaciones
-- No admite TRANSACCIONES
-- Los archivos de tablas se guardan en el disco a nivel separado. Guardan dos archivos, un punto FRM que seria como  un formulario con los datos, cpn el nombre y la tabla y tambien guarda un archivo para la tabla indices.(Facilmente Protable)
-- ES muy vulnerable a corrupciones de archivos
-- Realiza bloqueos de tablas completas
--No soporta claves extrañas o foreign keys
-- Admite indices FULL-TEXT
-- AWS Desanconseja su uso para el servicio RDS


-------------------------------------------------

--INNODB

-- Motor predeterminado desde la vision 5.6
-- Fue creado por la compañia INNOBASE OY
-- Incorpora la funcionalidad de transacciones
-- Todo se guarda en 1 solo archivo llamado IBDATA1
-- Soporta claves externas o Foreign Keys
-- Cumple con el patron ACID (Atomicity, Consistency, Isolation and Durability)