-- Pretty Formatting for tables
.mode COLUMN
.header ON 

-- my chat system database 
.OPEN onlinechat.db 


-- CREATE TABLE statements for tables organization, channel, user and message:

-- organization table (Lambda School)
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name VARCHAR(128) NOT NULL UNIQUE
);


-- channel table (2 channels - #random, #general) 
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name VARCHAR(128) NOT NULL UNIQUE, 
    organization_id INTEGER REFERENCES organization(id)
);


-- user table (3 users - Alice, Bob, Chris)
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name VARCHAR(128) NOT NULL UNIQUE
);


-- message table (10 mssgs; 1 per/user, 1 per/channel)
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content LONGTEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);


-- channel subscription for users
CREATE TABLE channel_subscriptions (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);

-- Alice should be in channels #general & #random
-- Bob should be in #general
-- Chris should be in #random


-- TABLE INSERTS
-- Insert Lambda School (organization)
INSERT INTO organization (name)VALUES('Lambda School');


-- Insert the 3 users (user)
INSERT INTO user (name)VALUES('Alice');
INSERT INTO user (name)VALUES('Bob');
INSERT INTO user (name)VALUES('Chris');


-- Insert 2 channels (channels)
INSERT INTO channel (name,organization_id)VALUES('#general', 1);
INSERT INTO channel (name,organization_id)VALUES('#random', 1);


-- Add Alice to both channels
INSERT INTO channel_subscriptions (channel_id,user_id)VALUES(1,1);
INSERT INTO channel_subscriptions (channel_id,user_id)VALUES(2,1);
-- Add Bob to #general
INSERT INTO channel_subscriptions (channel_id,user_id)VALUES(1,2);
-- Add Chris to #random
INSERT INTO channel_subscriptions (channel_id,user_id)VALUES(2,3);


-- Adding 10 mssgs (1/user and 1/channel)
INSERT INTO message (content, user_id, channel_id)VALUES('Hello I am Alice and new to #general', 1,1);

INSERT INTO message (content, user_id, channel_id)VALUES('Hello I am Alice and new to #random', 1,2);

INSERT INTO message (content, user_id, channel_id)VALUES('Hello I am Chris and new to #random', 3,2);

INSERT INTO message (content, user_id, channel_id)VALUES('Hello I am Bob and new to #general', 2,1);

INSERT INTO message (content, user_id, channel_id)VALUES('Bob loves the #general channel', 2,1);

INSERT INTO message (content, user_id, channel_id)VALUES('Truth be told I am Bob Ross #general', 2,1);

INSERT INTO message (content, user_id, channel_id)VALUES('OMG I am Alice and I am your #1 Bob Ross! #general', 1,1);

INSERT INTO message (content, user_id, channel_id)VALUES('Bob Ross is my hero - xoxo Alice #general', 1,1);

INSERT INTO message (content, user_id, channel_id)VALUES('This is Chris from #random - did Bob Ross really join #general?', 3,2);

INSERT INTO message (content, user_id, channel_id)VALUES('This is Chris from #random - Guess I will join #general to see for myself', 3,2);

-- -----------------------------------------------------------------------------------

-- Write SELECT queries TO RUN IN TERMINAL! 
-- List all organization names
SELECT name AS Organization_Name FROM organization;

-- List all channel names
SELECT name AS Channel_Name FROM channel;


--List all channels in a specific organization by organization name.
 SELECT name AS LambdaSchool_Channels FROM channel WHERE organization_id IS (SELECT id FROM organization WHERE name IS 'Lambda School');



--List all messages in a specific channel by channel name #general in order of post_time, descending. (Hint: ORDER BY. Because your INSERTs might have all taken place at the exact same time, this might not return meaningful results. But humor us with the ORDER BY anyway.)
SELECT * FROM message WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#general') ORDER BY post_time DESC;



--List all channels to which user Alice belongs.
SELECT c.name AS Alice_Channels, c.id AS Channel_ID FROM channel AS c INNER JOIN channel_subscriptions AS cs ON c.id IS cs.channel_id INNER JOIN user AS u ON u.id IS cs.user_id WHERE u.name IS 'Alice';


--List all users that belong to channel #general.
SELECT u.name AS Users_In_General FROM user AS u INNER JOIN channel_subscriptions AS cs ON u.id IS cs.user_id INNER JOIN channel AS c ON cs.channel_id IS c.id WHERE c.name IS "#general";



-- List all messages in all channels by user Alice.
SELECT post_time AS POSTED_AT, content AS MESSGE_BODY, u.name AS USERNAME FROM message AS m INNER JOIN user AS u ON user_id IS u.id WHERE u.name IS 'Alice';



-- List all messages in #random by user Bob. (None will show as he is only in #general)
SELECT * FROM message WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#random') 
AND user_id IS (SELECT id FROM user WHERE name IS 'Bob');



--List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.)
SELECT COUNT(u.id) AS 'Message Count', u.name AS 'User Name' FROM message AS m
INNER JOIN user AS u on m.user_id IS u.id 
INNER JOIN channel as c WHERE m.channel_id IS c.id GROUP BY u.id;


-- QUESTION #6
-- What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?
-- I would use the 'ON DELETE CASCADE' then specify it within Foreign Key on the mssg schema