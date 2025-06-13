TABLESPACE

CREATE TABLESPACE `high_performance_tables`
ADD DATAFILE 'e:\\mysql\\data\\HighPerformanceTables\\high.ibd'
ENGINE=INNODB

DROP TABLESPACE `high_performance_tables`

ALTER TABLE ventas_detalle TABLESPACE `high_performance_tables`

CREATE TABLE nombre_tabla(
    columna1 INT,
    columna2 INT,
    ...
) TABLESPACE `high_performance_tables`