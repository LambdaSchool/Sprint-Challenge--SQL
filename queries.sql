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
  post_time varchar(128) NOT NULL,
  content VARCHAR(512) NOT NULL,
  user INTEGER, --foreign key
  channel INTEGER, --foreign key
  FOREIGN KEY(user) REFERENCES user(id),
  FOREIGN KEY(channel) REFERENCES channel(id)
);

INSERT INTO organization (name) VALUES ('LAMBDA SCHOOL');

INSERT INTO  channel(name, organization) VALUES ("#general", 1);
INSERT INTO  channel(name, organization) VALUES ("#cs9_cody", 1);
INSERT INTO  channel(name, organization) VALUES ("#random", 1);

UPDATE organization
SET channel = 1
WHERE id=1;
INSERT INTO organization (name, channel) VALUES ('LAMBDA SCHOOL', 2);
INSERT INTO organization (name, channel) VALUES ('LAMBDA SCHOOL', 3);

INSERT INTO user (name, channel) VALUES('Alice', 1);
INSERT INTO user (name, channel) VALUES('Alice', 3);
INSERT INTO user (name, channel) VALUES('Bob', 1);
INSERT INTO user (name, channel) VALUES('Chris', 3);

INSERT INTO message (content, post_time, user, channel) VALUES('hello world', Date("now"), 1, 1);
INSERT INTO message (content, post_time, user, channel) VALUES('hello world', Date("now"), 3, 2);
INSERT INTO message (content, post_time, user, channel) VALUES('hello world', Date("now"), 2, 3);
INSERT INTO message (content, post_time, user, channel) VALUES('hello world', Date("now"), 4, 1);
INSERT INTO message (content, post_time, user, channel) VALUES('hello world', Date("now"), 1, 1);
INSERT INTO message (content, post_time, user, channel) VALUES('hello world', Date("now"), 1, 1);
INSERT INTO message (content, post_time, user, channel) VALUES('hello world', Date("now"), 1, 1);
INSERT INTO message (content, post_time, user, channel) VALUES('hello world', Date("now"), 1, 1);
INSERT INTO message (content, post_time, user, channel) VALUES('hello world', Date("now"), 1, 1);
INSERT INTO message (content, post_time, user, channel) VALUES('hello world', Date("now"), 1, 1);


SELECT organization.name FROM organization;
SELECT channel.name FROM channel;
SELECT organization.name AS "Organization", channel.name AS "channel" FROM channel join organization;
SELECT message.content FROM  message, channel WHERE message.channelId IS channelId AND  channel.name IS "#general" ORDER  BY  message.postTime;
SELECT channel.name FROM user INNER JOIN channel WHERE user.channel=channel.id WHERE user.name='Alice';
SELECT user.name FROM channel INNER JOIN user WHERE user.channel=channel.id AND channel.id = 1;
SELECT message.content, user.name FROM message INNER JOIN user WHERE user.name='Alice' AND message.user=user.id;
SELECT message.content,user.name from message  INNER JOIN user, channel WHERE user.name =  "Bob" AND channel.name = "#random" And message.user = user.id;
SELECT user.name AS "User Name", COUNT(content) AS "Message Count" FROM message, user WHERE message.user = user.id GROUP BY name ORDER BY user.name DESC;

-- question six: i would use ON DELETE CASCADE to delete all messages associated with the user.