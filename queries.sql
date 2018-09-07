PRAGMA foreign_keys = ON;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    organization_id INTEGER REFERENCES organization(id),
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64),
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
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