CREATE DATABASE intmag;

USE intmag;

CREATE TABLE users (
	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	users VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE catalogs (
	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	catalogs VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE products (
	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	products VARCHAR(30) NOT NULL,
	catalogs_id BIGINT UNSIGNED,
	CONSTRAINT catalog_id_c FOREIGN KEY (catalogs_id) REFERENCES catalogs (id)
);

CREATE TABLE orders (
	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	order_number BIGINT UNSIGNED NOT NULL,
	users_id BIGINT UNSIGNED NOT NULL,
	products_id BIGINT UNSIGNED,
	FOREIGN KEY (users_id) REFERENCES users (id)
);

CREATE TABLE flights (
	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	fromm VARCHAR(30) NOT NULL,
	too VARCHAR(30) NOT NULL
);

CREATE TABLE cities (
	label VARCHAR(30) NOT NULL,
	name VARCHAR(30) NOT NULL
);

INSERT INTO users VALUES
	(DEFAULT, "Игор"),
	(DEFAULT, "Маша"),
	(DEFAULT, "Лена"),
	(DEFAULT, "Вася"),
	(DEFAULT, "Гоша"),
	(DEFAULT, "Настя"),
	(DEFAULT, "Михаил");

INSERT INTO catalogs VALUES
	(DEFAULT, "Телефон"),
	(DEFAULT, "Компьютер"),
	(DEFAULT, "Принтер"),
	(DEFAULT, "Монитор"),
	(DEFAULT, "Клавиатура"),
	(DEFAULT, "Мышка"),
	(DEFAULT, "Ноутбук");

INSERT INTO products VALUES
	(DEFAULT, "Модель 1", 1),
	(DEFAULT, "Модель 2", 1),
	(DEFAULT, "Модель 3", 1);

INSERT INTO orders VALUES
	(DEFAULT, 12, 1, 1),
	(DEFAULT, 122, 2, 2),
	(DEFAULT, 121, 2, 2),
	(DEFAULT, 1211, 1, 1),
	(DEFAULT, 1442, 1, 3),
	(DEFAULT, 1562, 5, 4),
	(DEFAULT, 1732, 6, 5);

INSERT INTO flights VALUES
	(DEFAULT, "moscow", "omsk"),
	(DEFAULT, "novgorod", "kazan"),
	(DEFAULT, "irkutsk", "moscow"),
	(DEFAULT, "omsk", "irkutsk"),
	(DEFAULT, "moscow", "kazan");

INSERT INTO cities VALUES
	("moscow", "Москва"),
	("irkutsk", "Иркутск"),
	("novgorod", "Новгород"),
	("kazan", "Казань"),
	("omsk", "Омск");

/* Задание 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в 
интернет магазине.*/

SELECT users, id FROM users WHERE id IN (SELECT users_id FROM orders GROUP BY users_id);

# Задание 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT catalogs, products FROM catalogs JOIN products WHERE catalogs.id = products.catalogs_id;