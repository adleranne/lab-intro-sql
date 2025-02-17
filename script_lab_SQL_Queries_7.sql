use sakila;

-- In the table actor, which are the actors whose last names are not repeated?
select last_name, count(last_name) from actor group by last_name having count(last_name)=1;

-- Which last names appear more than once? 
select last_name, count(last_name) from actor group by last_name having count(last_name)>1;

-- Using the rental table, find out how many rentals were processed by each employee.
select staff_id, count(rental_id) from rental group by staff_id;

-- Using the film table, find out how many films were released each year
select release_year, count(film_id) from film group by release_year;

-- Using the film table, find out for each rating how many films were there.
select rating, count(film_id) from film group by rating order by count(film_id) desc;

-- What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
select rating, round(avg(length),2) as average_length from film group by rating order by avg(length) desc;

-- Which kind of movies (rating) have a mean duration of more than two hours?
select rating, round(avg(length),2) as average_length from film group by rating having average_length>120 order by avg(length) desc;