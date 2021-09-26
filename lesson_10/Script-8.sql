/* Курсовой проект на тему: база данных CRM-системы Битрикс24. 
 Ее база данных будет состоять из 10 таблиц: контакты, компании, товары, сделки, сообщения, сотрудники, отделы, 
 этапы воронки продаж, задачи, проекты, медиа, категории товаров, воронки продаж
 Эта база данных будет решать задачу по поиску клиентов в базе данных, их покупок и общение с менеджерами*/

-- создаем базу данных "курсовой проект"
CREATE DATABASE course_project;

-- переключаемся на базу данных "курсовой проект"
USE course_project;

-- создаем таблицу "отделы"
CREATE TABLE departments (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL, #имя отдела
superior_department_id BIGINT DEFAULT NULL
);

ALTER TABLE departments DROP COLUMN superior_department_id;
DROP TABLE departments; -- неправильно создал ранее таблицу, поэтому удалил

-- создаем типы медиа
CREATE TABLE media_types (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(45) NOT NULL
);

-- создаем таблицу "медиа"
CREATE TABLE media (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
media_types_id INT UNSIGNED NOT NULL,
file_name VARCHAR(245) DEFAULT NULL COMMENT '/files/folder/img.png',
file_size BIGINT UNSIGNED DEFAULT NULL,
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_media_media_types FOREIGN KEY (media_types_id) REFERENCES media_types (id)
);

-- создаем таблицу "сотрудники"
CREATE TABLE employees (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL, #имя
surname VARCHAR(30), #фамилия
media_id BIGINT UNSIGNED, #медиа
post VARCHAR(20), #должность
work_phone CHAR(11), #телефон рабочий
internal_phone CHAR(11), #телефон внутренний
email VARCHAR(30), #почта
department_id BIGINT UNSIGNED, #отдел id
skype VARCHAR(30), #skype логин
CONSTRAINT fk_department_id FOREIGN KEY (department_id) REFERENCES departments (id),
CONSTRAINT fk_media1_id FOREIGN KEY (media_id) REFERENCES media (id)
);

-- создаем таблицу "сообщения сотрудников"
CREATE TABLE staff_message (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
from_user_id BIGINT UNSIGNED NOT NULL,
to_user_id BIGINT UNSIGNED NOT NULL,
txt TEXT NOT NULL,
is_delivered TINYINT(1) DEFAULT '0',
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT fk_messages_employees_1 FOREIGN KEY (from_user_id) REFERENCES employees (id),
CONSTRAINT fk_messages_employees_2 FOREIGN KEY (to_user_id) REFERENCES employees (id)
);

-- создаем таблицу "компании"
CREATE TABLE company (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL, #имя
description VARCHAR(30), #описание
media_id BIGINT UNSIGNED, #медиа
type_company VARCHAR(20) DEFAULT 'Клиент', #тип компании
field_of_activity VARCHAR(50) DEFAULT 'Информационные технологии', #сфера деятельности
annual_turnover BIGINT DEFAULT 0, #годовой оборот 
currency VARCHAR(30) DEFAULT 'Российский рубль', #валюта
phone CHAR(11), #телефон
email VARCHAR(30), #почта
website VARCHAR(50), #сайт
messenger VARCHAR(30), #мессенджер
contact_id BIGINT UNSIGNED, #контакты id
address VARCHAR(30), #адрес
requisites VARCHAR(30), #реквизиты
number_of_employees VARCHAR(20), #количество сотрудников
responsible_id BIGINT UNSIGNED, #ответственный
CONSTRAINT fk_media3_id FOREIGN KEY (media_id) REFERENCES media (id),
CONSTRAINT fk_contact_id FOREIGN KEY (contact_id) REFERENCES contacts (id),
CONSTRAINT fk_responsible2_id FOREIGN KEY (responsible_id) REFERENCES employees (id)
);

-- создаем таблицу "контакты"
CREATE TABLE contacts (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL, #имя
surname VARCHAR(30), #фамилия
patronymic VARCHAR(30), #отчество
appeal VARCHAR(20) DEFAULT 'Не выбрано', #обращение
media_id BIGINT UNSIGNED, #медиа
birthday DATE, #день рождение
post VARCHAR(20), #должность
phone CHAR(11), #телефон
email VARCHAR(30), #почта
website VARCHAR(50), #сайт
messenger VARCHAR(30), #мессенджер
company_id BIGINT, #компании
address VARCHAR(30), #адрес
requisites VARCHAR(30), #реквизиты
type_contact VARCHAR(30) DEFAULT 'Клиенты', #тип контакта
source VARCHAR(30) DEFAULT 'Звонок', #источник
responsible_id BIGINT UNSIGNED, #ответственный
CONSTRAINT fk_media2_id FOREIGN KEY (media_id) REFERENCES media (id),
CONSTRAINT fk_responsible_id FOREIGN KEY (responsible_id) REFERENCES employees (id)
);

