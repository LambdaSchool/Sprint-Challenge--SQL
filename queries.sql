-- Turn on pretty formatting
.mode column
.header on
-- Create a DB for the online chat system
.open chat.db
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

-- * Users TABLE (e.g. `Dave`)
-- ID, NAME,
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- * Messge TABLE ()
-- ID, POST_TIME, CONTENT, AUTHOR, CHANNEL
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content LONGTEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

-- * CHANNEL_SUBSCRIPTIONS
-- CHANNEL_ID, USER_ID
CREATE TABLE channel_subs (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);

-- #### INSERT LAND ######## --
--   1. One organization, `Lambda School`
INSERT INTO organization(name) VALUES('Lambda School');
--   2. Three users, `Alice`, `Bob`, and `Chris`
INSERT INTO user(name) VALUES('Alice');
INSERT INTO user(name) VALUES('Bob');
INSERT INTO user(name) VALUES('Chris');
--   3. Two channels, `#general` and `#random`
INSERT INTO channel(name, organization_id) VALUES('#general', 1);
INSERT INTO channel(name, organization_id) VALUES('#random', 1);

-- Alice can be in both General and Random Channels
INSERT INTO channel_subs (channel_id,user_id) VALUES(1, 1);
INSERT INTO channel_subs (channel_id,user_id) VALUES(2, 1);

-- Bob can be in General Channel
INSERT INTO channel_subs (channel_id,user_id) VALUES(1, 2);

-- Chris can be in Random Channel
INSERT INTO channel_subs (channel_id,user_id) VALUES(2, 3);


--   4. 10 messages (at least one per user, and at least one per channel).
INSERT INTO message(content, user_id, channel_id) VALUES('Alice is here at general', 1,1);
INSERT INTO message(content, user_id, channel_id) VALUES('Bob is here at general', 2,1);
INSERT INTO message(content, user_id, channel_id) VALUES('Chris is here at random', 3,2);
INSERT INTO message(content, user_id, channel_id) VALUES('Alice is here general', 1,1);
INSERT INTO message(content, user_id, channel_id) VALUES('Bob is here general', 2,1);
INSERT INTO message(content, user_id, channel_id) VALUES('Chris is at random', 3,2);
INSERT INTO message(content, user_id, channel_id) VALUES('Bob is here at general', 2,1);
INSERT INTO message(content, user_id, channel_id) VALUES('Chris is here at random', 3,2);
INSERT INTO message(content, user_id, channel_id) VALUES('Bob is here general', 2,1);
INSERT INTO message(content, user_id, channel_id) VALUES('Alice is here random', 1,2);

--   5. `Alice` should be in `#general` and `#random`.

--   6. `Bob` should be in `#general`.
--   7. `Chris` should be in `#random`.

-- #### QUERY LAND ######## --
-- 1. List all organization `name`s.
SELECT name AS Organization_Name FROM organization;

-- 2. List all channel `name`s.
SELECT name AS Channel_Name From channel;
-- 3. List all channels in a specific organization by organization `name`.
SELECT name AS Lambda_Channel FROM channel WHERE organization_id IS (SELECT id FROM organization WHERE name IS 'Lambda School');
-- 4. List all messages in a specific channel by channel `name` `#general` in
-- order of `post_time`, descending.
SELECT * FROM message WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#general') ORDER BY post_time DESC;
-- 5. List all channels to which user `Alice` belongs.
SELECT c.name AS Alice_Channels, c.id AS Channel_ID  FROM channel AS c INNER JOIN channel_subs AS cs ON c.id IS cs.channel_id INNER JOIN user AS u ON u.id IS cs.user_id WHERE u.name IS 'Alice';
-- 6. List all users that belong to channel `#general`.
SELECT u.name AS Users_In_General FROM user AS u INNER JOIN channel_subs AS cs ON u.id IS cs.user_id INNER JOIN channel AS c ON cs.channel_id IS c.id WHERE c.name IS "#general";
-- 7. List all messages in all channels by user `Alice`.
SELECT post_time AS POSTED_AT, content AS MESSGE_BODY, u.name AS USERNAME FROM message AS m INNER JOIN user AS u ON user_id IS u.id WHERE u.name IS 'Alice';
-- 8. List all messages in `#random` by user `Bob`.
SELECT * FROM message WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#random') 
AND user_id IS (SELECT id FROM user WHERE name IS 'Bob');
-- 9. List the count of messages across all channels per user. (Hint:
-- `COUNT`, `GROUP BY`.)

-- The title of the user's name column should be `User Name` and the title of
-- the count column should be `Message Count`. (The SQLite commands
-- `.mode column` and `.header on` might be useful here.)
SELECT COUNT(u.id) AS 'Message Count', u.name AS 'User Name' FROM message AS m 
INNER JOIN user AS u on m.user_id IS u.id 
INNER JOIN channel as c WHERE m.channel_id IS c.id GROUP BY u.id;


DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS channel_subs;
DROP TABLE IF EXISTS message;

