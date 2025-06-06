--Nombre: UtilidadTotal
--Tipo: Funcion
--Regresa: Decimal
--Acceso a datos: Read SQL data
--PArametros:
    --_FechaDesde DATE
    --_FechaHasta DATE

BEGIN
    DECLARE Ganancia DECIMAL(10,2);
    
        SELECT SUM(VD_Cantidad * (VD_Precio - VD_Costo)) INTO Ganancia
    FROM ventas_detalle
        JOIN ventas ON VD_VentasID = Ventas_ID
    WHERE Ventas_Fecha BETWEEN _FechaDesde AND _FechaHasta AND 
        VD_Costo>0 AND VD_Precio>VD_Costo;
    RETURN Ganancia;
END

---
--LLamar a la Funcion

SELECT UtilidadTotal('2018-01-01', '2018-01-31');


-----------------------------------------------------

--Nombre: codigoABC
--Tipo: Procedimiento
--Acceso a datos: Read SQL data
--PArametros:
    --_FechaDesde DATE
    --_FechaHasta DATE

BEGIN
    DECLARE Ganancia DECIMAL(10,2);
    DECLARE GananciaA DECIMAL(10,2);
    DECLARE GananciaB DECIMAL(10,2);
    DECLARE GananciaC DECIMAL(10,2);

    DECLARE _ProdId INT;
    DECLARE _Utilidad DECIMAL(10,2);
    DECLARE Acumulado DECIMAL(10,2);
    DECLARE Letra CHAR(01);
    DECLARE Final TINYINT DEFAULT 0;

    DECLARE CUR_UTI CURSOR FOR    
        SELECT VD_ProdId, SUM(VD_Cantidad * (VD_Precio - VD_Costo)) AS Utilidad
    FROM ventas_detalle
        JOIN ventas ON VD_VentasID = Ventas_ID
    WHERE Ventas_Fecha BETWEEN _FechaDesde AND _FechaHasta AND 
        VD_Costo>0 AND VD_Precio>VD_Costo;
    GROUP BY VD_ProdId
    ORDER BY Utilidad;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET Final=1;

    SELECT UtilidadTotal(_FechaDesde, _FechaHasta) INTO Ganancia;

    SET GananciaA = Ganancia * .80;
    SET GananciaB = Ganancia * .15;
    SET GananciaC = Ganancia * .05;
    SET Acumulado = 0;
    SET Letra = "C";

    OPEN CUR_UTI;

    WHILE Final=0 DO
        FETCH CUR_UTI INTO _ProdId, _Utilidad;
        IF Final=0 THEN
            SET Acumulado = Acumulado + _Utilidad;
            IF Letra = "C" AND Acumulado > GananciaC THEN
                SET Acumulado = _Utilidad;
                SET Letra = "B";
            END IF;
            IF Letra = "B" AND Acumulado > GananciaB THEN
                SET Acumulado = _Utilidad;
                SET Letra = "A";
            END IF;
            UPDATE productos SET Prod_ABC = Letra WHERE Prod_Id = _ProdId;
        END IF;
    END WHILE;

    CLOSE CUR_UTI;
END

---
--LLamar a la Funcion

CALL CodigosABC('2018-01-01', '2018-01-31')