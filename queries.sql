-- Testing .read queries.sql command

    DROP TABLE subs;
    DROP TABLE message;
    DROP TABLE user;
    DROP TABLE channel;
    DROP TABLE organization;

-- Formatting
.mode column
.header on

-- Enable Foreign Keys

    PRAGMA foreign_keys = ON;

-- Create Tables

    CREATE TABLE organization (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(128) NOT NULL 
    );

    CREATE TABLE channel (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(128) NOT NULL,
        org_ID INTEGER,
        FOREIGN KEY (org_ID) REFERENCES organization(ID)
    );

    CREATE TABLE user (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(128) NOT NULL
    );

    CREATE TABLE message (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
        content VARCHAR(128) NOT NULL,        
        userID INTEGER,
        chanID INTEGER,
        FOREIGN KEY (userID)  REFERENCES user(ID),
        FOREIGN KEY (chanID) REFERENCES channel(ID)
    );

    CREATE TABLE subs (
        userID INTEGER,
        chanID INTEGER,
        FOREIGN KEY (userID) REFERENCES user(ID),
        FOREIGN KEY (chanID) REFERENCES channel(ID)
    );

-- Insert one organization, Lambda School

    INSERT INTO organization (name) VALUES ('Lambda School');

-- Insert three users, Alice, Bob, and Chris

    INSERT INTO user (name) VALUES ('Alice'), ('Bob'), ('Chris');

-- Insert two channels, #general and #random

    INSERT INTO channel (name, org_ID) VALUES ('#general', 1);
    INSERT INTO channel (name, org_ID) VALUES ('#random', 1);

-- Insert 10 messages (at least one per user, and at least one per channel)

    INSERT INTO message (content, chanID, userID) VALUES ('Hello, my name is Alice, is this the cat channel?', 1, 1);
    INSERT INTO message (content, chanID, userID) VALUES ('My name is Bob and no, we dont want you here', 1, 2);
    INSERT INTO message (content, chanID, userID) VALUES ('Is this the cat channel?', 2, 1);
    INSERT INTO message (content, chanID, userID) VALUES ('No, we have cats but this is the random channel, ask in general', 2, 3);
    INSERT INTO message (content, chanID, userID) VALUES ('I asked already, they didnt give any direction and were rude to me', 2, 1);
    INSERT INTO message (content, chanID, userID) VALUES ('Who', 2, 3);
    INSERT INTO message (content, chanID, userID) VALUES ('Some guy called Bob', 2, 1);
    INSERT INTO message (content, chanID, userID) VALUES ('Tell him Chris sent you', 2, 3);
    INSERT INTO message (content, chanID, userID) VALUES ('Im back, Chris sent me, where are the cats?', 1, 1);
    INSERT INTO message (content, chanID, userID) VALUES ('Press Alt + F4', 1, 2);
    INSERT INTO message (content, chanID, userID) VALUES ('I hate you all, Im leaving forever! Peace!', 2, 2);

-- Insert Alice in #general and #random, Bob in #general and Chris in #random

    INSERT INTO subs (userID, chanID) VALUES (1, 1), (1, 2), (2, 1), (3, 2);

-- List all organization names

    SELECT name AS 'Organization Name' FROM organization;

-- List all channel names.

    SELECT name AS 'Channel Name' FROM channel;

-- List all channels in a specific organization by organization name.

    SELECT channel.name AS 'Channel Name', organization.name AS 'Organization Name'
    FROM channel, organization 
    WHERE channel.org_ID = organization.ID
    AND organization.name = 'Lambda School';

-- List all messages in a specific channel by channel name #general in order of post_time, descending.
--(Hint: ORDER BY. Because your INSERTs might have all taken place at the exact same time, this might not return meaningful results. But humor us with the ORDER BY anyway.)

    SELECT message.* FROM message, channel
    WHERE message.chanID = channel.ID
    AND channel.name = '#general'
    ORDER BY message.post_time DESC;

-- List all channels to which user Alice belongs.

    SELECT user.name, channel.name FROM user, channel, subs
    WHERE subs.chanID = channel.id
    AND subs.userID = user.ID
    AND user.name = 'Alice';

-- List all users that belong to channel #general.

    SELECT user.name, channel.name FROM user, channel, subs
    WHERE subs.chanID = channel.id
    AND subs.userID = user.ID
    AND channel.name = '#general';

-- List all messages in all channels by user Alice.

    SELECT message.* FROM user, message
    WHERE message.userID = user.ID
    AND user.name = 'Alice';

-- List all messages in #random by user Bob.

    SELECT message.* FROM user, message, channel
    WHERE message.userID = user.ID
    AND message.chanID = channel.ID
    AND channel.name = '#random'
    AND user.name = 'Bob';

-- List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.)

    SELECT user.name AS 'User Name', COUNT (message.content) AS 'Message Count' FROM user, message
    WHERE message.userID = user.ID
    GROUP BY user.name
    ORDER BY user.name DESC;

-- List the count of messages per user per channel.

    SELECT user.name AS 'User Name', channel.name AS 'Channel' , COUNT (message.content) AS 'Message Count'FROM user, message, channel
    WHERE message.userID = user.ID
    AND message.chanID = channel.ID
    GROUP BY channel.name, user.name;

-- What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?

    -- 'ON DELETE CASCADE', this allows all the children to be automatically deleted when their parent is deleted (so gloomy).