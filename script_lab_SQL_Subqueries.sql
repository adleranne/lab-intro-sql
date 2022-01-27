-- Lab SQL Subqueries
use sakila;

-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?
select count(inventory_id) as number_copies
from inventory
where film_id = (select film_id from film where title = 'Hunchback Impossible');

-- 2. List all films whose length is longer than the average of all the films.
select film_id, title, length
from film
where length > (select avg(length) from film)
order by length;

-- 3. Use subqueries to display all actors who appear in the film Alone Trip.
select f.actor_id, a.first_name, a.last_name
from actor as a
join film_actor as f
on a.actor_id = f.actor_id
where f.film_id = (select film_id from film where title = 'Alone Trip');

-- 4. Sales have been lagging among young families, and you wish to target all family movies
-- for a promotion. Identify all movies categorized as family films.
select film_id, title
from film
where film_id in
(select film_id
from film_category
where category_id =
(select category_id
from category
where name = 'Family'));

-- 5a. Get name and email from customers from Canada using subqueries.
SELECT 
    customer_id, first_name, last_name, email
FROM
    customer
WHERE
    address_id IN (SELECT 
            address_id
        FROM
            address
        WHERE
            city_id IN (SELECT 
                    city_id
                FROM
                    city
                WHERE
                    country_id = (SELECT 
                            country_id
                        FROM
                            country
                        WHERE
                            country = 'Canada')));

-- 5b. Do the same with joins.
SELECT 
    c.customer_id, c.first_name, c.last_name, c.email
FROM
    customer AS c
        JOIN
    address AS a ON c.address_id = a.address_id
        JOIN
    city AS ci ON a.city_id = ci.city_id
        JOIN
    country AS co ON ci.country_id = co.country_id
WHERE
    co.country = 'Canada'; 

-- 6. Which are films starred by the most prolific actor?
-- Most prolific actor is defined as the actor that has acted in the most number of films.
select film_id, title
from film
where film_id in (select film_id
from film_actor
where actor_id =
(with Movie_counts as 
(select actor_id, count(film_id) as Number_Movies
from film_actor
group by actor_id)
select actor_id
from Movie_counts
where Number_Movies = ( select max(Number_Movies) from Movie_counts)));

-- 7. Films rented by most profitable customer.
select title as films_rented
from film
where film_id in
(select film_id from inventory
where inventory_id in
(select inventory_id from rental
where customer_id =
(with sum_payments as
(select customer_id, sum(amount) as payments
from payment
group by customer_id)
select customer_id
from sum_payments
where payments = 
(select max(payments)
from sum_payments))));

-- 8. Get the client_id and the total_amount_spent of those clients who spent more than the
-- average of the total_amount spent by each client.

with sum_payments as
(select customer_id, sum(amount) as total_amount_spent, avg(sum(amount)) over() as Average
from payment
group by customer_id)
select customer_id, total_amount_spent, Average
from sum_payments
where total_amount_spent > Average;