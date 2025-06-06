--Rutinas Almacenadas: Son pedazos de codigo que pueden o no contener codigo SQL, que se graban en en motor de base de datos y que en definitiva se crean por un tema de seguridad y de velocidad.
--Al estar compiladas dentro del motor son mas rapidas 
--Mantiene todo el codigo SQL y nuestro manejo de base de datos de manera oculta hacia la vista de los curiosos
------------------------------------------------------------------------------
--OPCIONES:
	--Nombre: Nombre de la rutina.
	--Definir: Quien va a ser el usuario que va a tener acceso a la rutina
	--Comentario: Indicas que hace la rutina.
	--TIPO:
		--Un Procedimiento lo voy a poder ejecutar por fuera de una sentencia SELECT, lo voy a tener que ejecutar.
		--Una Funcion lo voy a tener que usar dentro de una sentencia SELECT 
	--Regresa: definis que tipo de dato va a retornar(varchar, int, etc..)
	--Acceso a datos: definimos si va a contener SQL o no, si van a utilizar cursores  o no
	--seguridad SQL: Defie de donde se van a tomar los aspectos de seguridad
	--Deterministio:Se usa cuando creamos un almacenamiento almacenado que siempre ejecuta lo mismo, no hay variable, sin parametros(recomendacion siempre usar destildado)
--PARAMETRO:
	--Recibe parametros externos
	--definimos el nombre del parametro y que tipo de datos estamos recibiendo

BEGIN
	DECLARE CONTINUE HANDLER FOR 1062
	SELECT "Clave Duplicado";
	INSERT INTO alumnos (Alumno_Id, Alumno_Nombre) VALUES (_IdAlumno, _NombreAlumno);
END
--DECLARE: Me permitr crear y declarar variables, declarar cursores y tambien declarar manejadores

-- HANDLER: van a capturar el error, lo van a manejar, le van a dar tratamiento en cuanto encuentren un erroren tiempo de ejecucion
 
--CONTINUE: En caso de un error continua con lo de abajo
-- EXIT: TErminar la ejecucion
--error 1062: clave duplicada

--LLAMAR a la RUTINA
CALL <Nombre Rutina(<parametros>)>;

-------------------------
--MaximaVenta
BEGIN
	DECLARE ValorMaximo DECIMAL(10,2);
	
	SET ValorMaximo = 0;
	
	SELECT MAX(Ventas_Total) INTO ValorMaximo FROM ventas;
	IF ValorMaximo > 1000 THEN
		SELECT "Se superaron los $1ooo!" AS Mensaje;
	ELSE
		SELECT "Aun no superas los $1000" AS Mensaje;
	END IF;
END


CALL MaximaVenta();

----------------------------
--CURSORES: Son tablas en memoria que crea el motor, no son tablas reales. Nos permite recorrer sus registros y procesar sus datos esas tablas son creadas en base a una sentencia SQL que nosotros ejecutamos. Una vez que tenemos nuestra instruccion SELECT con el resultado, eso lo vamos a grabar en un CURSOR. Esto sirve para ir recorriendo el registro por registro capturando valores del cursor y en base a eso poder ir haciendo operaciones, comparaciones, y procesos especiales


--GananciaVentas

BEGIN
	DECLARE Ganancia DECIMAL(10,2);
	DECLARE _Precio DECIMAL(10,2);
	DECLARE _Cantidad MEDIUMINT;
	DECLARE _Costo DECIMAL(10,2);
	DECLARE Final TINYINT DEFAULT 0;
	
	DECLARE CV CURSOR FOR
		SELECT VD_Precio, VD_Costo, VD_Cantidad FROM ventas_detalle
			JOIN ventas ON VD_Ventas_Id=Ventas_ID
		WHERE VD_Costo>0 AND YEAR(ventas_Fecha)=_Ano AND MONTH(ventas_Fecha)=_Mes;
		
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET Final=1;
	
	SET Ganancia = 0;
	
	OPEN CV;
	
	WHILE Final=0 DO
		FETCH cv INTO _Precio, _Costo, _Cantidad;
		IF Final=0 THEN
			SET Ganancia = Ganancia + ((_Precio - _Costo) * _Cantidad);
		END IF;
	END WHILE;
	
	CLOSE CV;
	RETURN Ganancia;		
END

-- LLamar a la funcion

SELECT GananciaVentas(2018,5);
---
SELECT GananciaVentas(2018,1) AS Ganancia, ventas_Fecha
FROM Ventas;