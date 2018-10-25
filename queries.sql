DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS user_channel;

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128),
  org_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_time TIMESTAMP NOT NULL DEFAULT(DATETIME()),
  content TEXT NOT NULL,
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE user_channel (
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);

-- Organization
INSERT INTO organization (name) VALUES ("Lambda School");

-- Users
INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

-- Channels
INSERT INTO channel (name, org_id) VALUES ("#general", 1);
INSERT INTO channel (name, org_id) VALUES ("#random", 1);

-- Content
INSERT INTO message (content, user_id, channel_id) VALUES ("@PatrickBot hi", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Ni Hao", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Sat Nam", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Namaste", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Aloha", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Merry New Year!", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Some Text", 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("if (Brain === Mush) coffee++", 1, 3);
INSERT INTO message (content, user_id, channel_id) VALUES ("Next Time!", 2, 3);
INSERT INTO message (content, user_id, channel_id) VALUES ("This Time!", 2, 3);

-- Alice should be in #general and #random
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);

-- Bob should be in #general
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);

-- Chris should be in #random
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);

-- Organization Names
SELECT name FROM organization;

-- Channels in an organization by organization name
SELECT channel.name AS "Channel Name", organization.name AS "Organization Name"
  FROM channel, organization
  WHERE channel.org_id = organization.id
  AND organization.name = "Lambda School";

-- All messages in a specific channel by channel name in order of post_time, descending
SELECT message.* FROM message, channel
  WHERE message.channel_id = channel.id
  AND channel.name = "#general"
  ORDER BY message.post_time DESC;

-- All channels to which user Alice belongs
SELECT channel.* FROM channel, user, user_channel
  WHERE user_channel.channel_id = channel.id
  AND user_channel.user_id = user.id
  AND user.name = "Alice";

-- Users that belong to channel #general
SELECT user.* FROM channel, user, user_channel
  WHERE user_channel.channel_id = channel.id
  AND user_channel.user_id = user.id
  AND channel.name = "#general";

-- All messages in all channels by user Alice
SELECT message.* FROM message, user
  WHERE message.user_id = user.id
  AND user.name = "Alice";

-- All messages in #random by user Bob
SELECT message.* FROM message, user, channel WHERE message.user_id = user.id
  AND message.channel_id = channel.id
  AND channel.name = "#random"
  AND user.name = "Bob";

-- Count of messages across all channels per user
SELECT user.name AS "User Name", COUNT(message.content) AS "Message Count"
  FROM user, message
  WHERE message.user_id = user.id
  GROUP BY user.name
  ORDER BY user.name DESC;

-- What SQL keywords or concept would you use if you wanted to automatically
--   delete all messages by a user if that user were deleted from the `user`
--   table?

-- DELETE FROM message WHERE message.user_id = 1;