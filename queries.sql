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

CREATE TABLE message (id INT NOT NULL AUTOINCREMENT PRIMARY KEY, post_time DATETIME DEFAULT CURRENT_TIMESTAMP, content VARCHAR(1000) NOT NULL, user_id INT REFERENCES user(id), channel_id INT REFERENCES channel(id))