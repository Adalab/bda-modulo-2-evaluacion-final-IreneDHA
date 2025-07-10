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
GROUP BY r.customer_id;
