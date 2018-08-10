-- Section 1-3

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    organization_id INT,
    FOREIGN KEY(organization_id) REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time INT,
    content TEXT,
    user_id INTEGER,
    channel_id INTEGER,
    FOREIGN KEY(user_id) REFERENCES user(id)
    FOREIGN KEY(channel_id) REFERENCES channel(id)
);

CREATE TABLE channel_user (
    channel_id INTEGER,
    user_id INTEGER,
    FOREIGN KEY(channel_id) REFERENCES channel(id),
    FOREIGN KEY(user_id) REFERENCES user(id)
);

-- Section 4

-- 1
INSERT INTO organization(name) VALUES ("Lambda School");

-- 2
INSERT INTO user(name) VALUES ("Alice");
INSERT INTO user(name) VALUES ("Bob");
INSERT INTO user(name) VALUES ("Chris");

-- 3
INSERT INTO channel(name, organization_id) VALUES ("#general", 1);
INSERT INTO channel(name, organization_id) VALUES ("#random", 1);

-- 4
INSERT INTO message(post_time, content, user_id, channel_id) VALUES (datetime(), "Test1", 1, 1);
INSERT INTO message(post_time, content, user_id, channel_id) VALUES (datetime(), "Test2", 2, 2);
INSERT INTO message(post_time, content, user_id, channel_id) VALUES (datetime(), "Test3", 3, 1);
INSERT INTO message(post_time, content, user_id, channel_id) VALUES (datetime(), "Test4", 1, 2);
INSERT INTO message(post_time, content, user_id, channel_id) VALUES (datetime(), "Test5", 2, 1);
INSERT INTO message(post_time, content, user_id, channel_id) VALUES (datetime(), "Test6", 3, 2);
INSERT INTO message(post_time, content, user_id, channel_id) VALUES (datetime(), "Test7", 1, 1);
INSERT INTO message(post_time, content, user_id, channel_id) VALUES (datetime(), "Test8", 2, 2);
INSERT INTO message(post_time, content, user_id, channel_id) VALUES (datetime(), "Test9", 3, 1);
INSERT INTO message(post_time, content, user_id, channel_id) VALUES (datetime(), "Test10", 1, 1);
INSERT INTO message(post_time, content, user_id, channel_id) VALUES (datetime(), "Test11", 2, 2);

-- 5-7
INSERT INTO channel_user(channel_id, user_id) VALUES (1, 1);
INSERT INTO channel_user(channel_id, user_id) VALUES (2, 1);
INSERT INTO channel_user(channel_id, user_id) VALUES (2, 2);
INSERT INTO channel_user(channel_id, user_id) VALUES (1, 3);

-- Section 5

-- 1
SELECT name FROM organization;

-- 2
SELECT name FROM channel;

-- 3
SELECT channel.name, organization.name 
    FROM channel, organization 
    WHERE organization_id NOT NULL 
        AND organization_id IS organization.id;

-- 4
SELECT content, name 
    FROM message, channel 
    WHERE name IS "#general" 
        AND channel_id IS channel.id 
    ORDER BY post_time;

-- 5
SELECT channel.name
    FROM channel, user, channel_user
    WHERE user.name IS "Alice"
        AND user_id IS user.id
        AND channel_id is channel.id;

--6
SELECT user.name
    FROM channel, user, channel_user
    WHERE channel.name IS "#general"
        AND user_id is user.id
        AND channel_id is channel.id;

-- 7
SELECT message.content, user.name, channel.name
    FROM message, user, channel
    WHERE user.name IS "Alice"
        AND user_id IS user.id
        AND channel_id IS channel.id;

-- 8
SELECT post_time, content, user.name, channel.name
    FROM message, user, channel
    WHERE user.name IS "Bob"
        AND channel.name IS "#random"
        AND message.user_id IS user.id
        AND message.channel_id IS channel.id;

-- 9
SELECT name as "User Name", COUNT() as "Message Count"
    FROM message, user
    WHERE user_id IS user.id
    GROUP BY user.name;

-- 10
SELECT user.name as "User", channel.name as "Channel", COUNT() as "Message Count"
    FROM message, user, channel
        WHERE user_id IS user.id AND channel_id IS channel.id
        GROUP BY user.name, channel.name;
    
-- Section 6
-- Deleting a user's messages when the user is deleted is accomplished by using
-- ON DELETE CASCADE as part of the foreign key statement