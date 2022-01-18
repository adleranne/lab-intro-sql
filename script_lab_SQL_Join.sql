-- LAB SQL Join
use sakila;

-- 1. List number of films per category
select category_id, count(film_id) as number_of_films
from film_category
group by category_id;

-- 2. Display the first and last names, as well as the address, of each staff member.
select s.first_name, s.last_name, a.address, a.district, a.postal_code
from staff as s
join address as a
on s.address_id = a.address_id;

-- 3. Display the total amount rung up by each staff member in August of 2005.
select p.staff_id, s.first_name, s.last_name, sum(p.amount) total_amount_August
from payment as p
join staff as s
on p.staff_id = s.staff_id
where month(p.payment_date) = 8
group by p.staff_id;

-- 4. List each film and the number of actors who are listed for that film.
select f.film_id, f.title, count(fa.actor_id) as number_of_actors
from film as f
join film_actor as fa
on f.film_id = fa.film_id
group by f.film_id;

-- 5. Using the tables payment and customer and the JOIN command, list the total paid
-- by each customer. List the customers alphabetically by last name.
select p.customer_id, c.last_name, sum(p.amount) as total_paid
from payment as p
join customer as c
on p.customer_id = c.customer_id
group by p.customer_id
order by c.last_name;