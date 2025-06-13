--------------------CREACION DE BASE DE DATOS---------------------

--RDS

--Templates.
    --Production:Amazon coloca toda la infraestructura necesaria para que funcione lo mas optimo posible.
    --Dev/Test:Lo usan los desarrolladores para  pones a prueba un desarrollo
    --Free tier: Es la capa Gratuita

--Settings
    --DB instance identifier: Colocamos el nombre de la base de datos (ej: cursoDB)
    --Credential Settings
        --Master username: Usuario maestro (ej: root)
        --Master Password:

--DB instance Class
    --Burstable classes (includes t classes)
        --db.t3.micro(indica la cantidad de memotria y procesadores virtuales que le va a incluir)

--Storage
    --General Purpose (SSD): Disco de propositos general, es decir eque se puede usar tanto para alojar archivos como para lo que tiene que ver con el motor de base de datos.
    --Allocated storage: almacenamiento asignado
        -- 20
    --Storage autoscaling(Escalado automático de almacenamiento)
        --Enable storage autoescaling (Habilitar escalado automático de almacenamiento)
    --Maximum storage threshold(Umbral de almacenamiento máximo)
        --21 (para que no escale mas que lo premitido)

--Availability & durability
    --Multi-AZ deployment


--Connectivity
    --virtual private cloud(VPC)
        --Default
    --Subnet Group
        --Default
    --Public access
        --YES(nos permite conectarnos desde afuera, Ej. con heidiSQL desde la pc) ---ELEJIMOS YES
        -- NO( Solo la infra que yo tengo creada en Amazon va  a poder acceder a es base)

    --VPC security group. Grupo de coniguraciones y seteos enfocados a la seguridad de la DB
        --Create new: cursobd_security
        --Availability Zone: us-east-1a
    
--Database authentication
    --Password authentication

--Additional configuration
    --Initial database name:cambiar el nombre a la db, para que sea diferente a la instancia
        --LO DEJMAOS EN BLANCO
    --DB parameter gorup
        --Default
    --Option group
        --Default
    --Backup
        --Enable Automatico
        --Backup retention period(Periodo de retención de copia de seguridad): 7
        --Backup window: No preference
        --Backup replicacion: replicacion de un backup en otro dataCenter--LO DEJAMOS EN BLANCO

    --Monitoring
        --Enable Enhanced monitoring: Sirve para ver como esta el procesador de la bd
    --Deletion protection
        --Enable delection protection: protege la db para que no se pueda borrar