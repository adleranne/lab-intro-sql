use sakila;

# In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies.
# Convert the query into a simple stored procedure.
delimiter $$
create procedure action_customers()
begin
select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  end;
  $$
  delimiter ;
  
  # Now keep working on the previous stored procedure to make it more dynamic.
  # Update the stored procedure in a such manner that it can take a string argument for the category name and
  # return the results for all customers that rented movie of that category/genre. For eg., it could be action, animation, children, classics, etc.

delimiter $$
create procedure category_customers(in genre char(20))
begin
select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = genre
  group by first_name, last_name, email;
  end;
  $$
  delimiter ;
  
  call category_Customers('Animation');
  
  # Write a query to check the number of movies released in each movie category.
  
  select c.name as category, count(fc.film_id) as number_movies
  from film_category as fc
  join category as c
  on fc.category_id = c.category_id
  group by c.name
  order by number_movies desc;
  
  
	# Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number.
  # Pass that number as an argument in the stored procedure.
  
  delimiter $$
  create procedure category_moviecount (in moviecount int)
  begin
  select c.name as category, count(fc.film_id) as number_movies
  from film_category as fc
  join category as c
  on fc.category_id = c.category_id
  group by c.name
  having number_movies > moviecount
  order by number_movies desc;
  end;
  $$
  
  delimiter ;
  
  call category_moviecount(60);