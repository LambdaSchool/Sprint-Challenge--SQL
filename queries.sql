CREATE TABLE organization(
  organization_id INTEGER PRIMARY KEY AUTOINCREMENT,
  organization_name  VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE channel(
  channel_id INTEGER PRIMARY KEY AUTOINCREMENT,
  channel_name VARCHAR(50),
  organization_id INTEGER
   NOT NULL REFERENCES organization(organization_id)
);

CREATE TABLE user(
  u_id INTEGER PRIMARY KEY AUTOINCREMENT,
  username VARCHAR(50),
  firstname VARCHAR(50),
  lastname VARCHAR(50)
);

CREATE TABLE message(
  message_id INTEGER PRIMARY KEY AUTOINCREMENT,
  message_content VARCHAR(128),
  u_id  INTEGER NOT NULL REFERENCES user(u_id),
  channel_id INTEGER NOT NULL REFERENCES channel(channel_id),
  post_time timestamp DATE DEFAULT(DATETIME('NOW', 'LOCALTIME'))
);

CREATE TABLE channel_user(
  u_id INTEGER REFERENCES user(u_id),
  channel_id INTEGER REFERENCES channel(channel_id)
);

INSERT INTO organization(organization_name) VALUES('PFIZER');
INSERT INTO organization(organization_name) VALUES('ALU');
INSERT INTO organization(organization_name) VALUES('Lambda School');
INSERT INTO organization(organization_name) VALUES('NOKIA');

INSERT INTO user(username, firstname, lastname) VALUES('alicejones','Alice','Johns');
INSERT INTO user(username, firstname, lastname) VALUES('bobM','Bob','Marley');
INSERT INTO user(username, firstname, lastname) VALUES('ChrisR','Chris','Rock');

INSERT INTO channel(channel_name, organization_id) VALUES('#random', 1);
INSERT INTO channel(channel_name, organization_id) VALUES('#general', 1);
INSERT INTO channel(channel_name, organization_id) VALUES('#general #random', 1);
INSERT INTO channel(channel_name, organization_id) VALUES('#general', 2);
INSERT INTO channel(channel_name, organization_id) VALUES('#random', 2);
INSERT INTO channel(channel_name, organization_id) VALUES('#general #random', 2);


INSERT INTO message(message_content, u_id, channel_id) VALUES('Content of messege1 with uid 1 and channel id 1 ', 1, 1);
INSERT INTO message(message_content, u_id, channel_id) VALUES('Content of messege2 with uid 2 and channel id 1 ', 2, 1);
INSERT INTO message(message_content, u_id, channel_id) VALUES('Content of messege3 with uid 3 and channel id 1 ', 3, 1);
INSERT INTO message(message_content, u_id, channel_id) VALUES('Content of messege4 with uid 3 and channel id 2 ', 3, 2);
INSERT INTO message(message_content, u_id, channel_id) VALUES('Content of messege5 with uid 2 and channel id 2 ', 2, 2);
INSERT INTO message(message_content, u_id, channel_id) VALUES('Content of messege6 with uid 1 and channel id 2 ', 1, 2);
INSERT INTO message(message_content, u_id, channel_id) VALUES('Content of messege6 with uid 1 and channel id 3 ', 1, 3);
INSERT INTO message(message_content, u_id, channel_id) VALUES('Content of messege6 with uid 2 and channel id 3 ', 2, 3);
INSERT INTO message(message_content, u_id, channel_id) VALUES('Content of messege6 with uid 3 and channel id 3 ', 3, 3);


INSERT INTO channel_user(u_id, channel_id) VALUES(1,1);
INSERT INTO channel_user(u_id, channel_id) VALUES(2,1);
INSERT INTO channel_user(u_id, channel_id) VALUES(3,1);
INSERT INTO channel_user(u_id, channel_id) VALUES(1,2);
INSERT INTO channel_user(u_id, channel_id) VALUES(2,2);
INSERT INTO channel_user(u_id, channel_id) VALUES(3,2);
INSERT INTO channel_user(u_id, channel_id) VALUES(1,2);
INSERT INTO channel_user(u_id, channel_id) VALUES(2,2);
INSERT INTO channel_user(u_id, channel_id) VALUES(3,2);

-- 1. List all organization `name`s.
SELECT * FROM organization;
-- organization_id  organization_name
-- ---------------  -----------------
-- 1                Lambda School
-- 2                NOKIA
-- 3                ALU
-- 4                PFIZER

-- 2. List all channel `name`s.
SELECT channel_name FROM channel;
-- channel_name
-- ------------
-- #general
-- #random
-- #general #random

-- List all channels in a specific organization by organization `name`.
SELECT channel_name, organization_name 
FROM  channel C JOIN organization O 
ON C.organization_id = O.organization_id;
-- channel_name  organization_name
-- ------------  -----------------
-- #general      Lambda School
-- #random       Lambda School
-- #general #random  Lambda School
-- #general #random  NOKIA
-- #general   NOKIA
-- #random  NOKIA

-- List all messages in a specific channel by channel `name` `#general` in order of `post_time`, descending. (Hint: `ORDER BY`. Because your 
-- `INSERT`s might have all taken place at the exact same time, this might not return meaningful results. But humor us with the `ORDER BY` anyway.)
SELECT *
FROM message M JOIN channel C
ON M.channel_id = C.channel_id
WHERE channel_name='#general'
ORDER BY post_time DESC;
-- message_id  message_content                                   u_id        channel_id  post_time            channel_id  channel_name  organization_id
-- ----------  ------------------------------------------------  ----------  ----------  -------------------  ----------  ------------  ---------------
-- 3           Content of messege3 with uid 3 and channel id 1   3           1           2018-09-07 12:10:52  1           #general      1
-- 2           Content of messege2 with uid 2 and channel id 1   2           1           2018-09-07 12:10:37  1           #general      1
-- 1           Content of messege1 with uid 1 and channel id 1   1           1           2018-09-07 12:10:19  1           #general      1

-- 5. List all channels to which user `Alice` belongs.
SELECT * 
FROM channel C JOIN channel_user CU 
ON C.channel_id = CU.channel_id 
JOIN user U 
ON U.u_id = CU.u_id
WHERE U.firstname = 'Alice';
-- channel_id  channel_name  organization_id  u_id        channel_id  u_id        username    firstname   lastname
-- ----------  ------------  ---------------  ----------  ----------  ----------  ----------  ----------  ----------
-- 1           #general      1                1           1           1           alicejones  Alice       Johns
-- 2           #random       1                1           2           1           alicejones  Alice       Johns
-- 3           #general #ra  1                1           3           1           alicejones  Alice       Johns

-- 6. List all users that belong to channel `#general`.
SELECT * FROM user U JOIN channel_user CU 
ON U.u_id = CU.u_id JOIN channel C 
ON C.channel_id = CU.channel_id 
WHERE channel_name= '#general';
-- u_id        username    firstname   lastname    u_id        channel_id  channel_id  channel_name  organization_id
-- ----------  ----------  ----------  ----------  ----------  ----------  ----------  ------------  ---------------
-- 1           alicejones  Alice       Johns       1           1           1           #general      1
-- 2           bobM        Bob         Marley      2           1           1           #general      1
-- 3           ChrisR      Chris       Rock        3           1           1           #general      1

-- 7. List all messages in all channels by user `Alice`.
SELECT * FROM 
channel C JOIN message M 
ON M.channel_id = C.channel_id 
JOIN user U 
ON U.u_id = M.u_id 
WHERE U.firstname= 'Alice';
-- channel_id  channel_name  organization_id  message_id  message_content                                   u_id        channel_id  post_time            u_id        username    firstname   lastname
-- ----------  ------------  ---------------  ----------  ------------------------------------------------  ----------  ----------  -------------------  ----------  ----------  ----------  ----------
-- 1           #general      1                1           Content of messege1 with uid 1 and channel id 1   1           1           2018-09-07 12:10:19  1           alicejones  Alice       Johns
-- 2           #random       1                6           Content of messege5 with uid 3 and channel id 3   1           2           2018-09-07 12:12:16  1           alicejones  Alice       Johns
-- 3           #general #ra  1

-- 8. List all messages in `#random` by user `Bob`.
SELECT * FROM channel C JOIN message M 
ON M.channel_id = C.channel_id JOIN user U 
ON U.u_id = M.u_id 
WHERE U.firstname= 'Bob' AND C.channel_name ='#random';
-- channel_id  channel_name  organization_id  message_id  message_content                                   u_id        channel_id  post_time            u_id        username    firstname   lastname
-- ----------  ------------  ---------------  ----------  ------------------------------------------------  ----------  ----------  -------------------  ----------  ----------  ----------  ----------
-- 2           #random       1                5           Content of messege5 with uid 2 and channel id 2   2           2           2018-09-07 12:11:53  2           bobM        Bob         Marley


-- 9. List the count of messages across all channels per user. (Hint:`COUNT`, `GROUP BY`.)
SELECT  U.firstname AS 'User Name', COUNT(*) AS 'Message Count'  
FROM channel C JOIN message M 
ON M.channel_id = C.channel_id JOIN user U 
ON U.u_id = M.u_id 
GROUP BY(U.u_id);
-- User Name   Message Count
-- ----------  -------------
-- Alice       3
-- Bob         4
-- Chris       2

-- 10. [Stretch!] List the count of messages per user per channel.
SELECT  U.firstname AS 'User Name', channel_name AS 'Channel', COUNT(*) AS 'Message Count'  
FROM channel C JOIN message M 
ON M.channel_id = C.channel_id JOIN user U 
ON U.u_id = M.u_id 
GROUP BY( C.channel_id);
-- User Name   Channel     Message Count
-- ----------  ----------  -------------
-- Chris       #general    3
-- Alice       #random     3
-- Bob         #general #  3

-- 6. What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the `user`table?
-- the term is cascade, once the cascade on delete is set on the table, when all messages are deleted all related user info will be deleted with it, keeping the integrity and
-- consistancy of the database.