CREATE DATABASE vkcom;

USE vkcom;

CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL COMMENT 'ФАМИЛИЯ',
  `email` varchar(120) NOT NULL,
  `phone` char(11) NOT NULL,
  `password_hash` char(65) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `users_email_idx` (`email`),
  KEY `users_phone_idx` (`phone`)
) ENGINE=InnoDB;

INSERT INTO users (id, firstname, lastname, email, phone, password_hash, created_at) 
VALUES (DEFAULT, 'Petya', 'Petukhov', 'petya@mail.com', '89212223334', DEFAULT, DEFAULT),
(DEFAULT, 'Vasya', 'Petukhovd', 'petaaaqya@mail.com', '89222223334', DEFAULT, DEFAULT),
(DEFAULT, 'liza', 'Petukhovaa', 'petdvya@mail.com', '89232223334', DEFAULT, DEFAULT),
(DEFAULT, 'Gena', 'Petukhobv', 'petqya@mail.com', '89242222334', DEFAULT, DEFAULT),
(DEFAULT, 'Masha', 'Pevbtukhov', 'pethhhhywa@mail.com', '89252223334', DEFAULT, DEFAULT),
(DEFAULT, 'Misha', 'Petukchov', 'petyffffra@mail.com', '89262223334', DEFAULT, DEFAULT),
(DEFAULT, 'Vlada', 'Petukcchov', 'petydddda@mail.com', '89272223334', DEFAULT, DEFAULT),
(DEFAULT, 'Pasha', 'Petuzzkhov', 'petaaaya@mail.com', '89282223334', DEFAULT, DEFAULT),
(DEFAULT, 'Anya', 'Petukhobbv', 'petbya@mail.com', '89292223334', DEFAULT, DEFAULT),
(DEFAULT, 'Sveta', 'Petukhxtov', 'peftya@mail.com', '89211223334', DEFAULT, DEFAULT),
(DEFAULT, 'Roma', 'Petuwwkhov', 'pentya@mail.com', '89213223334', DEFAULT, DEFAULT),
(DEFAULT, 'Alex', 'Petukhqqov', 'petmya@mail.com', '89216223334', DEFAULT, DEFAULT);

SELECT * FROM users;

