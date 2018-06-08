PRAGMA foreign_keys = ON;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    org_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE channel_user (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(1024) NOT NULL,
    post_time DATETIME NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime')),
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);


INSERT INTO organization (name) VALUES ("Lambda School");
INSERT INTO channel (name, org_id) VALUES ("#general", 1);
INSERT INTO channel (name, org_id) VALUES ("#random", 1);
INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO message (content, user_id, channel_id)
    VALUES ("hi!", 1, 1);
INSERT INTO message (content, user_id, channel_id)
    VALUES ("hi, Alice!", 2, 1);
INSERT INTO message (content, user_id, channel_id)
    VALUES ("how you doing, Bob?", 1, 1);
INSERT INTO message (content, user_id, channel_id)
    VALUES ("It's too early!", 2, 1);
INSERT INTO message (content, user_id, channel_id)
    VALUES ("hi!", 3, 2);
INSERT INTO message (content, user_id, channel_id)
    VALUES ("hey there, Chris!", 1, 2);
INSERT INTO message (content, user_id, channel_id)
    VALUES ("It's a beautiful day here", 3, 2);
INSERT INTO message (content, user_id, channel_id)
    VALUES ("Oh, where are you?", 1, 2);
INSERT INTO message (content, user_id, channel_id)
    VALUES ("Of course I'm in CA!", 3, 2);
INSERT INTO message (content, user_id, channel_id)
    VALUES ("Going to go take a nap!", 2, 1);

INSERT INTO channel_user (channel_id, user_id) VALUES (1, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 2);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 3);


SELECT name FROM organization;
SELECT name FROM channel;
SELECT name AS Lambda_School_Channels FROM channel WHERE org_id = 1;
SELECT post_time, user.name, content FROM message, user
    WHERE channel_id = 1
    AND message.user_id = user.id
    ORDER BY post_time;
SELECT channel.name AS channels_Alice_is_in 
    FROM channel LEFT JOIN channel_user
    WHERE channel.id = channel_user.channel_id
    AND channel_user.user_id = 1;
SELECT user.name AS users_in_general 
    FROM user LEFT JOIN channel_user
    WHERE user.id = channel_user.user_id
    AND channel_user.channel_id = 1;
SELECT user.name, post_time, content, channel.name
    FROM user, message, channel
    WHERE message.user_id = 1
    AND message.channel_id = channel.id
    AND user.name = "Alice"
    ORDER BY post_time;

-- Bob is not in random, so does not show
SELECT post_time, content
    FROM message
    WHERE message.user_id = 2
    AND message.channel_id = 2;

SELECT user.name AS "User Name", COUNT(message.id) AS "Message Count"
    FROM user, message
    WHERE message.user_id = user.id
    GROUP BY user.id 
    ORDER BY user.id DESC;

SELECT user.name AS User, channel.name AS Channel, COUNT(message.id) AS "Message Count"
    FROM user, channel, message, channel_user
    WHERE message.user_id = user.id
    AND message.channel_id = channel.id
    AND user.id = channel_user.user_id
    AND channel.id = channel_user.channel_id
    GROUP BY channel.name, user.id;

-- you would use the DELETE keyword, but in this order:
-- you'd first look and see which channels that user was in
-- then, go delete the messages that user posted in that channel
-- then delete that user/channel connection
-- repeat for each channel
