PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    content VARCHAR(1024)
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    org_id INTEGER REFERENCES organization(id)
);

CREATE TABLE channel_user_message (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id),
    message_id INTEGER REFERENCES message(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(1024) NOT NULL,
    post_time DATETIME NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime')),
    user_id INTEGER REFERENCES user(id)
);