-- Lab | SQL Joins on multiple tables
use sakila;

-- 1.Write a query to display for each store its store ID, city, and country.
select s.store_id, c.city, co.country
from store as s
left join address as a
on s.address_id = a.address_id
left join city as c
on a.city_id=c.city_id
left join country as co
on c.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in
select s.store_id, sum(p.amount) as sum_of_payments
from payment as p
join staff as s
on p.staff_id = s.staff_id
group by s.store_id;

-- 3.What is the average running time of films by category?
select c.category_id, c.name, avg(f.length) as average_length
from film as f
join film_category as fc
on f.film_id=fc.film_id
join category as c
on c.category_id = fc.category_id
group by c.category_id;

-- 4.Which film categories are longest?
select c.category_id, c.name, avg(f.length) as average_length
from film as f
join film_category as fc
on f.film_id=fc.film_id
join category as c
on c.category_id = fc.category_id
group by c.category_id
order by average_length desc limit 5;

-- 5. Display the most frequently rented movies in descending order.
select f.film_id, f.title, count(rental_id) as times_rented
from film as f
left join inventory as i
on f.film_id=i.film_id
right join rental as r
on r.inventory_id=i.inventory_id
group by f.film_id
order by times_rented desc;

-- 6. List the top five genres in gross revenue in descending order.
select c.name, sum(p.amount) as sum_payments
from payment as p
join rental as r
on p.rental_id = r.rental_id
join inventory as i
on r.inventory_id = i.inventory_id
join film as f
on i.film_id=f.film_id
join film_category as fc
on f.film_id=fc.film_id
join category as c
on fc.category_id=c.category_id
group by c.category_id
order by sum_payments desc
limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
select i.store_id, f.title, count(i.inventory_id) as number_of_copies
from inventory as i
right join film as f
on i.film_id = f.film_id
where f.title = 'Academy Dinosaur'
group by i.store_id;