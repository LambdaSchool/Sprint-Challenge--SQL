
PRAGMA foreign_keys = ON;

-- organization table --
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE
);

-- channel table --
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE
);

-- user table --
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE
);

-- message table --
CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- insert into organization --
INSERT INTO organization (name) VALUES ("Lambda School");

-- insert into user --
INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

-- insert into channel --
INSERT INTO channel (name) VALUES ("#general");
INSERT INTO channel (name) VALUES ("#random");

-- insert into messages --
INSERT INTO messages (content, user_id, channel_id) VALUES ("Fly me to the moon!", 1, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Love for all, hatred for none.", 1, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Change the world by being yourself.", 2, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Every moment is a fresh beginning.", 2, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Never regret anything that made you smile.", 3, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Everything you can imagine is real.", 3, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Simplicity is the ultimate sophistication.", 1, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Reality is wrong, dreams are for real.", 1, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ("And still I rise.", 2, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Turn your wounds into wisdom.", 3, 2);

-- Write SELECT queries to: --

--List all organization names.--
SELECT name from organization;

--List all channel names.--
SELECT name from channel;

--List all channels in a specific organization by organization name.--
SELECT channel.name
FROM channel, organization
WHERE organization_id = organization.id
AND organization.name = "Lambda School";

--List all messages in a specific channel by channel name #general in order of post_time, descending. (Hint: ORDER BY. Because your INSERTs might have all taken place at the exact same time, this might not return meaningful results. But humor us with the ORDER BY anyway.)--
SELECT content
FROM message, channel
WHERE channel_id = channel.id
AND channel.name = "#general"
ORDER BY created DESC;

--List all channels to which user Alice belongs.--
SELECT chennel.name
FROM users, channel, user_channel
WHERE user.id = user_id
AND channel.id = channel_id
AND user.name  = "Alice";

--List all users that belong to channel #general.--
SELECT user.name
FROM user, channel, user_channel
WHERE user.id = user_id
AND channel.id = channel_id
AND channel.name = "#general";

--List all messages in all channels by user Alice.--
SELECT content
FROM message, user
WHERE user_id = user.id
AND user.name = "Alice";

--List all messages in #random by user Bob.--
SELECT content
FROM message, channel, user
WHERE user_id = user.id
AND channel_id = channel.id
AND channel.name = "#random"
AND user.name = "Bob";

--List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.)--
SELECT user.name AS "User", channel.name AS "Channel", COUNT(*)
AS "Message Count"
FROM user, message, channel
WHERE user_id = user.id
AND channel_id = channel.id
GROUP BY channel.name, user.name  

--What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?--
I would try using the ON DELETE CASCADE to automatically delete.





