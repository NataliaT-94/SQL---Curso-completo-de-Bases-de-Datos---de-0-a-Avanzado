--Vistas: SOn sentencias SELECT, (No se pueden colocar ni un INSERT,UPDATE,DELETE), que quedan grabadas en el motor para ejecutarlas cuando nosotros lo deseemos. Es una manera de ofuscar nuestras sentencias SQL a las vista de los demas, se necesita permisos. Las vistas no aceptan parametros. No se pueden modificar

--Nombre:ListadeProdustos

select `productos`.`Prod_Id` AS `Prod_Id`,`productos`.`Prod_Descripcion` AS `Prod_Descripcion`,`productos`.`Prod_Color` AS `Prod_Color`,`productos`.`Prod_Status` AS `Prod_Status`,`productos`.`Prod_Precio` AS `Prod_Precio`,`productos`.`Prod_ProvId` AS `Prod_ProvId`,`productos`.`Prod_ABC` AS `Prod_ABC` from `productos`

----------
--Llamar a la vista

SELECT * FROM ListadeProdustos
