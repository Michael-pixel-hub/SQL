/* Задача 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции. */

CREATE DATABASE shop;
CREATE DATABASE sample;

CREATE TABLE shop.users (id BIGINT UNSIGNED NOT NULL, name VARCHAR(20) NOT NULL);

CREATE TABLE sample.users (id BIGINT UNSIGNED NOT NULL, name VARCHAR(20) NOT NULL);

SELECT * FROM users;
SELECT * FROM sample.users;

INSERT INTO shop.users VALUES (1, 'Миша');
INSERT INTO sample.users VALUES (1, 'Миша');

START TRANSACTION;

INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;

DELETE FROM shop.users WHERE id = 1;

COMMIT;

/* Задача 2. Создайте представление, которое выводит название name товарной позиции 
из таблицы products и соответствующее название каталога name из таблицы catalogs. */

CREATE DATABASE dz2;

USE dz2;

CREATE TABLE catalogs (
id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
name VARCHAR(20) NOT NULL
);

CREATE TABLE products (
id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
name VARCHAR(20) NOT NULL, 
catalogs_id BIGINT UNSIGNED,
FOREIGN KEY (catalogs_id) REFERENCES catalogs (id)
);

INSERT INTO catalogs VALUES (DEFAULT, 'Компьютер'),
(DEFAULT, 'Принтер');

INSERT INTO products VALUES 
(DEFAULT, 'Модель 1', 1),
(DEFAULT, 'Модель 1', 2);

SELECT * FROM catalogs;
SELECT * FROM products;

SELECT catalogs.name AS name1, products.name FROM catalogs JOIN products ON catalogs.id = products.catalogs_id;

CREATE VIEW table_1 
AS SELECT catalogs.name AS name1, products.name 
FROM catalogs 
JOIN products 
ON catalogs.id = products.catalogs_id;

SELECT * FROM table_1;