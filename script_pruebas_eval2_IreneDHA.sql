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