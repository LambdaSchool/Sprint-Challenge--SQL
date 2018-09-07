PRAGMA foreign_keys = ON;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    organization_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64)
    organization_id INTEGER REFERENCES organization(id)

);

CREATE TABLE channel_user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(2056) NOT NULL,
    timestamp DATE DEFAULT (datetime('now', 'localtime'))
    channel_user_id INTEGER REFERENCES channel_user(id)
    channel_id INTEGER REFERENCES channel(id)
);


INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO user (name, organization_id ) VALUES ("Alice", 1);
INSERT INTO user (name, organization_id ) VALUES ("Bob", 1);
INSERT INTO user (name, organization_id ) VALUES ("Chris", 1);

INSERT INTO channel_user (channel_id, user_id) VALUES (1,1);
INSERT INTO channel_user (channel_id, user_id) VALUES (2,1);
INSERT INTO channel_user (channel_id, user_id) VALUES (1,2);
INSERT INTO channel_user (channel_id, user_id) VALUES (2,3);

INSERT INTO message (content, channel_id,  user_id) VALUES ("Alice's post in #general", 1, 1);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Alice's post in #random", 2, 1);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Alice's post in #general again", 1, 1);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Bob's post in #random", 2, 2);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Bob's post in #general", 1, 2);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Bob's post in #general again", 1, 2);
INSERT INTO message (content, channel_id;  user_id) VALUES ("Alice's second post in #random again", 2, 1);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Chris' first post in #random", 2, 3);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Chris' post in #general", 1, 3);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Chris' second post in #random", 2, 3);