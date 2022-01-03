use sakila;
drop table if exists films_2020;
CREATE TABLE `films_2020` (
  `film_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year DEFAULT NULL,
  `language_id` tinyint unsigned NOT NULL,
  `original_language_id` tinyint unsigned DEFAULT NULL,
  `rental_duration` text,
  `rental_rate` text,
  `length` smallint unsigned DEFAULT NULL,
  `replacement_cost` text DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

show variables like 'local_infile';
set global local_infile = 1;

show variables like 'secure_file_priv';

load data local infile 'C:/Users/Anne_2/Documents/Ironhack/MySQL/lab-sql-6-master/files_for_lab/films_2020.csv'
into table films_2020
fields terminated by ','
lines Terminated by '\n';

-- For 2020, the rental duration will be 3 days, with an offer price of 2.99€ and a replacement cost of 8.99€ 
update films_2020
set films_2020.rental_duration = 3
where film_id <> 0;

update films_2020
set films_2020.replacement_cost = 8.99
where film_id <> 0;

-- alter table films_2020
-- add column offer_price integer;

-- update films_2020
-- set films_2020.offer_price = 2.99
-- where film_id <> 0;

update films_2020
set films_2020.rental_rate = 2.99
where film_id <> 0;

select * from films_2020;

