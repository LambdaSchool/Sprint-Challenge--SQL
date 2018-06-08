.mode column
.header on

PRAGMA foreign_keys = ON;

-- Write CREATE TABLE statements for tables organization, channel, user, and message
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    organization_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    content VARCHAR(1024),
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE user_channel (
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);


-- Write INSERT queries to add information to the database.

-- One organization, Lambda School
INSERT into organization (name) VALUES ("Lambda School");

-- Three users, Alice, Bob, and Chris
INSERT into user (name) VALUES ("Alice");
INSERT into user (name) VALUES ("Bob");
INSERT into user (name) VALUES ("Chris");

-- Two channels, #general and #random
INSERT into channel (name) VALUES ("#general");
INSERT into channel (name) VALUES ("#random");

-- Two channels, #general and #random
INSERT INTO message (content, user_id, channel_id) VALUES("Alice posted a message in #general", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Alice posted a message in #random.", 1, 2);

INSERT INTO message (content, user_id, channel_id) VALUES ("Bob posted a message in #general", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Bob posted a message in #random", 2, 2);

INSERT INTO message (content, user_id, channel_id) VALUES ("Chris posted a message in #general", 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Chris posted a message in #random", 3, 2);

-- Alice should be in #general and #random.
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);

-- Bob should be in #general.
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);

-- Chris should be in #random.
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);



-- Write SELECT queries.

-- List all organization names
SELECT name AS Organizations from organization;

-- List all channel names.
SELECT name AS Channels from channel;

-- List all channels in a specific organization by organization name.
SELECT organization.name AS Organization, channel.name AS Channel FROM channel JOIN organization WHERE organization.name = "Lambda School";

-- List all messages in a specific channel by channel name #general in order of post_time, descending.
SELECT channel.name, message.content FROM channel JOIN message WHERE channel.name = "#general" AND message.channel_id = channel.id ORDER BY post_time DESC;

-- List all channels to which user Alice belongs.
SELECT channel.name AS Alices_Channels FROM channel, user_channel, user WHERE user_channel.user_id = user.id AND user_channel.channel_id = channel.id AND user.name = "Alice";

-- List all users that belong to channel #general.
SELECT user.name AS "#generals_users" FROM user, user_channel, channel WHERE user_channel.channel_id = channel.id AND user_channel.user_id = user.id AND channel.name = "#general";

-- List all messages in all channels by user Alice.
SELECT * FROM message, user WHERE user.name = "Alice" AND message.user_id = user.id;

-- List all messages in #random by user Bob.
SELECT * FROM message, user, channel WHERE message.channel_id = channel.id AND message.user_id = user.id AND user.name = "Bob" AND channel.name = "#random";

-- List the count of messages across all channels per user.
SELECT user.name AS "User Name", COUNT(message.content) AS "Message Count" FROM message, user WHERE user.id = message.user_id GROUP BY message.user_id ORDER BY user.name DESC;
