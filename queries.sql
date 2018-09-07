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
SELECT


-- List all users that belong to channel #general.
SELECT


-- List all messages in all channels by user Alice.
SELECT


-- List all messages in #random by user Bob.
SELECT


-- List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.)
SELECT


