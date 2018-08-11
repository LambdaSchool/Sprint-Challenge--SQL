-- Create Table

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    org_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
);

CREATE TABLE message (
    content VARCHAR(128),
    post_time TIMESTAMP
    DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

-- Join Table
CREATE TABLE subscription (
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

-- Insert

INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel (name) VALUES ("#general");
INSERT INTO channel (name) VALUES ("#random");

INSERT INTO message (content, user_id, channel_id) VALUES ("Potato", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Yam", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Crabs", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hamburgers", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Chicken Pot Pie", 3, 1);

INSERT INTO message (content, user_id, channel_id) VALUES ("Bananas", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Bunny", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Turtle", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hamster", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Dog", 3, 2);

INSERT INTO subscription VALUES (1, 1);
INSERT INTO subscription VALUES (1, 2);
INSERT INTO subscription VALUES (2, 1);
INSERT INTO subscription VALUES (3, 2);

-- SELECT

SELECT organization.name FROM organization;

SELECT channel.name FROM channel;

SELECT channel.name FROM channel, organization
WHERE organization.name = "Lambda School";

SELECT message.post_time AS "Time", message.content AS "Posts"
FROM message, channel
WHERE channel.name = "#general" AND message.channel_id = channel.id
ORDER BY message.post_time DESC;

SELECT channel.name AS "Alice's Channel(s)"
FROM channel, user, subscription
WHERE user.name = "Alice" AND user.id = subscription.user_id AND channel.id = subscription.channel_id;

SELECT message.content AS "#random - Bob"
FROM channel, user, message
WHERE channel.name = "#random" AND message.channel_id = channel.id
AND message.user_id = user.id AND user.name = "Bob";

SELECT user.name AS "User Name", COUNT(message.content) AS "Message Count"
FROM user, message
WHERE message.user_id = user.id
GROUP BY user.name
ORDER BY user.name DESC;

SELECT user.name AS "User", channel.name AS "Channel", COUNT(message.content) AS "Message Count"
FROM message, channel, user
WHERE message.user_id = user.id
AND message.channel_id = channel.id
GROUP BY user.name, channel.name 
ORDER BY channel.name;