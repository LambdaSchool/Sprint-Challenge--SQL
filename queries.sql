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
INSERT INTO message (content, channel_id, user_id) VALUES ("Chris is weird.", 1, 1);

-- Alice should be in #general and #random.
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);

-- Bob should be in #general.
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);

-- Chris should be in #random.
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);
