-- Lab SQL Queries 3
use sakila;

-- 1. How many distinct (different) actors' last names are there?
select count(distinct(last_name)) as distinct_lastnames from actor;

-- 2. In how many different languages where the films originally produced? (Use the column language_id from the film table)
select count(distinct(language_id)) as distinct_languages from film; -- original_language_id is empty, language_id is always 1

-- 3. How many movies were released with "PG-13" rating?
select count(rating) as PG_13 from film where rating = 'PG-13';

-- 4. Get 10 the longest movies from 2006.
select length from film where release_year = 2006 order by length desc limit 10;

-- 5. How many days has been the company operating (check DATEDIFF() function)?
select max(rental_date), min(rental_date), datediff(max(rental_date), min(rental_date)) as operating_days from rental;

-- 6. Show rental info with additional columns month and weekday. Get 20.
select *, monthname(rental_date) as month, dayname(rental_date) as weekday from rental limit 20;

-- 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
select rental_date,
case
when weekday(rental_date) = 5 or 6 then 'weekend'
when weekday(rental_date) is null then 'undefined'
else 'workday'
end as day_type
from rental;

-- 8. How many rentals were in the last month of activity?
select max(rental_date) from rental;
select count(rental_id) from rental where year(rental_date) = 2006 and month(rental_date) = 2;