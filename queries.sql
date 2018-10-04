-- DB Config Setup
.header on
.mode column

-- 1. DB Tables (2 & 3 Not Required Here)

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT (datetime('now','localtime'))
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES organization(id),
    created_at DATETIME DEFAULT (datetime('now','localtime'))
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    username VARCHAR(64) NOT NULL UNIQUE,
    created_at DATE DEFAULT (datetime('now','localtime'))
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content text,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
    post_time DATE DEFAULT (datetime('now','localtime')),
    last_modified DATE DEFAULT NULL
);

CREATE TABLE user_channel (
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

-- 4. DB Inserts

INSERT INTO organization (name) VALUES ("LambdaSchool");

INSERT INTO user (name, username) VALUES ('Alice', "alice");
INSERT INTO user (name, username) VALUES ('Bob', "bob");
INSERT INTO user (name, username) VALUES ('Chris', "chris");

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO message (content, channel_id, user_id) VALUES ("Message A", 2, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message B", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message C", 1, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message D", 2, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message E", 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message F", 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message G", 2, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message H", 2, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message I", 2, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message J", 2, 2);

INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);

-- 5. DB Select

SELECT name AS "Organization Name" FROM organization;
SELECT name AS "Channel Name" FROM channel;

SELECT channel.name AS "LambdaSchool Channels"
FROM channel, organization
WHERE channel.organization_id = organization.id
AND organization.name = "LambdaSchool";

SELECT content AS "Messages", post_time FROM message
WHERE channel_id IS (
    SELECT id FROM channel WHERE name IS "#general"
)
ORDER BY post_time DESC;

SELECT channel.name AS "Alice's Channels"
FROM channel INNER JOIN user_channel
ON channel.id IS user_channel.channel_id INNER JOIN user ON user.id IS user_channel.user_id
AND user.name IS "Alice";

SELECT user.name AS "Users in #general"
FROM user INNER JOIN user_channel
ON user.id IS user_channel.user_id INNER JOIN channel ON channel.id IS user_channel.channel_id
AND channel.name IS "#general";

SELECT message.content AS "Alice's Messages"
FROM message INNER JOIN USER
ON message.user_id IS user.channel_id
WHERE user.name IS "Alice";

SELECT content AS "Bob's Messages in #random"
FROM message
WHERE channel_id IS (
    SELECT id FROM channel
    WHERE name IS "#random"
)
AND user_id IS (
    SELECT id FROM USER
    WHERE name IS "Bob"
);

SELECT user.name AS "Username", COUNT(user.id) AS "Message Count"
FROM message INNER JOIN user
ON message.user_id IS user.id INNER JOIN channel
WHERE message.channel_id IS channel.id
GROUP BY user.id
ORDER BY user.name DESC;

-- 6. Answer to Question
-- ON DELETE CASCADE
