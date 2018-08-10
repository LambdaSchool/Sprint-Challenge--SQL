PRAGMA foreign_keys = ON;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    channel VARCHAR(128),
    FOREIGN KEY (channel) REFERERENCES channel (id));
CREATE TABLE channel(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    organization_id INTEGER NOT NULL,
    FOREIGN KEY(organization) REFERERENCES organization(id)
   );
CREATE TABLE user(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    FOREIGN KEY(channel) REFERERENCES channel(id)
    );

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    message VARCHAR(1500) NOT NULL,
    postTime VARCHAR(128) NOT NULL,
    userId INTEGER REFERERENCES user(id),
    channelId INTEGER REFERERENCES channel(id)
    );

INSERT INTO organization (name,1) VALUES ("Lambda School");

INSERT INTO  channel(name) VALUES ("#general");
INSERT INTO  channel(name) VALUES ("#random");



INSERT INTO user (name,organization_id) VALUES('Alice',1);
INSERT INTO user (name,organization_id) VALUES('Bob',1);
INSERT INTO user (name,organization_id) VALUES('Chris',1);

INSERT INTO  channel (channelId, userId) VALUES (1,1);
INSERT INTO  channel (channelId, userId) VALUES (2,1);
INSERT INTO  channel (channelId, userId) VALUES (1,2);
INSERT INTO  channel (channelId, userId) VALUES (2,3);

INSERT INTO message (content, postTime, userId, channelId) VALUES ("perl is so good #winning", date("now"), 1,1);
INSERT INTO message (content, postTime, userId, channelId) VALUES (".net is so good #winning", date("now"), 1,2);
INSERT INTO message (content, postTime, userId, channelId) VALUES ("java is so good #winning", date("now"), 2,1);
INSERT INTO message (content, postTime, userId, channelId) VALUES ("ruby is so good #winning", date("now"), 2,2);
INSERT INTO message (content, postTime, userId, channelId) VALUES ("c++ is so good #winning", date("now"), 3,1);
INSERT INTO message (content, postTime, userId, channelId) VALUES ("c# is so good #winning", date("now"), 3,2);
INSERT INTO message (content, postTime, userId, channelId) VALUES ("c is so good #winning", date("now"), 1,1);
INSERT INTO message (content, postTime, userId, channelId) VALUES ("php is so good #winning", date("now"), 2,2);
INSERT INTO message (content, postTime, userId, channelId) VALUES ("python is so good #winning", date("now"), 3,2);
INSERT INTO message (content, postTime, userId, channelId) VALUES ("javaScript  is good #winning", date("now"), 1,2);

-- question 5
-- part 1 name from org
SELECT name FROM organization;
-- part 2 name from channel
SELECT name FROM channel;
-- part 3 orgs channel list
SELECT organization.name AS "Organization", channel.name AS "Channel" FROM Channel JOIN organization;
-- part 4  list in genral by post time 
SELECT message.content FROM  message, channel WHERE message.channelId IS channelId AND  channel.name IS "#general" ORDER  BY  message.postTime;
-- part 5 list alcies stuff
SELECT channel.name FROM user INNER JOIN channel ON user.channel = channel.id WHERE user.name="Alice";
-- question 6
SELECT user.name, channel.name FROM channel INNER JOIN user WHERE user.channel=channel.id AND channel.id = 1;
-- question 7 getting alices content 
SELECT message.content From message INNER JOIN user WHERE user.name = "Alice" AND message.user = user.id;
-- question 8 get bob from random, random bob is gotten randomly
SELECT message.content from message  INNER JOIN user, channel WHERE user.name =  "Bob" AND channel.name = "#random" AND message.user = user.id;
-- part 9 message count from users
SELECT user.name AS "User Name", COUNT(message.content) AS "Message Count" FROM message, user WHERE userId = user.id GROUP BY name ORDER BY user.name DESC;

-- Question six
-- ON DELETE cascade;