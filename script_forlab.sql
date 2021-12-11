use sakila;
select * from actor, film, customer;
select title from film;
select distinct(name) as 'language' from language;
select count(distinct(store_id)) from store;
select count(distinct(staff_id)) from staff;
select first_name from staff;
