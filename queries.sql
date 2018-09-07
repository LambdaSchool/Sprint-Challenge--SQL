/********* Set up database *********/
-- sqlite3 chatroom.db
-- .mode column
-- .header on

/******** Create Tables *********/
CREATE TABLE organization (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE
    );

CREATE TABLE channel (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    organization_id INTERGER REFERENCES organization(id)
    );

CREATE TABLE user (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE
    );

CREATE TABLE message (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE user_channel (
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
    );


/********* Insertq queries *********/
-- organization
INSERT INTO organization (name) VALUES ("Lambda School");

-- channel
INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

-- user
INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

-- user_channel
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);

-- message
INSERT INTO message (content, user_id, channel_id) VALUES ("Alice in General channel", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Alice in Random channel", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Bob in General channel", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Chris in Random channel", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Nice to see you Bob from Alice", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hey, Alice. Nice to see you too", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hello everyone. This is Bob", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hello Chris. This is Alice", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hi Alice. How are you?", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("I'm Chris. Yoroshiku onegaishimasu!", 3, 2);

/*
Output Tables

SELECT * FROM organization;
id          name         
----------  -------------
1           Lambda School


SELECT * FROM user;
id          name      
----------  ----------
1           Alice     
2           Bob       
3           Chris  


SELECT * FROM channel;
id          name        organization_id
----------  ----------  ---------------
1           #general    1              
2           #random     1              


SELECT * FROM user_channel;
user_id     channel_id
----------  ----------
1           1         
1           2         
2           1         
3           2   


SELECT * FROM message;
id          content                   user_id     channel_id  post_time          
----------  ------------------------  ----------  ----------  -------------------
1           Alice in General channel  1           1           2018-09-07 16:17:29
2           Alice in Random channel   1           2           2018-09-07 16:18:06
3           Bob in General channel    2           1           2018-09-07 16:18:37
4           Chris in Random channel   3           2           2018-09-07 16:19:09
5           Nice to see you Bob from  1           1           2018-09-07 16:20:32
6           Hey, Alice. Nice to see   2           1           2018-09-07 16:22:10
7           Hello everyone. This is   2           1           2018-09-07 16:23:05
8           Hello Chris. This is Ali  1           2           2018-09-07 16:24:11
9           Hi Alice. How are you?    3           2           2018-09-07 16:25:40
10          I'm Chris. Yoroshiku one  3           2           2018-09-07 16:28:03
*/


/********* Select queries *********/
-- List all organization names.
SELECT name AS organization_name FROM organization;
/*
organization_name
-----------------
Lambda School 
*/


-- List all channel names.
SELECT name AS channel_name FROM channel;
/*
channel_name
------------
#general    
#random
*/


-- List all channels in a specific organization by organization name.
SELECT channel.name
    FROM channel, organization
    WHERE organization_id = organization.id
    AND organization.name = "Lambda School";
/*
name      
----------
#general  
#random 
*/


-- List all messages in a specific channel by channel name #general in order of post_time, descending.
SELECT message.content, channel.name, message.post_time
    FROM message, channel
    WHERE channel_id = channel.id
    AND channel.name = "#general"
    ORDER BY post_time DESC;
/*
content                      name        post_time          
---------------------------  ----------  -------------------
Hello everyone. This is Bob  #general    2018-09-07 16:23:05
Hey, Alice. Nice to see you  #general    2018-09-07 16:22:10
Nice to see you Bob from Al  #general    2018-09-07 16:20:32
Bob in General channel       #general    2018-09-07 16:18:37
Alice in General channel     #general    2018-09-07 16:17:29
*/


-- List all channels to which user Alice belongs.
SELECT channel.name 
    FROM channel, user, user_channel
    WHERE user.name = "Alice"
    AND user_id = user.id
    AND channel_id = channel.id;
/*
name      
----------
#general  
#random
*/


-- List all users that belong to channel #general.
SELECT user.name
    FROM channel, user, user_channel
    WHERE channel.name = "#general"
    AND user_id = user.id
    AND channel_id = channel.id;
/*
name      
----------
Alice     
Bob
*/


-- List all messages in all channels by user Alice.
SELECT user.name, message.content
    FROM message, user
    WHERE user_id = user.id
    AND user.name = "Alice";
/*
name        content                 
----------  ------------------------
Alice       Alice in General channel
Alice       Alice in Random channel 
Alice       Nice to see you Bob from
Alice       Hello Chris. This is Ali
*/


-- List all messages in #random by user Bob.
SELECT message.content
FROM message, channel, user
WHERE user.name = "Bob"
AND channel.name = "#random"
AND user_id = user.id
AND channel_id = channel.id;
/* nothing return*/


-- List the count of messages across all channels per user.
SELECT user.name AS "User Name", Count(*) AS "Message Count"
    FROM user, message
    WHERE user_id = user.id
    GROUP BY user.id
    ORDER BY user.name DESC;
/*
User Name   Message Count
----------  -------------
Chris       3            
Bob         3            
Alice       4 
*/


-- Stretch! List the count of messages per user per channel.
SELECT user.name 
    AS "User",
    channel.name
    AS "Channel",
    COUNT (*)
    AS "Message Count"
    FROM user, message, channel
    WHERE user_id = user.id
    AND channel_id = channel.id
    GROUP BY channel.name, user.name;
/*
User        Channel     Message Count
----------  ----------  -------------
Alice       #general    2            
Bob         #general    3            
Alice       #random     2            
Chris       #random     3
*/


/*
What SQL keywords or concept would you use 
if you wanted to automatically delete all messages 
by a user if that user were deleted from the user table?

ANSWER:  
    Add `ON DELETE CASCADE` clause to the foreign key, 
    for example, 
    `FOREIGN KEY(author_id) REFERENCES author(id) ON DELETE CASCADE`.
*/
