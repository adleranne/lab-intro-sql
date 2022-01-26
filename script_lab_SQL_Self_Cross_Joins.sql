-- Lab SQL self and cross joins

use sakila;

-- 1. Get all pairs of actors that worked together
select distinct a1.actor_id as Actor_1, a2.actor_id as Actor_2 # using distinct to filter out actor pairs, that worked together on different movies
from film_actor as a1
join film_actor as a2
on a1.film_id = a2.film_id # same film means working together
and a2.actor_id > a1.actor_id # to avoid duplicate pairs (e.g. 1:10 and 10:1), second id needs to be bigger than first
order by Actor_1;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.

with rentalcustomerfilm as #subquery to count how often a customer rented a certain movie
(select f.title as Film, r.customer_id, count(f.title) as Renting_times
from rental as r
left join inventory as i
on r.inventory_id = i.inventory_id
left join film as f
on i.film_id = f.film_id
group by r.customer_id, f.title)
select a.Film, a.customer_id as Customer_1, b.customer_id as Customer_2 # self join the subquery to see matches on film with rental_times > 3
from rentalcustomerfilm as a
join rentalcustomerfilm as b
on a.Film = b.Film
and a.customer_id < b.customer_id # again, to avoid duplicate pairs (e.g. 1:10 and 10:1), second id needs to be bigger than first id
where a.Renting_times > 3 and b.Renting_times > 3;
-- The query returns 0 pairs
-- checking the first part to see, if there are any customers renting a movie more than 3 times
select f.title as Film, r.customer_id, count(f.title) as Renting_times
from rental as r
left join inventory as i
on r.inventory_id = i.inventory_id
left join film as f
on i.film_id = f.film_id
group by r.customer_id, f.title
order by Renting_times desc;
-- there seems to be no customer that rented any movie more than 3 times

-- 3. Get all possible pairs of actors and films
select * from (select distinct(actor_id) from actor) as sub1
cross join (select distinct(film_id) from film) as sub2
order by film_id, actor_id;