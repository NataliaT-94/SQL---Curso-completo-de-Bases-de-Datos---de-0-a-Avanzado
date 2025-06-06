--WHERE: esta presente en todas las instrucciones DML

SELECT Prod_Id, Prod_Descripcion, Prod_ Precio, Prod_ProvId
FROM productos
WHERE Prod_Precio > 0 OR (Prod_ProvId > 10 AND Prod_ProvId < 50)

--ORDER BY: Nos permite ordenar el conjunto de datos que hemos conseguiado, funciona sobre los datos ya procesados

SELECT v.Ventas_NroFactura, v.Ventas_CliId, c.Cli_RazonSocial, v.Ventas_Fecha, vd.VD_ProdId,
    p.Prod_Descripcion, pr.Prov_Id, pr.Prov_Nombre
FROM ventas v, clientes c, ventas_detalle vd, productos p, proveedores pr
WHERE v.Ventas_CliId = c.Cli_Id AND v.Ventas_CliId > 1 AND
    vd.VD_VentasId = v.Ventas_Id AND vd.VD_ProdId = p.Prod_Id AND p.Pod_ProvId = pr.Pov_Id
ORDER BY v.Ventas_Fecha DESC, Prod_Descripcion

--HAVING: Trabaja sobre los resultados

SELECT vd.VD_ProdId, p.Prod_Descripcion, COUNT(*) AS ventas
FROM ventas_detalle vd, produsctos p
WHERE p.Prod_Id = vd.VD_ProdId
GROUP BY vd.VD_ProdId 
HAVING ventas > 100


--IN:

SELECT * FROM productos p 
WHERE p.Prod_Id IN (4,8,10,15)

--NOT IN

SELECT * FROM productos p 
WHERE p.Prod_Id NOT IN (4,8,10,15)

--LIKE: SIrve para busqueda de texto, nos permite filtrar por campos de descripcion

SELECT p.Prod_Id, p.Prod_Descripcion, p.Prod_Color, p.Prod_Precio
FROM productos p
WHERE p.Prod_Descripcion LIKE "%NEGRO%"
----------------------------------------------------------------------

--JOIN: Sirve para unir tablas

SELECT * FROM productos p
    JOIN ventas_detalle vd ON vd.VD_ProdId = p.Prod_Id AND vd.VD_Costo > 1000
    JOIN proveedores pr ON pr.Prov_Id = p.Prod_PtovId
    JOIN ventas v ON vd.VD_VentasID = v.Ventas_Id


--LEFT JOIN: Muestra todos los campos de la tabla izquierda y de la tabla de la derecha solo muestras los campos que coincidan con la de la izquierda

SELECT p.Prod_Id, p.Prod_Descripcion, SUM(vd.VD_Cantidad) AS 'Unidades Vendidas'
FROM productos p
   LEFT JOIN ventas_detalle vd ON p.Prod_Id = vd.VD_ProdId
GROUP BY p.Prod_Id
ORDER BY p.Prod_Id

--RIGHT JOIN: Muestra todos los campos de la tabla derecha y de la tabla de la izquierda solo muestras los campos que coincidan con la de la derecha

SELECT p.Prod_Id, p.Prod_Descripcion, SUM(vd.VD_Cantidad) AS 'Unidades Vendidas'
FROM productos p
   RIGHT JOIN ventas_detalle vd ON p.Prod_Id = vd.VD_ProdId
GROUP BY vd.VD_ProdId
ORDER BY vd.VD_ProdId


