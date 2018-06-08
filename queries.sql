--
--
--RESETS
DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS channel_user;
-- RESETS
--
--

--
--
-- CREATES
CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  organization_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content VARCHAR(128) NOT NULL,
  post_time VARCHAR(128) NOT NULL,
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE channel_user (
  channel_id INTEGER REFERENCES channel(id),
  user_id INTEGER REFERENCES user(id)
);
-- CREATES
--
--

--
--
-- INSERTS
INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel (name) VALUES ("#general");
INSERT INTO channel (name) VALUES ("#random");

INSERT INTO message (content, post_time, user_id, channel_id) VALUES ("alice in general", date("now"), 1, 1);
INSERT INTO message (content, post_time, user_id, channel_id) VALUES ("alice in random one", date("now"), 1, 2);
INSERT INTO message (content, post_time, user_id, channel_id) VALUES ("alice in random two", date("now"), 1, 2);
INSERT INTO message (content, post_time, user_id, channel_id) VALUES ("bob in general", date("now"), 2, 1);
INSERT INTO message (content, post_time, user_id, channel_id) VALUES ("chris in general", date("now"), 3, 1);
INSERT INTO message (content, post_time, user_id, channel_id) VALUES ("chris in general", date("now"), 3, 1);
INSERT INTO message (content, post_time, user_id, channel_id) VALUES ("chris in general", date("now"), 3, 1);
INSERT INTO message (content, post_time, user_id, channel_id) VALUES ("chris in random", date("now"), 3, 2);
INSERT INTO message (content, post_time, user_id, channel_id) VALUES ("chris in random", date("now"), 3, 2);
INSERT INTO message (content, post_time, user_id, channel_id) VALUES ("chris in random", date("now"), 3, 2);

INSERT INTO channel_user (channel_id, user_id) VALUES (1, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 2);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 3);
-- INSERTS
--
--

--
--
-- SELECTS
SELECT name FROM organization;
SELECT name FROM channel;
SELECT organization.name AS "Organization", channel.name AS "Channel" FROM channel JOIN organization;
SELECT message.content FROM message, channel WHERE message.channel_id IS channel.id AND channel.name IS "#general" ORDER BY message.post_time;
SELECT channel.name FROM channel, user, channel_user WHERE channel_user.channel_id IS channel.id AND channel_user.user_id IS user.id AND user.name IS "Alice";
SELECT user.name FROM channel, user, channel_user WHERE channel_user.channel_id IS channel.id AND channel_user.user_id IS user.id AND channel.name IS "#general";
SELECT message.content FROM user, message WHERE user.id IS message.user_id and user.name IS "Alice";
SELECT message.content FROM user, message, channel WHERE user.id IS message.user_id AND user.name IS "Bob" AND channel.id IS message.channel_id AND channel.name IS "#random";
SELECT user.name AS "User Name", COUNT(message.content) AS "Message Count" FROM message, user WHERE user.id IS message.user_id GROUP BY message.user_id ORDER BY user.name DESC;
-- SELECTS
--
--

--
--
-- OUTPUT
--
-- sqlite> .read queries.sql
-- name
-- -------------
-- Lambda School
-- name
-- ----------
-- #general
-- #random
-- Organization   Channel
-- -------------  ----------
-- Lambda School  #general
-- Lambda School  #random
-- content
-- ----------------
-- alice in general
-- bob in general
-- chris in general
-- chris in general
-- chris in general
-- name
-- ----------
-- #general
-- #random
-- name
-- ----------
-- Alice
-- Bob
-- content
-- ----------------
-- alice in general
-- alice in random
-- alice in random
-- User Name   Message Count
-- ----------  -------------
-- Chris       6
-- Bob         1
-- Alice       3
--
-- OUTPUT
--
--

-- 6. Answer: You would use "ON DELETE CASCADE".