/*-- создаем таблицу "сообщения клиентов (сотрудников с клиентами)"
CREATE TABLE customer_message (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
from_user_id BIGINT UNSIGNED NOT NULL,
to_user_id BIGINT UNSIGNED NOT NULL,
txt TEXT NOT NULL,
is_delivered TINYINT(1) DEFAULT '0',
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT fk_messages_employees_1 FOREIGN KEY (from_user_id) REFERENCES
SELECT employees (id),
CONSTRAINT fk_messages_employees_2 FOREIGN KEY (to_user_id) REFERENCES employees (id)
); */

-- создаем таблицу "категории товаров"
CREATE TABLE product_category (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL #имя
);

-- создаем таблицу "товары"
CREATE TABLE product (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL, #имя
description VARCHAR(30), #описание
media_id BIGINT UNSIGNED, #медиа
quantity BIGINT DEFAULT 0, #количество
unit_of_measurement VARCHAR(20) DEFAULT 'Штука', #единица измерения
retail_price_rub BIGINT, #розничная цена в рублях
category_id BIGINT UNSIGNED, #категория id
CONSTRAINT fk_media4_id FOREIGN KEY (media_id) REFERENCES media (id),
CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES product_category (id)
);

-- создаем таблицу "воронка продаж"
CREATE TABLE sales_funnel (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL #имя воронки
);

-- создаем таблицу "этапы воронки продаж"
CREATE TABLE stages_of_the_sales_funnel (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL, #имя этапа воронки
sales_funnel_id BIGINT UNSIGNED NOT NULL, #id воронки продаж
CONSTRAINT fk_sales_funnel_id FOREIGN KEY (sales_funnel_id) REFERENCES sales_funnel (id)
);

-- создаем таблицу "сделки"
CREATE TABLE transactions (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL, #имя сделки
transaction_amount BIGINT DEFAULT 0, #сумма сделки
currency VARCHAR(30) DEFAULT 'Российские рубли', #валюта
stage_of_the_transaction_id BIGINT UNSIGNED DEFAULT 1, # стадия сдедки
start_date DATETIME DEFAULT CURRENT_TIMESTAMP, -- дата начала
date_of_completion DATETIME, #дата завершения
contacts_id BIGINT UNSIGNED, -- id контакта
company_id BIGINT UNSIGNED, -- id компании
type_transection VARCHAR(30) DEFAULT 'Продажа', -- тип сделки
source VARCHAR(30) DEFAULT 'Не выбран', -- источник сделки
additionally_about_source VARCHAR(30), -- дополнительно об источнике
responsible_id BIGINT UNSIGNED, #ответственный
comments VARCHAR(100), -- комментарии к сделке
CONSTRAINT fk_stage_of_the_transaction_id FOREIGN KEY (stage_of_the_transaction_id) REFERENCES stages_of_the_sales_funnel (id),
CONSTRAINT fk_contacts2_id FOREIGN KEY (contacts_id) REFERENCES contacts (id),
CONSTRAINT fk_company_id FOREIGN KEY (company_id) REFERENCES company (id),
CONSTRAINT fk_responsible4_id FOREIGN KEY (responsible_id) REFERENCES employees (id)
);

SELECT * FROM transactions;
SELECT * FROM stages_of_the_sales_funnel;
SELECT * FROM sales_funnel;
SELECT * FROM product;
SELECT * FROM product_category;
SELECT * FROM contacts;
SELECT * FROM company;
SELECT * FROM staff_message;
SELECT * FROM employees;
SELECT * FROM media;
SELECT * FROM media_types;
SELECT * FROM departments;

INSERT INTO `departments` (`id`, `name`, `superior_department_id`) VALUES ('1', 'minima', '2');
INSERT INTO `departments` (`id`, `name`, `superior_department_id`) VALUES ('2', 'id', '5');
INSERT INTO `departments` (`id`, `name`, `superior_department_id`) VALUES ('3', 'enim', '8');
INSERT INTO `departments` (`id`, `name`, `superior_department_id`) VALUES ('4', 'quaerat', '1');
INSERT INTO `departments` (`id`, `name`, `superior_department_id`) VALUES ('5', 'magni', '1');
INSERT INTO `departments` (`id`, `name`, `superior_department_id`) VALUES ('6', 'porro', '7');
INSERT INTO `departments` (`id`, `name`, `superior_department_id`) VALUES ('7', 'commodi', '8');
INSERT INTO `departments` (`id`, `name`, `superior_department_id`) VALUES ('8', 'dolores', '8');
INSERT INTO `departments` (`id`, `name`, `superior_department_id`) VALUES ('9', 'optio', '4');
INSERT INTO `departments` (`id`, `name`, `superior_department_id`) VALUES ('10', 'eligendi', '9');
