-- Lab | SQL Rolling calculations
use sakila;

-- 1. Get number of monthly active customers.
select * from rental;
create view monthly_customers as
select date_format(rental_date, '%y%m') as rental_yymm, count(distinct customer_id) as active_customers
from rental
group by rental_yymm
order by rental_yymm;

select * from monthly_customers;

-- 2. Active users in the previous month.
select rental_yymm, active_customers, lag(active_customers, 1) over() as previous_customers
from monthly_customers;

-- 3. Percentage change in the number of active customers.
select rental_yymm, active_customers,
round((active_customers-(lag(active_customers, 1) over()))/active_customers*100, 2) as diff_in_perc
from monthly_customers;

-- 4. Retained customers every month.
with customers_month as
(select distinct customer_id, date_format(rental_date, '%y%m') as rental_yymm
from rental)
select l1.rental_yymm, count(distinct l1.customer_id) as retained_customers
from customers_month as l1
where l1.customer_id = (select distinct l2.customer_id from customers_month as l2
where l1.rental_yymm = l2.rental_yymm +1 and l1.customer_id = l2.customer_id)
group by rental_yymm;