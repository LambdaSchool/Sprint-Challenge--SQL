PRAGMA foreign_keys = ON;

.mode column
.header on

DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;

-- Write CREATE TABLE statements for tables organization, channel, user, and message
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    organization_id INTEGER REFERENCES organization(id) ON DELETE CASCADE NOT NULL
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    channel_id INTEGER REFERENCES channel(id) ON DELETE CASCADE NOT NULL
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    content VARCHAR(1024) NOT NULL,
    user_id INTEGER REFERENCES user(id) ON DELETE CASCADE NOT NULL,
    channel_id INTEGER REFERENCES channel(id) ON DELETE CASCADE NOT NULL
);

CREATE TABLE user_channel (
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

-- Write INSERT queries to add information to the database.



-- Write SELECT queries