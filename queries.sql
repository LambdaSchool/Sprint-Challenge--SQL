CREATE TABLE organization (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE channel (id INTEGER PRIMARY KEY, name TEXT, organization_id);

CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE message (id INTEGER PRIMARY KEY, content TEXT, post_time DATETIME NOT NULL DEFAULT (GETDATE()), user_id, channel_id);

CREATE TABLE user_channel (user_id, channel_id);

INSERT INTO organization (1, "Lambda School");

INSERT INTO user VALUES(1, "Alice");
INSERT INTO user VALUES(2, "Bob");
INSERT INTO user VALUES(3, "Chris");

INSERT INTO channel VALUES(1, "#general");
INSERT INTO channel VALUES(2, "#random");

INSERT INTO message VALUES(1, "Hi", 1, 1);
INSERT INTO message VALUES(2, "my", 1, 1);
INSERT INTO message VALUES(3, "name", 1, 1);
INSERT INTO message VALUES(4, "is", 1, 1);
INSERT INTO message VALUES(5, "chika", 2, 1);
INSERT INTO message VALUES(6, "chika", 2, 2);
INSERT INTO message VALUES(7, "Slim", 2, 2);
INSERT INTO message VALUES(8, "Shady", 3, 2);
INSERT INTO message VALUES(9, "Hi", 3, 2);
INSERT INTO message VALUES(10, "kids", 3, 2);

INSERT INTO user_channel (1, 1)
INSERT INTO user_channel (1, 2)

INSERT INTO user_channel (2, 1)

INSERT INTO user_channel (3, 2)

SELECT name FROM organization;

SELECT name FROM channel;


