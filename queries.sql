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

