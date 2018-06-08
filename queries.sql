PRAGMA foreign_keys = ON; -- SQLite Only!

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,  
  name VARCHAR(128),
  organization_id INTEGER REFERENCES organization(id) -- A channel can belong to one organization
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT,
  post_time TIMESTAMP NOT NULL DEFAULT(DATETIME()),
  user_id INTEGER REFERENCES user(id), --  a user can post messages to a channel
  channel_id INTEGER REFERENCES channel(id)
);

-- A channel can have many users subscribed.
-- A user can be subscribed to many channels.
CREATE TABLE user_channel (
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);

-- One organization, Lambda School
INSERT INTO organization (name) VALUES ("Lambda School");

-- Three users, Alice, Bob, and Chris
INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

-- Two channels, #general and #random
INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

-- 10 messages (at least one per user, and at least one per channel).
INSERT INTO message (content, channel_id, user_id) VALUES ("I can't believe it's our last day!", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("Yeah me neith, that's so cray", 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("Right? We'll never talk again", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("I love you", 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("k", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("OMG I can't believe it's our last day..", 2, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("That's so crazy, right?", 2, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("No, it's not crazy at all", 2, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("Time never stops.", 2, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("k", 2, 1);
-- INSERT INTO message (content, channel_id, user_id) VALUES ("Chris is weird.", 1, 1);

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

-- What SQL keywords or concept would you use if you wanted to
-- automatically delete all messages by a user if that user were 
-- deleted from the user table? 
-- by id:
-- DELETE FROM message WHERE message.user_id = 1;

-- OR by subquery:
-- DELETE FROM message 
  -- WHERE EXISTS (SELECT user.id FROM user WHERE message.user_id = user.id AND user.name = "Alice");

-- better answer using WHERE NOT EXISTS:
DELETE FROM message
  WHERE NOT EXISTS(SELECT NULL FROM user WHERE message.user_id = user.id);

-- STRETCH GOAL:
-- List the count of messages per user per channel
SELECT user.name AS "User Name",
  channel.name AS "Channel Name",
  COUNT(*) AS "Message Count"
  FROM user, message, channel
  WHERE message.user_id = user.id
  AND message.channel_id = channel.id
  GROUP BY channel.name, user.name;