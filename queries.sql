PRAGMA foreign_keys = ON; -- SQLite Only!

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,  
  name VARCHAR(128),
  organization_id INTEGER REFERENCES organization(id) -- A channel can belong to one organization
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
);



CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT,
  post_time TIMESTAMP NOT NULL DEFAULT(DATETIME()), 
  user_id INTEGER REFERENCES user(id), --  A user can post messages to a channel
  channel_id INTEGER REFERENCES channel(id)
);

-- A channel can have many users subscribed.
-- A user can be subscribed to many channels.
CREATE TABLE user_channel (
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);

-- 1 organization: Lambda School
INSERT INTO organization (name) VALUES ("Lambda School");

-- 3 users:  Alice, Bob, and Chris
INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

-- 2 channels: #general and #random
INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

-- 10 messages (at least one per user, and at least one per channel).
INSERT INTO message (content, channel_id, user_id) VALUES ("I'm Alice in #general!", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("I'm Bob in #general!", 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("Sweet, let's be frienzies!", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("You betcha!", 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("Hurray!", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("I'm Alice in #random!", 2, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("I'm Chris in #random!", 2, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("You want to be my frienzi too?", 2, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("You betcha!", 2, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("Sweeeet!", 2, 1);

-- Alice should be in #general and #random.
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);

-- Bob should be in #general.
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);

-- Chris should be in #random.
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);

-- List all organization names.
SELECT name FROM organization;

-- List all channel names.
SELECT name FROM channel;

-- List all channels in a specific organization by organization name.
SELECT channel.name AS "Channel Name", organization.name AS "Organization Name"
  FROM channel, organization
  WHERE channel.organization_id = organization.id
  AND organization.name = "Lambda School";

-- List all messages in a specific channel by channel name #general
-- in order of post_time, descending
SELECT message.* FROM message, channel
  WHERE message.channel_id = channel.id
  AND channel.name = "#general"
  ORDER BY message.post_time DESC;

-- List all channels to which user Alice belongs
SELECT channel.* FROM channel, user, user_channel
  WHERE user_channel.channel_id = channel.id
  AND user_channel.user_id = user.id
  AND user.name = "Alice";

-- List all users that belong to channel #general
SELECT user.* FROM channel, user, user_channel
  WHERE user_channel.channel_id = channel.id
  AND user_channel.user_id = user.id
  AND channel.name = "#general";

-- List all messages in all channels by user Alice
SELECT message.* FROM message, user
  WHERE message.user_id = user.id
  AND user.name = "Alice";

-- List all messages in #random by user Bob.
SELECT message.* FROM message, user, channel WHERE message.user_id = user.id
  AND message.channel_id = channel.id
  AND channel.name = "#random"
  AND user.name = "Bob";

-- List the count of messages across all channels per user
SELECT user.name AS "User Name", COUNT(message.content) AS "Message Count"
  FROM user, message
  WHERE message.user_id = user.id
  GROUP BY user.name
  ORDER BY user.name DESC;

