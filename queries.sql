-- format commands --
PRAGMA foreign_keys = ON;
.header on
.mode column

-- CREATE TABLE Statements --
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

-- INSERT Queries --
INSERT INTO organization (name) VALUES ("Lambda Sschool");

INSERT INTO user (name, username) VALUES ("Alice", "alice");
INSERT INTO user (name, username) VALUES ("Bob", "bob");
INSERT INTO user (name, username) VALUES ("Chris", "chris");

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO message (content, channel_id, user_id) VALUES ("content-1", 2, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-2", 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-3", 1, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-4", 2, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-5", 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-6", 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-7", 2, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-8", 2, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-9", 2, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ("content-10", 2, 2);

INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);
