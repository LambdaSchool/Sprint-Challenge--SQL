
-- * Organizations (e.g. `Lambda School`)
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(256) NOT NULL UNIQUE,
)

-- * Channels (e.g. `#random`)
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    organization_id INTEGER REFRENCES channel(id)
)


-- * Users (e.g. `Dave`)
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE
);

-- message
CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(MAX) NOT NULL,
    channel_id INTEGER REFRENCES channel(id),
    user_id INTEGER REFRENCES user(id),
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User's subscribed channels
CREATE TABLE subbed_channels (
    channel_id INTEGER REFRENCES channel(id),
    user_id INTEGER REFRENCES user(id)
);

-- populate them tables
-- 1. One organization, `Lambda School`
INSERT INTO organization (name) VALUES ('Lambda School');

--2. Three users, `Alice`, `Bob`, and `Chris`
INSERT INTO user(name)VALUES('Alice');
INSERT INTO user(name)VALUES('Bob');
INSERT INTO user(name)VALUES('Chris');

--3. Two channels, `#general` and `#random`
INSERT INTO channel(name, organization_id)VALUES('#general',1); --channel 1
INSERT INTO channel(name, organization_id)VALUES('#random',1);  -- channel 2

--   5. `Alice` should be in `#general` and `#random`.
INSERT INTO subbed_channels(channel_id, user_id)VALUES(1,1);
INSERT INTO subbed_channels(channel_id, user_id)VALUES(2,1);
--   6. `Bob` should be in `#general`.
INSERT INTO subbed_channels(channel_id, user_id)VALUES(1,2);
--   7. `Chris` should be in `#random`.
INSERT INTO subbed_channels(channel_id, user_id)VALUES(2,3);

--4. 10 messages (at least one per user, and at least one per channel).

INSERT INTO messages(content, user_id, channel_id)VALUES(
    'Hello #general, I am writing you from wonderland', 1
);


