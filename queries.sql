PRAGMA foreign_keys = ON;
-- TABLES --

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  channel INTEGER,
  FOREIGN KEY(channel) REFERENCES channel(id)
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  organization INTEGER,
  FOREIGN KEY(organization) REFERENCES organization(id)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_time TIMESTAMP NOT NULL DEFAULT(datetime()),
  content TEXT,
  user INTEGER,
  channel INTEGER,
  FOREIGN KEY(user) REFERENCES user(id),
  FOREIGN KEY(channel) REFERENCES channel(id)
);

CREATE TABLE channel_joins (
  channel_id INTEGER REFERENCES channel(id),
  user_id INTEGER REFERENCES user(id)
);

-- INSERT --

INSERT INTO organization (name) VALUES ('Lambda School');

INSERT INTO user (name) VALUES ('Alice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');

INSERT INTO channel (name, organization) VALUES ('#general', 1);
INSERT INTO channel (name, organization) VALUES ('#random', 1);

INSERT INTO message (content, user, channel) VALUES('these are all the same...kinda 1', 1, 1);
INSERT INTO message (content, user, channel) VALUES('these are all the same...kinda 2', 3, 2);
INSERT INTO message (content, user, channel) VALUES('these are all the same...kinda 3', 2, 2);
INSERT INTO message (content, user, channel) VALUES('these are all the same...kinda 4', 3, 1);
INSERT INTO message (content, user, channel) VALUES('these are all the same...kinda 5', 1, 1);
INSERT INTO message (content, user, channel) VALUES('these are all the same...kinda 6', 1, 1);
INSERT INTO message (content, user, channel) VALUES('these are all the same...kinda 7', 1, 1);
INSERT INTO message (content, user, channel) VALUES('these are all the same...kinda 8', 1, 1);
INSERT INTO message (content, user, channel) VALUES('these are all the same...kinda 9', 1, 1);
INSERT INTO message (content, user, channel) VALUES('these are all the same...kinda 0', 1, 1);

INSERT INTO channel_joins (channel_id, user_id) VALUES (1, 1);
INSERT INTO channel_joins (channel_id, user_id) VALUES (1, 2);

INSERT INTO channel_joins (channel_id, user_id) VALUES (2, 1);

INSERT INTO channel_joins (channel_id, user_id) VALUES (2, 3);

-- SELECT--

SELECT name FROM organization;

SELECT name FROM channel;

SELECT organization.name AS "organization", 
channel.name AS "channel" FROM channel 
join organization;

SELECT message.content FROM message, 
channel WHERE message.channel IS channel.id AND channel.name IS "#general" 
ORDER BY post_time;

SELECT user.name AS "User Name", COUNT (message.content) AS "Message Count" FROM message, 
user WHERE message.user = user.id GROUP BY user.id ORDER BY user.name DESC;

-- Question --

--  What SQL keywords or concept would you use if you wanted to automatically
--  delete all messages by a user if that user were deleted from the `user`
--  table?

-- Answer --

-- ON DELETE CASCADE