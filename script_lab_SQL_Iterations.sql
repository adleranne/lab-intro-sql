-- Lab SQL Iterations
use sakila;

# Write a query to find what is the total business done by each store.
select s.store_id, sum(p.amount) as total_business
from payment as p
left join staff as s
on p.staff_id = s.staff_id
group by s.store_id
order by total_business desc;

# Convert the previous query into a stored procedure.
delimiter //
create procedure store_business()
begin
select s.store_id, sum(p.amount) as total_business
from payment as p
left join staff as s
on p.staff_id = s.staff_id
group by s.store_id
order by total_business desc;
end //
delimiter ;

call store_business();

# Convert the previous query into a stored procedure that takes the input for store_id
# and displays the total sales for that store.

delimiter //
create procedure store_business_input(in storeID int)
begin
select s.store_id, sum(p.amount) as total_business
from payment as p
left join staff as s
on p.staff_id = s.staff_id
where s.store_id = storeID;
end //
delimiter ;

call store_business_input(1);

# Update the previous query. Declare a variable total_sales_value of float type,
# that will store the returned result (of the total sales amount for the store).
# Call the stored procedure and print the results.

delimiter //
create procedure store_business_var(in storeID int)
begin
declare total_sales_value float;
select sum(p.amount) into total_sales_value
from payment as p
left join staff as s
on p.staff_id = s.staff_id
where s.store_id = storeID;
select storeID, total_sales_value;
end //
delimiter ;

call store_business_var(1);

# In the previous query, add another variable flag.
# If the total sales value for the store is over 30.000, then label it as green_flag, otherwise label is as red_flag.
# Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.

delimiter //
create procedure store_business_flag(in storeID int)
begin
declare total_sales_value float;
declare flag varchar(10) default " ";
select sum(p.amount) into total_sales_value
from payment as p
left join staff as s
on p.staff_id = s.staff_id
where s.store_id = storeID;
if total_sales_value > 30000 then
set flag = "green_flag";
else set flag = "red_flag";
end if;
select storeID, total_sales_value, flag;
end //
delimiter ;

call store_business_flag(1);