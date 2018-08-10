CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    org_id INTEGER FOREIGN KEY REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    channel_id INTEGER FOREIGN KEY REFERENCES channel(id)
);

CREATE TABLE message (
    post_time DATETIME,
    content VARCHAR(128),
    user_id INTEGER FOREIGN KEY REFERENCES user(id)
);

-- Join Table For Channel and Users
SELECT channel.name AS "Channel", user.name AS "User"
FROM channel, user WHERE user.channel_id = channel.id

-- Join Table For Users and Post
SELECT user.name AS "User", message.content AS "Messages"
FROM user, message WHERE message.user_id = user.id

