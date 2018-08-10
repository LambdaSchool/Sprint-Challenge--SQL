CREATE TABLE Organizations(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE Channels(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    orgID INTEGER,
    FOREIGN KEY (orgID) REFERENCES Organizations(id)
);

CREATE TABLE Users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR (128) NOT NULL
);

CREATE TABLE Messages(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(1500) NOT NULL,
    post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    msgChannel INTEGER,
    userID INTEGER,
    FOREIGN KEY (msgChannel) REFERENCES Channels(id),
    FOREIGN KEY (userID) REFERENCES Users(id)
);

INSERT INTO Organizations (name) VALUES ('Lambda School');

INSERT INTO Users (username) VALUES ('Alice');
INSERT INTO Users (username) VALUES ('Bob');
INSERT INTO Users (username) VALUES ('Chris');

INSERT INTO Channels (name, orgID) VALUES ('#general', 1);
INSERT INTO Channels (name, orgID) VALUES ('#random', 1);

INSERT INTO Messages (content, msgChannel, userID) VALUES ('Alice content 1', 1, 1);
INSERT INTO Messages (content, msgChannel, userID) VALUES ('Alice content 3', 2, 1);
INSERT INTO Messages (content, msgChannel, userID) VALUES ('Alice content 4', 2, 1);
INSERT INTO Messages (content, msgChannel, userID) VALUES ('Bob content 1', 1, 2);
INSERT INTO Messages (content, msgChannel, userID) VALUES ('Bob content 2', 1, 2);
INSERT INTO Messages (content, msgChannel, userID) VALUES ('Chris content 1', 2, 3);
INSERT INTO Messages (content, msgChannel, userID) VALUES ('Chris content 2', 2, 3);
INSERT INTO Messages (content, msgChannel, userID) VALUES ('Chris content 3', 2, 3);
INSERT INTO Messages (content, msgChannel, userID) VALUES ('Alice content 2', 1, 1);
INSERT INTO Messages (content, msgChannel, userID) VALUES ('Bob content 3', 1, 2);


SELECT * FROM Organizations;

SELECT * FROM Channels;

SELECT Channels.name from Channels, Organizations
    WHERE Channels.orgID = Organizations.id
    AND Organizations.name = "Lambda School";

SELECT Messages.content, Messages.post_time, Messages.userID FROM Messages, Channels
    WHERE msgChannel = Channels.id
    AND Channels.name = "#general"
    ORDER BY post_time;

SELECT Channels.name as Channel_Name FROM Channels, Messages, Users
    WHERE Channels.id = Messages.msgChannel
    AND Messages.userID = Users.id
    AND Users.username = "Alice"
    GROUP BY Channels.name;

SELECT Users.username FROM Users, Channels, Messages
    WHERE Users.id = Messages.userID
    AND Messages.msgChannel = Channels.id
    AND Channels.name = "#general"
    GROUP BY Users.username;

SELECT Messages.id, Messages.content, Messages.post_time, Messages.msgChannel, Messages.userID
    FROM Messages, Users
    WHERE Messages.userID = Users.id
    AND Users.username = "Alice";

SELECT Messages.id, Messages.content, Messages.post_time, Messages.msgChannel, Messages.userID
    FROM Messages, Channels, Users
    WHERE Messages.userID = Users.id
    AND Users.username = "Bob"
    AND Messages.msgChannel = Channels.id
    AND Channels.name = "#random";

SELECT COUNT(Messages.id) AS "Message Count", Users.username AS "User Name"
    FROM Messages, Users
    WHERE Messages.userID = Users.id
    GROUP BY Users.id
    ORDER BY Users.username desc;

SELECT COUNT(Messages.id) AS "Message Count", Users.username AS "User", Channels.name AS "Channel"
    FROM Messages, Users, Channels
    WHERE Messages.userID = Users.id
    AND Messages.msgChannel = Channels.id
    GROUP BY Messages.UserID
    HAVING COUNT(Messages.id) > 0;



DROP TABLE Organizations;
DROP TABLE Channels;
DROP TABLE Users;
DROP TABLE Messages;


-- Answer to question 6: ON DELETE CASCADE on all the foreign keys referencing it.