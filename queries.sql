-- FORMATTING
.mode column
.header on

-- CREATE TABLES
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    organization_id INTEGER,
    FOREIGN KEY(organization_id) REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    channel_id INTEGER,
    content TEXT,
    post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES user(id),
    FOREIGN KEY(channel_id) REFERENCES channel(id)
);

-- JOIN TABLE
CREATE TABLE channel_user (
    channel_id INTEGER,
    user_id INTEGER,
    FOREIGN KEY(channel_id) REFERENCES channel(id)
    FOREIGN KEY(user_id) REFERENCES user(id)
);

-- INSERT QUERIES
INSERT INTO organization(name) VALUES ("Lambda School");

INSERT INTO user(name) VALUES ("Alice");
INSERT INTO user(name) VALUES ("Bob");
INSERT INTO user(name) VALUES ("Chris");

INSERT INTO channel(name, organization_id) VALUES ("#general", 1);
INSERT INTO channel(name, organization_id) VALUES ("#random", 1);

INSERT INTO message(content, user_id, channel_id) VALUES ("AliceMessage1", 1, 1);
INSERT INTO message(content, user_id, channel_id) VALUES ("AliceMessage2", 1, 1);
INSERT INTO message(content, user_id, channel_id) VALUES ("AliceMessage3", 1, 2);
INSERT INTO message(content, user_id, channel_id) VALUES ("AliceMessage4", 1, 2);

INSERT INTO message(content, user_id, channel_id) VALUES ("BobMessage1", 2, 1);
INSERT INTO message(content, user_id, channel_id) VALUES ("BobMessage2", 2, 2);
INSERT INTO message(content, user_id, channel_id) VALUES ("BobMessage3", 2, 2);

INSERT INTO message(content, user_id, channel_id) VALUES ("ChrisMessage1", 3, 1);
INSERT INTO message(content, user_id, channel_id) VALUES ("ChrisMessage2", 3, 1);
INSERT INTO message(content, user_id, channel_id) VALUES ("ChrisMessage3", 3, 2);

INSERT INTO channel_user(channel_id, user_id) VALUES (1, 1);
INSERT INTO channel_user(channel_id, user_id) VALUES (2, 1);
INSERT INTO channel_user(channel_id, user_id) VALUES (1, 2);
INSERT INTO channel_user(channel_id, user_id) VALUES (2, 3);

-- SELECT QUERIES
SELECT name FROM organization;

SELECT name FROM channel;

SELECT channel.name FROM channel, organization WHERE organization_id = organization.id AND organization.name = "Lambda School";

SELECT message.content FROM message, channel WHERE channel_id = channel.id AND channel.name = "#general" ORDER BY post_time;

SELECT channel.name FROM channel, user, channel_user WHERE user.name IS "Alice" AND user_id IS user.id AND channel_id IS channel.id;

SELECT user.name FROM channel, user, channel_user WHERE channel.name IS "#general" AND user_id is user.id AND channel_id IS channel.id;

SELECT message.content FROM message, user, channel WHERE user.name IS "Alice" AND user_id IS user.id AND channel_id IS channel.id;

SELECT message.content FROM message, user, channel WHERE user.name IS "Bob" AND message.user_id IS user.id AND message.channel_id IS channel.id AND channel.name IS "#random";

SELECT name as "User Name", COUNT() as "Message Count" FROM user, message WHERE user_id IS user.id GROUP BY user.name ORDER BY user.name DESC;

SELECT user.name as "User", channel.name as "Channel", COUNT() as "Message Count" FROM user, channel, message WHERE user_id IS user.id AND channel_id is channel.id GROUP BY channel.name, user.name;