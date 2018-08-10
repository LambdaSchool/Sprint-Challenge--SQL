PRAGMA foreign_keys = ON; --enable foreign key constraints for sqlite

-- SQLite Configuration
.header on
.mode column
.timer on

-- Create a database for an online chat system
.open chat.db --sqlite
CREATE DATABASE chat; --mysql

-- Create a table
CREATE TABLE organization (id INT NOT NULL AUTOINCREMENT PRIMARY KEY, name VARCHAR(255) NOT NULL UNIQUE);

CREATE TABLE channel (id INT NOT NULL AUTOINCREMENT PRIMARY KEY, name VARCHAR(255) NOT NULL UNIQUE, organization_id INT REFERENCES organization(id));

CREATE TABLE user (id INT NOT NULL AUTOINCREMENT PRIMARY KEY, name VARCHAR(255) NOT NULL UNIQUE);

CREATE TABLE message (id INT NOT NULL AUTOINCREMENT PRIMARY KEY, post_time DATETIME DEFAULT CURRENT_TIMESTAMP, content VARCHAR(1000) NOT NULL, user_id INT REFERENCES user(id), channel_id INT REFERENCES channel(id));


-- INSERT QUERIES
INSERT INTO organization(name) VALUES ('Lambda School');
INSERT INTO user(name) VALUES ('Alice'), ('Bob'), ('Chris');
INSERT INTO channel(name, organization_id) VALUES ('#general', 1), ('#random', 1);
INSERT INTO message(content, user_id, channel_id) VALUES ('Alice Sample Content', 1, 1), ('Alice Sample Content 2', 1, 2), ('Alice Sample Content 3', 1, 1), ('Alice Sample Content 4', 1, 2), ('Bob Sample Content', 2, 1), ('Bob Sample Content 2', 2, 1), ('Bob Sample Content 3', 2, 1), ('Chris Sample Content', 3, 2), ('Chris Sample Content 2', 3, 2), ('Chris Sample Content 3', 3, 2);


