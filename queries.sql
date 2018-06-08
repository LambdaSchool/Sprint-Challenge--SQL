DROP TABLE organization;
DROP TABLE user;
DROP TABLE channel;
DROP TABLE user_channel;
DROP TABLE message;

CREATE TABLE organization (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(128) NOT NULL
);

CREATE TABLE channel (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(128) NOT NULL,
	organization_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(128) NOT NULL
);

CREATE TABLE user_channel (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	user_id INTEGER REFERENCES user(id),
	channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE message (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	post_time DEFAULT(datetime()),
	content VARCHAR(1024) NOT NULL,
	user_id INTEGER REFERENCES user(id),
	channel_id INTEGER REFERENCES channel(id)
);

-- INSERT queries
-- One organization, `Lambda School`
INSERT INTO organization (name) VALUES ('Lambda School');
-- Three users, `Alice`, `Bob`, and `Chris`
INSERT INTO user (name) VALUES ('Alice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');
-- Two channels, `#general` and `#random`
INSERT INTO channel (name) VALUES ('#general');
INSERT INTO channel (name) VALUES ('#random');
-- 10 messages (at least one per user, and at least one per channel).
INSERT INTO message (content, user_id, channel_id) 
	VALUES ('Hello, I am user 1', 1, 1);
INSERT INTO message (content, user_id, channel_id) 
	VALUES ('Hello, I am user 2', 2, 1);
INSERT INTO message (content, user_id, channel_id) 
	VALUES ('Hello, I am user 3', 3, 1);
INSERT INTO message (content, user_id, channel_id) 
	VALUES ('Hello, I am user 1', 1, 1);
INSERT INTO message (content, user_id, channel_id) 
	VALUES ('Hello, I am user 1', 1, 2);
INSERT INTO message (content, user_id, channel_id) 
	VALUES ('Hello, I am user 1', 1, 3);
INSERT INTO message (content, user_id, channel_id) 
	VALUES ('Hello, I am user 2', 2, 1);
INSERT INTO message (content, user_id, channel_id) 
	VALUES ('Hello, I am user 2', 2, 2);
INSERT INTO message (content, user_id, channel_id) 
	VALUES ('Hello, I am user 2', 2, 3);

--`Alice` should be in `#general` and `#random`.	
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);

-- `Bob` should be in `#general`.
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);

-- `Chris` should be in `#random`.
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);

-- SELECT queries
-- List all organization `name`s.
SELECT name FROM organization;

-- List all channel `name`s.
SELECT name FROM channel;

-- List all channels in a specific organization by organization `name`.
SELECT * FROM channel, organization
	WHERE channel.organization_id = organization.id
	AND organization.name = "Lambda School";

-- List all messages in a specific channel by channel `name` `#general` in
-- order of `post_time`, descending. (Hint: `ORDER BY`. Because your
-- `INSERT`s might have all taken place at the exact same time, this might
-- not return meaningful results. But humor us with the `ORDER BY` anyway.)
SELECT * FROM message, channel 
	WHERE message.channel_id = channel.id
	AND channel.name = '#general'
	ORDER BY message.post_time DESC;

-- List all channels to which user `Alice` belongs.
SELECT * FROM channel, user, user_channel
	WHERE user_channel.channel_id = channel_id
	AND user_channel.user_id = user.id
	WHERE user.name = 'Alice';

-- List all users that belong to channel `#general`.
SELECT * FROM user, channel, user_channel 
	WHERE user_channel.channel_id = channel_id
	AND user_channel.user_id = user.id
	AND channel.name = "#general";

-- List all messages in all channels by user `Alice`.
SELECT * FROM message, user 
	WHERE message.user_id = user.id AND user.id = 1;

-- List all messages in `#random` by user `Bob`.
SELECT * FROM message, user, channel 
  WHERE message.user_id = user.id 
  AND channel.name = "#random" 
  AND user.name = "Bob";

-- List the count of messages across all channels per user. (Hint:










