DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;

CREATE TABLE organization(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(32) NOT NULL
);

CREATE TABLE channel(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL,
    organization_id INTEGER,
    FOREIGN KEY(organization_id) REFERENCES organization(id)
);

CREATE TABLE user(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(16) NOT NULL
);

CREATE TABLE message(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    channel_id INTEGER,
    content TEXT,
    post_time DATETIME NOT NULL,
    FOREIGN KEY(user_id) REFERENCES user(id),
    FOREIGN KEY(channel_id) REFERENCES channel(id)
);

INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO message (user_id, channel_id, post_time, content) VALUES (1, 1, CURRENT_TIMESTAMP, "Hello!");
INSERT INTO message (user_id, channel_id, post_time, content) VALUES (2, 1, CURRENT_TIMESTAMP, "Hey, good morning");
INSERT INTO message (user_id, channel_id, post_time, content) VALUES (1, 1, CURRENT_TIMESTAMP, "What are we doing today?");
INSERT INTO message (user_id, channel_id, post_time, content) VALUES (2, 1, CURRENT_TIMESTAMP, "I think we are free now..");
INSERT INTO message (user_id, channel_id, post_time, content) VALUES (1, 1, CURRENT_TIMESTAMP, "No, we still have Labs!");

INSERT INTO message (user_id, channel_id, post_time, content) VALUES (1, 2, CURRENT_TIMESTAMP, "RIP Anthony Bourdain");
INSERT INTO message (user_id, channel_id, post_time, content) VALUES (3, 2, CURRENT_TIMESTAMP, "Oh wow, I didnt even know he passed away!");
INSERT INTO message (user_id, channel_id, post_time, content) VALUES (1, 2, CURRENT_TIMESTAMP, "Yeah it's so crazy!");
INSERT INTO message (user_id, channel_id, post_time, content) VALUES (3, 2, CURRENT_TIMESTAMP, "Wow, I loved hi shows");
INSERT INTO message (user_id, channel_id, post_time, content) VALUES (1, 2, CURRENT_TIMESTAMP, "Me too man, me too..");

SELECT " ";

SELECT "List all organization names.";
SELECT organization.name from organization;
SELECT " ";

SELECT "List all channel names.";
SELECT channel.name from channel;
SELECT " ";

SELECT "List all channels in a specific organization by organization name.";
SELECT channel.name, organization.name
FROM channel, organization
WHERE channel.organization_id = organization.id
AND organization.name = "Lambda School";
SELECT " ";

SELECT "List all messages in a specific channel by channel name #general in order of post_time, descending.";
SELECT channel.name, user.name, message.content, message.post_time
FROM message, user, channel
WHERE message.user_id = user.id 
AND message.channel_id = channel.id
AND channel.name = "#general"
ORDER BY message.post_time DESC;
SELECT " ";

SELECT "List all channels to which user Alice belongs.";

SELECT " ";

SELECT "List all users that belong to channel #general.";

SELECT " ";

SELECT " List all messages in all channels by user Alice.";

SELECT " ";

SELECT " List all messages in #random by user Bob.";

SELECT " ";

SELECT " List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.)";
