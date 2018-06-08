-- Please note that SQLite syntax will be in use.

.mode column
.header on

PRAGMA foreign_keys = OFF;

DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS user_channel;

PRAGMA foreign_keys = ON;

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  organization_id INTEGER REFERENCES organization(id) ON DELETE CASCADE NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER REFERENCES user(id) ON DELETE CASCADE NOT NULL,
  channel_id INTEGER REFERENCES channel(id) ON DELETE CASCADE NOT NULL,
  content TEXT NOT NULL,
  post_time TEXT NOT NULL
);

CREATE TABLE user_channel (
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);

INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO user_channel (user_id, channel_id)
  VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id)
  VALUES (1, 2);
INSERT INTO user_channel (user_id, channel_id)
  VALUES (2, 1);
INSERT INTO user_channel (user_id, channel_id)
  VALUES (3, 2);

INSERT INTO message (user_id, channel_id, content, post_time)
  VALUES (1, 1, "Hi Bob!", DATETIME("now"));
INSERT INTO message (user_id, channel_id, content, post_time)
  VALUES (2, 1, "Hi Alice!", DATETIME("now"));
INSERT INTO message (user_id, channel_id, content, post_time)
  VALUES (3, 2, "Hello Alice.", DATETIME("now"));
INSERT INTO message (user_id, channel_id, content, post_time)
  VALUES (1, 2, "Hi Chris!", DATETIME("now"));
INSERT INTO message (user_id, channel_id, content, post_time)
  VALUES (1, 1, "Tell me about yourself Bob", DATETIME("now"));
INSERT INTO message (user_id, channel_id, content, post_time)
  VALUES (3, 2, "flurpiderple", DATETIME("now"));
INSERT INTO message (user_id, channel_id, content, post_time)
  VALUES (1, 2, "That was indeed random.", DATETIME("now"));
INSERT INTO message (user_id, channel_id, content, post_time)
  VALUES (3, 2, "Yep.", DATETIME("now"));
INSERT INTO message (user_id, channel_id, content, post_time)
  VALUES (2, 1, "I don't want to do that, Alice.", DATETIME("now"));
INSERT INTO message (user_id, channel_id, content, post_time)
  VALUES (1, 1, "Okay Bob.", DATETIME("now"));

SELECT * FROM organization;
SELECT * FROM channel;
SELECT * FROM channel, organization WHERE channel.organization_id = organization.id;
SELECT * FROM message, channel WHERE message.channel_id = channel.id 
  AND channel.name = "#general" ORDER BY post_time DESC;
SELECT user.name, channel.name FROM user_channel, channel, user WHERE user_channel.user_id = user.id
  AND user_channel.channel_id = channel.id AND user.name = "Alice";
SELECT user.name, channel.name FROM user_channel, user, channel 
  WHERE user_channel.channel_id = channel.id AND user_channel.user_id = user.id
  AND channel.name = "#general";
SELECT * FROM message, user WHERE message.user_id = user.id AND user.name = "Alice";
SELECT * FROM user_channel, channel, message, user 
  WHERE user_channel.user_id = user.id AND user_channel.channel_id = channel.id
  AND message.user_id = user.id AND message.channel_id = channel.id
  AND channel.name = "#random" AND user.name = "Bob"; -- This should return nothing because Bob isn't in #random, and could likely be shortened up quite a bit.
SELECT user.name AS "User Name", COUNT(message.id) AS "Message Count" FROM user, message
  WHERE message.user_id = user.id GROUP BY user.name ORDER BY user.name DESC;

  -- ON DELETE CASCADE is in use in the appropriate tables in order to delete all messages by a user
  -- if that user is deleted.