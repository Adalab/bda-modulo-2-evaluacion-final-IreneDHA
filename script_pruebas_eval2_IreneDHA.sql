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