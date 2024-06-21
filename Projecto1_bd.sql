CREATE DATABASE Projeto1_bd;
USE Projeto1_bd;
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
   data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
CREATE TABLE Tweets (
    tweet_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    conteudo VARCHAR(280),
    imagem_url VARCHAR(255),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


CREATE TABLE Seguidores (
    _id INT AUTO_INCREMENT PRIMARY KEY,
    seguidor_id INT NOT NULL,
    seguido_id INT NOT NULL,
    FOREIGN KEY (seguidor_id) REFERENCES Users(user_id),
    FOREIGN KEY (seguido_id) REFERENCES Users(user_id),
    UNIQUE (seguidor_id, seguido_id)
);


CREATE TABLE Likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    tweet_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (tweet_id) REFERENCES Tweets(tweet_id),
    UNIQUE (user_id, tweet_id)
);

CREATE TABLE Admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    permission_level INT NOT NULL DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


INSERT INTO Users (username, email, password) VALUES ('Mari', 'mari2@gamil.com', 'password2'),
('Carlos', 'carlos1@gmail.com', 'password1');
INSERT INTO Tweets (user_id, conteudo, imagem_url) VALUES (1, 'Hello, this is my first tweet!', NULL);
INSERT INTO Tweets (user_id, conteudo, imagem_url) VALUES (2, 'Carro dos sonhos.', '54c02cd28bba57f81d73d11b4fd8af20.jpg'),
 (3, 'hora de fazer acontecer.', NULL);
INSERT INTO Seguidores (seguidor_id, seguido_id) VALUES (1, 2), (2, 3),
(3, 1), (2, 1), (3,2);
INSERT INTO Likes (user_id, tweet_id) VALUES (1, 1),(2, 2),
 (3, 3);
 INSERT INTO Admin (user_id, permission_level) VALUES (1, 1);
 
 SELECT * FROM users;
 SELECT * FROM Tweets;
 SELECT * FROM Seguidores;
 SELECT * FROM Likes;
 SELECT * FROM Adminn;
 SELECT seguido_id, COUNT(seguidor_id) AS num_followers
FROM Seguidores
GROUP BY seguido_id;

SELECT seguidor_id, COUNT(seguido_id) AS num_following
FROM Seguidores
GROUP BY seguidor_id;

UPDATE Users SET username = 'João Paulo' WHERE user_id = 1;

UPDATE Tweets SET conteudo = 'Vamos  atualizar com o tweet' WHERE tweet_id = 1;
UPDATE Seguidores SET seguido_id = 2 WHERE _id = 1;
UPDATE Likes SET tweet_id = 2 WHERE id = 1;
UPDATE Admin SET permission_level = 5 WHERE admin_id = 2;
DELETE FROM Admin WHERE user_id = 3;
DELETE FROM Likes WHERE user_id = 1;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Likes WHERE tweet_id IN (SELECT tweet_id FROM Tweets WHERE user_id = 1);
SET SQL_SAFE_UPDATES = 1;
DELETE FROM Seguidores WHERE seguidor_id = 1;
DELETE FROM Seguidores WHERE seguido_id = 1;
DELETE FROM Tweets WHERE user_id = 1;
DELETE FROM Users WHERE user_id = 1;

INSERT INTO Users (user_id, username, email, password) VALUES 
(1, 'admin_user', 'admin@gmail.com', 'password');


DROP TABLE Admin;
CREATE TABLE Adminn (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    permission_level INT NOT NULL DEFAULT 1
);




