create database tweeter_elton_jonh;
use tweeter_elton_jonh;

CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `refreshToken` varchar(255) DEFAULT NULL,
  `biography` text,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
);

CREATE TABLE `tweets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(280) NOT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `tweets_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE `admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_level` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`admin_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `tweetId` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `tweetId` (`tweetId`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`tweetId`) REFERENCES `tweets` (`id`) ON UPDATE CASCADE
);

CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `tweetId` int NOT NULL,
  `content` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `tweetId` (`tweetId`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`tweetId`) REFERENCES `tweets` (`id`)
);

ALTER TABLE `users` 
ADD COLUMN `updatedAt` varchar(255) DEFAULT NULL;

INSERT INTO `users` (username, email, password, refreshToken, biography, createdAt, updatedAt)
VALUES ('Elton', 'elsantos@gmail.com', 'teamo19C', 'jcgiyvxiakshXJBjsxSXsxtiYSXUBlaxbVSUTYCF', 'Olhando pra sima', NOW(), NOW());
INSERT INTO `users` (username, email, password, refreshToken, biography, createdAt, updatedAt) VALUES
('JohnDoe1', 'john.doe1@gmail.com', '32a123', 'kwcavWKECUNHYDWIEOWEFRGEGTfdfdfsdgfgdf', 'Just a regular guy.', NOW(), NOW()),
('JaneSmith1', 'jane.smith1@yahoo.com', '432456', 'dfbfbgbfgndhnszgbsgnfdgbsfbsbdfg', 'Love to travel.', NOW(), NOW()),
('AliceJohnson1', 'alice.johnson1@hotmail.com', '123789', 'rfafvafvsgdbafvbsbtgnzdfbgb', 'Coffee enthusiast.', NOW(), NOW()),
('BobBrown1', 'bob.brown1@outlook.com', '222321', 'dsdfvsagdbafdvsrthbfdb', 'Avid reader and writer.', NOW(), NOW()),
('CharlieDavis1', 'charlie.davis1@icloud.com', '12d654','sdvsdsagzssvdfdfsghdfghdsgv<dsv', 'Tech geek.', NOW(), NOW());

SELECT id, username FROM `users`;

INSERT INTO `tweets` (content, imageUrl, createdAt, updatedAt, userId) VALUES
('Hello world!', '/upload/image5.jpg', NOW(), NOW(), 17),  
('Excited to join Twitter!', '/upload/imagey.jpg', NOW(), NOW(), 8),  
('Just had the best coffee ever!', '/upload/imagef.jpg', NOW(), NOW(), 5),  
('Reading a fantastic book.', '/upload/image3.jpg', NOW(), NOW(), 7),  
('Tech conference was amazing.', '/upload/image2.jpg', NOW(), NOW(), 4);  

INSERT INTO `admin` (user_id, permission_level) VALUES
(4, 1);
INSERT INTO `comments` (userId, tweetId, content, createdAt, updatedAt) VALUES
(4, 40, 'Great tweet!', NOW(), NOW()),  
(5, 36, 'I agree!', NOW(), NOW()),   
(19, 37, 'Nice post!', NOW(), NOW()),   
(4, 40, 'Interesting view!', NOW(), NOW()), 
(5, 40, 'Thanks for sharing!', NOW(), NOW()); 

INSERT INTO `likes` (userId, tweetId, createdAt, updatedAt) VALUES
(4, 36, NOW(), NOW()),  
(5, 36, NOW(), NOW()),  
(15, 40, NOW(), NOW()), 
(8, 37, NOW(), NOW()),  
(5, 40, NOW(), NOW());  


SELECT * FROM `users`;

-- Update a user
UPDATE `users` SET 
  username = 'Barroza', 
  email = 'barroza@gmail.com', 
  password = '123123', 
  refreshToken = 'newRefreshToken', 
  biography = 'Estou no comando.', 
  createdAt = '2024-01-01 00:00:00', 
  updatedAt = NOW()
WHERE id = 7;

-- Update a tweet
UPDATE `tweets` SET 
  content = 'A forca do povo que move as montanhas.', 
  imageUrl = '/upload/povo_image.jpg', 
  createdAt = '2024-01-01 00:00:00', 
  updatedAt = NOW(), 
  userId = 7
WHERE id = 36;

-- Update an admin
UPDATE `admin` 
SET 
  user_id = 9, 
  permission_level = 2
WHERE admin_id = 1;

-- Update a like
UPDATE `likes` 
SET 
  userId = 2, 
  tweetId = 2, 
  createdAt = '2024-01-01 00:00:00', 
  updatedAt = NOW()
WHERE id = 8;

-- Update a comment
UPDATE `comments` 
SET 
  userId = 10, 
  tweetId = 40, 
  content = 'Isso é verdade.', 
  createdAt = '2024-01-01 00:00:00', 
  updatedAt = NOW()
WHERE id = 40;

DELETE FROM `comments` WHERE id = 1;


 -- INNER JOIN
SELECT users.id AS user_id, users.username, tweets.id AS tweet_id, tweets.content
FROM users
INNER JOIN tweets ON users.id = tweets.userId;

-- LEFT JOIN
SELECT users.id AS user_id, users.username, tweets.id AS tweet_id, tweets.content
FROM users
LEFT JOIN tweets ON users.id = tweets.userId;

SELECT users.id AS user_id, users.username, tweets.id AS tweet_id, tweets.content AS tweet_content, comments.content AS comment_content
FROM users
INNER JOIN tweets ON users.id = tweets.userId
INNER JOIN comments ON tweets.id = comments.tweetId;



-- Users and their tweets (including users without tweets)
SELECT u.id AS user_id, u.username, t.id AS tweet_id, t.content
FROM users u
LEFT JOIN tweets t ON u.id = t.userId;

-- Users, their tweets, and comments on those tweets
SELECT u.id AS user_id, u.username, t.id AS tweet_id, t.content AS tweet_content, c.content AS comment_content
FROM users u
INNER JOIN tweets t ON u.id = t.userId
INNER JOIN comments c ON t.id = c.tweetId;

-- Users(including users without tweets)
SELECT u.id AS user_id, u.username, t.id AS tweet_id, t.content AS tweet_content, l.id AS like_id, l.userId AS liked_by_user_id
FROM users u
LEFT JOIN tweets t ON u.id = t.userId
LEFT JOIN likes l ON t.id = l.tweetId;
