create database example;
create DATABASE sample;
use example;
create table users (
	id INT,
	name VARCHAR(100)
);

insert users (id, name) values (1, 'Misha');

select * from users;