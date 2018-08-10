PRAGMA foreign_keys = ON;


CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  channel INTEGER, --foreign key
  FOREIGN KEY(channel) REFERENCES channel(id)
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  organization INTEGER, --foreign key
  FOREIGN KEY(organization) REFERENCES organization(id)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  channel INTEGER, --foreign key
  message INTEGER, --foreign key
  FOREIGN KEY(channel) REFERENCES channel(id),
  FOREIGN KEY(message) REFERENCES channel(id)
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  postTime varchar(128) NOT NULL,
  content VARCHAR(512) NOT NULL,
  user INTEGER, --foreign key
  channel INTEGER, --foreign key
  FOREIGN KEY(user) REFERENCES user(id),
  FOREIGN KEY(channel) REFERENCES channel(id)
);

INSERT INTO organization (name) VALUES ('LAMBDA SCHOOL');

INSERT INTO  channel(name, organization) VALUES ("#general", 1);
INSERT INTO  channel(name, organization) VALUES ("#random", 1);
INSERT INTO organization (name, channel) VALUES ('LAMBDA SCHOOL', 1);
INSERT INTO organization (name, channel) VALUES ('LAMBDA SCHOOL', 2);

INSERT INTO user (name, channel) VALUES('Alice', 1);
INSERT INTO user (name, channel) VALUES('Bob', 1);
INSERT INTO user (name, channel) VALUES('Chris', 1);

INSERT INTO message (content, postTime, user, channel) VALUES('perl is so good #winning', Date("now"), 1, 1);
INSERT INTO message (content, postTime, user, channel) VALUES('.net is so good #winning', Date("now"), 3, 2);
INSERT INTO message (content,postTime, user, channel) VALUES('python is so good #winning', Date("now"), 2, 2);
INSERT INTO message (content, postTime, user, channel) VALUES('ruby is so good #winning', Date("now"), 3, 1);
INSERT INTO message (content, postTime, user, channel) VALUES('c++ is so good #winning', Date("now"), 1, 1);
INSERT INTO message (content, postTime, user, channel) VALUES('c# is so good #winning', Date("now"), 3, 1);
INSERT INTO message (content,postTime, user, channel) VALUES('c is so good #winning', Date("now"), 2, 1);
INSERT INTO message (content,postTime, user, channel) VALUES('php is so good #winning', Date("now"), 3, 2);
INSERT INTO message (content,postTime, user, channel) VALUES('python is so good #winning', Date("now"), 2, 2);
INSERT INTO message (content,postTime, user, channel) VALUES('javaScript  is good #winning', Date("now"), 2, 2);

-- question 5
-- part 1 name from org
SELECT organization.name FROM organization;
-- part 2 name from channel
SELECT channel.name FROM channel;
-- part 3 orgs from channel list
SELECT organization.name AS "Organization", channel.name AS "channel" FROM channel join organization;
-- part 4 llist in genral by post time
SELECT message.content FROM  message, channel WHERE message.channel IS channel.id AND  channel.name IS "#general" ORDER  BY  message.postTime;
-- part 5 list in Alice's stuff
SELECT channel.name FROM user INNER JOIN channel ON user.channel=channel.id WHERE user.name='Alice';
-- part 6 
SELECT user.name FROM channel INNER JOIN user WHERE user.channel=channel.id AND channel.id = 1;
-- part 7 getting alices content
SELECT message.content, user.name FROM message INNER JOIN user WHERE user.name='Alice' AND message.user=user.id;
-- part 8 get bob from random
SELECT message.content,user.name from message  INNER JOIN user, channel WHERE user.name =  "Bob" AND channel.name = "#random" And message.user = user.id;
-- part 9 count from users
SELECT user.name AS "User Name", COUNT(content) AS "Message Count" FROM message, user WHERE message.user = user.id GROUP BY name ORDER BY user.name DESC;

--question 6
--ON DELETE CASCADE 