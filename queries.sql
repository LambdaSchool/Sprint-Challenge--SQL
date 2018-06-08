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
    name VARCHAR(128) NOT NULL
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time DATETIME default current_time,
    content VARCHAR(1024),
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE channel_user (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);

INSERT INTO organization (name) VALUES ('Lambda School');

INSERT INTO user (name) VALUES ('Alice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');

INSERT INTO channel (name, organization_id) VALUES ('#general', 1);
INSERT INTO channel (name, organization_id) VALUES ('#random', 1);

INSERT INTO message (content, user_id, channel_id) VALUES ('How much', 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('wood', 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('coulda', 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('woodchuck', 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('chuck', 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('if a', 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('woodchuck', 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('could', 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('chuck', 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('wood', 3, 2);

-- Alice should be in #general and #random.
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);

-- Bob should be in #general.
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);

-- Chris should be in #random.
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);