-- Pretty Viewing :)
.mode column
.header on
-- Create a DB for the Online Chat System
.open onlinechat.db

-- TABLES

-- * Users TABLE
-- ID, NAME,
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- * Organizations TABLE
-- ID, NAME,
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- * Channels TABLE
-- ID, NAME, ORGANIZATION_ID
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES organization(id)
);

-- * Message TABLE
-- ID, POST_TIME, CONTENT, USER_ID, CHANNEL_ID
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content LONGTEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);
