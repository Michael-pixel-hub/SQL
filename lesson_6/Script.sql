CREATE DATABASE vk;

USE vk;

CREATE TABLE `communities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(145) NOT NULL,
  `description` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `communities_name_idx` (`name`)
) ENGINE=InnoDB;


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

CREATE TABLE `media_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB;

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

CREATE TABLE friend_requests_types
(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(128) UNIQUE NOT NULL
);

SELECT * FROM users;
SELECT * FROM profiles;
SELECT * FROM communities;
SELECT * FROM communities_users;
SELECT * FROM messages;
SELECT * FROM media;
SELECT * FROM media_types;
SELECT * FROM friend_requests;
SELECT * FROM friend_requests_types;
SELECT * FROM likes;

-- Задание 1. Задан Reuben Nienow. Найти кто из пользователей больше всего ему писал

SELECT 
(SELECT CONCAT(lastname, ' ', firstname) FROM users WHERE id = MAX(from_user_id)) AS name,
COUNT(*) AS quantity,
from_user_id,
to_user_id 
FROM messages 
WHERE to_user_id = (SELECT id FROM users WHERE firstname = 'Reuben' AND lastname = 'Nienow')
GROUP BY from_user_id ORDER BY quantity DESC LIMIT 1;

-- Задание 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

SELECT SUM(like_photo) AS likes FROM profiles WHERE DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birthday, '%Y') < 10;

-- Задание 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT COUNT(*) AS quantity, gender FROM profiles GROUP BY gender ORDER BY quantity DESC LIMIT 1;