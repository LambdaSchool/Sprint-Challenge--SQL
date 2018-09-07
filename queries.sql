
-- * Organizations (e.g. `Lambda School`)
CREATE TABLE organizations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(256) NOT NULL UNIQUE
);

-- * Channels (e.g. `#random`)
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES channel(id)
);


-- * Users (e.g. `Dave`)
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE
);

-- message
CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(10000) NOT NULL,
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id),
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User's subscribed channels
CREATE TABLE subbed_channels (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);

-- populate them tables
-- 1. One organizations, `Lambda School`
INSERT INTO organizations (name) VALUES ('Lambda School');

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
    'Hello #general, I am writing you from wonderland!', 1, 1
);
INSERT INTO messages(content, user_id, channel_id)VALUES(
    'Hello #general, I am bob, and I am a builder, AMA!', 2, 1
);
INSERT INTO messages(content, user_id, channel_id)VALUES(
    'Hello #general, Alice here again', 1, 1
);
INSERT INTO messages(content, user_id, channel_id)VALUES(
    'Chrismas is my favorite holiday', 3, 2
);
INSERT INTO messages(content, user_id, channel_id)VALUES(
    'Hello #general, I am writing you from wonderland!', 1, 1
);
INSERT INTO messages(content, user_id, channel_id)VALUES(
    'Hello #general, I am writing you from wonderland!', 1, 1
);
INSERT INTO messages(content, user_id, channel_id)VALUES(
    'Hello #random, I am writing you from wonderland!', 1, 2
);
INSERT INTO messages(content, user_id, channel_id)VALUES(
    'Hello #general, I am writing you from wonderland!', 1, 1
);
INSERT INTO messages(content, user_id, channel_id)VALUES(
    'Hello #general, I am writing you from wonderland!', 1, 1
);
INSERT INTO messages(content, user_id, channel_id)VALUES(
    'Hello #general, I am writing you from wonderland!', 1, 1
);
INSERT INTO messages(content, user_id, channel_id)VALUES(
    'Hello #general, I am writing you from wonderland!', 1, 1
);


-- 5. Write `SELECT` queries to:
--1. List all organizations `name`s.
    SELECT name FROM organizations;

--2. List all channel `name`s.
    Select name FROM channel;

--3. List all channels in a specific organization by organization `name`.
    SELECT name FROM channel WHERE organization_id IS 
    (SELECT id FROM organizations WHERE name IS 'Lambda School');

--4. List all messages in a specific channel by channel `name` `#general` in
    --   order of `post_time`, descending. (Hint: `ORDER BY`. Because your
    --   `INSERT`s might have all taken place at the exact same time, this might
    --   not return meaningful results. But humor us with the `ORDER BY` anyway.)
    SELECT * FROM messages WHERE channel_id IS 
    (SELECT id FROM channel WHERE name IS '#general') ORDER BY post_time DESC;

--5. List all channels to which user `Alice` belongs.
    SELECT channel.* 
    FROM channel, user, subbed_channels 
    WHERE subbed_channels.channel_id = channel.id 
    AND user.name = "Alice"
    AND subbed_channels.user_id = user.id ;

--6. List all users that belong to channel `#general`.
    SELECT user.* 
    FROM channel, user, subbed_channels 
    WHERE subbed_channels.channel_id = channel.id 
    AND channel.name = "#general"
    AND subbed_channels.user_id = user.id ;
    
--7. List all messages in all channels by user `Alice`.
    SELECT * from messages WHERE user_id = 1;

--8. List all messages in `#random` by user `Bob`.
    SELECT * from messages WHERE user_id = 2 AND channel_id = 2;

--9. List the count of messages across all channels per user. (Hint:
      --`COUNT`, `GROUP BY`.)
    SELECT user.name , COUNT(messages.id) AS "Total Messages"
    FROM messages, user
    WHERE messages.user_id = user.id
    GROUP BY user.name;