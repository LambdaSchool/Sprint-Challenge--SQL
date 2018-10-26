DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channels;
DROP TABLE IF EXISTS messages;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    organization_name VARCHAR(128),

);

CREATE TABLE channels (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     channels_name VARCHAR(128) NOT NULL,
 
);

CREATE TABLE users (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     users_name VARCHAR(128) NOT NULL,
);

CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    content VARCHAR(1024),
    post_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    users_id INTEGER REFERENCES users(id),
    channels_id INTEGER REFERENCES channels(id)

);

INSERT INTO organization (name) VALUES ('Lambda School');

INSERT INTO users (name) VALUES ('Alice');
INSERT INTO users (name) VALUES ('Bob');
INSERT INTO users (name) VALUES ('Chris');

INSERT INTO channels (name) VALUES ('#general');
INSERT INTO channels (name) VALUES ('#random');
INSERT INTO channels (name) VALUES ('#writing');

INSERT INTO messages (content, users_id, channels_id) VALUES ('Hey guys!', 1, 1);
INSERT INTO messages (content, users_id, channels_id) VALUES ('Good morning', 1, 2);
INSERT INTO messages (content, users_id, channels_id) VALUES ('I need help with this problem', 1, 2);
INSERT INTO messages (content, users_id, channels_id) VALUES ('@channel #brownbag', 2, 1);
INSERT INTO messages (content, users_id, channels_id) VALUES ('@dk574', 2, 1);
INSERT INTO messages (content, users_id, channels_id) VALUES ('Do you guys know this?', 2, 1);
INSERT INTO messages (content, users_id, channels_id) VALUES ('#Good afternoon', 3, 1);
INSERT INTO messages (content, users_id, channels_id) VALUES ('What are we doign today?', 3, 2);
INSERT INTO messages (content, users_id, channels_id) VALUES ('Do I need this app?', 3, 2);
INSERT INTO messages (content, users_id, channels_id) VALUES ('@dave you coming to the meetup?', 1, 2);

-- List all organization names.
SELECT * FROM organization;
-- List all channel names.
SELECT * FROM channels;

-- List all channels in a specific organization by organization name.

-- List all messages in a specific channel by channel name #general in order of post_time, descending. (Hint: ORDER BY. Because your INSERTs might have all taken place at the exact same time, this might not return meaningful results. But humor us with the ORDER BY anyway.)

-- List all channels to which user Alice belongs.

-- List all users that belong to channel #general.

-- List all messages in all channels by user Alice.

-- List all messages in #random by user Bob.

-- List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.)