
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    organization_id INTEGER,
    FOREIGN KEY (organization_id) REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    channel_id INTEGER,
    FOREIGN KEY (channel_id) REFERENCES channel(id)
);

CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date_stamp INTEGER,
    content VARCHAR(300),
    channel_id INTEGER,
    user_id INTEGER,
    FOREIGN KEY (channel_id) REFERENCES channel(id)
    FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE channel_join (
    user_id INTEGER,
    channel_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (channel_id) REFERENCES channel(id)
);
-- 1
INSERT INTO organization(name) VALUES ('Lambda School');

-- 2
INSERT INTO user(name) VALUES ('Alice');
INSERT INTO user(name) VALUES ('Bob');
INSERT INTO user(name) VALUES ('Chris');

-- 3
INSERT INTO channel(name, organization_id) VALUES ('#general',1);
INSERT INTO channel(name, organization_id) VALUES ('#random',1);

-- 4?
-- Alice in Gen&Ran
INSERT INTO channel_join(user_id, channel_id) VALUES(1,1);
INSERT INTO channel_join(user_id, channel_id) VALUES(1,2);
-- Bob in #general
INSERT INTO channel_join(user_id, channel_id) VALUES(2,1);
-- Chris in #random
INSERT INTO channel_join(user_id, channel_id) VALUES(3,2);

-- 4 to 7
INSERT INTO messages(date_stamp, content, user_id, channel_id) 
VALUES (datetime(), 'Msg 1', 1, 1);

INSERT INTO messages(date_stamp, content, user_id, channel_id) 
VALUES (datetime(), 'Msg 2', 2, 1);

INSERT INTO messages(date_stamp, content, user_id, channel_id) 
VALUES (datetime(), 'Msg 3', 3, 2);

INSERT INTO messages(date_stamp, content, user_id, channel_id) 
VALUES (datetime(), 'Msg 4', 1, 2);

INSERT INTO messages(date_stamp, content, user_id, channel_id) 
VALUES (datetime(), 'Msg 5', 2, 1);

INSERT INTO messages(date_stamp, content, user_id, channel_id) 
VALUES (datetime(), 'Msg 6', 3, 2);

INSERT INTO messages(date_stamp, content, user_id, channel_id) 
VALUES (datetime(), 'Msg 7', 1, 2);

INSERT INTO messages(date_stamp, content, user_id, channel_id) 
VALUES (datetime(), 'Msg 8', 2, 1);

INSERT INTO messages(date_stamp, content, user_id, channel_id) 
VALUES (datetime(), 'Msg 9', 3, 2);

INSERT INTO messages(date_stamp, content, user_id, channel_id) 
VALUES (datetime(), 'Msg 10', 1, 1);

-- Section 5 SELECT QUERIES

-- 1
SELECT name FROM organization;

-- 2
SELECT name FROM channel;

-- 3 Hard LambdaSchool vs Lambda School haha
SELECT channel.name FROM channel WHERE organization_id IS 
    (SELECT id FROM organization WHERE name is "Lambda School"); 

-- 4
SELECT messages.content, channel.name, date_stamp FROM messages, channel WHERE channel.name IS "#general"
    AND channel_id IS channel.id ORDER BY date_stamp;

-- 5 ALice vs Alice, Ambiguousness
SELECT channel.name FROM channel, user, channel_join WHERE user.name IS "Alice" 
    AND user_id IS user.id AND channel_join.channel_id IS channel.id; 

-- 6
SELECT user.name FROM user, channel, channel_join WHERE channel.name IS "#general"
    AND user_id IS user.id AND channel_join.channel_id IS channel.id;

-- 7
SELECT messages.content FROM messages, user, channel WHERE user.name IS "ALice"
    AND user_id IS user.id AND messages.channel_id IS channel.id;

-- 8
SELECT messages.content FROM messages, user, channel WHERE channel.name IS "#random"
    AND user.name IS "Bob" AND user_id IS user.id;

-- 9
SELECT user.name as "User Name", Count(*) as "Message Count" FROM user, messages
    WHERE user_id IS user.id GROUP BY user.name ORDER BY user.name DESC;


ON DELETE CASCADE or a series of DROP TABLE commands