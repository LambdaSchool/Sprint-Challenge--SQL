-- Turn on Foreign key constraints

PRAGMA foreign_key=true;

-- Create an org table

CREATE TABLE organization (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name VARCHAR(128) NOT NULL
);

-- create a user table

CREATE TABLE user (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name VARCHAR(128) NOT NULL,
org_id INTEGER REFERENCES organization(id)
);

-- create a channel table

CREATE TABLE channel (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name VARCHAR(128) NOT NULL,
org_id INTEGER REFERENCES organization(id)
);

-- create join table for users + channels

CREATE TABLE user_channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    u_id INTEGER REFERENCES user(id),
    ch_id INTEGER REFERENCES channel(id)
);

-- create a message table

CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    u_id INTEGER REFERENCES user(id),
    ch_id INTEGER REFERENCES channel(id),
    body VARCHAR(2056) NOT NULL,
    timestamp DATE DEFAULT (datetime('now', 'localtime'))
);

-- seed data 

INSERT INTO organization (name) VALUES ("Lambda School");
INSERT INTO user (name, org_id) VALUES ("Alice", 1);
INSERT INTO user (name, org_id) VALUES ("Bob", 1);
INSERT INTO user (name, org_id) VALUES ("Chris", 1);

INSERT INTO channel (name, org_id) VALUES ("#general", 1);
INSERT INTO channel (name, org_id) VALUES ("#random", 1);

INSERT INTO user_channel (u_id, ch_id) VALUES (1, 1);
INSERT INTO user_channel (u_id, ch_id) VALUES (1, 2);
INSERT INTO user_channel (u_id, ch_id) VALUES (2, 1);
INSERT INTO user_channel (u_id, ch_id) VALUES (3, 2);

INSERT INTO messages (u_id, ch_id, body) VALUES (1, 1, "test msg");
INSERT INTO messages (u_id, ch_id, body) VALUES (1, 2, "test msg");
INSERT INTO messages (u_id, ch_id, body) VALUES (1, 1, "test msg2");
INSERT INTO messages (u_id, ch_id, body) VALUES (1, 2, "test msg2");
INSERT INTO messages (u_id, ch_id, body) VALUES (2, 1, "test msg");
INSERT INTO messages (u_id, ch_id, body) VALUES (2, 1, "test msg2");
INSERT INTO messages (u_id, ch_id, body) VALUES (3, 2, "test msg1");
INSERT INTO messages (u_id, ch_id, body) VALUES (3, 2, "test msg2");
INSERT INTO messages (u_id, ch_id, body) VALUES (1, 2, "test msg3");
INSERT INTO messages (u_id, ch_id, body) VALUES (1, 1, "test msg3");
