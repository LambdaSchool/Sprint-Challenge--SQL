PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS messages;

CREATE TABLE organization (
    organization_id INTEGER PRIMARY KEY NOT NULL,
    organization_name CHAR(50) NOT NULL
);

CREATE TABLE channel (
     channel_id INTEGER PRIMARY KEY NOT NULL,
     channel_name CHAR(50) NOT NULL
);

CREATE TABLE messages (
    message_id INTEGER PRIMARY KEY NOT NULL,
    post_time TIMESTAMP DEFAULT NOW(),
    content CHAR(255) 
);