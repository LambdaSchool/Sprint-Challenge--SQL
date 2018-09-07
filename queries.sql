/*create a persistent DB file*/
sqlite3 queries.db

/*Turns on foreign key constraints*/
PRAGMA foreign_keys = ON

/*Turn on column out put and headers for `SELECT`*/
.mode COLUMN
.header ON

-- CREATE TABLES
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    organization_id INT REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    organization_id INT REFERENCES organization(id)
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    content VARCHAR(300) NOT NULL,
    channel_id INT REFERENCES channel(id),
    user_id INT REFERENCES user(id)
);

-- JOIN TABLES

-- CREATE TABLE organization_user (
--     organization_id INT REFERENCES organization(id),
--     user_id INT REFERENCES user(id)
-- );

CREATE TABLE channel_user (
    user_id INT REFERENCES user(id),
    channel_id INT REFERENCES channel(id)
);

-- INSERT

INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name, organization_id) VALUES ("Alice", 1);
INSERT INTO user (name, organization_id) VALUES ("Bob", 1);
INSERT INTO user (name, organization_id) VALUES ("Chris", 1);

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO message (content, user_id, channel_id) VALUES ("Chris is so random", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Bob is so basic", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("CHECK THIS CRAZY VIDEO OUT", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Ha, yeah", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Somebody at google was just like 'yea, just have someone drive down every road on f@#%ing earth.' And you know what? They did it.", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Anxiety is like when video game combat music is playing but you can't find any enemies.", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("I like bread", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("What's your favorite language? Ruby or Javascript?", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("I prefer ArnoldC :P" , 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("...Can't you take anything seriously?!", 1, 2);

INSERT INTO channel_user (user_id, channel_id) VALUES (1, 1);
INSERT INTO channel_user (user_id, channel_id) VALUES (1, 2);
INSERT INTO channel_user (user_id, channel_id) VALUES (2, 1);
INSERT INTO channel_user (user_id, channel_id) VALUES (3, 2);

-- SELECT

-- List all organization names.
SELECT organization.name from organization;

-- OUTPUT
-- name
-- -------------
-- Lambda School


-- List all channel names.
SELECT channel.name from channel;

-- OUTPUT
-- name
-- ----------
-- #general
-- #random


-- List all channels in a specific organization by organization name.
SELECT channel.name from channel, organization WHERE organization_id = organization.id AND organization.name = "Lambda School";

-- OUTPUT
-- name
-- ----------
-- #general
-- #random


-- List all messages in a specific channel by channel name #general in order of post_time, descending. (Hint: ORDER BY. Because your INSERTs might have all taken place at the exact same time, this might not return meaningful results. But humor us with the ORDER BY anyway.)
SELECT content FROM message WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#general') ORDER BY post_time DESC;

-- OUTPUT
-- content
-- ------------------
-- Chris is so random
-- Ha, yeah
-- I like bread


-- List all channels to which user Alice belongs.
SELECT channel.name, channel.id FROM channel INNER JOIN channel_user ON channel.id IS channel_user.channel_id INNER JOIN user ON user.id IS channel_user.user_id WHERE user.name IS "Alice";

-- OUTPUT
-- name        id
-- ----------  ----------
-- #general    1
-- #random     2


-- List all users that belong to channel #general.
SELECT user.name from user INNER JOIN channel_user ON user.id IS channel_user.user_id INNER JOIN channel ON channel_user.channel_id IS channel.id WHERE channel.name IS "#general";

-- OUTPUT
-- name
-- ----------
-- Alice
-- Bob


-- List all messages in all channels by user Alice.
SELECT content from message INNER JOIN user ON message.user_id IS user.id WHERE user.name IS "Alice";

-- OUTPUT 
-- content
-- ------------------
-- Chris is so random
-- Bob is so basic
-- What's your favori
-- ...Can't you take


-- List all messages in #random by user Bob.
SELECT content FROM message WHERE channel_id IS (SELECT id FROM channel WHERE name is "#general") AND user_id IS (SELECT id FROM user WHERE name is "Bob");

-- OUTPUT
-- content
-- ----------
-- Ha, yeah
-- I like bre


-- List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.)
SELECT user.name AS "User Name", COUNT(user.id) as "Message Count" FROM message INNER JOIN user ON message.user_id IS user.id INNER JOIN channel WHERE message.channel_id IS channel.id GROUP BY user.id ORDER BY user_id DESC;

-- OUTPUT
-- User Name   Message Count
-- ----------  -------------
-- Chris       4
-- Bob         2
-- Alice       4


-- What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?

PRAGMA foreign_keys = OFF
DELETE FROM message WHERE message.user_id IS user.id

