PRAGMA foreign_keys = ON;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
)

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    organization_id INTEGER REFERENCES organization(id), --might need ON DELETE CASCADE
)

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64),
)

CREATE TABLE channel_user (
    channel_id INTEGER REFERENCES channel(id), --might need ON DELETE CASCADE
    user_id INTEGER REFERENCES user(id), --might need ON DELETE CASCADE
)

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    post_time TIMESTAMP default datetime('now'),
    user_id INTEGER REFERENCES user(id), --might need ON DELETE CASCADE
)