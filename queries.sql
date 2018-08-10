CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    org_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(1024) NOT NULL,
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE user_channel (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);

INSERT INTO organization (name)VALUES('Lambda School');

INSERT INTO user (name)VALUES('Alice');
INSERT INTO user (name)VALUES('Bob');
INSERT INTO user (name)VALUES('Chris');

INSERT INTO channel (name,org_id)VALUES('#general',1);
INSERT INTO channel (name,org_id)VALUES('#random',1);

INSERT INTO user_channel (channel_id,user_id)VALUES(1,1);
INSERT INTO user_channel (channel_id,user_id)VALUES(2,1);
INSERT INTO user_channel (channel_id,user_id)VALUES(1,2);
INSERT INTO user_channel (channel_id,user_id)VALUES(2,3);

INSERT INTO messages (content, user_id, channel_id)VALUES('Alice post 1',1,1);
INSERT INTO messages (content, user_id, channel_id)VALUES('Alice post 1',1,1);
INSERT INTO messages (content, user_id, channel_id)VALUES('Bob post 1',2,1);
INSERT INTO messages (content, user_id, channel_id)VALUES('Chris post 1',3,2);
INSERT INTO messages (content, user_id, channel_id)VALUES('Alice post 2',1,1);
INSERT INTO messages (content, user_id, channel_id)VALUES('Alice post 2',1,1);
INSERT INTO messages (content, user_id, channel_id)VALUES('Bob post 2',2,1);
INSERT INTO messages (content, user_id, channel_id)VALUES('Chris post 2',3,2);
INSERT INTO messages (content, user_id, channel_id)VALUES('Alice post 3',1,1);
INSERT INTO messages (content, user_id, channel_id)VALUES('Alice post 3',1,1);

SELECT name AS Organization_Name FROM organization;

SELECT name AS Channel_Name FROM channel;

SELECT name AS LambdaSchool_Channels FROM channel WHERE org_id IS (SELECT id FROM organization WHERE name IS 'Lambda School');

SELECT * FROM messages WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#general') ORDER BY post_time DESC;

SELECT c.name AS Alice_Channels, c.id AS Channel_ID  FROM channel AS c INNER JOIN user_channel AS cs ON c.id IS cs.channel_id INNER JOIN user AS u ON u.id IS cs.user_id WHERE u.name IS 'Alice';

SELECT u.name AS General_Users FROM user AS u INNER JOIN user_channel AS cs ON u.id IS cs.user_id INNER JOIN channel AS c ON cs.channel_id IS c.id WHERE c.name IS "#general";

SELECT post_time AS POSTED_AT, content AS MESSGE, u.name AS USERNAME FROM messages AS m INNER JOIN user AS u ON user_id IS u.id WHERE u.name IS 'Alice';

SELECT * FROM messages WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#random') 
AND user_id IS (SELECT id FROM user WHERE name IS 'Bob');

SELECT COUNT(u.id) AS 'Message Count', u.name AS 'User Name' FROM messages AS m 
INNER JOIN user AS u on m.user_id IS u.id 
INNER JOIN channel as c WHERE m.channel_id IS c.id GROUP BY u.id 
ORDER BY u.id DESC;


--in 'messages' table schema, add 'ON DELETE CASCADE' to the foreign key constraint to remove the user's messages if the user is deleted.--