-- Lab 8
use sakila;

-- Rank films by length (filter out the rows that have nulls or 0s in length column).
-- In your output, only select the columns title, length, and the rank.
select title, length,
rank() over (order by length desc) rank_length
from sakila.film
where length <> '' and length <> 0;

-- Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column).
-- In your output, only select the columns title, length, rating and the rank.
select title, length, rating,
rank() over (partition by rating order by length desc) rank_per_rating
from sakila.film
where length <> '' and length <> 0;

-- How many films are there for each of the categories in the category table. Use appropriate join to write this query
select cat.name, count(fc.film_id) as number_films
from sakila.film_category as fc
left join sakila.category as cat on fc.category_id = cat.category_id
group by cat.name
order by number_films desc;

-- Which actor has appeared in the most films?
select a.first_name, a.last_name, count(fa.film_id) number_films
from film_actor as fa
left join actor as a on fa.actor_id = a.actor_id
group by fa.actor_id
order by number_films desc
limit 1;

-- Most active customer (the customer that has rented the most number of films)
select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as number_films
from sakila.rental as r
left join sakila.customer as c on r.customer_id = c.customer_id
group by r.customer_id
order by number_films desc
limit 1;

-- Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement.
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
select f.film_id, f.title, count(r.rental_id) as number_rented
from sakila.rental as r
join sakila.inventory as i on r.inventory_id = i.inventory_id
join sakila.film as f on i.film_id = f.film_id
group by f.film_id
order by number_rented desc
limit 1;
