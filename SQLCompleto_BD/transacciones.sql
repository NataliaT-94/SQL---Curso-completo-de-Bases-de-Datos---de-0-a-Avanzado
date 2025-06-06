--Transacciones: Le permiten marcar al motor de base de datos un comienzo de operacion y un final de operacion, esto permite que nosotros los desarrolladores que si en el medio detectamos una falla o una operacion que no se realizo podemos echar atras todos los cambios que se hicieron previamente

START TRANSACTION; --Inicio de la transaccion
-
-
-
ROLLBACK; --si se detecta un arroe antes de llegar al commit, puedo desaser todas las sentencias anteriores con ROLLBACK
-
-
COMMIT; -- una vez que se ejecuta el COMMIT no hay vuelta atras

