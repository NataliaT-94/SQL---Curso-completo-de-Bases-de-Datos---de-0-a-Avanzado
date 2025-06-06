--Eventos: Es la programaion de una tarea que se va a ejecutar en una hora determinada un dia determinado y le podemos dar cierta periodisidad. Permite realizar un mantenimiento mucho mas fino de la base de datos. Realizarr tareas especificas como pasar datos de una tabla a otra, Crear tablas, borrar datos, hacer una especie de mantenimiento a medida de lo que nosotros vamos a necesitar

--Nombre: <Nombre del evento>
--Comentario:< brevecomentario de lo que hace el evento>
--Suprimir evento despues de su expiracion: una vez que se ejecute el evento se borra automaticamente
--Estado.
    --Enable: Habilitado
    --Disable: DesHabilitado
    --Disable on slave: DesHabilitado en esclavo(replicas)

---PROGRAMAR
--Una sola vez: que dia y hora
--Cada: la cantidad de veces y cada cuanto
    --Comienza: seleccionar cuando comienza
    --Termina: seleccionar Cuando termina

BEGIN

END

----------------
