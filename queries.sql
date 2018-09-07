PRAGMA foreign_keys = ON;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE
);


CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    post_time DATETIME default current_time,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

--- Join table for users + channels --- 

CREATE TABLE user_channel (
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);



INSERT INTO organization (name) VALUES ('Lambda School');

INSERT INTO user (name) VALUES ('ALice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');

INSERT INTO channel (name, organization_id) VALUES ('#general', 1);
INSERT INTO channel (name, organization_id) VALUES ('#random', 2);

INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 3);

INSERT INTO message (content, user_id, channel_id) VALUES ('Have a great weekend!', 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES (':partypotato:', 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('Ready for Lambda Labs', 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('SQL is too verbose for me', 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('Happy Friday!', 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES (':ultrafastparrot:', 2, 1 );
INSERT INTO message (content, user_id, channel_id) VALUES (':coffeeparrot:', 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('What is the weekly retro topic?', 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES (':lambdareps:', 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('Almost done!', 2, 1);
