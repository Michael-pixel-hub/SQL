/* Задача 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от 
текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 
функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — 
"Доброй ночи". */

DROP FUNCTION IF EXISTS hello;

DELIMITER //

CREATE FUNCTION hello ()
RETURNS VARCHAR(250) DETERMINISTIC
BEGIN
  	DECLARE times_now TIME;
  	SET times_now = DATE_FORMAT(NOW(), '%H:%i');
	IF (times_now < '12:00' AND times_now > '06:00') THEN 
		RETURN 'Доброе утро';
	END IF;
	IF (times_now < '18:00' AND times_now > '12:00') THEN
		RETURN 'Добрый день';
	END IF;
	IF (times_now <= '23:59' AND times_now > '18:00') THEN
		RETURN 'Добрый вечер';
	END IF;
	IF (times_now < '06:00' AND times_now > '00:00') THEN
		RETURN 'Доброй ночи';
	END IF;
END//

SELECT hello()//

/* Задача 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение 
NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию. */

CREATE TABLE products (
name VARCHAR(250),
description VARCHAR(250)
);

SELECT * FROM products;

DELIMITER //

CREATE TRIGGER trigger_1 AFTER INSERT ON products
FOR EACH ROW
BEGIN
	IF (NEW.name IS NULL AND NEW.description IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Нужно ввести хотя бы одно значение в один из столбцов';
	END IF;
END//

INSERT INTO products (name, description) VALUES (NULL, NULL);

SELECT * FROM products;