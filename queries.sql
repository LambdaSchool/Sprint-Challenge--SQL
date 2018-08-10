.mode column
.header on

.open sprintChat.db

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE
);


CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content LONGTEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE channel_subs (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);

INSERT INTO organization (name)VALUES('Lambda School');

INSERT INTO user (name)VALUES('Alice');
INSERT INTO user (name)VALUES('Bob'); 
INSERT INTO user (name)VALUES('Chris');

INSERT INTO channel (name,organization_id)VALUES('#general',1);
INSERT INTO channel (name,organization_id)VALUES('#random',1); 

INSERT INTO channel_subs (channel_id,user_id)VALUES(1,1);
INSERT INTO channel_subs (channel_id,user_id)VALUES(2,1);

INSERT INTO channel_subs (channel_id,user_id)VALUES(1,2);

INSERT INTO channel_subs (channel_id,user_id)VALUES(2,3);

INSERT INTO message (content, user_id, channel_id)VALUES(
    'Alice in #general',
    1,1
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'Alice in #random',
    1,2
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'Bob in #general',
    2,1
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'Dejavu for Bob in #general',
    2,1
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'Bob in #general likes to talk about himself in 3rd person and spam post',
    2,1
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'im confused',
    2,1
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'I hate bob',
    1,1
);
INSERT INTO message (content, user_id, channel_id)VALUES(
    'bob, im going to crush your soul',
    1,1
);


INSERT INTO message (content, user_id, channel_id)VALUES(
    'Chris in #random',
    3,2
);

SELECT name AS Organization_Name FROM organization;

SELECT name AS Channel_Name FROM channel;

SELECT name AS LambdaSchool_Channels FROM channel WHERE organization_id IS (SELECT id FROM organization WHERE name IS 'Lambda School');

SELECT * FROM message WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#general') ORDER BY post_time DESC;

SELECT c.name AS Alice_Channels, c.id AS Channel_ID  FROM channel AS c INNER JOIN channel_subs AS cs ON c.id IS cs.channel_id INNER JOIN user AS u ON u.id IS cs.user_id WHERE u.name IS 'Alice';

SELECT u.name AS Users_In_General FROM user AS u INNER JOIN channel_subs AS cs ON u.id IS cs.user_id INNER JOIN channel AS c ON cs.channel_id IS c.id WHERE c.name IS "#general";

SELECT post_time AS POSTED_AT, content AS MESSGE_BODY, u.name AS USERNAME FROM message AS m INNER JOIN user AS u ON user_id IS u.id WHERE u.name IS 'Alice';

--shouldnt show anything here for bob
SELECT * FROM message WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#random') AND user_id IS (SELECT id FROM user WHERE name IS 'Bob');

-- #6: ON DELETE CASCADE or I would throw my laptop off of the bay bridge, depends on if i was hangry at the time.

