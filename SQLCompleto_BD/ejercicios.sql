--INSERT

INSERT INTO productos(Prod_Descripcion, Prod_Color, Prod_Status, Prod_Precio) 
VALUES ('Mi producto', 'Mi color', 1, 200)

----------------------------------------------------

--BULK INSERT


INSERT INTO productos(Prod_Descripcion, Prod_Color) 
VALUES ('Mi producto 2', 'Mi color 2'),
    ('Mi producto 3', 'Mi color 3'),
    ('Mi producto 4', 'Mi color 4')

---------------------------------------------------
--UPDATE
--Modificar el estado de la tabla clientes y asaignarle un 0

UPDATE clientes SET Cli_Estado = 0

--Asignarle 1 al estado de la tabla clientes, del cliente ID nro 10

UPDATE clientes SET Cli_Estado = 1 WHERE Cli_Id = 10

--Asignarle 1 al estado de la tabla clientes de los clientes 6,20,54, 56
UPDATE clientes SET Cli_Estado = 1 WHERE Cli_Id IN (6,20,54,56)

--Sumarle al producto 6989, 100 en el campo Prod_Precio
UPDATE productos SET Prod_Precio = Prod_Precio + 100 WHERE Prod_Id = 6989

--DELETE
--Borrar de la tabla clientes el ID nro 10

DELETE FROM clientes WHERE Cli_Id = 10

--Borrar todos los registros de la tabla productos cuyo proveedor comience con la letra A

DELETE p FROM productos p 
    JOIN proveedores pro ON p.Prod_ProvId = pro.Prov_Id
    WHERE pro.Prov_Nombre LIKE 'A%'

--------------------------------------------------------

--SELECT
--Traer las fechas, numeros de facturas y monto total de mis ventas

SELECT ventas_Fecha, ventas_NroFactura, ventas_Total FROM ventas 

--Traer los ID de productos, cantidad y precio de mi detalle de ventas de los registros donde el precio sea mayor a 0

SELECT VD_ProId, VD_Cantidad, VD_Precio FROM ventas_detalle WHERE  VD_precio > 0

--Traer el total vendido por fecha de factura

SELECT ventas_fecha AS Fecha, 
SUM( ventas_total) AS 'Total Vendido' 
FROM ventas 
GROUP BY Fecha 

--Traer el total vendido por año y mes de factura

SELECT YEAR(ventas_fecha) AS Año,
    MONTH(ventas_fecha) AS Mes, 
    SUM( ventas_total) AS 'Total Vendido' 
FROM ventas
GROUP BY Año, Mes 

--Traer los productos de la tabla Productos que pertenezcan al proveedor 62

SELECT p.Prod_Id, p.Prod_Descripcion 
FROM productos p
WHERE p.Prod_ProvId = 62

SELECT * FROM productos p
WHERE p.Prod_ProvId = 62

--Traer la lista de productos vendidos (solo su Id) sin repeticiones y con el total vendido por cada uno

SELECT 
    vd.VD_ProdId AS Producto,
    SUM((vd.VD_Precio * vd.VD_Cantidad)) AS Total
FROM ventas_detalle vd
GROUP BY Producto

-------------------

--Traer fecha de factura, nro de factura, Id del Cliente, Nombre del Cliente, y monto total vendido
SELECT 
    v.Ventas_Fecha AS Fecha,
    v.Ventas_NroFactura AS Factura,
    v.Ventas_CliId,
    c.Cli_RazonSocial,
    v.Ventas_Total AS 'Monto Total'
FROM ventas v
    JOIN clientes c ON v.Ventas_CliId = c.Cli_Id

--Traer fecha de factura, Id de Producto, Descripcion de producto, Id de Proveedor, Nombre de Proveedor, Cantidad, PrecioUnitario y Parcial. (cantidad * precio)
SELECT
    v.Ventas_Fecha AS Fecha,
    v.Ventas_NroFactura AS Factura,
    p.Prod_Id AS Codigo,
    p.Prod_Descripcion AS Descripcion,
    pv.Prov_Id AS CodProv,
    pv.Prov_Nombre AS Nombre,
    vd.VD_Cantidad AS Cant,
    vd.VD_Precio AS Unitario,
    (vd.VD_Cantidad * vd.VD_Precio) AS Parcial
