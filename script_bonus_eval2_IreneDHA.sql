USE sakila;
-- BONUS: -- 25. Encuentra todos los actores que han actuado juntos en al menos una película. 
-- La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.

-- primer: de dónde puedo sacar mis datos:
SELECT * FROM actor
INNER JOIN film_actor USING (actor_id)
INNER JOIN film USING (film_id);
-- cómo puedo relacionar actores de la misma película:
SELECT fa1.actor_id AS actor1, fa2.actor_id AS actor2 
FROM film_actor AS fa1
JOIN film_actor AS fa2
ON fa1.film_id = fa2.film_id; 
-- ARRIBA los actores se están comparando consigo mismos
-- voy a ver solo las combinaciones para 1 película y voy a ordenar por los actor_ids para ver claramente sus combinaciones
SELECT fa1.actor_id AS actor1, fa2.actor_id AS actor2 
FROM film_actor AS fa1
JOIN film_actor AS fa2
ON fa1.film_id = fa2.film_id
WHERE fa1.film_id = 1
ORDER BY actor1, actor2; 
-- quitar repeticiones:
SELECT fa1.actor_id AS actor1, fa2.actor_id AS actor2 
FROM film_actor AS fa1
JOIN film_actor AS fa2
ON fa1.film_id = fa2.film_id
WHERE fa1.actor_id < fa2.actor_id; 
-- contar número de películas en las que han participado:
SELECT fa1.actor_id AS actor1, fa2.actor_id AS actor2, COUNT(fa1.film_id) AS num_películas
FROM film_actor AS fa1
JOIN film_actor AS fa2
ON fa1.film_id = fa2.film_id
WHERE fa1.actor_id < fa2.actor_id
GROUP BY actor1, actor2; 
-- CTE para no tener que repetirlo

WITH costarts AS (SELECT fa1.actor_id AS actor1, fa2.actor_id AS actor2, COUNT(fa1.film_id) AS num_películas
					FROM film_actor AS fa1
					JOIN film_actor AS fa2
					ON fa1.film_id = fa2.film_id
					WHERE fa1.actor_id < fa2.actor_id
					GROUP BY actor1, actor2); 
SELECT * FROM costarts; -- me da error de que la tabla sakila.costarts no existe y CHATGPT dice que puede deberse a mi version de mySQL

-- ahora cogemos el SELECT correcto
SELECT fa1.first_name, fa1.last_name, fa2.first_name, fa2.last_name, COUNT(fa1.film_id) AS num_películas
FROM actor
-- estoy haciendo el SELF JOIN, pero no sé cómo unir actor con un SELF JOIN 
JOIN film_actor AS fa1
JOIN film_actor AS fa2 
ON fa1.film_id = fa2.film_id
WHERE fa1.actor_id < fa2.actor_id
GROUP BY fa1.first_name, fa1.last_name;


