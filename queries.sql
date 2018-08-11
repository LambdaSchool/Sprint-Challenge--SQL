DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS user_channel;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,  
    organization_id INTEGER REFERENCES organization(id),
    name VARCHAR(128) NOT NULL
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id),
    post_time DATETIME NOT NULL,
    content TEXT NOT NULL
);

CREATE TABLE user_channel (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
)

-- One organization, Lambda School
INSERT INTO organization (name) VALUES ("Lambda School");

-- Three users, Alice, Bob, and Chris
INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

-- Two channels, #general and #random
INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

-- 10 messages (at least one per user, and at least one per channel).
INSERT INTO message (content, channel_id, user_id) VALUES ("I'm starving", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("What's for lunch?", 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("Sushiiiiii", 1, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("In n out or Shake Shack?", 2, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("In n out FTW", 2, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("Alice doesn't eat sushi", 1, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("Neither does Bob", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("Chris is allergic to raw fish", 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("Then who the hell said sushi?", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("this channel is haunted!", 1, 3);

-- Alice should be in #general and #random.
INSERT INTO user_channel (channel_id, user_id) VALUES (1, 1);
INSERT INTO user_channel (channel_id, user_id) VALUES (2, 1);

-- Bob should be in #general.
INSERT INTO user_channel (channel_id, user_id) VALUES (1, 2);

-- Chris should be in #random.
INSERT INTO user_channel (channel_id, user_id) VALUES (2, 3);