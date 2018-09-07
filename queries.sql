CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    channel_id INTEGER NOT NULL,
    post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES user(id),
    FOREIGN KEY(channel_id) REFERENCES channel(id)
);

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    organization_id INTEGER NOT NULL,
    FOREIGN KEY(organization_id) REFERENCES organization(id)
);

CREATE TABLE channel_messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    channel_id INTEGER NOT NULL,
    messages_id INTEGER NOT NULL,
    FOREIGN KEY(channel_id) REFERENCES channel(id),
    FOREIGN KEY(messages_id) REFERENCES messages(id)
);

CREATE TABLE channel_user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    channel_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY(channel_id) REFERENCES channel(id),
    FOREIGN KEY(user_id) REFERENCES user(id)
);

CREATE TABLE organization_channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    organization_id INTEGER NOT NULL,
    channel_id INTEGER NOT NULL,
    FOREIGN KEY(organization_id) REFERENCES organization(id),
    FOREIGN KEY(channel_id) REFERENCES channel(id)
);

CREATE TABLE organization_user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    organization_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY(organization_id) REFERENCES organization(id),
    FOREIGN KEY(user_id) REFERENCES user(id)
);

-- User: many messages, many channels (user_message, user_channel (already joined in channel_user?))
-- Message: one user (foreign key)
-- Channel: many users, messages (channel_user, channel_message),
    -- one org (foreign key)
-- Organization: many channels (organiation_channel) 

-- JOIN tables needed: user_message, channel_user, channel_message, organization_channel (4)

INSERT INTO organization (name) VALUES ('Lambda School');

INSERT INTO user (name) VALUES ('Alice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');

INSERT INTO channel (name, organization_id) VALUES ('#general', 1);
INSERT INTO channel (name, organization_id) VALUES ('#random', 1);

INSERT INTO messages (content, user_id, channel_id) VALUES ('Message 1', 1, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ('Message 2', 1, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ('Message 3', 2, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ('Message 4', 2, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ('Message 5', 3, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ('Message 6', 1, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ('Message 7', 3, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ('Message 8', 2, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ('Message 9', 3, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ('Message 10', 1, 1);
-- Alice: 1, Bob: 2, Chris: 3
-- #general: 1, #random: 2
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 2);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 3);

.mode column
.headers on

-- SELECT QUERIES
-- 1. 
SELECT * FROM organization;
-- 2. 
SELECT channel.name FROM channel;
-- 3. 
SELECT channel.name FROM organization, channel WHERE channel.organization_id IS organization.id AND organization.id IS '1';
-- 4.
SELECT messages.content, messages.id, messages.post_time FROM channel, messages WHERE messages.channel_id IS channel.id AND channel.id IS '1' ORDER BY post_time DESC;
-- 5. 




