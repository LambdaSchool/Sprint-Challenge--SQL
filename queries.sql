PRAGMA foreign_keys = ON;
.header on
.mode column

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT (datetime('now','localtime'))
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES organization(id),
    created_at DATETIME DEFAULT (datetime('now','localtime'))
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    username VARCHAR(64) NOT NULL UNIQUE,
    created_at DATE DEFAULT (datetime('now','localtime'))
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content text,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
    post_time DATE DEFAULT (datetime('now','localtime')),
    last_modified DATE DEFAULT NULL
);

CREATE TABLE user_channel (
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

