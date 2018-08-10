CREATE TABLE organization (
	organization_name VARCHAR(128) NOT NULL,
	id INTEGER PRIMARY KEY AUTOINCREMENT
);


CREATE TABLE channel (
	channel_name VARCHAR(128) NOT NULL,
	organization_id INT REFERENCES organization(id),
	id INTEGER PRIMARY KEY AUTOINCREMENT
);

CREATE TABLE user (
        user_name VARCHAR(128) NOT NULL,
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        creation_date TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE message (
        message_content VARCHAR(128) NOT NULL,
        user_id INT REFERENCES user(id),
	channel_id INT REFERENCES channel(id),
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        post_time TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE join_channel_user (
	user_id INT NOT NULL,
	channel_id INT NOT NULL,
	PRIMARY KEY(user_id, channel_id)
);

CREATE TABLE join_channel_organization (
	organization_id INT NOT NULL,
	channel_id INT NOT NULL,
	PRIMARY KEY(organization_id, channel_id)
);

INSERT INTO organization(organization_name) VALUES ("Lambda School");
INSERT INTO user(user_name) VALUES ("Alice");
INSERT INTO user(user_name) VALUES ("Bob");
INSERT INTO user(user_name) VALUES ("Chris");
INSERT INTO channel(channel_name) VALUES ("#general");
INSERT INTO channel(channel_name) VALUES ("#random");
INSERT INTO message(message_content, user_id, channel_id) VALUES ("First Message", 1, 1);
INSERT INTO message(message_content, user_id, channel_id) VALUES ("Second Message", 1, 2);
INSERT INTO message(message_content, user_id, channel_id) VALUES ("Third Message", 2, 1);
INSERT INTO message(message_content, user_id, channel_id) VALUES ("Fourth Message", 2, 2);
INSERT INTO message(message_content, user_id, channel_id) VALUES ("Fifth Message", 3, 1);
INSERT INTO message(message_content, user_id, channel_id) VALUES ("Sixth Message", 3, 2);
INSERT INTO message(message_content, user_id, channel_id) VALUES ("Seventh Message", 1, 1);
INSERT INTO message(message_content, user_id, channel_id) VALUES ("Eigth Message", 1, 2);
INSERT INTO message(message_content, user_id, channel_id) VALUES ("Ninth Message", 2, 1);
INSERT INTO message(message_content, user_id, channel_id) VALUES ("Tenth Message", 2, 2);
INSERT INTO join_channel_user (user_id, channel_id) VALUES (1, 1);
INSERT INTO join_channel_user (user_id, channel_id) VALUES (2, 1);
INSERT INTO join_channel_user (user_id, channel_id) VALUES (3, 2);
INSERT INTO join_channel_user (user_id, channel_id) VALUES (1, 2);


SELECT organization_name from organization;
SELECT channel_name from channel;
SELECT organization_name from organization;
SELECT * from channel WHERE organization_id = (SELECT id from organization WHERE organization_name = "Lambda School");
SELECT * from channel join organization on channel.organization_id = organization.id;
SELECT * FROM message where channel_id = (SELECT id from channel where channel_name = "#general") ORDER BY post_time ;
SELECT * FROM message join channel on message.channel_id = channel.id where channel.channel_name = "#general" ORDER BY post_time DESC ;
SELECT * FROM channel WHERE id in (SELECT channel_id FROM join_channel_user where user_id = (SELECT id FROM user WHERE user_name = "Alice"));
SELECT * from channel join join_channel_user on join_channel_user.channel_id = channel.id join user on user.id = join_channel_user.user_id where user.user_name = "Alice"; 
SELECT * FROM user where id in (SELECT user_id FROM join_channel_user where channel_id = (select id from channel where channel_name = "#general"));
SELECT * FROM user join join_channel_user on join_channel_user.user_id = user.id join channel on channel.id = join_channel_user.channel_id where channel.channel_name = "#general";
SELECT * FROM message where user_id = (select id from user where user_name = "Alice");
SELECT * from message join user on message.user_id = user.id where user.user_name = "Alice";
SELECT * from message join user on message.user_id = user.id join channel on channel.id = message.channel_id where channel.channel_name = "#random" AND user.user_name = "Bob";
SELECT count(message.id) as "Message Count", user.user_name as "User Name" from message join user on message.user_id = user.id join channel on channel.id = message.channel_id where channel.channel_name = "#random" AND user.user_name = "Bob";

