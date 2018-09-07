-- --Formatting
-- .mode column
-- .header on

CREATE TABLE organization (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(128) NOT NULL);

CREATE TABLE channel (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(128) NOT NULL,org_id INT REFERENCES organization(id));

CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(128) NOT NULL,org_id INT REFERENCES organization(id));

CREATE TABLE message (id INTEGER PRIMARY KEY AUTOINCREMENT, post_time DATETIME, content VARCHAR(500), channel_id INT REFERENCES channel(id), user_id INT REFERENCES user(id));


