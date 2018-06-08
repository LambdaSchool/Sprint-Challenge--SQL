DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS channel_user;

CREATE TABLE organization (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(128)
);

CREATE TABLE channel (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(128),
	organization_id INTEGER REFERENCES organizaiton(id)
);

CREATE TABLE user (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(128)
);

CREATE TABLE message (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	post_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	content TEXT,
	channel_id INTEGER REFERENCES channel(id),
	user_id INTEGER REFERENCES user(id)
);

CREATE TABLE channel_user (
	channel_id INTEGER REFERENCES channel(id),
	user_id INTEGER REFERENCES user(id)
);

INSERT INTO organization (name) VALUES ("Lambda School"); -- organization id 1

INSERT INTO user (name) VALUES ("Alice"); -- user id 1
INSERT INTO user (name) VALUES ("Bob"); -- user id 2
INSERT INTO user (name) VALUES ("Chris"); -- user id 3

INSERT INTO channel (name, organization_id) VALUES ("#general", 1); -- channel id 1
INSERT INTO channel (name, organization_id) VALUES ("#random", 1); -- channel id 2

INSERT INTO channel_user (channel_id, user_id) VALUES (1, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 2);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 3);


INSERT INTO message (post_time, content, channel_id, user_id)
	VALUES (datetime(), "Hi folks welcome to general", 1, 1);
INSERT INTO message (post_time, content, channel_id, user_id)
	VALUES (datetime(), "Hi Alice, I'm Bob.", 1, 2);
INSERT INTO message (post_time, content, channel_id, user_id)
	VALUES (datetime(), "Hi, Bob.", 1, 1);
INSERT INTO message (post_time, content, channel_id, user_id)
	VALUES (datetime(), "I thought I'd also put in a random channel too", 2, 1);
INSERT INTO message (post_time, content, channel_id, user_id)
	VALUES (datetime(), "Thanks Alice", 2, 3);
INSERT INTO message (post_time, content, channel_id, user_id)
	VALUES (datetime(), "You're welcome, Chris", 2, 1);
INSERT INTO message (post_time, content, channel_id, user_id)
	VALUES (datetime(), "I'm looking forward to many chats", 1, 1);
INSERT INTO message (post_time, content, channel_id, user_id)
	VALUES (datetime(), "Do you have anything random to say, Chris?", 2, 1);
INSERT INTO message (post_time, content, channel_id, user_id)
	VALUES (datetime(), "naw", 2, 3);
INSERT INTO message (post_time, content, channel_id, user_id)
	VALUES (datetime(), "Well, I think those are all the channels that I will add today", 1, 1);

SELECT name FROM organizaiton;
SELECT name FROM channel;

SELECT channel.name, organization.name FROM channel, organization 
	WHERE organization.name = "Lambda School";

SELECT content, name FROM message, channel 
	WHERE name = "#general" AND channel_id = channel.id 
	ORDER BY post_time DESC;
	


