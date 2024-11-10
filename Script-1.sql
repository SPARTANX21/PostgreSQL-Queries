--------------------------------------------------------------------------------------------------
--POSTGRES SQL
--------------------------------------------------------------------------------------------------

-- Creating Schema and table

-- create schema tutorials;


create table tutorials.employees(
	id numeric primary key, 
	first_name varchar not null,
	last_name varchar not null,
	email varchar,
	hire_date date default current_date,
	department varchar default 'Unassigned'
);

select * from tutorials.employees;

--------------------------------------------------------------------------------------------------
-- ALTER COMMAND 
--------------------------------------------------------------------------------------------------

alter table tutorials.employees add column age int;

-- dropping a column 
alter table tutorials.employees drop column age;

-- Changing default values 
alter table tutorials.employees alter column department set default 'Reassigned';

--------------------------------------------------------------------------------------------------
-- INSERT COMMAND 
--------------------------------------------------------------------------------------------------

insert into tutorials.employees(id, first_name, last_name, email) 
values(1, 'John', 'Doe', 'johndoe@example.com');

select * from tutorials.employees;

insert into tutorials.employees(id, first_name, last_name, email) 
values(2, 'Bob', 'Builder', 'bobuilder@example.com'),
(3, 'Lily', 'Greens', 'lilygreens@siemens.com'),
(4,'Matthias', 'Rebbelius', 'matthiasreb@siemens.com');

select * from tutorials.employees;

--------------------------------------------------------------------------------------------------
-- UPDATE COMMAND 
--------------------------------------------------------------------------------------------------

update tutorials.employees
	set first_name = 'Jane', last_name = 'Miller', email = 'janemiller@crio.di'
	where id = 1;

select * from tutorials.employees;

--------------------------------------------------------------------------------------------------
-- DELETE COMMAND 
--------------------------------------------------------------------------------------------------

delete from tutorials.employees 
where id = 3; select * from tutorials.employees;

delete from tutorials.employees where id in (1,4); 
select * from tutorials.employees;


insert into tutorials.employees(id, first_name, last_name, email) 
values(3, 'Lily', 'Greens', 'lilygreens@siemens.com'),
(4,'Matthias', 'Rebbelius', 'matthiasreb@siemens.com');

--------------------------------------------------------------------------------------------------
-- TRUNCATE COMMAND 
--------------------------------------------------------------------------------------------------

truncate table tutorials.employees;
select * from tutorials.employees;

--------------------------------------------------------------------------------------------------
-- MERGE COMMAND 
--------------------------------------------------------------------------------------------------

create table tutorials.employees_two(
	id int not null ,
	first_name varchar(50) not null, 
	last_name varchar(50) not null, 
	email varchar(100) not null, 
	hire_date date not null, 
	department varchar(50) not null, 
	primary key (id)
);

INSERT INTO tutorials.employees_two (id, first_name, last_name, email, hire_date, department)
VALUES
    (1, 'John', 'Doe', 'johndoe@example.com', '2022-01-01', 'Sales'),
    (2, 'Jane', 'Doe', 'janedoe@example.com', '2022-01-02', 'Marketing'),
    (3, 'Bob', 'Smith', 'bobsmith@example.com', '2022-01-03', 'Human Resources'),
    (4, 'Alice', 'Jones', 'alicejones@example.com', '2022-01-04', 'Sales'),
    (6, 'Tom', 'Wilson', 'tomwilson@example.com', '2022-01-05', 'Marketing');
  
select * from tutorials.employees_two;
 

merge into tutorials.employees as e 
using tutorials.employees_two as e2
on e.id = e2.id 
when matched then 
	update set 
		first_name = e2.first_name,
		last_name = e2.last_name, 
		email = e2.email,
		hire_date = e2.hire_date, 
		department = e2.department
when not matched then 
	insert (id, first_name, last_name, email, hire_date, department)
	values (e2.id, e2.first_name, e2.last_name, e2.email, e2.hire_date, e2.department );


select * from tutorials.employees_two;

--------------------------------------------------------------------------------------------------
-- DROP COMMAND 
--------------------------------------------------------------------------------------------------

drop table tutorials.employees;
--select * from tutorials.employees;		won't work

--------------------------------------------------------------------------------------------------
-- DATE TIME INTRO  
--------------------------------------------------------------------------------------------------

select timestamp '2024-11-09T13:09:00'; 

select date '2024-11-09';

select date 'November 09; 2024';

-- UTC COnverted
select timestamp with time zone '2024-11-09 13:10:05';

select current_date ;
select current_time;
select current_timestamp ;

select date_trunc('month', date '2024-11-09') ;
select date_trunc('year', date '2024-11-09') ;
select date_trunc('hour', date '2024-11-09') ;


