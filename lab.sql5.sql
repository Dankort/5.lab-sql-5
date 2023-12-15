use sakila;

-- 1. Drop column picture from staff.
alter table staff
drop column picture;
select * from sakila.staff;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO sakila.staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password,last_update)
values(
    -- Replace with the appropriate store_id
    3,
    "TAMMY",
    "SANDERS",
    79,
    'TAMMY.SANDERS@sakilacustomer.org',
    2,
    1 ,
    'TAMMY',
    NULL,
    CURRENT_TIMESTAMP());
select * from sakila.staff;

    
    -- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.
    -- You can use current date for the rental_date column in the rental table. 
    -- Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. 
    -- For eg., you would notice that you need customer_id information as well. To get that you can use the following query:

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

-- what's the academy dinosur film_id

select * from sakila.film 
where title like '%Academy Dinosaur%';

-- or academy dinosur film_id and inventory_id

select inventory_id, film_id
from sakila.inventory
where film_id = (select film_id from sakila.film WHERE title = 'Academy Dinosaur');


-- checking for staff_id

select staff_id
from sakila.staff
where first_name = 'MIKE' and last_name = 'HILLYER';

INSERT INTO sakila.rental(rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES ('2023-12-01 14:00:00', 1, 130, '2023-12-09 15:00:00', 1, '2023-12-09 17:00:00');
 
  select * from rental
 order by rental_id desc;
 
 -- 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:

-- Check if there are any non-active users
-- Create a table backup table as suggested
-- Insert the non active users in the table backup table
-- Delete the non active users from the table customer
 
 
 select * from customer
where active = 0;

create table deleted_users (
    customer_id int,
    email varchar(255),
    deletion_date date);

-- Insert the non active users in the table backup table

insert into deleted_users (customer_id, email, deletion_date)
select customer_id, email, current_date
from customer
where active = 0;

-- Delete the non active users from the table customer
set SQL_SAFE_UPDATES = 0;

delete from customer
where active = 0;
 

 










