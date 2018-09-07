PRAGMA foreign_keys = ON
.mode column
.header ON

DROP TABLE IF EXISTS organization
DROP TABLE IF EXISTS channel
DROP TABLE IF EXISTS user
DROP TABLE IF EXISTS message

/*CREATE TABLE*/
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/**/
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES organization(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/**/
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/**/
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
/**/
CREATE TABLE user_channel (
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

/**/
INSERT INTO organization (name) VALUES("Lambda School");

/**/
INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

/**/
INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

/**/
INSERT INTO message (content, user_id, channel_id) VALUES ("1 DAMN DANIEL", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("2 I'M THE KING OF THE WORLD", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("3 LAMBDA4LIFE", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("4 I'm so exited for labs!!!", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("5 I can't wait to be a grown up", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("6 Cat all over me", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("7 Javascript is my favorite", 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("8 Life is 42", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("9 what is the purpose of life", 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("10 I'm finished!!!", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("11 I'm finished for real!!!", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("12 I'm finished for real for real!!!", 1, 1);

/**/
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);

/**/
SELECT organization.name FROM organization;

/**/
SELECT channel.name FROM channel;

/**/
SELECT channel.name as "Channel Name" FROM channel, organization WHERE organization_id = organization.id AND 
    organization.name = "Lambda School";

/**/
SELECT message.user_id, message.content 
FROM channel, message 
WHERE message.channel_id = channel.id AND channel.name = "#general" 
ORDER BY post_time DESC;

/**/
SELECT channel.name AS "Alice's Channels" 
FROM channel, user, user_channel 
WHERE user.name = "Alice" 
AND user.id = user_channel.user_id
AND channel.id = user_channel.channel_id;

SELECT channel.name as "Alice's Channels" 
FROM channel 
INNER JOIN user_channel ON channel.id IS user_channel.channel_id 
INNER JOIN user ON user.id IS user_channel.user_id
AND user.name = "Alice";

/**/
SELECT user.name AS "#general users" 
FROM user, channel, user_channel
WHERE channel.name = "#general" 
AND user.id = user_channel.user_id
AND channel.id = user_channel.channel_id;

/**/
SELECT message.id AS Message ID, message.content AS "Alice's Messages"
FROM user, message
WHERE user.name = "Alice"
AND user.id = message.user_id;

/**/
SELECT message.id AS "Message ID", message.content AS "#random content by Bob"
FROM user, channel, message, user_channel
WHERE user.name = "Bob"
AND channel.name = "#random"
AND user.id = message.user_id
AND user_channel.user_id = user.id;

/**/
SELECT user.name AS "User Name", COUNT(message.user_id) AS "Message Count"
FROM user, message 
WHERE user.id = message.user_id
GROUP BY user.id
ORDER BY user.name DESC;
