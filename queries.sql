/*create a persistent DB file*/
sqlite3 queries.db

/*Turns on foreign key constraints*/
PRAGMA foreign_keys = ON

/*Turn on column out put and headers for `SELECT`*/
.mode COLUMN
.header ON


-- CREATE TABLES
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL

);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    organization_id INT REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    organization_id INT REFERENCES organization(id)
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    content VARCHAR(300) NOT NULL,
    channel_id INT REFERENCES channel(id),
    user_id INT REFERENCES user(id)
);