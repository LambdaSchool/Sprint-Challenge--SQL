-- format commands --
PRAGMA foreign_keys = ON;
.header on
.mode column

-- CREATE TABLE Statements --
-- Organization Table --
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT (datetime('now','localtime'))
);

-- Channel Table -- 
CREATE TABLE channel (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   name VARCHAR(64) NOT NULL UNIQUE,
   organization_id INTEGER REFERENCES organization(id),
   created_at DATETIME DEFAULT (datetime('now','localtime'))
);

-- User Table --
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    username VARCHAR(32) NOT NULL UNIQUE,
    created_at DATE DEFAULT (datetime('now','localtime'))
);

-- Message Table --
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
    post_time DATE DEFAULT (datetime('now','localtime')),
    last_modified DATE DEFAULT NULL
);

-- User_Channel Table --
CREATE TABLE user_channel (
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

-- INSERT Queries --
INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name, username) VALUES ("Alice", "alice");
INSERT INTO user (name, username) VALUES ("Bob", "bob");
INSERT INTO user (name, username) VALUES ("Chris", "chris");

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO message (content, channel_id, user_id) VALUES ("content-1", 2, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-2", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-3", 1, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-4", 2, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-5", 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-6", 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-7", 2, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-8", 2, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-9", 2, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-10", 2, 2);

INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);

-- SELECT queries --
-- List all organization names --
SELECT name AS "ORGANIATION NAME(S)" from organization;

-- List all channel names --
SELECT name AS "CHANNEL NAME(S)" from channel;

-- List all channels in a specific organization by organization name --
SELECT channel.name AS "LAMBDA SCHOOL CHANNELS"
FROM channel, organization
WHERE channel.organization_id = organization.id 
AND organization.name = "Lambda School";

-- List all messages in a specific channel by channel name #general in order of post_time, descending --
SELECT content AS "General Messages", post_time FROM message
WHERE channel_id IS (
SELECT id FROM channel WHERE name  IS "#general"
)
ORDER BY post_time DESC;

-- List all channels to which user Alice belongs -- 
SELECT channel.name AS "Alice's Channels" 
FROM channel INNER JOIN user_channel 
ON channel.id IS user_channel.channel_id INNER JOIN user ON user.id IS user_channel.user_id
AND user.name IS "Alice";

-- List all users that belong to channel #general --
SELECT user.name AS "USERS in #general"
FROM user INNER JOIN user_channel
ON user.id IS user_channel.user_id INNER JOIN channel ON channel.id IS user_channel.channel_id
AND channel.name IS "#general";

-- List all messages in all channels by user Alice --
SELECT message.content AS "Alice's Messages"
FROM message INNER JOIN user
ON message.user_id IS user.id
WHERE user.name IS "Alice";

-- List all messages in #random by user Bob --
SELECT content AS "Bob's Messages in #random" FROM message
WHERE channel_id IS (
    SELECT id FROM channel 
    WHERE name IS "#random"
)
AND user_id IS (
    SELECT id FROM user 
    WHERE name IS "Bob"
);

-- List the count of messages across all channels per user --
SELECT user.name AS "User Name", COUNT(user.id) AS "Message Count"
FROM message
INNER JOIN user 
ON message.user_id IS user.id
INNER JOIN channel 
WHERE message.channel_id IS channel.id
GROUP BY user.id
ORDER BY user.name DESC;

/*
What SQL keywords or concept would you use if you wanted to automatically 
delete all messages by a user if that user were deleted from the user table?

ON DELETE CASCADE
*/