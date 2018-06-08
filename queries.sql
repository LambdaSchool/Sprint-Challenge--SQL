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
    post_time DATETIME default (datetime(current_time),
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

INSERT INTO message (content, user_id, channel_id) VALUES ('Hi', 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Sup', 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Ohai', 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('Yahello', 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Howdy do?', 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Heyo', 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('Greetings', 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('See ya', 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Salutations', 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('Ciao', 3, 2);

