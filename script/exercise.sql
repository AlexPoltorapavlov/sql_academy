-- Удаление старой базы данных, если она есть
DROP DATABASE IF EXISTS exercise_db;

-- Создание новой базы данных
CREATE DATABASE exercise_db;

\c exercise_db;

-- Создание таблицы пользователей
CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL
);

-- Создание таблицы сообщений
CREATE TABLE Messages (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(id) ON DELETE CASCADE,
    msg VARCHAR(1000) NOT NULL
);

-- Заполнение таблиц данными
INSERT INTO Users (email, password) VALUES ('example1@domen.name', 'password1'), ('example2@domen.name', 'password2');

INSERT INTO Messages (user_id, msg) VALUES (1, 'Hello from user1'), (2, 'Hello from user2'), (1, 'Another message from user1');

-- Обновление данных пользователя
UPDATE Users SET email = 'example3@domen.name' WHERE email = 'example1@domen.name';

-- Удаление одного сообщения
DELETE FROM messages WHERE id= 1;

-- Выборка сообщений, которые есть только у одного пользователя
SELECT email, msg FROM Users 
    JOIN Messages ON Messages.user_id = Users.id
    WHERE email = 'example3@domen.name';

-- Удаление одного пользователя
DELETE FROM Users WHERE id = 2;

EXPLAIN SELECT email, msg FROM Users 
    JOIN Messages ON Messages.user_id = Users.id
    WHERE email = 'example3@domen.name';

CREATE INDEX msg_user_idx ON Messages (user_id);

EXPLAIN ANALYZE SELECT email, msg FROM Users 
    JOIN Messages ON Messages.user_id = Users.id
    WHERE email = 'example3@domen.name';
