-- 1. Write CREATE TABLE statements for tables organization, channel, user, and message.
    -- i. organization. This table should at least have column(s): 
    -- name 

CREATE TABLE organization (id PRIMARY KEY AUTOINCREMENT, name VARCHAR(100) NOT NULL UNIQUE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP)

CREATE TRIGGER UPDATE_TIMESTAMP_TRIGGER_FOR_ORGANIZATION 
AFTER UPDATE ON organization
BEGIN
    UPDATE organization SET TIMESTAMP = STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;

    -- i. channel. This table should at least have column(s): 
    -- name 

CREATE TABLE channel (id PRIMARY KEY AUTOINCREMENT, name VARCHAR(100) NOT NULL UNIQUE, organization_id INTEGER NOT NULL REFERENCES organization(id) ON DELETE CASCADE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, last_modified TIMESTAMP CURRENT_TIMESTAMP)

CREATE TRIGGER UPDATE_TIMESTAMP_TRIGGER_FOR_CHANNEL  
AFTER UPDATE ON channel
BEGIN
    UPDATE channel SET TIMESTAMP = STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;

    -- user. This table should at least have column(s): 
    -- name    

CREATE TABLE user (id PRIMARY KEY AUTOINCREMENT, first_name VARCHAR(100) NOT NULL, last_name VARCHAR(100) NOT NULL, username VARCHAR(50) NOT NULL UNIQUE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP)

CREATE TRIGGER UPDATE_TIMESTAMP_TRIGGER_FOR_USER
AFTER UPDATE ON user 
BEGIN
    UPDATE user SET TIMESTAMP = STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;

    -- message. This table should have at least columns(s):
    -- post_time--the timestamp of when the message was posted
      content--the messa  content itself

CREATE TABLE message (id PRIMARY KEY AUTOINCREMEN  content TEXT, user_id INTEGER REFERENCES user(id) ON DELETE CASCADE, channel_id INTEGER REFERENCES channel(id) ON DELETE CASCADE, post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP)

CREATE TRIGGER UPDATE_TIMESTAMP_TRIGGER_FOR_MESSAGE
AFTER UPDATE ON message
BEGIN
    UPDATE message SET TIMESTAMP = STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;

-- 2. Add additional foreign keys needed to the above tables, if any.
-- 3. Add additional join tables needed, if any.

CREATE TABLE users_channel (users_id INTEGER REFERENCES user(id) ON DELETE CASCADE, channel_id INTEGER REFERENCES channel(id) ON DELETE CASCADE) 

-- 4. Write INSERT queries to add information to the database.

    -- One organization, Lambda School

INSERT INTO organization (name) VALUES ('Lambda School')

    -- Three users, Alice, Bob, and Chris

INSERT INTO user (username) VALUES ('Alice', 'Wonderland', 'alice20')
INSERT INTO user (username) VALUES ('Bob', 'Dillan', 'bobby76')
INSERT INTO user (username) VALUES ('Chris', 'Hay', 'chrisp9')

    -- Two channels, #general and #random

INSERT INTO channel (name, organization_id) VALUES ('#general', 1)
INSERT INTO channel (name, organization_id) VALUES ('#random', 1) 

    -- 10 messages (at least one per user, and at least one per channel).
    -- Alice should be in #general and #random.
    -- Bob should be in #general.
    -- Chris should be in #random.

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




