PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;

CREATE TABLE organization (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		name VARCHAR(128) NOT NULL
		channel_id INT REFERENCES channel(id)
);

CREATE TABLE channel (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
		organization_id INT REFERENCES organization(id)
);

CREATE TABLE user (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
		channel_id INT REFERENCES channel(id),
);

CREATE TABLE message (
		id INTEGER PRIMARY KEY AUTOINCREMENT
		content TEXT,
		post_time TIMESTAMP NOT NULL DEFAULT(DATETIME())
		user_id INT REFERENCES user(id)
		channel_id INT REFERENCES channel(id)
);

CREATE TABLE channel_user (
	  channel_id INT REFERENCES channel(id)
		user_id INT REFERENCES user(id)
);

INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO message (content, user_id, channel_id) VALUES ("Welcome to the 
Lambda School online chat message system!", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Beej is an aweso
teacher and cs7 will miss him" (1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("This is an amazing
chat message system", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Yeah all the teachers
at Lambda have been good", 1, 2); 		
INSERT INTO message (content, user_id, channel_id) VALUES ("Sean is my favorite teacher", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Can not believe that this is our last official class before capstones", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Yeah these past six months have just flown by", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Yes, that is true. It does not feel like it has though", 2, 3);
INSERT INTO message (content, user_id, channel_id) VALUES ("Luckily we still have another month together so do not get all nostalgic yet", 2, 3);
INSERT INTO message (content, user_id, channel_id) VALUES ("Yeah, I really did enjoy Beej and Sean especially as teachers", 1, 2);

INSERT INTO channel_user (channel_id, user_id) VALUES (1, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 2);

INSERT INTO channel_user (channel_id, user_id) VALUES (2, 1);

INSERT INTO channel_user (channel_id, user_id) VALUES (3, 2);

SELECT name FROM organization;

SELECT name FROM channel;

SELECT organization.name AS "Organization", channel.name AS "Channel" FROM channel JOIN organization;

SELECT message.* FROM message, channel WHERE message.channel_id = channel.id AND channel.name = "#general" ORDER BY message.post_time DESC;

SELECT channel.* FROM channel, user, channel_user WHERE user_channel.channel_id = channel.id AND user_channel.user_id = user.id AND user.name = "Alice";

SELECT user.* FROM channel, user, user_channel WHERE user_channel.channel_id = channel.id AND user_channel.user_id = user.id AND channel.name = "#general";

SELECT message.* FROM message, user WHERE message.user_id = user.id AND user.name = "Alice";

SELECT message.* FROM message, user, channel WHERE message.user_id = user.id AND message.channel_id = channel.id AND channel.name = "#random" AND user.name = "Bob";

SELECT user.name AS "User Name", COUNT(message.content) AS "Message Count" FROM user, message WHERE message.user_id = user.id GROUP BY user.name ORDER BY user.name DESC;
