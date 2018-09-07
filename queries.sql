--What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?--

PRAGMA foreign_keys = ON;

-- organization table --
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE
);

-- channel table --
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE
);

-- user table --
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE
);

-- message table --
CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- insert into organization --
INSERT INTO organization (name) VALUES ("Lambda School");

-- insert into user --
INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

-- insert into channel --
INSERT INTO channel (name) VALUES ("#general");
INSERT INTO channel (name) VALUES ("#random");

-- insert into messages --
INSERT INTO messages (content, user_id, channel_id) VALUES ("Fly me to the moon!", 1, 1);


