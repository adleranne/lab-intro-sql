use sakila;

-- In this lab we will find the customers who were active in consecutive months of May and June. Follow the steps to complete the analysis.
-- Create a table rentals_may to store the data from rental table with information for the month of May.
-- Insert values in the table rentals_may using the table rental, filtering values only for the month of May.
create table rentals_may
as select * from rental
where month(rental_date) = 5;

-- Create a table rentals_june to store the data from rental table with information for the month of June.
-- Insert values in the table rentals_june using the table rental, filtering values only for the month of June.
create table rentals_june
as select * from rental
where month(rental_date) = 6;

-- Check the number of rentals for each customer for May.
select customer_id, count(rental_id) as number_of_rentals
from rentals_may
group by customer_id
order by number_of_rentals desc;

-- Check the number of rentals for each customer for June.
select customer_id, count(rental_id) as number_of_rentals
from rentals_june
group by customer_id
order by number_of_rentals desc;