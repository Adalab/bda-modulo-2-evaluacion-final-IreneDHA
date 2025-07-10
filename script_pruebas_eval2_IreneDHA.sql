USE sakila;
-- EJER 2:
SELECT description, rating, special_features, rental_rate -- comprobación sobre qué tipo de datos hay en estas columnas
FROM film;
SELECT title, rating -- comprobación de que la selección se esté haciendo correctamente
FROM film
WHERE rating IN ('PG-13');

-- EJER 4: 
SELECT title, length -- comprobración del tipo de dato que hay en lenght
FROM film;

SELECT title, length -- comprobración de que la selección se está haciendo correctamente
FROM film
WHERE length > 120
ORDER BY length ASC; -- comprobación de cuál es la película más cercana a 120 min

-- EJER 5:
SELECT DISTINCT first_name, last_name
FROM actor;
SELECT first_name, last_name
FROM actor; -- al comprobar si hace falta el DISTINCT aparece 1 fila más

SELECT first_name, last_name
FROM actor
WHERE first_name IS NULL OR last_name IS NULL; -- no parece haber ningún dato vacío

SELECT actor_id
FROM actor; -- con esta selección puedo ver que hay 200 actores ya que el actor_id es un dato único

SELECT CONCAT(first_name, ' ', last_name)
FROM actor; -- prueba para refinar el formato de concat

-- EJER 6:
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE 'gibson';
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%gibson'; -- pensándolo he visto que en este caso si hay un apellido que sea por ejemplo McGibson esta opción también lo incluiría
SELECT first_name, last_name
FROM actor
WHERE last_name IN ('gibson');

-- EJER 7:
SELECT first_name, last_name, actor_id 
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

-- EJER 8:
SELECT title, rating
FROM film 
WHERE rating NOT IN ('r', 'PG-13')
ORDER BY rating; -- he incluido esto porque me parece permitente tener las películas ordenadas por la condición que nos piden, pero no es necesario

-- EJER 9:
SELECT DISTINCT rating
FROM film; -- comprobación de cuántas categorías hay en rating
SELECT COUNT(title), rating
FROM film
GROUP BY rating;

-- EJER 10:
-- cantidad películas alquiladas x cliente
-- mostrar id, nombre, apellido cliente + cantidad 
SELECT * FROM inventory;
SELECT * FROM rental;
DESCRIBE inventory; -- no entendía muy bien qué era "inventory_id" y he descubierto esto gracias a CHATGPT
-- con ello puedo ver el tipo de dato y el tipo de claves que hay en la tabla (PK o FK)
SELECT * FROM customer AS c
INNER JOIN rental AS r
ON c.customer_id = r.customer_id; -- aquí veo las columnas que realmente necesito

SELECT c.customer_id, r.customer_id, c.first_name, c.last_name, r.rental_id -- selección de columnas para comprobación
FROM customer AS c
INNER JOIN rental AS r
ON c.customer_id = r.customer_id;

SELECT c.customer_id, r.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) -- selección de columnas para comprobación
FROM customer AS c
INNER JOIN rental AS r
ON c.customer_id = r.customer_id -- para comprobar que el join se está haciendo correctamente
GROUP BY r.customer_id;

-- EJER 11
-- cantidad películas alquilas x categoría + nombre categoria
-- film + film_category + category
SELECT * FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id;

-- con esta selección puedo ver todas las películas y sus categorías
SELECT f.film_id, f.title, fc.film_id, c.category_id, fc.category_id, c.name
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id;
-- ahora quiero ver cuáles se han alquilado: inventory y rental
SELECT * FROM inventory AS i
INNER JOIN rental AS R
ON i.inventory_id = r.inventory_id;

SELECT i.inventory_id, r.inventory_id, i.film_id, r.rental_id, r.customer_id
FROM inventory AS i
INNER JOIN rental AS R
ON i.inventory_id = r.inventory_id;
-- muestro la cantidad total de películas alquiladas, aunque da error porque estoy intentabdo seleccionar diferente número de filas
SELECT i.inventory_id, r.inventory_id, i.film_id, COUNT(r.rental_id), r.customer_id
FROM inventory AS i
INNER JOIN rental AS R
ON i.inventory_id = r.inventory_id
GROUP BY r.customer_id;
-- join de las 5 tablas que necesito
SELECT f.film_id, f.title, fc.film_id, c.category_id, fc.category_id, c.name, 
i.inventory_id, r.inventory_id, i.film_id, r.rental_id
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
INNER JOIN inventory AS i
INNER JOIN rental AS r
ON i.inventory_id = r.inventory_id;
-- 
SELECT c.category_id, c.name, COUNT(r.rental_id)
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
INNER JOIN inventory AS i
INNER JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY c.category_id;
-- he corregido los join ya que faltaba la unión entre film e inventory
SELECT c.category_id, c.name, COUNT(r.rental_id)
FROM category AS c
INNER JOIN film_category AS fc
ON fc.category_id = c.category_id
INNER JOIN film AS f
ON f.film_id = fc.film_id 
INNER JOIN inventory AS i
ON f.film_id = i.film_id
INNER JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name;

-- EJER 12:
-- AVG lenght para cada rating
SELECT AVG(length) AS duración_promedio, rating
FROM film
GROUP BY rating;

-- EJER 13:
-- nombre y apellido actores
SELECT * FROM actor;
SELECT first_name, last_name FROM actor;
-- película con title "Indian Love".
SELECT title FROM film
WHERE title LIKE "Indian Love";
-- join film_actor
SELECT first_name, last_name FROM actor
INNER JOIN film_actor USING (actor_id)
INNER JOIN film USING (film_id)
WHERE film.title LIKE "Indian Love";

-- EJER 14:
-- title where description "dog" o "cat
SELECT * FROM film;
SELECT title, description FROM film
WHERE description LIKE '%dog%' OR '%cat%';

-- EJER 15:
SELECT first_name, last_name, film_id FROM actor
LEFT JOIN film_actor USING (actor_id)
LEFT JOIN film USING (film_id);

-- comprobación de cuántos actores hay
SELECT COUNT(actor_id) FROM actor;
-- no consigo ver cómo puedo comprobar que el resultado que me da es correcto
SELECT actor_id, film_id FROM actor
LEFT JOIN film_actor USING (actor_id)
WHERE film_id IS NULL;
SELECT actor
-- EJER 16:
SELECT * FROM film;
SELECT DISTINCT release_year FROM film;
-- todas las películas salieron el mismo año, así que todas están incluidas
SELECT TITLE, release_year FROM film
WHERE release_year BETWEEN 2005 AND 2010;

-- EJER 17: he reutilizado código del ejer 11
SELECT f.title, fc.film_id, c.category_id, fc.category_id, c.name
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
WHERE c.name IN ('family');

-- EJER 18:
-- SELECT first_name, last_name FROM actor
-- COUNT(film_id)
-- INNER JOIN film_actor USING (film_id)

-- EJER 19
-- title
-- rating 'r'
-- length > 2 horas = 120 min
-- encontramos todas las películas que estén en la clasificación 'r'
SELECT title, rating FROM film
WHERE rating IN ('R');
-- añadimos la condición length
SELECT title, rating, length FROM film
WHERE rating IN ('R') AND length > 120;

-- EJER 20: 
-- SELECT category.name + AVG length > 120
SELECT AVG(f.length) AS promedio_duración, c.category_id, fc.category_id, c.name
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY c.category_id
HAVING promedio_duración > 120 