FROM ventas v
    JOIN ventas_detalle vd ON vd.VD_VentasId = v.Ventas_Id
    JOIN productos p ON  vd.VD_ProdId = p.Prod_Id
    JOIN proveedores pv ON p.Prod_ProvId = pv.Prov_Id

--Traer todos los productos que hayan sido vendidos entre el 14/01/2018 y el 16/01/2018 (sin repetir) y calculando la cantidad de unidades vendidas
SELECT 
    p.Prod_Id AS Codigo,
    p.Prod_Descripcion AS Descripcion,
    SUM(vd.VD_Cantidad) AS 'Unidades Vendidas'
FROM productos p
    JOIN ventas_detalle vd ON p.Prod_Id = vd.VD_ProdId
    JOIN ventas v ON v.Ventas_Id = vd.VD_VentasId
WHERE v.Ventas_Fecha BETWEEN '2018-01-14' AND '2018-01-16'
GROUP BY Codigo

-- como podemos realizar un ORDER BY DESC

 SELECT Codigo, Descripcion, UnidVen AS 'Unidades Vendidas'
 FROM (
    SELECT 
    p.Prod_Id AS Codigo,
    p.Prod_Descripcion AS Descripcion,
    SUM(vd.VD_Cantidad) AS UnidVen
FROM productos p
    JOIN ventas_detalle vd ON p.Prod_Id = vd.VD_ProdId
    JOIN ventas v ON v.Ventas_Id = vd.VD_VentasId
WHERE v.Ventas_Fecha BETWEEN '2018-01-14' AND '2018-01-16'
GROUP BY Codigo
 ) AS u
ORDER BY UnidVen DESC

--------------------------------------------------------

--SELECT buscando STRING

--Traer todos los articulos cuya descripcion comience con la palabra 'SUBTERRANEO'

SELECT 
    p.Prod_Id AS codigo,
    p.Prod_Descripcion AS descripcion
FROM productos p
WHERE p.Prod_Descripcion LIKE "SUBTERRANEO%"

--Traer todos los articulos que en su descripcion o color o nombre de proveedor tenga el string 'FERRO'

SELECT 
    p.Prod_Id AS codigo,
    p.Prod_Descripcion AS descripcion,
    p.Prod_Color AS  color,
    pv.Prov_Nombre As nombre
FROM productos p
    JOIN proveedores pv ON p.Prod_ProvId = pv.Prov_Id
WHERE CONCAT(p.Prod_Descripcion, p.Prod_Color, pv.Prov_Nombre) LIKE '%FERRO%'

--TRAER todos los articulos cuya descripcion tenga el String 'CINTA' y que tenga ventas realizadas
SELECT
    p.Prod_Id AS codigo,
    p.Prod_Descripcion AS descripcion
FROM productos p
    JOIN ventas_detalle vd ON p.Prod_Id = vd.VD_ProdId
WHERE p.Prod_Descripcion LIKE '%CINTA%'
GROUP BY p.Prod_Id


---------------
-- Traer la cantidad de productos que han sido vendidos

SELECT 
    COUNT(DISTINCT(vd.VD_ProdId)) AS cantidad
FROM ventas_detalle vd

--Traer el total vendido de los productos que fueron vendidos entre el 02/01/2018 y el 10/01/2018, y cuyo proveedor se encuentre entre el 2 y 100
SELECT 
    SUM((vd.VD_Precio * vd.VD_Cantidad)) AS 'Total Vendido'
FROM ventas_detalle vd
    JOIN productos p ON vd.VD_ProdId = p.Prod_Id
    JOIN ventas v ON v.Ventas_Id = vd.VD_VentasId
WHERE 
    (v.Ventas_Fecha BETWEEN '2018-01-02' AND '2018-01-10') AND
    (p.Prod_ProvId BETWEEN 2 AND 100)

--Traer la factura de valor maximo, que haya tenido en sus items vendidos,el producto 656
SELECT 
    MAX(v.Ventas_Total) AS 'Valor Maximo'
FROM  ventas v
JOIN ventas_detalle vd ON vd.VD_VentasId = v.Ventas_Id AND vd.VD_ProdId = 656