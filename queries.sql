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

CREATE TABLE user (id PRIMARY KEY AUTOINCREMENT, username VARCHAR(100) NOT NULL UNIQUE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP)

CREATE TRIGGER UPDATE_TIMESTAMP_TRIGGER_FOR_USER
AFTER UPDATE ON user 
BEGIN
    UPDATE user SET TIMESTAMP = STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;

    -- message. This table should have at least columns(s):
    -- post_time--the timestamp of when the message was posted
    -- content--the message content itself

CREATE TABLE message (id PRIMARY KEY AUTOINCREMENT, content TEXT, user_id INTEGER REFERENCES user(id) ON DELETE CASCADE, channel_id INTEGER REFERENCES channel(id) ON DELETE CASCADE, post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP)

CREATE TRIGGER UPDATE_TIMESTAMP_TRIGGER_FOR_MESSAGE
AFTER UPDATE ON message
BEGIN
    UPDATE message SET TIMESTAMP = STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;

-- 2. Add additional foreign keys needed to the above tables, if any.
-- 3. Add additional join tables needed, if any.

CREATE TABLE users_channel (users_id INTEGER REFERENCES user(id) ON DELETE CASCADE, channel_id INTEGER REFERENCES channel(id) ON DELETE CASCADE) 



