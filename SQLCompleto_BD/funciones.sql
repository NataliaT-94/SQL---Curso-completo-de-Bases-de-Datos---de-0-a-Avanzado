--COUNT(): Sirve para contar registros

SELECT COUNT(*) AS registros 
FROM ventas v
WHERE v.Ventas_Fecha = '2018-01-02'

--SUM(): Sirve para sumar registros

SELECT SUM(v.Ventas_Total) AS Total
FROM ventas v
WHERE YEAR(v.Ventas_Fecha) = 2018
AND MONTH(v.Ventas_Fecha) = 01

--MIN(): Trae el valor mas pequeño

SELECT MIN(v.Ventas_Total) AS VtaMinima
FROM ventas v
WHERE YEAR(v.Ventas_Fecha) = 2018
AND MONTH(v.Ventas_Fecha) = 01

--MIN(): Trae el valor mas grande

SELECT MAX(v.Ventas_Total) AS VtaMaxima
FROM ventas v
WHERE YEAR(v.Ventas_Fecha) = 2018
AND MONTH(v.Ventas_Fecha) = 01


--AVG: trae el promedio

SELECT AVG (v.Ventas_Total) AS PromedioVta
FROM ventas v
WHERE YEAR(v.Ventas_Fecha) = 2018
AND MONTH(v.Ventas_Fecha) = 01

--------------------------------------------------------------
--IF: permite evaluar una condicion, y en base a los resultados(true, false), permite ir configurando distintos resultados

SELECT p.Prod_Id, p.Prod_Descripcion,
    IF(Prod_Status=1, 'Habilitado', 'Deshabilitado') AS Estado
FROM productos p

--CASE: 


SELECT p.Prod_Id, p.Prod_Descripcion,
    CASE WHEN Prod_Status=1 THEN 'Habilitado' ELSE 'Deshabilitado' END AS Estado
FROM productos p


SELECT p.Prod_Id, p.Prod_Descripcion,
    CASE p.Prod_Status
        WHEN 0 'Deshabilitado'
        WHEN 1 'Habilitado'
        WHEN 1 'Otro Estado' 
        END AS Estado
FROM productos p

SELECT p.Prod_Id, p.Prod_Descripcion,
    CASE p.Prod_Status
        WHEN 0 THEN 'Deshabilitado'
        WHEN 1 THEN (SELECT SUM(vd.VD_Cantidad) FROM ventas_detalle vd WHERE vd.VD_ProdId = p.Prod_Id)
        WHEN 2 THEN 'Otro Estado' 
        END AS Estado
FROM productos p


--IFNULL: Si el campo que estoy evaluando es null, le asigno que valor mostrar

SELECT p.Prod_Id, p.Prod_Descripcion,
    CASE p.Prod_Status
        WHEN 0 THEN 'Deshabilitado'
        WHEN 1 THEN IFNULL((SELECT SUM(vd.VD_Cantidad) FROM ventas_detalle vd WHERE vd.VD_ProdId = p.Prod_Id), 0)
        WHEN 2 THEN 'Otro Estado' 
        END AS Estado
FROM productos p

-----------------------------------------------------------

--SUBSTR: Me permite extraer de un texto una cantidad de caracteres determinado

SELECT p.Prod_Id, p.PROd_Descripcion, 
    CASE SUBSTR(p.Prod_Descripcion,1,1)--del campo tomar a partir de la primera letra el primer caracter
        WHEN 'A' THEN 'Letra A'
        WHEN 'B' THEN 'Letra B'
        END AS ejercicio
FROM productos p


----------------------------------------------------------
SELECT CURRENT_DATE(); --me muestra la feha actual
SELECT CURRENT_TIME(); --Me muestra la hora exacta
SELECT CURRENT_TIMESTAMP; --Me muestra dia y hora
SELECT DATABASE(); --Me muestra la vase de datos en curso
SELECT CURRENT_USER(); --Me muestra el usuario que esta conectado

SELECT DATEDIFF(); --Me muestra cuantos dias paso de una a fecha a otra
SELECT DATEDIFF('2023-06-25', '2023-01-01') AS 'Dias desde el comienzo del año'

SELECT DATEDIFF(CURRENT_DATE, v.Ventas_Fecha) AS 'Antiguedad en dias',
    v.Ventas_NroFacturas
FROM ventas v

SELECT DAYOFWEEK(); --me trae que dia de la semana es
SELECT DAYOFWEEK(CURRENT_DATE) AS 'Dia de la Semana'


---------------------------------------------------------
-- ADDDATE(): Me permite adicionar dias a una fecha

SELECT ADDDATE(CURRENT_DATE(),10)

-- ADDTIME(): Me permite sumar un tiempo determinado a una hora determinada

SELECT CURRENT_TIMESTAMP(), ADDTIME(CURRENT_TIMESTAMP(), '00:15:00');

-- CAST():Convertir un valor en un tipo de dato determinado

SELECT CAST('2023-06-25' AS DATE);

SELECT CAST(20065 AS CHAR);

SELECT ADDDATE(CAST('2023-06-25' AS DATE), 10);

--CHAR_LENGTH(): Me da el largo de un campo string

SELECT p.Prod_Id, p.Prod_Descripcion, 
    CHAR_LENGTH(p.Prod_Descripcion) AS largo 
FROM productos p

--COMPRESS(): Comprime el contenido del campo, me permite ahorrar espacio

SELECT COMPRESS(p.Prod_Descripcion) AS comprimido
FROM productos p


--UNCOMPRESS(): DEscomprime el contenido comprimido

SELECT UNCOMPRESS(COMPRESS(p.Prod_Descripcion)) AS original
FROM productos p

--CONCAT(): Sirve para concatenar texto

SELECT CONCAT("(",p.Prod_Id,") ",p.Prod_Descripcion," ",p.Prod_Color) AS descripcion
FROM productos p

--CONCAT_WS(): le agrega un delimitador, el cual nosotros indicamos, en este caso el delimitador es el ESPACIO

SELECT CONCAT_WS(" ",p.Prod_Id,p.Prod_Descripcion,p.Prod_Color) AS descripcion
FROM productos p

--CONV(): convierte valores

SELECT CONV("10",10,2); --quiero convertir el num 10, el cual es del sistema decimal(10), a binario(2)
SELECT CONV("A",16,10); --quiero convertir la letra A, el cual es del sistema exadecimal(16), a decimal(10)


--DATE_ADD(): sirve para sumar, me permite colocarle parametros , y asean  dias, mes, año

SELECT DATE_ADD(CURRENT_DATE, INTERVAL 10 DAY)


--DATE_FORMAT(): Sirve para formatear las fechas

SELECT DATE_FORMAT('2023-08-21', '%W' )

%Y: Año de 4 digitos
%y: Año de 2 digitos
%M: Nombre del mes en ingles
%m: Mes (00...12)
%d: Dia del mes(00..31)
%H: Horas (00..23)
%i: Minutos (00..59)
%s: Segundos (00..59)
%p: AM o PM
%W: Nombre del dia en ingles(Sunday..Saturday)

--DATE_SUB(): sirve para sustraer

SELECT DATE_SUB(CURRENT_DATE, INTERVAL 10 DAY)