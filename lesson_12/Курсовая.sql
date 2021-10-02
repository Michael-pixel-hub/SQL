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
);

-- вставляем значения в таблицу "отделы"
INSERT INTO departments VALUES 
(DEFAULT, 'Отдел маркетинга'),
(DEFAULT, 'Отдел продаж'),
(DEFAULT, 'Отдел финансов'),
(DEFAULT, 'Отдел логистики'),
(DEFAULT, 'Отдел ИТ'),
(DEFAULT, 'Отдел закупок'),
(DEFAULT, 'Отдел исследования и развидия');

-- создаем таблицу "типы медиа"
CREATE TABLE media_types (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(45) NOT NULL
);

-- вставляем данные в таблицу "типы медиа"
INSERT INTO media_types VALUES
(DEFAULT, 'Картинка'),
(DEFAULT, 'Музыка'),
(DEFAULT, 'Видео');

-- создаем таблицу "медиа"
CREATE TABLE media (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
media_types_id INT UNSIGNED NOT NULL,
file_name VARCHAR(245) DEFAULT NULL COMMENT '/files/folder/img.png',
file_size_mb BIGINT UNSIGNED DEFAULT NULL,
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_media_media_types FOREIGN KEY (media_types_id) REFERENCES media_types (id)
);

-- вставляем данные в таблицу "медиа"
INSERT INTO media VALUES 
(DEFAULT, 1, '/files/folder/name1.png', 5, DEFAULT),
(DEFAULT, 1, '/files/folder/name2.png', 1, DEFAULT),
(DEFAULT, 1, '/files/folder/name3.png', 2, DEFAULT),
(DEFAULT, 1, '/files/folder/name4.pmg', 3, DEFAULT),
(DEFAULT, 1, '/files/folder/name5.png', 1, DEFAULT),
(DEFAULT, 1, '/files/folder/name6.png', 1, DEFAULT),
(DEFAULT, 1, '/files/folder/name7.png', 1, DEFAULT),
(DEFAULT, 1, '/files/folder/name8.pmg', 2, DEFAULT),
(DEFAULT, 1, '/files/folder/name9.png', 3, DEFAULT),
(DEFAULT, 1, '/files/folder/name10.png', 1, DEFAULT);

-- создаем таблицу "сотрудники"
CREATE TABLE employees (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL, #имя
surname VARCHAR(30), #фамилия
media_id BIGINT UNSIGNED, #медиа
post VARCHAR(20), #должность
work_phone CHAR(11), #телефон рабочий
internal_phone CHAR(11) UNIQUE, #телефон внутренний
email VARCHAR(30) UNIQUE, #почта
department_id BIGINT UNSIGNED, #отдел id
skype VARCHAR(30), #skype логин
CONSTRAINT fk_department_id FOREIGN KEY (department_id) REFERENCES departments (id),
CONSTRAINT fk_media1_id FOREIGN KEY (media_id) REFERENCES media (id)
);

-- вставляем данные в таблицу "сотрудники"
INSERT INTO employees VALUES 
(DEFAULT, 'Вася', 'Пупкин', 1, 'Маркетолог', '89112145679', '89117453947', 'mixer@gmail.com', 1, 'mixer'),
(DEFAULT, 'Петя', 'Карпов', 1, 'Программист', '89112445279', '89216512253', 'bab@gmail.com', 5, 'bab'),
(DEFAULT, 'Рудольф', 'Дроздов', 1, 'Менеджер', '89212345679', '89112453311', 'nasha@gmail.com', 2, 'nasha'),
(DEFAULT, 'Гена', 'Синицин', 1, 'Старший менеджер', '89032145679', '89214456623', 'hasd@gmail.com', 2, 'hasd'),
(DEFAULT, 'Петя', 'Березов', 1, 'Менеджер', '89112423422', '89112234566', 'big@gmail.com', 2, 'big'),
(DEFAULT, 'Руся', 'Туркин', 1, 'Менеджер', '89212223344', '89219123451', 'red@gmail.com', 2, 'red'),
(DEFAULT, 'Маша', 'Дурова', 1, 'Бухгалтер', '89112445679', '89219153854', 'green@gmail.com', 3, 'green'),
(DEFAULT, 'Даша', 'Зорина', 1, 'Бухгалтер', '89113445679', '89219529533', 'yellow@gmail.com', 3, 'yellow'),
(DEFAULT, 'Настя', 'Евлеева', 1, 'Маркетолог', '89115545679', '89112763264', 'blue@gmail.com', 1, 'blue'),
(DEFAULT, 'Кристина', 'Вишнева', 1, 'Аналитик', '89212445689', '89214467524', 'girl@gmail.com', 5, 'girl')

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

