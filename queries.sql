PRAGMA foreign_keys = ON;

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
    name VARCHAR(64)
);

CREATE TABLE channel_user (
    id INTEGER PRIMARY KEY AUTOINCREMENT, --included so messages can only be posted to the correct channel/user combo
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id) --might need ON DELETE CASCADE
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    post_time TIMESTAMP default CURRENT_TIMESTAMP,
    channel_user_id INTEGER REFERENCES channel_user(id) --might need ON DELETE CASCADE
);


INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel_user (channel_id, user_id) VALUES (1,1); --Alice in #general
INSERT INTO channel_user (channel_id, user_id) VALUES (1,2); --Bob in #general
INSERT INTO channel_user (channel_id, user_id) VALUES (2,1); --Alice in #random
INSERT INTO channel_user (channel_id, user_id) VALUES (2,3); --Chris in #random

INSERT INTO message (content, channel_user_id) VALUES ("This is Alice posting in #general", 1);
INSERT INTO message (content, channel_user_id) VALUES ("Once again, Alice posting in #general", 1);
INSERT INTO message (content, channel_user_id) VALUES ("For the last time, Alice posting in #general", 1);
INSERT INTO message (content, channel_user_id) VALUES ("This is Bob posting in #general", 2);
INSERT INTO message (content, channel_user_id) VALUES ("Once again, Bob posting in #general", 2);
INSERT INTO message (content, channel_user_id) VALUES ("For the last time, Bob posting in #general", 2);
INSERT INTO message (content, channel_user_id) VALUES ("This is Alice posting in #random", 3);
INSERT INTO message (content, channel_user_id) VALUES ("Once again, Alice posting in #random", 3);
INSERT INTO message (content, channel_user_id) VALUES ("This is Chris posting in #random", 4);
INSERT INTO message (content, channel_user_id) VALUES ("Once again, Chris posting in #random", 4);


-- List all organization names
SELECT * FROM organization;

-- List all channel names
SELECT * FROM channel;

-- List all channels in a specific organization by name
SELECT channel.name, organization.name 
FROM organization, channel 
WHERE channel.organization_id = organization.id 
AND organization.name = "Lambda School";

-- List all messages in a specific channel by channel name #general in order of post_time, descending
SELECT message.content, message.post_time, channel.name 
FROM message, channel, user, channel_user 
WHERE message.channel_user_id = channel_user.id 
AND channel_user.channel_id = channel.id 
AND channel_user.user_id = user.id 
AND channel.name = "#general" 
ORDER BY post_time DESC;

-- List all channels to which user Alice belongs
SELECT channel.* 
FROM channel, user, channel_user 
WHERE channel_user.channel_id = channel.id 
AND channel_user.user_id = user.id 
AND user.name = "Alice";

-- List all users that belong to channel #general
SELECT user.* 
FROM channel, user, channel_user 
WHERE channel_user.channel_id = channel.id 
AND channel_user.user_id = user.id 
AND channel.name = "#general";

-- List all messages in all channels by user Alice
SELECT message.*, channel.name 
FROM message, channel, user, channel_user 
WHERE message.channel_user_id = channel_user.id 
AND channel_user.channel_id = channel.id 
AND channel_user.user_id = user.id 
AND user.name = "Alice";

-- List all messages in #random by user Bob
SELECT message.*, channel.name 
FROM message, channel, user, channel_user 
WHERE message.channel_user_id = channel_user.id 
AND channel_user.channel_id = channel.id 
AND channel_user.user_id = user.id 
AND user.name = "Bob" 
AND channel.name= "#random";

-- List the count of messages across all channels per user
SELECT user.name AS "User Name", COUNT(*) AS "Message Count" 
FROM message, channel, user, channel_user 
WHERE message.channel_user_id = channel_user.id 
AND channel_user.channel_id = channel.id 
AND channel_user.user_id = user.id 
GROUP BY user_id 
ORDER BY user.name DESC;

-- [STRETCH!] List the count of messages per user per channel
SELECT user.name AS "User Name", channel.name AS "Channel", COUNT(*) AS "Message Count" 
FROM message, channel, user, channel_user 
WHERE message.channel_user_id = channel_user.id 
AND channel_user.channel_id = channel.id 
AND channel_user.user_id = user.id 
GROUP BY channel_user.id ;


-- Question: What SQL keywords or concept would you use if you wanted to automatically delete all 
-- messages by a user if that user were deleted from the user table?

-- Answer: Add `ON DELETE CASCADE` to the end of the `message.channel_user` and `channel_user.user_id` line