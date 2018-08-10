PRAGMA foreign_keys = ON; --enable foreign key constraints for sqlite

-- SQLite Configuration
.header on
.mode column
.timer on

-- Create a database for an online chat system
.open chat.db --sqlite
CREATE DATABASE chat; --mysql

-- Create a table
CREATE TABLE organization (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name VARCHAR(255) NOT NULL UNIQUE); --sqlite

CREATE TABLE channel (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name VARCHAR(255) NOT NULL UNIQUE, organization_id INT REFERENCES organization(id));

CREATE TABLE user (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name VARCHAR(255) NOT NULL UNIQUE);

CREATE TABLE message (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, post_time DATETIME DEFAULT CURRENT_TIMESTAMP, content VARCHAR(1000) NOT NULL, user_id INT REFERENCES user(id), channel_id INT REFERENCES channel(id));

CREATE TABLE user_subscriptions(user_id INTEGER REFERENCES user(id), channel_id INTEGER REFERENCES channel(id));


-- INSERT QUERIES
INSERT INTO organization(name) VALUES ('Lambda School');
INSERT INTO user(name) VALUES ('Alice'), ('Bob'), ('Chris');
INSERT INTO channel(name, organization_id) VALUES ('#general', 1), ('#random', 1);
INSERT INTO message(content, user_id, channel_id) VALUES ('Alice Sample Content', 1, 1), ('Alice Sample Content 2', 1, 2), ('Alice Sample Content 3', 1, 1), ('Alice Sample Content 4', 1, 2), ('Bob Sample Content', 2, 1), ('Bob Sample Content 2', 2, 1), ('Bob Sample Content 3', 2, 1), ('Chris Sample Content', 3, 2), ('Chris Sample Content 2', 3, 2), ('Chris Sample Content 3', 3, 2);
INSERT INTO user_subscriptions(user_id, channel_id) VALUES (1,1), (1,2), (2,1), (3,2);


-- SELECT QUERIES
SELECT name AS 'Organization Names' FROM organization;
SELECT name AS 'Channel Names' FROM channel;
SELECT channel.name FROM channel, organization WHERE organization.id = channel.organization_id AND organization.name = 'Lambda School';
SELECT message.content FROM message, channel WHERE channel.id = message.channel_id AND channel.name = '#general' ORDER BY post_time DESC;
SELECT channel.name FROM channel, user, user_subscriptions WHERE channel.id = user_subscriptions.channel_id AND user.id = user_subscriptions.user_id AND user.name = 'Alice';
SELECT user.name FROM channel, user, user_subscriptions WHERE channel.id = user_subscriptions.channel_id AND channel.name = '#general' AND user.id = user_subscriptions.user_id;
SELECT message.content FROM message, user WHERE user.id = message.user_id AND user.name='Alice';
SELECT message.content FROM message, user, channel WHERE user.id = message.user_id AND channel.name='#random' AND user.name='Bob';
SELECT user.name AS 'User Name', COUNT(content) AS 'Message Count' FROM message, user WHERE user.id = message.user_id GROUP BY user.name;
SELECT user.name AS User, channel.name AS Channel, COUNT(message.content) AS 'Message Count' FROM message, user, channel WHERE user.id = message.user_id AND channel.id = message.channel_id GROUP BY channel.name, user.name;

-- What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?

-- ANS: ON DELETE CASCADE