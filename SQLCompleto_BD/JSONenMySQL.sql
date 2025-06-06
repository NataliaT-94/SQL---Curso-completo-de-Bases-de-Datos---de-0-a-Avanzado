--JSON_REPLACE(): Permite modificar dentro del campo un valor JSON
--JSON_EXTRACT(): Permite extraer un valor de dentro de un campo 
--JSON_REMOVE(): Permite eliminar una clave JSON

UPDATE productos SET Prod_Propiedades = JSON_REPLACE(Prod_Propiedades, '$.propiedades.electrico','false')
WHERE Prod_Id=6992

SELECT Prod_Id, Prod_Descripcion FROM productos 
WHERE JSON_EXTRACT(Prod_Propiedades, '$.propiedades.electricos')=true

UPDATE productos SET Prod_Propiedades = JSON_REMOVE(Prod_Propiedades, '$.propiedades.presentaFallas')
WHERE Prod_Id=6992