-- вставляем данные в таблицу "сообщения сотрудников"
INSERT INTO staff_message VALUES 
(DEFAULT, 1, 2, 'Привет', 1, DEFAULT, DEFAULT),
(DEFAULT, 2, 1, 'Привет', 1, DEFAULT, DEFAULT),
(DEFAULT, 1, 2, 'Как дела?', 1, DEFAULT, DEFAULT),
(DEFAULT, 2, 1, 'Нормально, а у тебя?', 1, DEFAULT, DEFAULT),
(DEFAULT, 1, 2, 'Тоже хорошо, ты проект сделал?', 1, DEFAULT, DEFAULT),
(DEFAULT, 2, 1, 'Нет, а ты?', 1, DEFAULT, DEFAULT),
(DEFAULT, 1, 2, 'Только начал)', 1, DEFAULT, DEFAULT),
(DEFAULT, 2, 1, 'Прорвемся)', 1, DEFAULT, DEFAULT),
(DEFAULT, 1, 2, 'Только не ты', 1, DEFAULT, DEFAULT),
(DEFAULT, 2, 1, 'Ты меня плохо знаешь)', 1, DEFAULT, DEFAULT);

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
phone CHAR(11) UNIQUE DEFAULT NULL, #телефон
email VARCHAR(30) UNIQUE DEFAULT NULL, #почта
website VARCHAR(50) DEFAULT NULL, #сайт
messenger VARCHAR(30) DEFAULT NULL, #мессенджер
contact_id BIGINT UNSIGNED DEFAULT NULL, #контакты id
address VARCHAR(30) DEFAULT NULL, #адрес
requisites VARCHAR(30) DEFAULT NULL, #реквизиты
number_of_employees VARCHAR(20) DEFAULT '0', #количество сотрудников
responsible_id BIGINT UNSIGNED DEFAULT NULL, #ответственный
CONSTRAINT fk_media3_id FOREIGN KEY (media_id) REFERENCES media (id),
CONSTRAINT fk_contact_id FOREIGN KEY (contact_id) REFERENCES contacts (id),
CONSTRAINT fk_responsible2_id FOREIGN KEY (responsible_id) REFERENCES employees (id)
);

