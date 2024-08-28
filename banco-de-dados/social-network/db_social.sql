DROP DATABASE IF EXISTS db_social;
CREATE DATABASE IF NOT EXISTS db_social;
USE db_social;

/*
Imagine que você está desenvolvendo um aplicatico de rede social onde os usuários podem postar atualizações e comnetários que podem incluir emojis

 nestes casos, você precisará de suporte parra o conjunto comple de caracteres unicode,
 incluindo emojis, o que requer o uso de UTF8MB4

 crie as tabelas e o relacionamento enetre elas
 */

CREATE TABLE users
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    username   VARCHAR(255) NOT NULL,
    email      VARCHAR(255) NOT NULL,
    password   VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (username),
    UNIQUE (email),

    PRIMARY KEY (id)
) CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE TABLE posts
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    user_id    BIGINT UNSIGNED NOT NULL,
    content    TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (user_id) REFERENCES users (id)
) CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE TABLE comments
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    post_id    BIGINT UNSIGNED NOT NULL,
    user_id    BIGINT UNSIGNED NOT NULL,
    content    TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (post_id) REFERENCES posts (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
) CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE TABLE likes
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    user_id    BIGINT UNSIGNED NOT NULL,
    post_id    BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (post_id) REFERENCES posts (id)
);


-- Inserir usuários
INSERT INTO users (username, email, password)
VALUES ('joao_silva', 'joao@example.com', 'senha123'),
       ('maria_costa', 'maria@example.com', 'segredo456'),
       ('pedro_henrique', 'pedro@example.com', 'p@$$wOrd');

-- Inserir posts
INSERT INTO posts (user_id, content)
VALUES (1, 'Olá, este é meu primeiro post! 😁'),
       (2, 'Adorei essa nova rede social! 😊'),
       (1, 'Alguém aí gosta de programar? 🤔');

-- Inserir comentários
INSERT INTO comments (post_id, user_id, content)
VALUES (1, 2, 'Que legal, João! 👏'),
       (2, 3, 'Eu também! 🤩'),
       (3, 1, 'Sim, eu adoro! 😄');

-- Inserir likes
INSERT INTO likes (user_id, post_id)
VALUES (1, 2),
       (2, 1),
       (3, 3),
       (2, 3);


SELECT * FROM users;
SELECT * FROM posts;
SELECT * FROM comments;
SELECT * FROM likes;