--Triggers: Son disparadores. Son objetos que se crean en nuestras tablas, no son del motor de la base de datos. Ejecuta ciertas operaciones cuando detectan que se ha ejecutado alguna de las tres operaciones mas importantes del lenguaje SQL(INSERT, UPDATE, DELETE)

--Al momento de querer insertar datos, podemos controlar que ciertos campos lleven algunas reglas. Ej: Convertir eb mayusculas un nombre para asegurarnos que todos lo que se grabe sea en mayuscula
-------------

--Como crear la tabla triggers
-- Nos posicionamos en la tabla del cual queremos crear el triggers, click derecho crear nuevo->Disparador

--NOMBRE: El nombre del trigeers, lo podes cambiar
--Tabla: DEl cual vamos a crea el triggers
--Evento: 
    --Before: podemos atajar la modificacion antes de que ocurra(ej: para poder formatear datos)
    --After: Se inserta los datos y lo que podems hacer es consultarlos, pero no modificarlos
-- luego elegis la instruccion (INSERT, UPDATE, DELETE)

BEGIN

END
-------------------------------

--Nombre: NombreMayusculas
--Tabla: alumnos
--Evento: BEFORE -- INSERT

BEGIN
    SET NEW.Alumno_Nombre = UCASE(NEW.Alumno_Nombre);
END

--NEW: Se refiere a los datos que yo le estoy mandando para insertar
--OLD: Se refiere a los campos y los datos que ya estaban previamente grabados en la tabla. se usa en los UPDATE

--UCASE: es la funcion que convierte un nombre a mayusculas

-----------------------------------

--Nombre: productos_after_update
--Tabla: productos
--Evento: AFTER -- UPDATE

BEGIN
    IF new.prod_Precio <> OLD.Prod_Precio THEN --guardo cuando el precio viejo es diferente al precio nuevo
        INSERT INTO productos_historial(PH_ProdID, PH_PrecioANT, PH_PrecioNEW, PH_Usuario) VALUES
        (NEW.Prod_Id, OLD.Prod_Precio, NEW.Prod_Precio, CURRENT_USER);
    END IF;
END