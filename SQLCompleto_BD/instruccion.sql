--SELECT: seleccionar

--INSERT: Inserta valores
INSERT INTO <tabla> (<campos>) VALUES (<valores>)

INSERT INTO alumnos (Alumno_Nombre) VALUES ('Pablo Tilotta')
INSERT INTO productos (prod_descripcion, prod_color) VALUES ('Mi Producto', 'Mi Color'),
    ('Mi Producto 2', 'Mi Color 2'),
    ('Mi Producto 3', 'Mi Color 3')

--UPDATE: Actualizar
UPDATE <tabla> SET <campo> = <valor> WHERE <condicion o condiciones>

UPDATE productos p 
SET p.Prod_Descripcion = 'Descripcion Modificada',
    p.Prod_Status = 0,
    p.Prod_CompraSuspendida = 1
WHERE p.Prod_Id = 6992

--DELETE: elimina registros (No olvidar poner el WHERE)
DELETE FROM <tabla> WHERE <condicion o condiciones>

DELETE FROM productos p WHERE p.Prod_Id = 6992

DELETE FROM productos p WHERE p.Prod_Id > 6992

-----------------------------------------------------------------------------------------

--SUBConsultas: Son consultas dentro de una consulta principal

SELECT p.Prod_Id,
    p.Prod_Descripcion,
    p.Prod_Color,
    (SELECT SUM(vd.VD_Cantidad) 
    FROM ventas_detalle vd 
    WHERE vd.VD_ProdId = p.Prod_Id) AS 'Total Unidades',
    (SELECT SUM(vd.VD_Precio) 
    FROM ventas_detalle vd 
    WHERE vd.VD_ProdId = p.Prod_Id) AS 'Total Ventas Dinero',
FROM productos p

---------

SELECT p.Prod_Id, p.Prod_Descripcion, p.Prod_Color,
    (SELECT COUNT(VD_Cantidad) unidades FROM ventas_detalle WHERE p.Prod_Id = VD_ProdId) 'Unidades Vendidas'
FROM productos p
    JOIN 
        (SELECT VD_ProdId, COUNT(VD_Cantidad) unidades FROM ventas_detalle
            GROUP BY VD_ProdId) v ON p.Prod_Id = v.VD_ProdId AND v.unidades > 100

----------

SELECT * FROM productos p
WHERE (SELECT SUM(VD_Cantidad) AS cantidad FROM ventas_detalle WHERE p.Prod_Id = VD_ProdId) > 100

--------------------------------------------------------
--DECLARE: Me permitr crear y declarar variables, declarar cursores y tambien declarar manejadores

-- HANDLER: van a capturar el error, lo van a manejar, le van a dar tratamiento en cuanto encuentren un erroren tiempo de ejecucion

--CONTINUE: En caso de un error continua con lo de abajo
-- EXIT: TErminar la ejecucion
--error 1062: clave duplicada
