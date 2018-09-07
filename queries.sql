-- clear tables 
DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS user_channel_translation;
-- create tables


CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL
);

-- a channel can only belong to one org but can have many users
CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  id_organization INT REFERENCES organization(id)
);

-- a user can belong to many channels
CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL
);

-- a message can only have one user, and only one channel
CREATE TABLE messages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  content TEXT NOT NULL,
  id_user INT REFERENCES user(id),
  id_channel INT REFERENCES channel(id)
);

-- many to many table
CREATE TABLE user_channel_translation (
  id_user INT REFERENCES user(id),
  id_channel INT REFERENCES channel(id)
);


-- inserts

INSERT INTO organization (name) VALUES("Lambda School");

INSERT INTO user (name) VALUES("Alice");
INSERT INTO user (name) VALUES("Bob");
INSERT INTO user (name) VALUES("Chris");

INSERT INTO channel (name, id_organization) VALUES("#general", 1);
INSERT INTO channel (name, id_organization) VALUES("#random", 1);

INSERT INTO messages (content, id_user, id_channel) VALUES ("SQL is a thing", 1,1);
INSERT INTO messages (content, id_user, id_channel) VALUES ("why yes SQL is a thing", 2,1);
INSERT INTO messages (content, id_user, id_channel) VALUES ("100% not a person or a place", 1,1);
INSERT INTO messages (content, id_user, id_channel) VALUES ("I <3 SQL", 2,1);
INSERT INTO messages (content, id_user, id_channel) VALUES ("^_^", 2,1);

-- Bob is not in channel random but this is a message to satisfy q#8
INSERT INTO messages (content, id_user, id_channel) VALUES ("You're my family and I love you, but you're terrible. You're all terrible.", 2,2);

INSERT INTO messages (content, id_user, id_channel) VALUES ("My my, hey hey", 1,2);
INSERT INTO messages (content, id_user, id_channel) VALUES ("Rock and roll is here to stay",3,2);
INSERT INTO messages (content, id_user, id_channel) VALUES ("It's better to burn out than to fade away", 1,2);
INSERT INTO messages (content, id_user, id_channel) VALUES ("My my, hey hey", 3,2);
INSERT INTO messages (content, id_user, id_channel) VALUES ("^_^", 1,2);

INSERT INTO user_channel_translation (id_user, id_channel) VALUES (1, 1);
INSERT INTO user_channel_translation (id_user, id_channel) VALUES (1, 2);
INSERT INTO user_channel_translation (id_user, id_channel) VALUES (2, 1);
INSERT INTO user_channel_translation (id_user, id_channel) VALUES (3, 2);

-- selects

-- 1
SELECT *
FROM organization;

-- 2
SELECT *
FROM channel;

-- 3
SELECT  organization.name AS org_name,
        channel.name AS channel_name
FROM organization, channel
WHERE organization.id = id_organization
;

-- 4
SELECT  channel.name,
        messages.content,
        messages.post_time
FROM channel, messages
WHERE channel.ID = id_channel
AND channel.name LIKE "#gen%"
ORDER BY post_time DESC
;

-- 5
SELECT  channel.name,
        user.name AS user
FROM channel, user, user_channel_translation
WHERE channel.id = id_channel
AND user.id = id_user
AND user.name LIKE "Alice"
;

-- 6
SELECT  channel.name,
        user.name AS user
FROM channel, user, user_channel_translation
WHERE channel.id = id_channel
AND user.id = id_user
;

-- 7
SELECT  user.name AS user,
        channel.name AS channel_name,
        messages.content
FROM user, messages, channel
WHERE messages.id_user = user.id
AND messages.id_channel = channel.id
AND user.name LIKE "Alice"
;

-- 8
SELECT  user.name AS user,
        channel.name AS channel_name,
        messages.content
FROM user, messages, channel
WHERE messages.id_user = user.id
AND messages.id_channel = channel.id
AND user.name LIKE "Bob"
AND channel.name LIKE "#random"
;

-- 9
SELECT  user.name AS "User Name",
        count(messages.id)
FROM user, messages
WHERE user.id = id_user
GROUP BY user.name
;

-- 10 Stretch
SELECT  user.name AS user,
        channel.name AS channel_name,
        count(messages.id)
FROM user, messages, channel
WHERE messages.id_user = user.id
AND messages.id_channel = channel.id
GROUP BY user.name, channel.name
;


-- Question: What SQL keywords or concept would you use if you wanted to 
-- automatically delete all messages by a user if that user were deleted 
-- from the user table?
-- 
-- Answer: in you table you would need to have something like ON DELETE CASCADE. 
-- the idea is that when the parent is deleted, all the children that ref that parent
-- are also deleted.

