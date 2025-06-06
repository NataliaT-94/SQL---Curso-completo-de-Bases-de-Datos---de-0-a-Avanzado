-- 1). Con cuantas 'Comedias' trabajamos en la empresa?

SELECT COUNT(*) AS Comedias FROM film f
    JOIN film_category fc ON fc.film_id = f.film_id
    JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Comedy'

-- 2). Cual es el actor o actriz que mas peliculas ha filmado?

SELECT 
    fa.actor_id AS Id,
    a.first_name AS Nombre,
    a.last_name AS Apellido
 FROM film_actor fa
    JOIN actor a ON fa.actor_id = a.actor_Id
GROUP BY Id
ORDER BY COUNT(*)DESC
LIMIT 1

--Verificamos si el resultado anterior es el correcto

SELECT 
    COUNT(*) AS Peliculas, 
    fa.actor_id
FROM film_actor fa
GROUP BY fa.actor_id
ORDER BY peliculas DESC

-- 3). Que empleado del staff ha alquilado mas peliculas de la actriz del ejercicio 2?

SELECT 
    s.staff_id,
    s.first_name, 
    s.last_name
FROM staff s
    JOIN rental r ON r.staff_id = s.staff_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON f.film_id = i.film_id
    JOIN film_actor fa ON fa.film_id = f.film_id
WHERE fa.actor_id = 107
GROUP BY s.staff_id
ORDER BY COUNT(*) DESC
LIMIT 1

-- 4). Cuantas peliculas con rating PG-13 que hay en el store nro 2 ha alquilado el mejor cliente de todos?

--Primero filtramos las peliculas que cumplan con las codiciones de rating y de store
SELECT i.film_id
FROM film f
    JOIN  inventory i ON f.film_id = i.film_id
WHERE f.rating = 'PG-13' AND i.store_id = 2
GROUP BY i.film_id

--Segundo filtramos que cliente es el que mas compra 
SELECT r.customer_id
FROM rental r
GROUP BY r.customer_id
ORDER BY COUNT(r.customer_id) DESC
LIMIT 1

-- Por ultimo unimos tablas y las subconsultas
SELECT COUNT(*) AS Peliculas
FROM film f
    JOIN inventory i ON i.film_id = f.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.film_id IN (SELECT i.film_id
                    FROM film f
                        JOIN  inventory i ON f.film_id = i.film_id
                    WHERE f.rating = 'PG-13' AND i.store_id = 2
                    GROUP BY i.film_id) AND
     r.customer_id IN (SELECT ren.customer_id
                        FROM (SELECT r.customer_id
                                FROM rental r
                                GROUP BY r.customer_id
                                ORDER BY COUNT(r.customer_id) DESC
                                LIMIT 1) AS ren) AND
    i.store_id=2

-- en la ultima subconsulta se le agrega un select ya que no se permite utilizar LIMIT dentro de una subconsulta