# Домашнее задание 4.1

CREATE DATABASE dz;

USE dz;

CREATE TABLE users(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	created_at VARCHAR(50) NOT NULL,
	updated_at VARCHAR(50) NOT NULL
);

INSERT INTO users VALUES (DEFAULT, "01.09.2021 08:00", "01.09.2021 09:00");

# Домашнее задание 4.2

SELECT STR_TO_DATE (created_at, "%d.%m.%Y %h:%i") AS created_at FROM users;
SELECT STR_TO_DATE (updated_at, "%d.%m.%Y %h:%i") AS created_at FROM users;

# Домашнее задание 4.3

CREATE TABLE storehouses_products(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	value BIGINT NOT NULL
);

INSERT INTO storehouses_products
VALUES (DEFAULT, 0), (DEFAULT, 0), (DEFAULT, 4), (DEFAULT, 200), (DEFAULT, 2500);

SELECT * FROM storehouses_products ORDER BY IF (value > 0 ,FALSE ,TRUE);
