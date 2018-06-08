PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;

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
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 2);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (3, 2);
