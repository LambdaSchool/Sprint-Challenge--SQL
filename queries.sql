-- Pretty Formatting for tables
.mode COLUMN
.header ON 

-- my chat system database 
.OPEN onlinechat.db 

-- CREATE TABLE statements for tables organization, channel, user and message:

-- organization table
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name VARCHAR(128) NOT NULL UNIQUE,
);

-- channel table
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name VARCHAR(128) NOT NULL UNIQUE, 
    organization_id INTEGER REFERENCES organization(id),
);

-- user table
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name VARCHAR(128) NOT NULL UNIQUE,
);

-- message table
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content LONGTEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
);