select age(date '2024-11-21', date '2000-11-21'); 
select age(current_date, date '2000-11-21');


--------------------------------------------------------------------------------------------------
-- Diff DateTime 
--------------------------------------------------------------------------------------------------


select '2024-11-09' :: date;

select '13:20:00'::time;

select '2024-11-09'::timestamp;

select '13:25:00'::time -'11:50:25'::time as Intervael_Example;


--------------------------------------------------------------------------------------------------
-- Diff Timezones
--------------------------------------------------------------------------------------------------

select current_setting('timezone') ;


create table demo (
	tz_demo timestamptz,
	ntz_demo timestamp
);

insert into
	demo(tz_demo, ntz_demo)
	values('2024-01-01 15:30:00 -0700',
			'2024 01-01 15:30:00');
		
select * from demo; 


--------------------------------------------------------------------------------------------------
-- Intervals
--------------------------------------------------------------------------------------------------

select interval '1 day 2 hours 30 minutes';

select now() + interval '1 day' as Intervals;

select current_date   + interval '5 month';

select current_time  + interval '20 min';


--------------------------------------------------------------------------------------------------
-- ENUM
--------------------------------------------------------------------------------------------------


create type weekday as enum ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

create table enum_demo( 
	id serial primary key, 
	day_of_week weekday not null, 
	random character varying
);


select * from enum_demo;


insert into enum_demo(day_of_week, random)
values('Monday', '4');
insert into enum_demo(day_of_week, random)
values('Tuesday', '47');
insert into enum_demo(day_of_week, random)
values('Wednesday', '7');
insert into enum_demo(day_of_week, random)
values('Saturday', '5');
insert into enum_demo(day_of_week, random)
values('Saturday', '5');


select * from enum_demo order by day_of_week;


create type cartype as enum ('Sedan', 'Hatchback', 'SUV', 'Coupe', 'Crossover', 'Luxury');

create table enum_cars(
	id serial primary key, 
	car_type cartype not null, 
	carname varchar(50) not null
); 

insert into enum_cars(car_type, carname) values('Sedan', 'Honda City 2023'), 
												('Hatchback', 'Hyundai i20'), 
												('SUV', 'Toyota Innova Crossover'),
												('Coupe', 'Porsche Cayenne Coupé'),
												('Crossover', 'Mini Cooper'), 
												('Luxury', 'Rolls Royce Phantom');
											
select * from enum_cars;

--------------------------------------------------------------------------------------------------
-- ARRAYS
--------------------------------------------------------------------------------------------------


create table array_table(
	id serial primary key,
	myarray INTEGER[]
);

select * from array_table;

insert into array_table(myarray) values(array[1,2,3,4]);
insert into array_table(myarray) values(array[4,3,2,1]);
insert into array_table(myarray) values(array[10,11,12,13]);
insert into array_table(myarray) values(array[9,25,24,64]);

select * from array_table;

select * from array_table where 4 = any(myarray);	-- Finds 4 in myarray, and returns that array

select * from array_table where array[9,25,24,64]::integer[] = myarray;	-- to find all values from an array

select * from array_table;

select id, unnest(myarray) as unnested from array_table; 

-- CHARACTER ARRAY
create table array_table_char(
	id serial primary key,
	myarray CHARACTER[]
);

insert into array_table_char(myarray) values(array['a','b','c','d']), 
											(array['d','c','b','a']), 
											(array['z', 'g', 'b', 's']), 
											(array['p', 'r', 's', 'k']);
										
select * from array_table_char;

select * from array_table_char where 'g' = any(myarray);	-- Finds 4 in myarray, and returns that array


create table array_table_text(
	id serial primary key,
	myarray TEXT[]
);

insert into array_table_text(myarray) values(array['Pranay','Bindesh','Shah','Krishna']), 
											(array['America','California','New York','Nevada']), 
											(array['San Diego', 'North Carolina', 'Michigan', 'Texas']), 
											(array['Central Park', 'Trump Tower', 'Wall Street', 'President House']);

										
select * from array_table_text;

--------------------------------------------------------------------------------------------------
-- NESTED DATA
--------------------------------------------------------------------------------------------------

create table customers(
	id serial primary key,
	name text,
	address jsonb
);

select * from customers;
insert into customers(name, address) values('Pranay Shah', '{"Street": "524th Street", "City" : "Kalyan", "State" : "Maharashtra", "Zip" : "421301"}');
select * from CUSTOMERS;


select id, name, address->>'Street' as Street, address->>'City' as City, address->>'State' as State
from customers;

-- To update column item
update customers 
set address = jsonb_set(address, '{City}', '"California"') 
where name = 'Pranay Shah';

select * from customers;


-- to remove the whole column 

update customers 
set address = address - 'Zip' 
where name = 'Pranay Shah';

select * from customers;


