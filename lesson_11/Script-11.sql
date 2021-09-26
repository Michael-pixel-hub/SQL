/* Задача 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
catalogs и products в таблицу logs помещается время и дата создания записи, 
название таблицы, идентификатор первичного ключа и содержимое поля name. */

USE intmag;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	id BIGINT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
	dates DATETIME,
 	name_table VARCHAR(255),
 	name VARCHAR(255)
) ENGINE=ARCHIVE;

DELIMITER //
DROP TRIGGER IF EXISTS users_options//
CREATE TRIGGER users_options AFTER INSERT ON users
FOR EACH ROW
BEGIN
	SELECT NOW() INTO @dates_now;
	SELECT users INTO @name_now FROM users ORDER BY id DESC LIMIT 1;
	INSERT INTO logs VALUES (
		DEFAULT, @dates_now, 'users', @name_now
	);
END//

DELIMITER //
DROP TRIGGER IF EXISTS catalogs_options//
CREATE TRIGGER catalogs_options AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	SELECT NOW() INTO @dates_now;
	SELECT catalogs INTO @name_now FROM catalogs ORDER BY id DESC LIMIT 1;
	INSERT INTO logs VALUES (
		DEFAULT, @dates_now, 'users', @name_now
	);
END//

DELIMITER //
DROP TRIGGER IF EXISTS products_options//
CREATE TRIGGER products_options AFTER INSERT ON products
FOR EACH ROW
BEGIN
	SELECT NOW() INTO @dates_now;
	SELECT products INTO @name_now FROM products ORDER BY id DESC LIMIT 1;
	INSERT INTO logs VALUES (
		DEFAULT, @dates_now, 'users', @name_now
	);
END//

SELECT * FROM logs;
SELECT * FROM products;
SELECT * FROM users;
SELECT * FROM catalogs;

INSERT INTO products VALUES (
DEFAULT, 'Модель 4', 1
);

INSERT INTO users VALUES (
DEFAULT, 'Юля'
);

INSERT INTO catalogs VALUES (
DEFAULT, 'Коврик'
);