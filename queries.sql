-- format commands --
PRAGMA foreign_keys = ON;
.header on
.mode column

-- Organization Table --
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT (datetime('now','localtime'))
);

-- Channel Table -- 
CREATE TABLE channel (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   name VARCHAR(64) NOT NULL UNIQUE,
   organization_id INTEGER REFERENCES organization(id),
   created_at DATETIME DEFAULT (datetime('now','localtime'))
);

-- User Table --
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    username VARCHAR(32) NOT NULL UNIQUE,
    created_at DATE DEFAULT (datetime('now','localtime'))
);

-- Message Table --
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
    post_time DATE DEFAULT (datetime('now','localtime')),
    last_modified DATE DEFAULT NULL
);

-- User_Channel Table --
CREATE TABLE user_channel (
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);