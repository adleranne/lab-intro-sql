use sakila;
-- 1. Drop column picture from staff.
alter table staff
drop column picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from staff;
select * from customer where last_name = 'Sanders';
insert into staff
values(3, 'Tammy', 'Sanders', 79, 'tammy.sanders@sakilacustomer.org', 2, 1, 'Tammy', null, CURRENT_TIMESTAMP());

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
select * from rental;
select max(rental_id) from rental;
select inventory_id from inventory
where film_id =
(select film_id from film where title = 'Academy Dinosaur' and store_id = 1);
-- there are 4 copies of that film as inventory in store 1, just entering inventory_id 1
select customer_id from customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
select staff_id from staff where first_name = 'Mike' and last_name = 'Hillyer';
insert into rental
values(16050, CURRENT_TIMESTAMP(), 1, 130, DATE_ADD(NOW(), INTERVAL 7 DAY), 1, CURRENT_TIMESTAMP());
select * from rental where rental_id = 16050;

-- 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:

-- Check if there are any non-active users
select customer_id from customer where active = 0;

-- Create a backup table as suggested
create table deleted_users(
customer_id int unique not null,
email varchar(50) default null,
delete_date datetime not null,
constraint primary key(customer_id));

-- Insert the non active users in the table backup table
insert into deleted_users
select customer_id, email, CURRENT_TIMESTAMP() 
from customer where active = 0;
select * from deleted_users;

-- Delete the non active users from the table customer
delete from customer where active = 0;
-- wouldn't let me delete without key column in where condition (safe update mode)?