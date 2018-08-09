-- Turn on pretty formatting
.mode column
.header on
-- Create a DB for the online chat system
.open chat.db
-- * Organizations TABLE (e.g. `Lambda School`)
-- ID, NAME,
CREATE TABLE organization (
    id INTEGER PRIMARY_KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
);

-- * Channels TABLE (e.g. `#random`)
-- ID, NAME, ORGANIZATION_ID
CREATE TABLE channel (
    id INTEGER PRIMARY_KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES organization(id),
);

-- * Users TABLE (e.g. `Dave`)
-- ID, NAME,
CREATE TABLE user (
    id INTEGER PRIMARY_KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
);

-- * Messge TABLE ()
-- ID, POST_TIME, CONTENT, AUTHOR, CHANNEL
CREATE TABLE message (
    id INTEGER PRIMARY_KEY AUTOINCREMENT,
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content LONGTEXT,
    user INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
);

-- * CHANNEL_SUBSCRIPTIONS
-- CHANNEL_ID, USER_ID
CREATE TABLE channel_subs (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id),
);

-- #### INSERT LAND ######## --
--   1. One organization, `Lambda School`
--   2. Three users, `Alice`, `Bob`, and `Chris`
--   3. Two channels, `#general` and `#random`
--   4. 10 messages (at least one per user, and at least one per channel).
--   5. `Alice` should be in `#general` and `#random`.
--   6. `Bob` should be in `#general`.
--   7. `Chris` should be in `#random`.

-- #### QUERY LAND ######## --
-- 1. List all organization `name`s.

-- 2. List all channel `name`s.

-- 3. List all channels in a specific organization by organization `name`.

-- 4. List all messages in a specific channel by channel `name` `#general` in
-- order of `post_time`, descending.

-- 5. List all channels to which user `Alice` belongs.

-- 6. List all users that belong to channel `#general`.

-- 7. List all messages in all channels by user `Alice`.

-- 8. List all messages in `#random` by user `Bob`.

-- 9. List the count of messages across all channels per user. (Hint:
-- `COUNT`, `GROUP BY`.)

-- The title of the user's name column should be `User Name` and the title of
-- the count column should be `Message Count`. (The SQLite commands
-- `.mode column` and `.header on` might be useful here.)