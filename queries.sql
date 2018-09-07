PRAGMA foreign_keys = ON;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    organization_id INTEGER REFERENCES organization(id)

);
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    organization_id INTEGER REFERENCES organization(id)
);


CREATE TABLE channel_user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(2056) NOT NULL,
    timestamp DATE DEFAULT (datetime('now', 'localtime')),
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);


INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO user (name, organization_id ) VALUES ("Alice", 1);
INSERT INTO user (name, organization_id ) VALUES ("Bob", 1);
INSERT INTO user (name, organization_id ) VALUES ("Chris", 1);

INSERT INTO channel_user (channel_id, user_id) VALUES (1,1);
INSERT INTO channel_user (channel_id, user_id) VALUES (2,1);
INSERT INTO channel_user (channel_id, user_id) VALUES (1,2);
INSERT INTO channel_user (channel_id, user_id) VALUES (2,3);

INSERT INTO message (content, channel_id,  user_id) VALUES ("Alice's post in #general", 1, 1);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Alice's post in #random", 2, 1);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Alice's post in #general again", 1, 1);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Bob's first post in #random", 2, 2);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Bob's  second post  in #general", 1, 2);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Bob's third post in #general again", 1, 2);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Chris' first post in #random", 2, 3);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Chris' post in #general", 1, 3);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Chris' second post in #random", 2, 3);
INSERT INTO message (content, channel_id,  user_id) VALUES ("Another by Alice in #random", 2, 1);


-- List all organization names
SELECT * FROM organization;

-- List all channel names
SELECT * FROM channel;

-- List all channels in a specific organization by name
SELECT channel.name FROM channel, organization
WHERE organization_id = organization.id
AND organization.name = "Lambda School";

-- List all messages in a specific channel by channel name #general in order of timestamp, descending
SELECT content FROM message, channel
WHERE channel_id = channel.id 
AND channel.name = "#general" 
ORDER BY timestamp DESC;

-- List all channels to which user Alice belongs
SELECT channel.name FROM channel, user, channel_user  
WHERE user.id = user_id
AND channel.id = channel_id
AND user.name = "Alice";

-- List all users that belong to channel #general
SELECT user.name FROM channel, user, channel_user 
WHERE user_id = user.id
AND channel.id = channel_id
AND channel.name = "#general";

-- List all messages in all channels by user Alice
SELECT message.*, channel.name 
FROM message, channel, user, channel_user 
WHERE message.user_id = channel_user.id 
AND channel_user.channel_id = channel.id 
AND channel_user.user_id = user.id 
AND user.name = "Alice";

SELECT content FROM message, user
WHERE user_id = user.id
AND user.name = 'Alice';

-- List all messages in #random by user Bob
SELECT content FROM Message, channel, user
WHERE user_id = user.id
AND channel_id = channel.id
AND channel.name = "#random"
AND User.name = "Bob";

-- List the count of messages across all channels per user
SELECT user.name  AS "User Name", COUNT(*) "Message Count" FROM user, message
WHERE user_id = user.id
GROUP BY user.id 
ORDER BY user.name DESC


-- Question: What SQL keywords or concept would you use if you wanted to automatically delete all 
-- messages by a user if that user were deleted from the user table?
-- Ans: Add "ON DELETE CASCADE" to the end of a target id