CREATE TABLE `profiles` (
  `user_id` bigint unsigned NOT NULL,
  `gender` enum('f','m','x') DEFAULT NULL,
  `birthday` date NOT NULL,
  `photo_id` int unsigned DEFAULT NULL,
  `city` varchar(130) DEFAULT NULL,
  `country` varchar(130) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB;

INSERT INTO profiles
VALUES (13, 'f', "2008-10-23", 5, 'Санкт-Петербург', 'sdfsf'),
(14, 'f', "2008-10-23", 5, 'Санкт-Петербург', 'sdfsf'),
(15, 'f', "2008-10-23", 5, 'Санкт-Петербург', 'sdfsf'),
(16, 'f', "2008-10-23", 5, 'Санкт-Петербург', 'sdfsf'),
(17, 'f', "2008-10-23", 5, 'Санкт-Петербург', 'sdfsf'),
(18, 'f', "2008-10-23", 5, 'Санкт-Петербург', 'sdfsf'),
(19, 'f', "2008-10-23", 5, 'Санкт-Петербург', 'sdfsf'),
(20, 'f', "2008-10-23", 5, 'Санкт-Петербург', 'sdfsf'),
(21, 'f', "2008-10-23", 5, 'Санкт-Петербург', 'sdfsf'),
(22, 'f', "2008-10-23", 5, 'Санкт-Петербург', 'sdfsf'),
(23, 'f', "2008-10-23", 5, 'Санкт-Петербург', 'sdfsf');

SELECT * FROM profiles;

CREATE TABLE `messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint unsigned NOT NULL,
  `to_user_id` bigint unsigned NOT NULL,
  `txt` text NOT NULL,
  `is_delivered` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_messages_from_user_idx` (`from_user_id`),
  KEY `fk_messages_to_user_idx` (`to_user_id`),
  CONSTRAINT `fk_messages_users_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_messages_users_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB;

INSERT INTO messages
VALUES (DEFAULT, 13, 14, 'Санкт-Петербург', DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 13, 14, 'Санкт-Петербург', DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 13, 14, 'Санкт-Петербург', DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 13, 14, 'Санкт-Петербург', DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 13, 14, 'Санкт-Петербург', DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 13, 14, 'Санкт-Петербург', DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 13, 14, 'Санкт-Петербург', DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 13, 14, 'Санкт-Петербург', DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 13, 14, 'Санкт-Петербург', DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 13, 14, 'Санкт-Петербург', DEFAULT, DEFAULT, DEFAULT),
(DEFAULT, 13, 14, 'Санкт-Петербург', DEFAULT, DEFAULT, DEFAULT);

SELECT * FROM messages;

CREATE TABLE `media_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB;

INSERT INTO media_types 
VALUES (DEFAULT, 'Картинка'),
(DEFAULT, 'Музssыка'),
(DEFAULT, 'Музssdыка'),
(DEFAULT, 'Музыffка'),
(DEFAULT, 'Музsfsdfsfыка'),
(DEFAULT, 'Музыsasasaка'),
(DEFAULT, 'Музыvcxvxка'),
(DEFAULT, 'Музы xzvxzка'),
(DEFAULT, 'Музыhgfhка'),
(DEFAULT, 'Музsretreыка'),
(DEFAULT, 'Музыкwhdbvа');

SELECT * FROM media_types;

CREATE TABLE `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `media_types_id` int unsigned NOT NULL,
  `file_name` varchar(245) DEFAULT NULL COMMENT '/files/folder/img.png',
  `file_size` bigint unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `media_users_idx` (`user_id`),
  KEY `media_media_types_idx` (`media_types_id`),
  CONSTRAINT `fk_media_media_types` FOREIGN KEY (`media_types_id`) REFERENCES `media_types` (`id`),
  CONSTRAINT `fk_media_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB;

INSERT INTO media
VALUES (DEFAULT, 13, 1, 'Санкт-Петербург', 5, DEFAULT),
(DEFAULT, 13, 1, 'Санкт-Петербург', 5, DEFAULT),
(DEFAULT, 13, 1, 'Санкт-Петербург', 5, DEFAULT),
(DEFAULT, 13, 1, 'Санкт-Петербург', 5, DEFAULT),
(DEFAULT, 13, 1, 'Санкт-Петербург', 5, DEFAULT),
(DEFAULT, 13, 1, 'Санкт-Петербург', 5, DEFAULT),
(DEFAULT, 13, 1, 'Санкт-Петербург', 5, DEFAULT),
(DEFAULT, 13, 1, 'Санкт-Петербург', 5, DEFAULT),
(DEFAULT, 13, 1, 'Санкт-Петербург', 5, DEFAULT),
(DEFAULT, 13, 1, 'Санкт-Петербург', 5, DEFAULT),
(DEFAULT, 13, 1, 'Санкт-Петербург', 5, DEFAULT);

SELECT * FROM media;

CREATE TABLE `friend_requests` (
  `from_user_id` bigint unsigned NOT NULL,
  `to_user_id` bigint unsigned NOT NULL,
  `accepted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`from_user_id`,`to_user_id`),
  KEY `fk_friend_requests_from_user_idx` (`from_user_id`),
  KEY `fk_friend_requests_to_user_idx` (`to_user_id`),
  CONSTRAINT `fk_friend_requests_users_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_friend_requests_users_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB;

INSERT INTO friend_requests
VALUES (13, 14, DEFAULT),
(15, 16, DEFAULT),
(17, 18, DEFAULT),
(19, 20, DEFAULT),
(21, 22, DEFAULT),
(23, 24, DEFAULT);

SELECT * FROM friend_requests;

CREATE TABLE `communities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(145) NOT NULL,
  `description` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `communities_name_idx` (`name`)
) ENGINE=InnoDB;

INSERT INTO communities
VALUES (DEFAULT, '14', 'sdfdsf'),
(DEFAULT, '14', 'sdfdsf'),
(DEFAULT, '14', 'sdfdsf'),
(DEFAULT, '14', 'sdfdsf'),
(DEFAULT, '14', 'sdfdsf'),
(DEFAULT, '14', 'sdfdsf'),
(DEFAULT, '14', 'sdfdsf'),
(DEFAULT, '14', 'sdfdsf'),
(DEFAULT, '14', 'sdfdsf'),
(DEFAULT, '14', 'sdfdsf'),
(DEFAULT, '14', 'sdfdsf'),
(DEFAULT, '14', 'sdfdsf');

SELECT * FROM communities;

CREATE TABLE `communities_users` (
  `community_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`community_id`,`user_id`),
  KEY `communities_users_comm_idx` (`community_id`),
  KEY `communities_users_users_idx` (`user_id`),
  CONSTRAINT `communities_users_ibfk_1` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`),
  CONSTRAINT `communities_users_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB;

INSERT INTO communities_users
VALUES (12, 13, DEFAULT),
(1, 13, DEFAULT),
(2, 14, DEFAULT),
(3, 15, DEFAULT),
(4, 16, DEFAULT),
(5, 17, DEFAULT),
(6, 18, DEFAULT),
(7, 19, DEFAULT),
(8, 20, DEFAULT),
(9, 21, DEFAULT),
(10, 22, DEFAULT),
(11, 23, DEFAULT);

SELECT * FROM communities_users;


SELECT DISTINCT * FROM users ORDER BY firstname ASC;

ALTER TABLE profiles ADD COLUMN is_active BOOLEAN DEFAULT TRUE;

ALTER TABLE profiles
ADD CONSTRAINT sss
CHECK (REGEXP_LIKE(is_active, '^1'));

DELETE FROM messages WHERE created_at > CURRENT_TIMESTAMP;

