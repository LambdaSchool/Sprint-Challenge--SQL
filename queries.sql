-- Organization
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
);

-- Channel
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    org_id INTEGER FOREIGN KEY REFERENCES organization(id)
);

-- User
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    channel_id INTEGER FOREIGN KEY REFERENCES channel(id)
);

-- Message
CREATE TABLE message (
    post_time DATETIME,
    content VARCHAR(128),
    user_id INTEGER FOREIGN KEY REFERENCES user(id)
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

INSERT INTO channel (name) VALUES ("#general");
INSERT INTO channel (name) VALUES ("#random");

INSERT INTO message (content, user_id) VALUES ("Potato", 1);
INSERT INTO message (content, user_id) VALUES ("Yam", 1);
INSERT INTO message (content, user_id) VALUES ("Crabs", 1);
INSERT INTO message (content, user_id) VALUES ("Hamburgers", 1);
INSERT INTO message (content, user_id) VALUES ("Chicken Pot Pie", 1);

INSERT INTO message (content, user_id) VALUES ("Bananas", 2);
INSERT INTO message (content, user_id) VALUES ("Bunny", 2);
INSERT INTO message (content, user_id) VALUES ("Turtle", 2);
INSERT INTO message (content, user_id) VALUES ("Hamster", 3);
INSERT INTO message (content, user_id) VALUES ("Dog", 3);