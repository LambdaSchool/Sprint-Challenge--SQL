PRAGMA foreign_keys = OFF;

DROP TABLE IF EXISTS channel_user;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS user;

PRAGMA foreign_keys = ON;

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
    name VARCHAR(64) NOT NULL
);

CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(2048) NOT NULL,
    post_time DATETIME default current_timestamp,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE channel_user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    channel_id INT REFERENCES channel(id),
    user_id INT REFERENCES user(id)
);

-- CREATE TABLE user_messages (
--     user_id INT REFERENCES user(id),
--     message_id INT REFERENCES (id)
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

INSERT INTO messages (content, user_id, channel_id) VALUES ("Hi, I'm Alice! This is a general post to my friends.", 1, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Hi, I'm Bob! This is a general post to my students.", 2, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Hi, I'm Chris! This is a general post to my teachers.", 3, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Hi, I'm Alice! I'm so random, whooo!", 1, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Hi, I'm Bob! I'm not random, doodeedoo.", 2, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Hi, I'm Chris! I'm just doing this to pass. Heheh.", 3, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Hi, I'm Alice! I forgot what  needs to be posted.", 1, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Hi, I'm Bob! Gee, SQL is fun, isn't it?", 2, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Hi, I'm Chris! Hey, my name really is Chris!", 3, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("Hi, I'm Alice! This is  #10!", 1, 2);

SELECT name from organization;
SELECT name from channel;

SELECT organization.name AS "Organization", channel.name AS "Channel" FROM channel JOIN organization;
SELECT messages.content, post_time FROM messages, channel WHERE messages.channel_id = channel.id AND channel.name = "#general" ORDER BY messages.post_time DESC;
SELECT channel.name, user.name FROM channel JOIN user WHERE user.name = "Alice";
SELECT user.name AS Username, channel.name AS General FROM channel JOIN user WHERE channel.name="#general";
SELECT messages.content, user.name AS user, channel.name FROM messages, user, channel WHERE message.user_id = user.id AND user.name = "Alice";
SELECT messages.content, user.name AS user, channel.name FROM messages, user, channel WHERE messages.user_id = user.id AND user.name = "Bob" AND channel.name = "#random";
SELECT user.name, COUNT(messages.id) FROM messages, user WHERE messages.user_id = user.id GROUP BY user.name;

-- 6. What SQL keywords or concept would you use if you wanted to automatically
--    delete all messages by a user if that user were deleted from the `user`
--    table?

-- ## ON DELETE CASCADE are the main keywords I would use to delete all messages associated with a given user that was also slated for deletion.