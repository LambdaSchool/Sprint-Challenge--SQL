PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS user_channel;

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  organization_id INTEGER REFERENCES organization(id),
  name VARCHAR(128) NOT NULL
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT NOT NULL,
  post_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  channel_id INTEGER REFERENCES channel(id),
  user_id INTEGER REFERENCES user(id)
);

CREATE TABLE user_channel (
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);

INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel (organization_id, name) VALUES (1, "#general");
INSERT INTO channel (organization_id, name) VALUES (1, "#random");

INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);

INSERT INTO message (content, channel_id, user_id) VALUES ("Message 1", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message 2", 2, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message 3", 1, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message 4", 2, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message 5", 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message 6", 2, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message 7", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message 8", 2, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message 9", 1, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("Message 10", 2, 1);

-- List all organization names
SELECT name FROM organization;

-- List all channel names
SELECT name FROM channel;

-- List all channels in a specific organization by organization name
SELECT channel.name FROM channel, organization 
  WHERE channel.organization_id = organization.id 
  AND organization.name IS "Lambda School";

-- List all messages in a specific channel by channel name #general in order of post_time, descending.
SELECT message.content FROM message, channel 
  WHERE message.channel_id = channel.id
  AND channel.name IS "#general" 
  ORDER BY message.post_time DESC;

-- List all channels to which user Alice belongs
SELECT channel.name FROM channel, user, user_channel
  WHERE user_channel.channel_id = channel.id
  AND user_channel.user_id = user.id
  AND user.name is "Alice";

-- List all users that belong to channel #general
SELECT user.name FROM user, channel, user_channel
  WHERE user_channel.channel_id = channel.id
  AND user_channel.user_id = user.id
  AND channel.name IS "#general";

-- List all messages in all channels by user Alice
SELECT message.content FROM message, user 
  WHERE message.user_id = user.id 
  AND user.name IS "Alice";

-- List all messages in #random by user Bob
SELECT message.content FROM message, user, channel 
  WHERE message.user_id = user.id 
  AND channel_id = channel.id
  AND channel.name = "#random" 
  AND user.name IS "Bob";

-- List the count of messages across all channels per user
SELECT user.name AS "User Name", COUNT(message.content) AS "Message Count"
  FROM user, message
  WHERE message.user_id = user.id
  GROUP BY user.name
  ORDER BY user.name DESC;