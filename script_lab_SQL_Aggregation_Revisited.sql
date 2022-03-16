# Lab Aggregation Revisited - Sub queries
use sakila;

# Select the first name, last name, and email address of all the customers who have rented a movie.
select distinct r.customer_id, c.first_name, c.last_name, c.email
from rental as r
left join customer as c
on r.customer_id = c.customer_id;

# What is the average payment made by each customer (display the customer id,
# customer name (concatenated), and the average payment made).
select p.customer_id, concat(c.first_name, " ", c.last_name) as name, round(avg(p.amount), 2) as average_payment
from payment as p
left join customer as c
on p.customer_id = c.customer_id
group by p.customer_id
order by average_payment desc;

# Select the name and email address of all the customers who have rented the "Action" movies.
# Write the query using multiple join statements
select distinct c.customer_id, concat(c.first_name, " ", c.last_name) as name, c.email
from category as ca
join film_category as fc
on ca.category_id = fc.category_id
join inventory as i
on fc.film_id = i.film_id
join rental as r
on i.inventory_id = r.inventory_id
join customer as c
on r.customer_id = c.customer_id
where ca.name = 'Action'
order by c.customer_id;

# Write the query using sub queries with multiple WHERE clause and IN condition
select distinct customer_id, concat(first_name, " ", last_name) as name, email
from customer
where customer_id IN 
(select customer_id from rental
where inventory_id IN
(select inventory_id from inventory
where film_id IN
(select film_id from film_category
where category_id IN
(select category_id from category
where name = 'Action'))))
order by customer_id;

# Verify if the above two queries produce the same results or not
with jq as
(select distinct c.customer_id, concat(c.first_name, " ", c.last_name) as name, c.email
from category as ca
join film_category as fc
on ca.category_id = fc.category_id
join inventory as i
on fc.film_id = i.film_id
join rental as r
on i.inventory_id = r.inventory_id
join customer as c
on r.customer_id = c.customer_id
where ca.name = 'Action'
order by c.customer_id)
select count(distinct jq.customer_id) as cases_join_query,
count(distinct sq.customer_id) as cases_subquery,
count(case when jq.customer_id = sq.customer_id then 1 end) as cases_same
from jq
left join 
(select distinct customer_id, concat(first_name, " ", last_name) as name, email
from customer
where customer_id IN 
(select customer_id from rental
where inventory_id IN
(select inventory_id from inventory
where film_id IN
(select film_id from film_category
where category_id IN
(select category_id from category
where name = 'Action'))))
order by customer_id) as sq
on jq.customer_id = sq.customer_id;

# Use the case statement to create a new column classifying existing columns as either
# or high value transactions based on the amount of payment.
# If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4,
# the label should be medium, and if it is more than 4, then it should be high.
select payment_id, customer_id, amount,
case when amount <= 2 then 'low'
when amount <= 4 then 'medium'
else 'high' end
as transaction_value
from payment;
