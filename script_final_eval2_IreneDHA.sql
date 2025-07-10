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
