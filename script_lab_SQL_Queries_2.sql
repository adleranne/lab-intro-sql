use sakila;

-- Select all the actors with the first name ‘Scarlett’.
select * from sakila.actor where first_name = 'Scarlett';

-- Select all the actors with the last name ‘Johansson’.
select * from actor where last_name = 'Johansson';

-- How many films (movies) are available for rent?
select count(distinct(film_id)) as number_of_movies from inventory;

-- How many films have been rented?
select count(distinct(inventory_id)) as rent_outs from rental;

-- What is the shortest and longest rental period?
select min(rental_duration) as shortest_rental_period, max(rental_duration) as longest_rental_period from film;

-- What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select min(length) as min_duration, max(length) as max_duration from film;

-- What's the average movie duration?
select avg(length) from film;

-- What's the average movie duration expressed in format (hours, minutes)?
SELECT 
    CONCAT(FLOOR(AVG(length) / 60),
            ':',
            FLOOR(AVG(length) % 60)) AS average_length
FROM
    film;

-- How many movies longer than 3 hours?
select count(film_id) from film where length > 180;

-- Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.
select concat(first_name, last_name,' - ',email) from customer as name_and_email;

-- What's the length of the longest film title?
select max(char_length(title)) from film;