DROP TABLE IF EXISTS organization
DROP TABLE IF EXISTS channel
DROP TABLE IF EXISTS user
DROP TABLE IF EXISTS message

CREATE TABLE organization(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
)
CREATE TABLE channel(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
)
CREATE TABLE user(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
)
CREATE TABLE message(
    post_time time(7) NOT NULL
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
)



-- Write CREATE TABLE statements for tables organization, channel, user, and message.

-- organization. This table should at least have column(s):

-- name
-- channel. This table should at least have column(s):

-- name
-- user. This table should at least have column(s):

-- name
-- message. This table should have at least columns(s):

-- post_time--the timestamp of when the message was posted

-- See Date types in SQLite. Also see the SQLite function datetime().
-- content--the message content itself

-- Add additional foreign keys needed to the above tables, if any.

-- Add additional join tables needed, if any.

-- Write INSERT queries to add information to the database.

-- For these INSERTs, it is OK to refer to users, channels, and organization by their ids. No need to do a subselect unless you want to.

-- One organization, Lambda School
-- Three users, Alice, Bob, and Chris
-- Two channels, #general and #random
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

