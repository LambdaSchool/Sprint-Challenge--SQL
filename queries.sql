-- Organization
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
);

-- Channel
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    org_id INTEGER REFERENCES organization(id)
);

-- User
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    channel_id INTEGER REFERENCES channel(id)
);

-- Message
CREATE TABLE message (
    post_time REAL 
    DEFAULT CURRENT_TIMESTAMP,
    content VARCHAR(128),
    user_id INTEGER REFERENCES user(id)
);

-- Join Table For Channel and Users
SELECT channel.name AS "Channel", user.name AS "User"
FROM channel, user WHERE user.channel_id = channel.id;

-- Join Table For Users and Post
SELECT user.name AS "User", message.content AS "Messages"
FROM user, message WHERE message.user_id = user.id;

-- Insert

INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name, channel_id) VALUES ("Alice", 1);
INSERT INTO user (name, channel_id) VALUES ("Alice", 2);
INSERT INTO user (name, channel_id) VALUES ("Bob", 1);
INSERT INTO user (name, channel_id) VALUES ("Chris", 2);

INSERT INTO channel (name, org_id) VALUES ("#general", 1);
INSERT INTO channel (name, org_id) VALUES ("#random", 1);

INSERT INTO message (content, user_id) VALUES ("Potato", 1);
INSERT INTO message (content, user_id) VALUES ("Yam", 1);
INSERT INTO message (content, user_id) VALUES ("Crabs", 1);
INSERT INTO message (content, user_id) VALUES ("Hamburgers", 4);
INSERT INTO message (content, user_id) VALUES ("Chicken Pot Pie", 4);

INSERT INTO message (content, user_id) VALUES ("Bananas", 2);
INSERT INTO message (content, user_id) VALUES ("Bunny", 2);
INSERT INTO message (content, user_id) VALUES ("Turtle", 2);
INSERT INTO message (content, user_id) VALUES ("Hamster", 3);
INSERT INTO message (content, user_id) VALUES ("Dog", 3);

-- SELECT

SELECT organization.name FROM organization;

SELECT channel.name FROM channel;

SELECT channel.name AS "Lambda School Channel(s)" FROM organization, channel WHERE channel.org_id = organization.id AND
organization.name = "Lambda School";

SELECT message.post_time, message.content AS "#general" FROM channel, user, message
WHERE message.user_id = user.id AND user.channel_id = 1 AND
channel.id = 1 ORDER BY message.post_time;

SELECT channel.name AS "Alice's Channels" FROM channel, user
WHERE user.channel_id = 1 AND user.name = "Alice";

SELECT user.name AS "#general Users" FROM channel, user
WHERE user.channel_id = 1 AND channel.name = "#general";

SELECT message.content AS "#general - Bob" FROM message, user, channel
WHERE message.user_id = user.id AND user.id = 3 and channel.id = 2;

SELECT user.name AS "User Name", COUNT(message.content) AS "Message Count" FROM message, user
WHERE message.user_id = user.id GROUP BY user.name ORDER BY user.name DESC;

-- The keywords that are important to delete all messages from a deleted user
-- is to first set up 'PRAGMA foreign_keys = on'. Then when creating
-- messages and setting up the foreign keys, write ON DELETE CASCADE
-- this will cause all of the messages to delete when a user is
-- deleted.

-- Stretch
SELECT user.name AS "User", channel.name AS "Channel", COUNT(message.content) AS "Message Count"
FROM message, channel, user 
WHERE user.channel_id = channel.id AND message.user_id = user.id
GROUP BY user.id ORDER BY channel.name;