-- Pretty formatting
.mode column
.header on

-- Creates a persistent DB for my chat system
.open chat.db

-- * Users TABLE (e.g. `Dave`)
-- ID, NAME,
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE
);
-- * Organizations TABLE (e.g. `Lambda School`)
-- ID, NAME,
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE
);
-- * Channels TABLE (e.g. `#random`)
-- ID, NAME, ORGANIZATION_ID
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES organization(id)
);
-- * Messge TABLE ()
-- ID, POST_TIME, CONTENT, AUTHOR, CHANNEL
CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content LONGTEXT, 
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);
-- * CHANNEL_SUBSCRIPTIONS
-- CHANNEL_ID, USER_ID
CREATE TABLE channel_sub (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);
-- #### INSERT LAND ######## --
--   1. One organization, `Lambda School`
INSERT INTO organization (name) VALUES ('Lambda School');
--   2. Three users, `Alice`, `Bob`, and `Chris`
INSERT INTO user(name)VALUES('Alice');
INSERT INTO user(name)VALUES('Bob');
INSERT INTO user(name)VALUES('Chris');

--   3. Two channels, `#general` and `#random`
INSERT INTO channel(name,organization_id)VALUES('#general', 1);
INSERT INTO channel(name,organization_id)VALUES('#random', 1);


--   5. `Alice` should be in `#general` and `#random`.
INSERT INTO channel_sub (channel_id, user_id)VALUES(1,1);
INSERT INTO channel_sub (channel_id, user_id)VALUES(2,1); 

--   6. `Bob` should be in `#general`.
INSERT INTO channel_sub (channel_id, user_id)VALUES(1,2);

--   7. `Chris` should be in `#random`.
INSERT INTO channel_sub (channel_id, user_id)VALUES(2,3);

--   4. 10 messages (at least one per user, and at least one per channel).
INSERT INTO messages (content, user_id, channel_id)VALUES(
    'This is a message from Alice in #general',
    1,1
);
INSERT INTO messages (content, user_id, channel_id)VALUES(
    'This is a message from Alice in #random',
    2,1
);
INSERT INTO messages (content, user_id, channel_id)VALUES(
    'This is a message from Alice in #random',
    2,1
);
INSERT INTO messages (content, user_id, channel_id)VALUES(
    'This is a message from Bob in #general',
    2,1
);
INSERT INTO messages (content, user_id, channel_id)VALUES(
    'This is a message from Chris in #general',
    3,1
);
INSERT INTO messages (content, user_id, channel_id)VALUES(
    'This is a message from Alice in #general',
    1,1
);
INSERT INTO messages (content, user_id, channel_id)VALUES(
    'This is a message from Bob in #general',
    2,1
);
INSERT INTO messages (content, user_id, channel_id)VALUES(
    'This is a message from Chris in #general',
    3,1
);

INSERT INTO messages (content, user_id, channel_id)VALUES(
    'This is a message from Bob in #general',
    2,1
);
INSERT INTO messages (content, user_id, channel_id)VALUES(
    'This is a message from Bob in #general',
    2,1
);

-- #### QUERY LAND ######## --
-- 1. List all organization `name`s.
SELECT name AS Organizaton_name FROM organization;

-- 2. List all channel `name`s.
SELECT name AS Channel_name FROM channel;

-- 3. List all channels in a specific organization by organization `name`.
SELECT name AS LS_Channel FROM channel WHERE organization_id IS (SELECT id FROM organization WHERE name IS 'Lambda School');

-- 4. List all messages in a specific channel by channel `name` `#general` in
-- order of `post_time`, descending.
SELECT * FROM messages WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#general') ORDER BY post_time DESC;

-- 5. List all channels to which user `Alice` belongs.
SELECT c.name AS Alice_Channels, c.id AS Channel_ID  FROM channel AS c INNER JOIN channel_sub AS cs ON c.id IS cs.channel_id INNER JOIN user AS u ON u.id IS cs.user_id WHERE u.name IS 'Alice';

-- 6. List all users that belong to channel `#general`.
SELECT u.name AS UsersInGeneral FROM user AS u INNER JOIN channel_sub AS cs ON u.id IS cs.user_id INNER JOIN channel AS c ON cs.channel_id IS c.id WHERE c.name IS "#general";
-- 7. List all messages in all channels by user `Alice`.
SELECT post_time AS Posted_AT, content AS Body_Message, u.name AS USERNAME FROM messages AS m INNER JOIN user AS u ON user_id IS u.id WHERE u.name IS 'Alice';
-- 8. List all messages in `#random` by user `Bob`.
SELECT * FROM messages WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#random');
-- 9. List the count of messages across all channels per user. (Hint:
-- `COUNT`, `GROUP BY`.)
SELECT COUNT (u.id) AS 'Message Count Totals', u.name AS 'Username' FROM messages AS m INNER JOIN user AS u on m.user_id IS u.id INNER JOIN channel AS c WHERE m.channel_id IS c.id GROUP BY u.id;
-- The title of the user's name column should be `User Name` and the title of
-- the count column should be `Message Count`. (The SQLite commands
-- `.mode column` and `.header on` might be useful here.)

-- DROP TABLE  organization;
-- DROP TABLE  channel;
-- DROP TABLE  user;
-- DROP TABLE  messages;
-- DROP TABLE  channel_sub;

-- 6. What SQL keywords or concept would you use if you wanted to automatically
--    delete all messages by a user if that user were deleted from the `user`
--    table?

-- I would us ON DELETE CASCADE and use it to specify it in the Foreign Key Constraint in the schema for my messages.