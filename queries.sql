PRAGMA foreign_keys = ON;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    organization_id INTEGER REFERENCES organization(id) --might need ON DELETE CASCADE
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64)
);

CREATE TABLE channel_user (
    id INTEGER PRIMARY KEY AUTOINCREMENT, --included so messages can only be posted to the correct channel/user combo
    channel_id INTEGER REFERENCES channel(id), --might need ON DELETE CASCADE
    user_id INTEGER REFERENCES user(id) --might need ON DELETE CASCADE
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    post_time TIMESTAMP default CURRENT_TIMESTAMP, --might need some tweeking
    channel_user_id INTEGER REFERENCES channel_user(id) --might need ON DELETE CASCADE
);


INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel_user (channel_id, user_id) VALUES (1,1); --Alice in #general
INSERT INTO channel_user (channel_id, user_id) VALUES (1,2); --Bob in #general
INSERT INTO channel_user (channel_id, user_id) VALUES (2,1); --Alice in #random
INSERT INTO channel_user (channel_id, user_id) VALUES (2,3); --Chris in #random

INSERT INTO message (content, channel_user_id) VALUES ("This is Alice posting in #general", 1);
INSERT INTO message (content, channel_user_id) VALUES ("Once again, Alice posting in #general", 1);
INSERT INTO message (content, channel_user_id) VALUES ("For the last time, Alice posting in #general", 1);
INSERT INTO message (content, channel_user_id) VALUES ("This is Bob posting in #general", 2);
INSERT INTO message (content, channel_user_id) VALUES ("Once again, Bob posting in #general", 2);
INSERT INTO message (content, channel_user_id) VALUES ("For the last time, Bob posting in #general", 2);
INSERT INTO message (content, channel_user_id) VALUES ("This is Alice posting in #random", 3);
INSERT INTO message (content, channel_user_id) VALUES ("Once again, Alice posting in #random", 3);
INSERT INTO message (content, channel_user_id) VALUES ("This is Chris posting in #random", 4);
INSERT INTO message (content, channel_user_id) VALUES ("Once again, Chris posting in #random", 4);