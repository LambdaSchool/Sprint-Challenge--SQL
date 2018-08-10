CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(256) NOT NULL,
    organization_id INTEGER,
    FOREIGN KEY(organization_id) REFERENCES organization(id)
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(256) NOT NULL,
    post_time datetime not null,
    user_id INTEGER,
    channel_id INTEGER,
    FOREIGN KEY(channel_id) REFERENCES channel(id),
    FOREIGN KEY(user_id) REFERENCES user(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE user_channels (
    user_id INTEGER,
    channel_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (channel_id) REFERENCES channel(id)
);

INSERT INTO organization (name) VALUES ('Lambda School');

INSERT INTO user (name) VALUES ('Alice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');

INSERT INTO channel (name) VALUES ('#general');
INSERT INTO channel (name) VALUES ('#random');

INSERT INTO message (content, user_id, post_time, channel_id) VALUES('Message 1', 1, date("now"), 1);
INSERT INTO message (content, user_id, post_time, channel_id) VALUES('Message 2', 2, date("now"),1);
INSERT INTO message (content, user_id, post_time, channel_id) VALUES('Message 3', 3, date("now"),2);
INSERT INTO message (content, user_id, post_time, channel_id) VALUES('Message 4', 2, date("now"),1);
INSERT INTO message (content, user_id, post_time, channel_id) VALUES('Message 5', 3, date("now"),2);
INSERT INTO message (content, user_id, post_time, channel_id) VALUES('Message 6', 1, date("now"),1);
INSERT INTO message (content, user_id, post_time, channel_id) VALUES('Message 7', 1, date("now"),1);
INSERT INTO message (content, user_id, post_time, channel_id) VALUES('Message 8', 2, date("now"),1);
INSERT INTO message (content, user_id, post_time, channel_id) VALUES('Message 9', 3, date("now"),2);
INSERT INTO message (content, user_id, post_time, channel_id) VALUES('Message 10', 1, date("now"),2);

INSERT INTO user_channels (channel_id, user_id) VALUES (1, 1);
INSERT INTO user_channels (channel_id, user_id) VALUES (1, 2);
INSERT INTO user_channels (channel_id, user_id) VALUES (2, 1);
INSERT INTO user_channels (channel_id, user_id) VALUES (3, 2);

-- SELECT DATA --

-- 1
SELECT name FROM organization; 
-- 2
SELECT name FROM channel;
-- 3
SELECT organization.name AS "organization", channel.name AS "channel" FROM channel JOIN organization;
-- 4
SELECT message.content FROM message, channel WHERE channel_id = channel.id and channel.name IS "#general" ORDER BY post_time;
-- 5
SELECT channel.name FROM channel, user, user_channels WHERE user_id = user.id and user_channels.channel_id = channel.id AND user.name = "Alice";
-- 6
SELECT user.name FROM channel, user_channels, user WHERE channel.name = "#general" and user_id = user.id and channel_id = channel.id;
-- 7
SELECT message.content FROM message inner join user WHERE user.id = message.user_id and user.name = "Alice";
-- 8
SELECT message.content, message.user_id FROM message inner join user, channel WHERE message.user_id = user.id AND user.id = 2 AND channel.id = message.channel_id AND channel.name = "#random";
-- 9
SELECT count(message.content) AS "Count", user.name, channel.name AS "Channel" FROM message inner join user, channel WHERE message.user_id = user.id AND message.channel_id = channel.id GROUP BY channel.name, user.name;

-- Answer to last README.md Question
-- What SQL keywords or concept would you use if you wanted to automatically
-- delete all messages by a user if that user were deleted from the `user`
-- table? 
-- ON DELETE CASCADE

