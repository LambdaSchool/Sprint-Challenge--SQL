CREATE TABLE organization (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(128) NOT NULL UNIQUE, created_at DATETIME DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE channel (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(21) NOT NULL UNIQUE, organization_id INT REFERENCES organization(id));
CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(128) NOT NULL UNIQUE, username VARCHAR(64) NOT NULL UNIQUE);
CREATE TABLE message (id INTEGER PRIMARY KEY AUTOINCREMENT, post_time DATETIME DEFAULT CURRENT_TIMESTAMP, content TEXT, user_id INT REFERENCES user(id), channel_id INT REFERENCES channel(id));
CREATE TABLE user_channel (user_id INT REFERENCES user(id), channel_id INT REFERENCES channel(id));

INSERT INTO organization (name) VALUES ("Lambda School");
INSERT INTO user (name, username) VALUES ("Alice", "Allie");
INSERT INTO user (name, username) VALUES ("Bob", "Robert");
INSERT INTO user (name, username) VALUES ("Chris", "Chris");
INSERT INTO channel (name, organization_id) VALUES ("#general", 1)
INSERT INTO channel (name, organization_id) VALUES ("#random", 1)
INSERT INTO message (content, user_id, channel_id) VALUES ("Last sprint!", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("So unmotivated", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hard to come up with messages", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Caffeine is less effective", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Have you ever tried SQL triggers?", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("I've been thinking about trying them.", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Though I really just want to get my Django front-end to work", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Kitten wants out the apartment", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Your cat always wants to escape!", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Pretty much.", 1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 1);

SELECT name FROM organization;
SELECT name FROM channel;
SELECT channel.name from channel, organization WHERE organization_id = organization.id AND organization.name = "Lambda School"
SELECT content FROM message, channel WHERE channel_id = channel.id AND channel.name = "#general" ORDER BY post_time DESC;
SELECT channel.name FROM channel, user_channel, user WHERE channel_id = channel.id AND user_id = user.id AND user.name = "Alice";
SELECT user.name, message.content FROM user, message WHERE message.user_id = user.id AND user.name = "Alice";
SELECT user.name FROM user, user_channel, channel WHERE user_id = user.id AND channel_id = channel.id AND channel.name = "#general";
SELECT content FROM message, channel, user WHERE user_id = user.id AND channel_id = channel.id AND channel.name = "#random" AND user.name = "Bob";
SELECT user.name as "User Name", COUNT(*) AS "Message Count" FROM user, message WHERE user_id = user.id GROUP BY user.id ORDER BY user.name DESC;
SELECT user.name AS "User", channel.name AS "Channel", Count(*) AS "Message Count" FROM user, message, channel WHERE user_id = user.id AND channel_id = channel.id GROUP BY channel.name, user.name;

/* I would use ON DELETE CASCADE to ensure messages by a user were automatically deleted if a user were deleted from the user table. */
