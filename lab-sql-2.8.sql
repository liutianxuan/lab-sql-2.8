-- Lab SQL Join (Part II)
use sakila;
-- 1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, city.city, country.country
FROM sakila.store s
LEFT JOIN sakila.address ad USING(address_id)
LEFT JOIN sakila.city city USING(city_id)
LEFT JOIN sakila.country country USING(country_id)
GROUP BY s.store_id, city, country;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, sum(pay.amount) AS revenue
FROM sakila.store s
LEFT JOIN sakila.staff pp USING(store_id)
LEFT JOIN sakila.payment pay USING(staff_id)
GROUP BY store_id
ORDER BY revenue DESC;

-- 3. Which film categories are longest?
SELECT c.name as category, sum(f.length) AS duration
FROM sakila.film f
INNER JOIN sakila.film_category fc USING(film_id)
LEFT JOIN sakila.category c USING(category_id)
GROUP BY category
ORDER BY duration DESC;
-- Category Sports are the longest with a total length of 9487 min. 

-- 4. Display the most frequently rented movies in descending order.
SELECT f.title, count(r.inventory_id) rented_times
FROM sakila.inventory i 
INNER JOIN sakila.rental r USING(inventory_id)
INNER JOIN sakila.film f USING(film_id)
GROUP BY f.title
ORDER BY rented_times DESC;

-- 5. List the top five genres in gross revenue in descending order.
SELECT c.name category, sum(pay.amount) gross_revenue
FROM sakila.payment pay
INNER JOIN sakila.rental r USING(rental_id)
LEFT JOIN sakila.inventory i USING(inventory_id)
LEFT JOIN sakila.film_category fc USING(film_id)
LEFT JOIN sakila.category c USING(category_id)
GROUP BY category
ORDER BY gross_revenue DESC
LIMIT 5;


-- 6. Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title, r.rental_date, r.return_date
FROM sakila.inventory i
INNER JOIN sakila.rental r USING(inventory_id)
INNER JOIN sakila.store s USING(store_id)
INNER JOIN sakila.film f USING(film_id)
WHERE f.title = "Academy Dinosaur" AND store_id = 1
GROUP BY title, rental_date, return_date;

-- 7. Get all pairs of actors that worked together.
SELECT f1.film_id, f1.actor_id, f2.actor_id
FROM film_actor f1
JOIN film_actor f2
ON (f1.film_id = f2.film_id) AND (f1.actor_id <> f2.actor_id)
GROUP BY f1.film_id, f1.actor_id, f2.actor_id;

-- Bonus:
-- These questions are tricky, you can wait until after Monday's lesson to use new techniques to answer them!

-- 8. Get all pairs of customers that have rented the same film more than 3 times.
-- 9. For each film, list actor that has acted in more films.