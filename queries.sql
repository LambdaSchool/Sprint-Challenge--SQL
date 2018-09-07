PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS user_channels;
DROP TABLE IF EXISTS message_table;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    organization_id INTEGER,
    FOREIGN KEY(organization_id) REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
);

CREATE TABLE user_channels (
    userid INTEGER,
    channel_id INTEGER,
    FOREIGN KEY(userid) REFERENCES user(id),
    FOREIGN KEY(channel_id) REFERENCES channel(id)
);

CREATE TABLE message_table (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    post_time DATETIME,
    channel_id INTEGER,
    author_id INTEGER,
    FOREIGN KEY(channel_id) REFERENCES channel(id),
    FOREIGN KEY(author_id) REFERENCES user(id)
);

INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO user_channels (userid, channel_id) VALUES (1, 1);
INSERT INTO user_channels (userid, channel_id) VALUES (1, 2);
INSERT INTO user_channels (userid, channel_id) VALUES (2, 1);
INSERT INTO user_channels (userid, channel_id) VALUES (3, 2);

INSERT INTO message_table (content, channel_id, author_id) VALUES ("message", 1, 1);
INSERT INTO message_table (content, channel_id, author_id) VALUES ("message", 1, 2);
INSERT INTO message_table (content, channel_id, author_id) VALUES ("message", 1, 3);
INSERT INTO message_table (content, channel_id, author_id) VALUES ("message", 2, 1);
INSERT INTO message_table (content, channel_id, author_id) VALUES ("message", 2, 1);
INSERT INTO message_table (content, channel_id, author_id) VALUES ("message", 2, 1);
INSERT INTO message_table (content, channel_id, author_id) VALUES ("message", 2, 1);
INSERT INTO message_table (content, channel_id, author_id) VALUES ("message", 2, 3);
INSERT INTO message_table (content, channel_id, author_id) VALUES ("message", 2, 3);
INSERT INTO message_table (content, channel_id, author_id) VALUES ("message", 2, 3);

SELECT * FROM organization;
SELECT * FROM channel;

SELECT channel.name FROM channel, organization
    WHERE channel.organization_id = organization.id AND organization.name = "Lambda School";

SELECT message_table.content FROM message_table, channel
    WHERE message_table.channel_id = channel.id AND channel.name = "#general"
    ORDER BY post_time;

SELECT channel.name FROM channel, user_channels, user
    WHERE user_channels.userid = user.id AND
    user_channels.channel_id = channel.id AND
    user.name = "Alice";

SELECT user.name FROM channel, user_channels, user
    WHERE user_channels.userid = user.id AND
    user_channels.channel_id = channel.id AND
    channel.name = "#general";

SELECT message_table.content FROM message_table, user
    WHERE message_table.author_id = user.id AND user.name = "Alice";

SELECT message_table.content FROM message_table, user, channel
    WHERE message_table.author_id = user.id AND 
    message_table.channel_id = channel.id AND
    user.name = "Bob" AND
    channel.name = "#random";

SELECT name AS "User Name", COUNT(*) AS "Message Count" FROM message_table, user
    WHERE message_table.author_id = user.id
    GROUP BY author_id
    ORDER BY user.name DESC;
