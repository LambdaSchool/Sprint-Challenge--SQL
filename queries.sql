-- Organization table
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (128) NOT NULL UNIQUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Channel table
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (128) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES organization(id),
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User table
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (128) NOT NULL UNIQUE,
    username VARCHAR (128) NOT NULL UNQIUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP    
);

-- Message table
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content text,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
    -- A SQLite data type used as a timestamp.
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Writing INSERT queries to populate the tables/databases.

-- One organization, Lambda School
INSERT INTO organization (name, username) VALUES ("Lambda School");

-- Three users, Alice, Bob, and Chris
INSERT INTO user (name, username) VALUES ("Alice", "aliceinchains");
INSERT INTO user (name, username) VALUES ("Bob", "bobmarley");
INSERT INTO user (name, username) VALUES ("Chris", "chriscornell");

-- Two channels, #general and #random
INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 2);

-- 10 messages (at least one per user, and at least one per channel).
INSERT INTO message (content, user_id, channel_id) VALUES ("Hello, I'm Alice.", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hey, I'm Bob.", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hi, I'm Chris.", 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("You know, from Alice in Wonderland.", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Marley.", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Just Chris.", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("I'm serious. I'm not a figment of your imagination.", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("But you can call me Bob Marley and the Wailers, for short.", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Family name's also Chris. So call me Chris Chris.", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Bye!", 1, 1);

-- Writing SELECT queries.

-- List all organization names.
SELECT name from organization;

-- List all channel names.
SELECT name from channel;

-- List all channels in a specific organization by organization name.
SELECT channel.name
    FROM channel, organization
    WHERE organization_id = organization.id
    AND organization.name = "Lambda School";

-- List all messages in a specific channel by channel name #general in order of post_time, descending.
SELECT contact
    FROM message, channel
    WHERE channel_id = channel.id
    AND channel.name = "#general"
    ORDER BY created DESC;

-- List all channels to which user Alice belongs.
SELECT channel.name
    FROM user, channel, user_channel
    WHERE user.id = user_id
    AND channel.id = channel_id
    AND user.name = "Alice";

-- List all users that belong to channel #general.
SELECT user.name
    FROM user, channel, user_channel
    WHERE user.id = user_id
    AND channel.id = channel_id
    AND channel.name = "#general";

-- List all messages in all channels by user Alice.
SELECT content
    FROM message, user
    WHERE user_id = user.id
    AND user.name = "Alice";

-- List all messages in #random by user Bob.
SELECT content 
    FROM message, channel, user
    WHERE user_id = user.id
    AND channel_id = channel.id
    AND channel.name = "#random"
    AND user.name = "Bob";

-- List the count of messages across all channels per user.
SELECT user.name AS "User Name", COUNT(*) AS "Message Count"
    FROM user, message
    WHERE user_id = user.id
    GROUP BY user.id
    ORDER BY user.name DESC;
