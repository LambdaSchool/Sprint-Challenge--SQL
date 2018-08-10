CREATE TABLE Organizations(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name VARCHAR(128) NOT NULL
); 


CREATE TABLE Channels(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name VARCHAR(128) NOT NULL, 
    organization_id INTEGER REFERENCES Organizations(id)
); 


CREATE TABLE Users(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name VARCHAR(128) NOT NULL
); 


CREATE TABLE Messages(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    content VARCHAR(2000) NOT NULL, 
    post_time DATETIME DEFAULT CURRENT_TIMESTAMP, 
    channel_id INTEGER REFERENCES Channels(id), 
    user_id INTEGER REFERENCES Users(id)
); 


	
INSERT INTO Organizations (name) VALUES ('Lambda School'); --1
INSERT INTO Organizations (name) VALUES ('Any School'); --2

INSERT INTO Users (name) VALUES ('Alice');   -- id --1

INSERT INTO Users (name) VALUES ('Bob');   -- id --2
INSERT INTO Users (name) VALUES ('Chris'); --id --3
------------------------------------------------------------------------------------------

INSERT INTO Channels (name) VALUES ('#general');--id -1
INSERT INTO Channels (name) VALUES ('#random'); --id -2

------------------------------------------------------------------------------------------

INSERT INTO Messages (content, channel_id, user_id) VALUES ('Alice content general', 1, 1);
INSERT INTO Messages (content, channel_id, user_id) VALUES ('Alice content random', 2, 1);

INSERT INTO Messages (content, channel_id, user_id) VALUES ('Alice content general2', 1, 1);
INSERT INTO Messages (content, channel_id, user_id) VALUES ('Alice content random2', 2, 1);

------------------------------------------------------------------------------------------
INSERT INTO Messages (content, channel_id, user_id) VALUES ('Bob content general', 1, 2);


INSERT INTO Messages (content, channel_id, user_id) VALUES ('Bob content general2', 1, 2);

INSERT INTO Messages (content, channel_id, user_id) VALUES ('Bob content general3', 1, 2);

------------------------------------------------------------------------------------------


INSERT INTO Messages (content, channel_id, user_id) VALUES ('Chris content random', 2, 3);

INSERT INTO Messages (content, channel_id, user_id) VALUES ('Chris content random2', 2, 3);
INSERT INTO Messages (content, channel_id, user_id) VALUES ('Chris content random3', 2, 3);

INSERT INTO Messages (content, channel_id, user_id) VALUES ('Chris content random4', 2, 3);
------------------------------------------------------------------------------------------
-- List all organization names.
SELECT name FROM Organizations;
-- List all channel names.
SELECT name FROM Channels;

-- List all channels in a specific organization by organization name.
SELECT Organizations.name AS "Organization", channels.name AS "Channel" FROM Channels JOIN Organizations;


--List all messages in a specific channel by channel name #general in order of post_time, descending.
SELECT Messages.content AS text, post_time AS time FROM Messages, Channels WHERE Messages.channel_id=Channels.id AND Channels.name="#general" ORDER BY Messages.post_time DESC;

-- List all channels to which user Alice belongs.
SELECT Channels.name AS CH_NAME, Users.name AS user FROM Channels JOIN Users WHERE Users.name="Alice"; 

--List all users that belong to channel #general.

SELECT Users.name AS username, Channels.name AS general FROM Channels JOIN Users WHERE Channels.name="#general"; 

--List all messages in all channels by user Alice.

SELECT Messages.content AS text, Users.name AS user, Channels.name AS ch FROM Messages, Users, Channels WHERE Messages.user_id=Users.id AND Users.name="Alice"; 
-- SELECT Messages.content AS text, Users.name AS user, Channels.name AS ch FROM Messages JOIN Users, Channels WHERE Messages.user_id=Users.id AND Users.name="Alice"; 

-- SELECT Messages.content, Users.name AS username FROM Users, Messages WHERE Users.id IS Messages.user_id AND Users.name IS "Alice";

-- List all messages in #random by user Bob.

SELECT Messages.content AS text, Users.name AS user, Channels.name AS ch FROM Messages, Users, Channels WHERE Messages.user_id=Users.id AND Users.name="Bob" AND Channels.name='#random'; 
-- SELECT Messages.content AS text, Users.name AS user, Channels.name AS ch FROM Messages JOIN Channels JOIN Users WHERE Messages.user_id=Users.id AND Channels.name='#random' AND Users.name='Bob'; 

-- List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.)
SELECT Users.name as 'User Name', COUNT(Messages.id) AS 'Message Count' FROM Messages, Users WHERE Messages.user_id=Users.id GROUP BY Users.name;

-- SELECT COUNT(Messages.id) AS msg_count, Users.name AS username
-- FROM Messages, Users
-- WHERE Messages.user_id = Users.id GROUP BY Users.name;

------------------------------------------------------------------------------------------
-- Stretch Goal
-- WIP



------------------------------------------------------------------------------------------
-- 6. What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?
-- Ans: first i would set 'PRAGMA foreign_keys = on' and  ON DELETE CASCADE to the orphan messages 

