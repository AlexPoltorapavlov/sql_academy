-- Удаление старой базы данных, если она есть
DROP DATABASE IF EXISTS exercise_db;

-- Создание новой базы данных
CREATE DATABASE exercise_db;

\c exercise_db;

-- Создание таблицы пользователей
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL
);

-- Создание таблицы сообщений
CREATE TABLE messages (
    message_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    message VARCHAR(1000) NOT NULL
);

-- Заполнение таблиц данными
INSERT INTO users (username, password) VALUES ('user1', 'password1'), ('user2', 'password2');

INSERT INTO messages (user_id, message) VALUES (1, 'Hello from user1'), (2, 'Hello from user2'), (1, 'Another message from user1');

-- Обновление данных пользователя
UPDATE users SET password = 'newpassword1' WHERE username = 'user1';

-- Удаление одного сообщения
DELETE FROM messages WHERE message='Hello from user2';

-- Выборка сообщений, которые есть только у одного пользователя
SELECT m.*
FROM messages m
JOIN users u ON u.user_id = m.user_id
WHERE u.username = 'user1';

-- Удаление одного пользователя
DELETE FROM users WHERE user_id = 2;

-- При помощи EXPLAIN выявление узких мест в запросе выборки сообщений пользователя
EXPLAIN SELECT * FROM messages WHERE user_id = 1;

