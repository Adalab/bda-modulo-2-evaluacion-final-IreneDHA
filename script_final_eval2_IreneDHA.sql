USE sakila;
-- EJER 1: Selecciona todos los nombres de las películas sin que aparezcan duplicados
SELECT DISTINCT title 
FROM film;

-- EJER 2: Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT title AS 'películas_clasificadas_PG-13'
FROM film
WHERE rating IN ('PG-13');

-- EJER 3: Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
SELECT title, description
FROM film
WHERE description LIKE "%amazing%";

-- EJER 4: Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
SELECT title AS películas_largas
FROM film
WHERE length > 120;

-- EJER 5: Recupera los nombres de todos los actores.
SELECT CONCAT(first_name, ' ', last_name) AS lista_actores
FROM actor;

-- EJER 6: Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT CONCAT(first_name, ' ', last_name) AS actores_gibson
FROM actor
WHERE last_name LIKE 'gibson';

-- EJER 7: Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT CONCAT(first_name, ' ', last_name) AS lista_actores
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

-- EJER 8: Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
SELECT title AS películas_aptas_para_niños
FROM film 
WHERE rating NOT IN ('r', 'PG-13');

-- EJER 9: Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
SELECT COUNT(title) AS num_películas, rating AS clasificación
FROM film
GROUP BY rating;

-- EJER 10: Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT c.customer_id, CONCAT(first_name, ' ', last_name) AS clientes, COUNT(r.rental_id) AS num_películas_alquiladas
FROM customer AS c
INNER JOIN rental AS r -- hago este join porque solo me interesa ver información sobre clientes que han alquilado
USING (customer_id)
GROUP BY c.customer_id;

-- EJER 11: Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT c.name AS categoría, COUNT(r.rental_id) AS cantidad_películas_alquiladas
FROM category AS c
INNER JOIN film_category AS fc USING (category_id)
INNER JOIN film AS f USING (film_id)
INNER JOIN inventory AS i USING (film_id)
INNER JOIN rental AS r USING (inventory_id)
GROUP BY c.category_id, c.name;

-- EJER 12: Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT AVG(length) AS duración_promedio, rating AS clasificación
FROM film
GROUP BY rating;

-- EJER 13: Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
SELECT CONCAT(first_name, ' ', last_name) AS actores_en_indian_love FROM actor
INNER JOIN film_actor USING (actor_id)
INNER JOIN film USING (film_id)
WHERE film.title LIKE "Indian Love";

-- EJER 14: Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
SELECT title AS películas_con_animales FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

-- EJER 15: Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.
SELECT actor_id, film_id FROM actor
LEFT JOIN film_actor USING (actor_id)
WHERE film_id IS NULL;
-- La respuesta es: No hay ningún actor o actriz que no aparezca en ninguna película

-- EJER 16: Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
SELECT title FROM film
WHERE release_year BETWEEN 2005 AND 2010;

-- EJER 17: Encuentra el título de todas las películas que son de la misma categoría que "Family".
SELECT f.title AS películas_para_familias
FROM film AS f
INNER JOIN film_category AS fc USING (film_id)
INNER JOIN category AS c USING (category_id)
WHERE c.name IN ('family');

-- EJER 18: Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

SELECT CONCAT(first_name, ' ', last_name) AS actores_con_experiencia
FROM actor AS a
INNER JOIN film_actor AS fa USING (actor_id)
GROUP BY a.actor_id
HAVING COUNT(DISTINCT fa.film_id) > 10; -- no podemos usar un WHERE cuando estamos poniendo la condición en el GROUP BY

-- EJER 19: Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
SELECT title AS películas_R_largas FROM film
WHERE rating IN ('R') AND length > 120; -- también se puede poner rating = 'R'

-- EJER 20: Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT AVG(f.length) AS promedio_duración, c.name AS categoría
FROM film AS f
INNER JOIN film_category AS fc USING (film_id)
INNER JOIN category AS c USING (category_id)
GROUP BY c.category_id
HAVING promedio_duración > 120;

-- EJER 21: Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.
SELECT CONCAT(first_name, ' ', last_name) AS actores_con_experiencia, COUNT(DISTINCT fa.film_id) AS num_películas 
-- hemos visto en el ejercicio 18 que realmente es distinct no es necesario
FROM actor AS a
INNER JOIN film_actor AS fa USING (actor_id)
GROUP BY a.actor_id
HAVING num_películas >= 5;

-- EJER 22: Encuentra el título de todas las películas que fueron alquiladas por más de 5 días.
SELECT DISTINCT f.title FROM film AS f
INNER JOIN inventory AS i USING (film_id)
INNER JOIN rental AS r USING (inventory_id)
WHERE rental_id IN (SELECT r.rental_id FROM rental AS r
					WHERE (r.return_date - r.rental_date) > 5); -- mi lógica me dice que tengo que restar estos dos datos, pero no estoy 100% de que esto sea correcto

-- existe la función DATEDIFF que calcula la diferencia de días en datos que son tipo DATE/DATETIME
SELECT DISTINCT f.title FROM film AS f
INNER JOIN inventory AS i USING (film_id)
INNER JOIN rental AS r USING (inventory_id)
WHERE rental_id IN (SELECT r.rental_id FROM rental AS r
					WHERE DATEDIFF(r.return_date, r.rental_date) > 5); -- EL RESULTADO ES DIFERENTE


-- EJER 23: Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror".
SELECT CONCAT(first_name, ' ', last_name) AS actores_no_horror
FROM actor AS a 
WHERE actor_id NOT IN (SELECT fa.actor_id 
						FROM film_actor AS fa 
						INNER JOIN film AS f USING (film_id) 
						INNER JOIN film_category AS fc USING (film_id)
						INNER JOIN category AS c USING (category_id)
						WHERE c.name IN ('horror'));

-- EJER 24: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.
SELECT f.title AS comedias_largas
FROM film AS f
INNER JOIN film_category AS fc USING (film_id)
INNER JOIN category AS c USING (category_id)
WHERE c.name IN ('comedy') AND f.length > 180;