PRAGMA foreign_keys = ON; 

-- Tables
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    org_name VARCHAR(128) NOT NULL
);
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ch_name VARCHAR(128) NOT NULL,
    organization_id INTEGER REFERENCES organization(id)
);
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(128) NOT NULL,
    organization_id INTEGER REFERENCES organization(id)
);
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    dt DATETIME DEFAULT current_timestamp,
    content VARCHAR(128) NOT NULL,
    user_id INTEGER REFERENCES user(id),
    recipient INTEGER REFERENCES user(id)
);

-- Join Tables
CREATE TABLE channel_user (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);
CREATE TABLE channel_message (
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id),
    dt DATETIME DEFAULT current_timestamp,
    content VARCHAR(128) NOT NULL
);

INSERT INTO organization (org_name) VALUES ("Lambda School");

INSERT INTO user (username,organization_id) VALUES ("Alice",1);
INSERT INTO user (username,organization_id) VALUES ("Bob",1);
INSERT INTO user (username,organization_id) VALUES ("Chris",1);

INSERT INTO channel (ch_name,organization_id) VALUES ("#general",1);
INSERT INTO channel (ch_name,organization_id) VALUES ("#random",1);

INSERT INTO message (content, user_id, recipient) VALUES ("Hey",1,2);
INSERT INTO message (content, user_id, recipient) VALUES ("Hello",1,3);
INSERT INTO message (content, user_id, recipient) VALUES ("Hola", 2,1);
INSERT INTO message (content, user_id, recipient) VALUES ("Guten Tag",2, 3);
INSERT INTO message (content, user_id, recipient) VALUES ("Bien Venudo",3,1);
INSERT INTO message (content, user_id, recipient) VALUES ("Bonjour",3,2);

INSERT INTO channel_message (channel_id,user_id,content) 
    VALUES (1,1,"Hey Everyone");
INSERT INTO channel_message (channel_id,user_id,content) 
    VALUES (1,2,"Hey How's A Goin!");
INSERT INTO channel_message (channel_id,user_id,content) 
    VALUES (1,3,"Hey There");
INSERT INTO channel_message (channel_id,user_id,content) 
    VALUES (2,1,"I eat paint");
INSERT INTO channel_message (channel_id,user_id,content) 
    VALUES (2,2,"I love penguins");
INSERT INTO channel_message (channel_id,user_id,content) 
    VALUES (2,3,"How much do you love them?");

INSERT INTO channel_user (user_id,channel_id) VALUES (1,1); 
INSERT INTO channel_user (user_id,channel_id) VALUES (1,2); 
INSERT INTO channel_user (user_id,channel_id) VALUES (2,1); 
INSERT INTO channel_user (user_id,channel_id) VALUES (3,2); 

--  1. List all organization `name`s.
SELECT org_name FROM organization;
-- 2. List all channel `name`s.
SELECT ch_name FROM channel;
-- 3. List all channels in a specific organization by organization `name`.
SELECT channel.ch_name AS "Channel Name", organization.org_name AS "Organization Name" 
    FROM channel,organization 
    WHERE channel.organization_id=organization.id;

-- 4. List all messages in a specific channel by channel `name` `#general` in
--    order of `post_time`, descending.    
SELECT channel_message.user_id AS "User", channel_message.content AS "MESSAGE"
    FROM channel_message,channel,user 
    WHERE channel.ch_name="#general" 
    AND channel_message.channel_id = channel.id
    AND channel_message.user_id = user.id
    ORDER BY channel_message.dt DESC;

-- 5. List all channels to which user `Alice` belongs.
-- Not sure if my DB is broken or my query is broken,
-- but without the DISTINCT keyword I would receive 2 of everything
SELECT DISTINCT user.username, channel.ch_name FROM user, channel, channel_user
    WHERE user.username = "Alice"
    AND channel_user.channel_id = channel.id;
    
-- 6. List all users that belong to channel `#general`.
SELECT user.username, channel.ch_name from channel_user,user,channel 
    WHERE channel_user.user_id = user.id
    AND channel_user.channel_id = channel.id
    AND channel.ch_name = "#general";

-- 7. List all messages in all channels by user `Alice`.
SELECT channel_message.content FROM channel_message,user 
    WHERE channel_message.user_id = user.id
    AND user.username = "Alice";

-- 8. List all messages in `#random` by user `Bob`.
SELECT channel_message.content from channel_message,user,channel
    WHERE channel_message.channel_id = channel.id
    AND channel_message.user_id = user.id
    AND channel.ch_name = "#random"
    AND user.username = "Bob";

-- 9. List the count of messages across all channels per user.
SELECT user.username,COUNT(*) FROM user,channel_message
    WHERE channel_message.user_id = user.id
    GROUP BY user.id
    ORDER BY user.username DESC;

-- 10. [Stretch!] List the count of messages per user per channel.
SELECT user.username, channel.ch_name,
    SUM(CASE WHEN channel_message.user_id = user.id THEN 1 ELSE 0 END)
    FROM user,channel_message,channel
    WHERE channel_message.user_id = user.id
    AND channel_message.channel_id = channel.id
    GROUP BY user.id, channel_message.channel_id
    ORDER BY channel.ch_name ASC;

--6. What SQL keywords or concept would you use if you wanted to automatically
--   delete all messages by a user if that user were deleted from the `user` table?
    
--  I am reasonably sure this wouldn't even be possible to delete a user without
--  deleting there messages first.  At least that was the case during a lecture.