-- вставляем данные в таблицу "компании"
INSERT INTO employees VALUES 
(DEFAULT, 'ООО "Папироска"', 'джфыоавофлва', 1, 'Клиент', DEFAULT, 231231, DEFAULT, '89112145679', 'mixer@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 1),
(DEFAULT, 'ООО "Генерал"', 'фыавыфавфыаф', 1, 'Клиент', DEFAULT, 1231231, DEFAULT, '89112445279', 'bab@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 5),
(DEFAULT, 'ООО "Сентар"', 'фываыфаыфваыфва', 1, 'Клиент', DEFAULT, 111, DEFAULT, '89212345679', 'nasha@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 2),
(DEFAULT, 'ООО "Банана"', 'фыаыфавыфафыа', 1, 'Клиент', DEFAULT, 123123123, DEFAULT, '89032145679', 'hasd@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 2),
(DEFAULT, 'ООО "Кент"', 'фавфыавыфа', 1, 'Клиент', DEFAULT, 111111, DEFAULT, '89112423422', 'big@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 2),
(DEFAULT, 'ООО "Мега"', 'фывафвафыва', 1, 'Клиент', DEFAULT, 13154132424, DEFAULT, '89212223344', 'red@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 2),
(DEFAULT, 'ООО "Вашинг"', 'фывафываыфаыв', 1, 'Клиент', DEFAULT, 123213132123, DEFAULT, '89112445679', 'green@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 3),
(DEFAULT, 'ООО "Бендар"', 'Зфыыфавыфафыв', 1, 'Клиент', DEFAULT, 111111, DEFAULT, '89113445679', 'yellow@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 3),
(DEFAULT, 'ООО "Сертар"', 'Ефыаывфавыфавыф', 1, 'Клиент', DEFAULT, 645365463, DEFAULT, '89115545679', 'blue@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 1),
(DEFAULT, 'ООО "Майкл"', 'Вифывафыафываа', 1, 'Клиент', DEFAULT, 456344526, DEFAULT, '89212445689', 'girl@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 5);

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
company_id BIGINT UNSIGNED DEFAULT NULL, #компании
address VARCHAR(30), #адрес
requisites VARCHAR(30), #реквизиты
type_contact VARCHAR(30) DEFAULT 'Клиенты', #тип контакта
source VARCHAR(30) DEFAULT 'Звонок', #источник
responsible_id BIGINT UNSIGNED, #ответственный
CONSTRAINT fk_media2_id FOREIGN KEY (media_id) REFERENCES media (id),
CONSTRAINT fk_responsible_id FOREIGN KEY (responsible_id) REFERENCES employees (id)
);

-- вставляем данные в таблицу "контакты" !!!
INSERT INTO employees VALUES 
(DEFAULT, 'Филипп', 'джфыоавофлва', 1, 'Клиент', DEFAULT, 231231, DEFAULT, '89112145679', 'mixer@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 1),
(DEFAULT, 'Амир', 'фыавыфавфыаф', 1, 'Клиент', DEFAULT, 1231231, DEFAULT, '89112445279', 'bab@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 5),
(DEFAULT, 'Серафим', 'фываыфаыфваыфва', 1, 'Клиент', DEFAULT, 111, DEFAULT, '89212345679', 'nasha@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 2),
(DEFAULT, 'Александр', 'фыаыфавыфафыа', 1, 'Клиент', DEFAULT, 123123123, DEFAULT, '89032145679', 'hasd@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 2),
(DEFAULT, 'Алексей'!!!, 'фавфыавыфа', 1, 'Клиент', DEFAULT, 111111, DEFAULT, '89112423422', 'big@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 2),
(DEFAULT, 'ООО "Мега"', 'фывафвафыва', 1, 'Клиент', DEFAULT, 13154132424, DEFAULT, '89212223344', 'red@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 2),
(DEFAULT, 'ООО "Вашинг"', 'фывафываыфаыв', 1, 'Клиент', DEFAULT, 123213132123, DEFAULT, '89112445679', 'green@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 3),
(DEFAULT, 'ООО "Бендар"', 'Зфыыфавыфафыв', 1, 'Клиент', DEFAULT, 111111, DEFAULT, '89113445679', 'yellow@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 3),
(DEFAULT, 'ООО "Сертар"', 'Ефыаывфавыфавыф', 1, 'Клиент', DEFAULT, 645365463, DEFAULT, '89115545679', 'blue@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 1),
(DEFAULT, 'ООО "Майкл"', 'Вифывафыафываа', 1, 'Клиент', DEFAULT, 456344526, DEFAULT, '89212445689', 'girl@gmail.com', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 5);

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

DROP TABLE departments;
DROP TABLE media_types;
DROP TABLE media;
DROP TABLE employees;
DROP TABLE staff_message;
DROP TABLE company;
DROP TABLE contacts;
DROP TABLE product_category;
DROP TABLE product;
DROP TABLE sales_funnel;
DROP TABLE stages_of_the_sales_funnel;
DROP TABLE transactions;