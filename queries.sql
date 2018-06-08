PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS messages;

CREATE TABLE organization (
    organization_id INTEGER NOT NULL,
    organization_name VARCHAR(128),
    PRIMARY KEY(ID)
);

CREATE TABLE channels (
     channels_id INTEGER NOT NULL,
     channels_name VARCHAR(128) NOT NULL,
     PRIMARY KEY(ID)
);

CREATE TABLE users (
     users_id INTEGER NOT NULL,
     users_name VARCHAR(128) NOT NULL,
     PRIMARY KEY(ID)
);

CREATE TABLE messages (
    message_id INTEGER NOT NULL, 
    content VARCHAR(1024),
    post_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    users_id INTEGER REFERENCES users(id),
    channels_id INTEGER REFERENCES channels(id)
    PRIMARY KEY(ID)
);

INSERT INTO organization (name) VALUES ('Lambda School');

INSERT INTO users (name) VALUES ('Alice');
INSERT INTO users (name) VALUES ('Bob');
INSERT INTO users (name) VALUES ('Chris');

INSERT INTO channels (name) VALUES ('#general');
INSERT INTO channels (name) VALUES ('#random');
INSERT INTO channels (name) VALUES ('#writing');

INSERT INTO messages (content, users_id, channels_id) VALUES ('Hey guys!', 1, 1);
INSERT INTO messages (content, users_id, channels_id) VALUES ('Good morning', 1, 2);
INSERT INTO messages (content, users_id, channels_id) VALUES ('I need help with this problem', 1, 2);
INSERT INTO messages (content, users_id, channels_id) VALUES ('@channel #brownbag', 2, 1);
INSERT INTO messages (content, users_id, channels_id) VALUES ('@dk574', 2, 1);
INSERT INTO messages (content, users_id, channels_id) VALUES ('Do you guys know this?', 2, 1);
INSERT INTO messages (content, users_id, channels_id) VALUES ('#Good afternoon', 3, 1);
INSERT INTO messages (content, users_id, channels_id) VALUES ('What are we doign today?', 3, 2);
INSERT INTO messages (content, users_id, channels_id) VALUES ('Do I need this app?', 3, 2);
INSERT INTO messages (content, users_id, channels_id) VALUES ('@dave you coming to the meetup?', 1, 2);