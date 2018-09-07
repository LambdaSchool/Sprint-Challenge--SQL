PRAGMA foreign_keys = TRUE;

CREATE TABLE organization(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
);

CREATE TABLE channel(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    organization_id INTEGER REFERENCES organization(id),
);

CREATE TABLE user(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL,
);

CREATE TABLE message(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT NOT NULL,
    post_time TIMESTAMP default datetime('now'),
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
);

CREATE TABLE channel_users (
    channel_id INT REFERENCES user(id),
    user_id INT REFERENCES channel(id)
);

-- CREATE TABLE user_messages (
--     user_id INT REFERENCES user(id),
--     message_id INT REFERENCES message(id)
-- );

-- CREATE TABLE organization_channels (
--     organization_id INT REFERENCES organization(id),
--     channel_id INT REFERENCES channel(id)
-- );

-- CREATE TABLE organization_users (
--     organization_id INT REFERENCES organization(id),
--     user_id INT REFERENCES user(id)
-- );

INSERT INTO organization (name) VALUES ("Lambda School");
INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");
INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 1); --Alice/general
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 2); --Bob/general
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 3); --Chris/general
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 1); --Alice/random
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 2); --Bob/general
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 3); --Chris/general
INSERT INTO message (content, user_id, channel_id) VALUES ("Hi, I'm Alice! This is a general post to my friends.", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hi, I'm Bob! This is a general post to my students.", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hi, I'm Chris! This is a general post to my teachers.", 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hi, I'm Alice! I'm so random, whooo!", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hi, I'm Bob! I'm not random, doodeedoo.", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hi, I'm Chris! I'm just doing this to pass. Heheh.", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hi, I'm Alice! I forgot what message needs to be posted.", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hi, I'm Bob! Gee, SQL is fun, isn't it?", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hi, I'm Chris! Hey, my name really is Chris!", 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hi, I'm Alice! This is message #10!", 1, 2);
SELECT name from organization;
SELECT name from channel;
SELECT organization.name AS "Organization", channel.name AS "Channel" FROM channel JOIN organization;
SELECT message.content AS text, post_time AS time FROM message, channel WHERE message.channel_id = channel.id AND channel.name = "#general" ORDER BY message.post_time DESC;
SELECT channel.name AS "Channel Name", user.name AS user FROM channel JOIN user WHERE user.name = "Alice";
SELECT user.name AS "Username", channel.name AS general FROM channel JOIN user WHERE channel.name = "#general";
SELECT message.content AS text, user.name AS "User", channel.name AS "Channel" FROM message, user, channel WHERE message.user_id = user.id AND user.name = "Alice";
SELECT message.content AS text, user.name AS "User", channel.name AS "Channel" FROM message, user, channel WHERE message.user_id = user.id AND user.name = "Bob" AND channel.name = "#random";
SELECT user.name as "Username", COUNT(messgae.id) AS "Number of messages" FROM message, user WHERE message.user_id = user.id GROUP BY user.name;

-- 6. What SQL keywords or concept would you use if you wanted to automatically
--    delete all messages by a user if that user were deleted from the `user`
--    table?

-- ## ON DELETE CASCADE are the main keywords I would use to delete all messages associated with a given user that was also slated for deletion.