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

INSERT INTO organization (name) VALUES ('Lambda School');

INSERT INTO user (name) VALUES ('Alice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');

INSERT INTO channel (name, organization_id) VALUES ('#general', 1);
INSERT INTO channel (name, organization_id) VALUES ('#random', 1);

INSERT INTO message (content, user_id, channel_id) VALUES ('How much', 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('wood', 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('coulda', 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('woodchuck', 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('chuck', 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('if a', 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('woodchuck', 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('could', 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('chuck', 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('wood', 3, 2);

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
