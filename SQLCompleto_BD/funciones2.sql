--Quiero una columna adicional para saber la fecha de vencimiento de facturas, calculando que cada fecha de factura se va a incrementar en 30 para obtener una fecha determinada

SELECT Ventas_Fecha AS Fecha, 
    ADDDATE(Ventas_Fecha,30) AS Fecha_Vto
FROM Ventas

-------
--encriptar
--AES_ENCRYPT(<campo a encriptar>, <palabra clave por la cual la vamos a encriptar>)

SELECT 
    Prod_Descripcion,
    AES_ENCRYPT(Prod_Descripcion, 'Masters del Desarollo') AS DescripEncrypt
FROM Productos

--AES_DECRYPT()

SELECT 
    Prod_Descripcion,
    AES_DECRYPT(AES_ENCRYPT(Prod_Descripcion, 'Masters del Desarollo'), 'Masters del Desarollo') AS DesencripEncrypt
FROM Productos

-----
--LENGTH()

SELECT Prod_Descripcion, LENGTH(Prod_Descripcion) AS largo
FROM productos
-
-----------

--COMPRESS()
SELECT COMPRESS(Prod_Descripcion) AS Comprimido FROM Productos

-- UNCOMPRESS()
SELECT UNCOMPRESS(COMPRESS(Prod_Descripcion)) AS Descomprimido FROM Productos

------------

--CONCAT()
SELECT CONCAT(Prod_Descripcion, Prod_Color) AS Descricion FROM Productos

--CONCAT_WS()
SELECT CONCAT(" ",Prod_Descripcion, Prod_Color, Prod_Precio) AS Descricion FROM Productos

------------
