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
	org_id REFERENCES organization(id)
);

CREATE TABLE user (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(128)
);

CREATE TABLE message (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	post_time DATETIME,
	content VARCHAR(1024) NOT NULL,
	channel_id REFERENCES channel(id),
	user_id REFERENCES user(id)
);

CREATE TABLE channel_user (
	user_id REFERENCES user(id),
	channel_id REFERENCES channel(id)
);

INSERT INTO organization (name) VALUES ("Lambda School");
INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel (name, org_id) VALUES ("#general", 1);
INSERT INTO channel (name, org_id) VALUES ("#random", 1);

INSERT INTO message (content, post_time, channel_id, user_id)
		 VALUES("This is Alice's first message in #general.", datetime(), 1, 1);
INSERT INTO message (content, post_time, channel_id, user_id)
		 VALUES ("This is Alice's first message in #random.", datetime(), 2, 1);
INSERT INTO message (content, post_time, channel_id, user_id)
		 VALUES ("This is Alice's second message in #general.", datetime(), 1, 1);
INSERT INTO message (content, post_time, channel_id, user_id)
		 VALUES ("This is Bob's first message in #general.", datetime(), 1, 2);
INSERT INTO message (content, post_time, channel_id, user_id)
		 VALUES ("This is Bob's second message in #general.", datetime(), 1, 2);
INSERT INTO message (content, post_time, channel_id, user_id)
		 VALUES ("This is Chris's first message in #random.", datetime(), 2, 3);
INSERT INTO message (content, post_time, channel_id, user_id)
		 VALUES ("This is Chris's first message in #general.", datetime(), 1, 3);
INSERT INTO message (content, post_time, channel_id, user_id)
		VALUES ("This is Chris's second message in #random.", datetime(), 2, 3);
INSERT INTO message (content, post_time, channel_id, user_id)
		VALUES ("This is Alice's third message in #general.", datetime(), 1, 1);
INSERT INTO message (content, post_time, channel_id, user_id)
		VALUES ("This is Bob's first message in #random.", datetime(), 2, 2);

INSERT INTO channel_user (user_id, channel_id) VALUES (1, 1);
INSERT INTO channel_user (user_id, channel_id) VALUES (1, 2);
INSERT INTO channel_user (user_id, channel_id) VALUES (2, 1);
INSERT INTO channel_user (user_id, channel_id) VALUES (3, 2);

SELECT name AS Organization_Name from organization;

SELECT name AS Channel_Name from channel;

SELECT organization.name AS Organization, channel.name AS Channel FROM channel JOIN organization WHERE organization.name = 'Lambda School';

SELECT channel.name, message.content FROM channel JOIN message WHERE channel.name = '#general' AND message.channel_id = channel.id ORDER BY post_time DESC;

SELECT channel.name AS Alices_Channels FROM channel, channel_user, user WHERE channel_user.user_id = user.id AND channel_user.channel_id = channel.id AND user.name = 'Alice';

SELECT user.name AS general_users FROM user, channel_user, channel WHERE channel_user.channel_id = channel.id AND channel_user.user_id = user.id AND channel.name = '#general';

SELECT * FROM message, user WHERE user.name = 'Alice' AND message.user_id = user.id;

SELECT * FROM message, user, channel WHERE message.channel_id = channel.id AND message.user_id = user.id AND user.name = 'Bob' AND channel.name = '#random';

SELECT user.name AS "User Name", COUNT(message.content) AS "Message Count" FROM message, user WHERE user.id = message.user_id GROUP BY message.user_id ORDER BY user.name DESC;


-- ON DELETE CASCADE in the message schema
