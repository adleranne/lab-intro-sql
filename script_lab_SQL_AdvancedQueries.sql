use sakila;
-- Lab | SQL Advanced queries
-- 1. List each pair of actors that have worked together.
select distinct a1.actor_id as Actor_1, a2.actor_id as Actor_2 # using distinct to list pairs, that worked together on several movies only once
from film_actor as a1
join film_actor as a2
on a1.film_id = a2.film_id # same film means working together
and a2.actor_id > a1.actor_id # to avoid duplicate pairs (e.g. 1:10 and 10:1), second id needs to be bigger than first
order by Actor_1;

-- 2. For each film, list actor that has acted in more films.
-- checking if there are any actors who worked in only one movie
select actor_id, count(film_id) as number_movies
from film_actor
group by actor_id
order by number_movies;
-- minimum are 14 movies --> assuming that the question above is asking for the one actor
-- per movie that worked in the most movies

with movie_counts as
(select film_id, actor_id, count(film_id) over(partition by actor_id) as number_movies
from film_actor)
select film_id, actor_id, number_movies
from movie_counts as l1
where actor_id in
(select actor_id from movie_counts
where number_movies =
(select max(number_movies)
from movie_counts as l2
where l1.film_id = l2.film_id))
order by film_id;

-- cross checking results
select film_id, actor_id, count(film_id) over(partition by actor_id) as number_movies
from film_actor
order by film_id, number_movies desc;