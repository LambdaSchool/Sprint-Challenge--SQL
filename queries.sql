CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    org_id INT REFERENCES organization(id)
);
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    org_id INT REFERENCES organization(id)
);
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time DATETIME,
    content VARCHAR(500),
    channel_id INT REFERENCES channel(id),
    user_id INT REFERENCES user(id)
);
CREATE TABLE user_messages (
    user_id INT REFERENCES user(id),
    message_id INT REFERENCES message(id)
);
CREATE TABLE organization_channels (
    org_id INT REFERENCES organization(id),
    channel_id INT REFERENCES channel(id)
);
CREATE TABLE organization_users (
    org_id INT REFERENCES organization(id),
    user_id INT REFERENCES user(id)
);
CREATE TABLE channel_users (
    channel_id INT REFERENCES user(id),
    user_id INT REFERENCES channel(id)
);

INSERT INTO organization VALUES (1, 'Lambda School');
INSERT INTO user VALUES (1, "Alice", 1);
INSERT INTO user VALUES (2, "Bob", 1);
INSERT INTO user VALUES (3, "Christina", 1);
INSERT INTO channel VALUES (1, "#general", 1);
INSERT INTO channel VALUES (2, "#random", 1);
INSERT INTO message VALUES (1, '2017-08-25 08:56:43', ':coffee: Good Morning, Lambda School!', 2, 3);
INSERT INTO message VALUES (2, '2017-08-25 08:57:43', ":joy: That'shilarious!", 2, 1);
INSERT INTO message VALUES (3, '2018-08-25 10:46:02', "Cats are awesome", 1, 2);
INSERT INTO message VALUES (4, '2018-09-05 23:46:02', "React is so much fun!", 2, 3);
INSERT INTO message VALUES (5, '2018-09-05 23:46:15', "I know I'm in the minority, but Game of Thrones...not my thing", 2, 1);
INSERT INTO message VALUES (6, '2018-09-25 19:46:02', "I got my dream job!", 1, 2);
INSERT INTO message VALUES (7, '2018-09-25 18:46:02', "What is the topic for the next brownbag?", 1, 1);
INSERT INTO message VALUES (8, '2018-10-25 14:26:34', "studentforms", 1, 2);
INSERT INTO message VALUES (9, '2018-10-21 1:26:34', "How does Lambda Next work?", 1, 3);
INSERT INTO message VALUES (10, '2018-10-21 1:28:34', "When do you wear your sunglasses?", 2, 2);
INSERT INTO channel_users VALUES (1, 1);
INSERT INTO channel_users VALUES (2, 1);
INSERT INTO channel_users VALUES (1, 2);
INSERT INTO channel_users VALUES (2, 3);
INSERT INTO organization_users VALUES (1, 1);
INSERT INTO organization_users VALUES (1, 2);
INSERT INTO organization_users VALUES (1, 3);
INSERT INTO organization_channels VALUES (1, 1);
INSERT INTO organization_channels VALUES (1, 2);
INSERT INTO user_messages VALUES (3,1);
INSERT INTO user_messages VALUES (1,2);
INSERT INTO user_messages VALUES (2,3);
INSERT INTO user_messages VALUES (3,4);
INSERT INTO user_messages VALUES (1,5);
INSERT INTO user_messages VALUES (2,6);
INSERT INTO user_messages VALUES (1,7);
INSERT INTO user_messages VALUES (2,8);
INSERT INTO user_messages VALUES (3,9);
INSERT INTO user_messages VALUES (2,10);