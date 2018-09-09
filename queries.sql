-- 1. Write CREATE TABLE statements for tables organization, channel, user, and message.
    -- i. organization. This table should at least have column(s): 
    -- name 

CREATE TABLE organization (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(100) NOT NULL UNIQUE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP); 

CREATE TRIGGER UPDATE_TIMESTAMP_TRIGGER_FOR_ORGANIZATION 
AFTER UPDATE ON organization
BEGIN
    UPDATE organization SET TIMESTAMP = STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;

    -- i. channel. This table should at least have column(s): 
    -- name 

CREATE TABLE channel (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(100) NOT NULL UNIQUE, organization_id INTEGER NOT NULL REFERENCES organization(id) ON DELETE CASCADE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, last_modified TIMESTAMP CURRENT_TIMESTAMP); 

CREATE TRIGGER UPDATE_TIMESTAMP_TRIGGER_FOR_CHANNEL  
AFTER UPDATE ON channel
BEGIN
    UPDATE channel SET TIMESTAMP = STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;

    -- user. This table should at least have column(s): 
    -- name    

CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, first_name VARCHAR(100) NOT NULL, last_name VARCHAR(100) NOT NULL, username VARCHAR(50) NOT NULL UNIQUE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP); 

CREATE TRIGGER UPDATE_TIMESTAMP_TRIGGER_FOR_USER
AFTER UPDATE ON user 
BEGIN
    UPDATE user SET TIMESTAMP = STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;

    -- message. This table should have at least columns(s):
    -- post_time--the timestamp of when the message was posted
    -- content--the message content itself

CREATE TABLE message (id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, user_id INTEGER REFERENCES user(id) ON DELETE CASCADE, channel_id INTEGER REFERENCES channel(id) ON DELETE CASCADE, post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP); 

CREATE TRIGGER UPDATE_TIMESTAMP_TRIGGER_FOR_MESSAGE
AFTER UPDATE ON message
BEGIN
    UPDATE message SET TIMESTAMP = STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;

-- 2. Add additional foreign keys needed to the above tables, if any.
-- 3. Add additional join tables needed, if any.

CREATE TABLE user_channel (user_id INTEGER REFERENCES user(id) ON DELETE CASCADE, channel_id INTEGER REFERENCES channel(id) ON DELETE CASCADE); 

-- 4. Write INSERT queries to add information to the database.

    -- One organization, Lambda School

INSERT INTO organization (name) VALUES ('Lambda School'); 

    -- Three users, Alice, Bob, and Chris

INSERT INTO user (first_name, last_name, username) VALUES ('Alice', 'Wonderland', 'alice20');
INSERT INTO user (first_name, last_name, username) VALUES ('Bob', 'Dillan', 'bobby76');
INSERT INTO user (first_name, last_name, username) VALUES ('Chris', 'Hay', 'chrisp9');

    -- Two channels, #general and #random

INSERT INTO channel (name, organization_id) VALUES ('#general', 1);
INSERT INTO channel (name, organization_id) VALUES ('#random', 1);

    -- 10 messages (at least one per user, and at least one per channel).

INSERT INTO message (content, user_id, channel_id) VALUES("I'M THE KING OF THE WORLD", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("OH, you did an actual query.  That’s awesome lol", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES("Cats are cool.", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("So many repos.", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES("Don't worry guys.", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES("Why do I type so slow?", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("Two hours of sleep is rough.", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("What's the repo for today?", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("Can you make a PR request please", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("Do you think I will graduate?", 1, 2);

    -- Alice should be in #general and #random.
    -- Bob should be in #general.
    -- Chris should be in #random.

INSERT INTO user_channel(user_id, channel_id) VALUES(1, 1); 
INSERT INTO user_channel(user_id, channel_id) VALUES(1, 2); 
INSERT INTO user_channel(user_id, channel_id) VALUES(2, 1); 
INSERT INTO user_channel(user_id, channel_id) VALUES(3, 2); 

-- 5. Write SELECT queries to:
    
    -- List all organization names.

SELECT name FROM organization; 
    
    -- List all channel names.

SELECT name FROM channel; 
    
    -- List all channels in a specific organization by organization name.

SELECT channel.name AS 'Channels in Lambda School' FROM channel, organization WHERE channel.organization_id = organization.id AND organization.name = 'Lambda School'; 
    
    -- List all messages in a specific channel by channel name #general in order of post_time, descending. 

SELECT message.content 'Messages in #general channel ordered by post time in descending order.' FROM message, channel WHERE message.channel_id = channel.id AND channel.name = '#general' ORDER BY message.post_time DESC; 
    
    -- List all channels to which user Alice belongs.

SELECT channel.name AS 'Channels that Alice belongs to' FROM user, channel, user_channel WHERE user.id = user_channel.user_id AND channel.id = user_channel.channel_id AND user.first_name = 'Alice'; 
    
    -- List all users that belong to channel #general.

SELECT user.first_name AS 'Users that belong to channel #general' FROM user, channel, user_channel WHERE user.id = user_channel.user_id AND channel.id = user_channel.channel_id AND channel.name = '#general'; 
    
    -- List all messages in all channels by user Alice.

SELECT message.content AS 'All messages in all channels by user Alice' FROM user, message WHERE user.id = message.user_id AND user.first_name = 'Alice'; 
    
    -- List all messages in #random by user Bob.

SELECT message.content AS 'All messages in #random by user Bob' FROM user, message, channel WHERE user.id = message.user_id AND message.channel_id = channel.id AND user.first_name = 'Bob' AND channel.name = '#random'; 

    -- List the count of messages across all channels per user.

SELECT user.first_name AS 'User Name', COUNT(message.id) AS 'Message Count' FROM user, message WHERE user.id = message.user_id GROUP BY user.first_name; 

    -- [Stretch!] List the count of messages per user per channel.

SELECT user.first_name AS 'User', channel.name AS 'Channel', COUNT(*) AS 'Message Count' FROM user, channel, message WHERE user.id = message.user_id AND message.channel_id = channel.id GROUP BY channel.name, user.first_name; 
 
    
