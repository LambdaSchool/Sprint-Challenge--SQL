CREATE TABLE Organizations( id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(128) NOT NULL, channels_id INT REFERENCES channels(id));

CREATE TABLE Channels( id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(128) NOT NULL, users_id INT REFERENCES users(id));

CREATE TABLE Users( id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(128) NOT NULL);

CREATE TABLE Messages( id INTEGER PRIMARY KEY AUTOINCREMENT, content VARCHAR(128) NOT NULL, post_time DATETIME DEFAULT CURRENT_TIMESTAMP,channels_id INT REFERENCES channels(id),users_id INT REFERENCES users(id));


INSERT INTO Organizations (name, channels_id) VALUES ("Lambda School", 1);

INSERT INTO Channels(name,  users_id) VALUES ("general", "1,2");
INSERT INTO Channels(name,  users_id) VALUES ("random", "1,3");



INSERT INTO Users(name) VALUES ("Alice");
INSERT INTO Users(name) VALUES ("bob");
INSERT INTO Users(name) VALUES ("chris");


INSERT INTO Messages(content, channels_id, users_id) VALUES ("hey i am in general",1, 1);
INSERT INTO Messages(content, channels_id, users_id) VALUES ("hey i am in general AS WELL",1, 2);
INSERT INTO Messages(content, channels_id, users_id) VALUES ("am i bob",1, 2);
INSERT INTO Messages(content, channels_id, users_id) VALUES ("another message",1, 2);
INSERT INTO Messages(content, channels_id, users_id) VALUES ("boooL",1, 1);
INSERT INTO Messages(content, channels_id, users_id) VALUES ("hey from random",2, 1);
INSERT INTO Messages(content, channels_id, users_id) VALUES (" i am alice",2, 1);
INSERT INTO Messages(content, channels_id, users_id) VALUES (" i am chris",2, 3);
INSERT INTO Messages(content, channels_id, users_id) VALUES (" i am",2, 3);
INSERT INTO Messages(content, channels_id, users_id) VALUES (" i am duper",2, 3);
INSERT INTO Messages(content, channels_id, users_id) VALUES (" i am cool",2, 3);




SELECT NAME FROM Organizations;


SELECT NAME FROM Channels;


SELECT * FROM Organizations,Channels WHERE Organizations.name = "Lambda School";

SELECT * FROM Messages, Channels  WHERE Channels.name is "general" AND messages.channels_id = channels.id Order BY post_time;

SELECT * FROM users,Channels  WHERE Users.name is "Alice";


SELECT * FROM users,Channels,Messages  WHERE Users.name is "bob" AND channels.Name = "random" AND messages.channels_id = channels.id;


SELECT COUNT(messages.channels_id),users.name FROM users,Channels,Messages  WHERE messages.channels_id = channels.id AND messages.users_id = users.id GROUP BY users.Name;



-- CASCADE - A foreign key with cascade delete means that if a record in the parent table is deleted,
--      then the corresponding records in the child table will automatically be deleted. This is called a cascade delete in SQL Server.