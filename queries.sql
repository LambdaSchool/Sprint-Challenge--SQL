PRAGMA foreign_keys = ON;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
)

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    organization_id INTEGER REFERENCES organization(id),
)

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64),
)

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    post_time TIMESTAMP default datetime('now'),
    user_id INTEGER REFERENCES user(id),
)

CREATE TABLE channel_users (
    channel_id INT REFERENCES user(id),
    user_id INT REFERENCES channel(id)
)

CREATE TABLE user_messages (
    user_id INT REFERENCES user(id),
    message_id INT REFERENCES message(id)
)

CREATE TABLE organization_channels (
    organization_id INT REFERENCES organization(id),
    channel_id INT REFERENCES channel(id)
)

CREATE TABLE organization_users (
    organization_id INT REFERENCES organization(id),
    user_id INT REFERENCES user(id)
)