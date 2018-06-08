DROP TABLE IF EXISTS organization
DROP TABLE IF EXISTS channel
DROP TABLE IF EXISTS user
DROP TABLE IF EXISTS message

CREATE TABLE organization(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(32) NOT NULL
)
CREATE TABLE channel(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL,
    organization_id INTEGER,
    FOREIGN KEY(organization_id) REFERENCES organization(id)
)
CREATE TABLE user(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(16) NOT NULL
)
CREATE TABLE message(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    channel_id INTEGER,
    content TEXT,
    post_time DATETIME NOT NULL,
    FOREIGN KEY(user_id) REFERENCES user(id)
    FOREIGN KEY(channel_id) REFERENCES channel(id)
)

INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel (name) VALUES ("#general");
INSERT INTO channel (name) VALUES ("#random");

INSERT INTO message (user_id, content) VALUES (1, "text");
INSERT INTO message (user_id, content) VALUES (1, "text");
INSERT INTO message (user_id, content) VALUES (1, "text");
INSERT INTO message (user_id, content) VALUES (1, "text");
INSERT INTO message (user_id, content) VALUES (1, "text");
INSERT INTO message (user_id, content) VALUES (1, "text");
INSERT INTO message (user_id, content) VALUES (1, "text");
INSERT INTO message (user_id, content) VALUES (1, "text");
INSERT INTO message (user_id, content) VALUES (1, "text");
INSERT INTO message (user_id, content) VALUES (1, "text");


-- 10 messages (at least one per user, and at least one per channel).
-- Alice should be in #general and #random.
-- Bob should be in #general.
-- Chris should be in #random.
-- Write SELECT queries to:

-- For these INSERTs, it is NOT OK to refer to users, channels, and organization by their ids. You must join in those cases.

-- List all organization names.

-- List all channel names.

-- List all channels in a specific organization by organization name.

-- List all messages in a specific channel by channel name #general in order of post_time, descending. (Hint: ORDER BY. Because your INSERTs might have all taken place at the exact same time, this might not return meaningful results. But humor us with the ORDER BY anyway.)

-- List all channels to which user Alice belongs.

-- List all users that belong to channel #general.

-- List all messages in all channels by user Alice.

-- List all messages in #random by user Bob.

-- List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.)

-- The title of the user's name column should be User Name and the title of the count column should be Message Count. (The SQLite commands .mode column and .header on might be useful here.)

-- The user names should be listed in reverse alphabetical order.

-- Example:

-- User Name   Message Count
-- ----------  -------------
-- Chris       4
-- Bob         3
-- Alice       3
-- [Stretch!] List the count of messages per user per channel.

-- Example:

-- User        Channel     Message Count
-- ----------  ----------  -------------
-- Alice       #general    1
-- Bob         #general    1
-- Chris       #general    2
-- Alice       #random     2
-- Bob         #random     2
-- Chris       #random     2
-- What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?

