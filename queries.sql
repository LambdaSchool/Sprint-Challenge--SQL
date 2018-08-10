-- Turn on Prettier Formatting for Displaying Queries
.mode column
.header on
-- Create a DB for the Online Chat System
.open onlinechat.db

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

-- * Messge TABLE
-- ID, POST_TIME, CONTENT, USER_ID, CHANNEL_ID
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content LONGTEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

-- * CHANNEL_SUBSCRIPTIONS JOIN TABLE
-- CHANNEL_ID, USER_ID
CREATE TABLE channel_subs (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);

-- #### INSERT LAND ######## --
--   1. One organization, `Lambda School`
INSERT INTO organization (name)VALUES('Lambda School');
--   2. Three users, `Alice`, `Bob`, and `Chris`
INSERT INTO user (name)VALUES('Alice'); -- user 1
INSERT INTO user (name)VALUES('Bob'); -- user 2
INSERT INTO user (name)VALUES('Chris'); -- user 3
--   3. Two channels, `#general` and `#random`
INSERT INTO channel (name,organization_id)VALUES('#general',1); -- channel 1
INSERT INTO channel (name,organization_id)VALUES('#random',1); -- channel 2
--   4. 10 messages (at least one per user, and at least one per channel).

-- Alice Joined Both Channels
INSERT INTO channel_subs (channel_id,user_id)VALUES(1,1);
INSERT INTO channel_subs (channel_id,user_id)VALUES(2,1);
-- Bob Joins General Channel
INSERT INTO channel_subs (channel_id,user_id)VALUES(1,2);
-- Chris Joins Random Channel
INSERT INTO channel_subs (channel_id,user_id)VALUES(2,3);

-- Users inserting Messages into Channels
INSERT INTO message (content, user_id, channel_id)VALUES(
    'This is a message from Alice in #general',
    1,1
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'This is a message from Alice in #random',
    1,2
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'This is a message from Chris in #random',
    3,2
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'This is a message from Bob in #general',
    2,1
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'This is an extra message from Bob in #general',
    2,1
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'This is yet another message from Bob in #general',
    2,1
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'Bob should really be banned from #general for sending so many messages',
    2,1
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'This is a message from Alice in #general: BOB please stop chatting in general..',
    1,1
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'This is a message from Alice in #general: BOB if you do not stop i will kick you from general..',
    1,1
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'This is a message from Alice in #general: BOB if you do not stop i will kick you from general..',
    1,1
);

-- #### QUERY LAND ######## --
-- 1. List all organization `name`s.
SELECT name AS Organization_Name FROM organization;

-- 2. List all channel `name`s.
SELECT name AS Channel_Name FROM channel;

-- 3. List all channels in a specific organization by organization `name`.
SELECT name AS LambdaSchool_Channels FROM channel WHERE organization_id IS (SELECT id FROM organization WHERE name IS 'Lambda School');

-- 4. List all messages in a specific channel by channel `name` `#general` in
-- order of `post_time`, descending.  [ORDER BY column1, column2, .. columnN] [ASC | DESC];
SELECT * FROM message WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#general') ORDER BY post_time DESC;

-- 5. List all channels to which user `Alice` belongs.
SELECT c.name AS Alice_Channels, c.id AS Channel_ID  FROM channel AS c INNER JOIN channel_subs AS cs ON c.id IS cs.channel_id INNER JOIN user AS u ON u.id IS cs.user_id WHERE u.name IS 'Alice';

-- 6. List all users that belong to channel `#general`.
SELECT u.name AS Users_In_General FROM user AS u INNER JOIN channel_subs AS cs ON u.id IS cs.user_id INNER JOIN channel AS c ON cs.channel_id IS c.id WHERE c.name IS "#general";

-- 7. List all messages in all channels by user `Alice`.
SELECT post_time AS POSTED_AT, content AS MESSGE_BODY, u.name AS USERNAME FROM message AS m INNER JOIN user AS u ON user_id IS u.id WHERE u.name IS 'Alice';

-- 8. List all messages in `#random` by user `Bob`.
-- NO messages will come up because nothing was added for bob in that channel, bob only speaks in General.
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


-- ### CLEARING OUT ALL TABLES ### 
-- # REMOVE THIS AFTER DEBUGGING #
DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS channel_subs;