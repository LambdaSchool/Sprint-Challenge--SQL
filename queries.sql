.header on
.mode column

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS join_channels_users;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS organization;

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  org_id INTEGER NOT NULL,
  FOREIGN KEY (org_id) REFERENCES organization(id)
    ON DELETE CASCADE
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

CREATE TABLE join_channels_users (
  user_id INTEGER NOT NULL,
  channel_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, channel_id),
  FOREIGN KEY (user_id) REFERENCES user(id)
    ON DELETE CASCADE,
  FOREIGN KEY (channel_id) REFERENCES channel(id)
    ON DELETE CASCADE
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  content TEXT,
  author_id INTEGER,
  channel_id INTEGER,
  FOREIGN KEY (author_id) REFERENCES user(id)
    ON DELETE SET NULL,
  FOREIGN KEY (channel_id) REFERENCES channel(id)
    ON DELETE CASCADE
);

INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel (name, org_id) VALUES ("#general", 1);
INSERT INTO channel (name, org_id) VALUES ("#random", 1);

INSERT INTO join_channels_users (user_id, channel_id) VALUES (1, 1);
INSERT INTO join_channels_users (user_id, channel_id) VALUES (1, 2);
INSERT INTO join_channels_users (user_id, channel_id) VALUES (2, 1);
INSERT INTO join_channels_users (user_id, channel_id) VALUES (3, 2);

INSERT INTO message (content, author_id, channel_id) VALUES (
  "Hello world!",
  1,
  1
);

INSERT INTO message (content, author_id, channel_id) VALUES (
  "Lorem ipsum dolor amet leggings butcher cardigan, listicle keytar mustache pinterest austin locavore vaporware blue bottle swag hot chicken street art gentrify.",
  1,
  2
);

INSERT INTO message (content, author_id, channel_id) VALUES (
  "IPhone offal la croix kale chips, listicle mlkshk raclette glossier hella irony enamel pin gochujang.",
  3,
  2
);

INSERT INTO message (content, author_id, channel_id) VALUES (
  "Cras pharetra justo vel arcu fermentum vulputate.",
  2,
  1
);

INSERT INTO message (content, author_id, channel_id) VALUES (
  "Deep v jianbing retro four loko chambray roof party.",
  2,
  2
);

INSERT INTO message (content, author_id, channel_id) VALUES (
  "Butcher authentic cornhole roof party letterpress sartorial.",
  1,
  1
);

INSERT INTO message (content, author_id, channel_id) VALUES (
  "Synth leggings pabst sriracha you probably haven't heard of them hot chicken narwhal godard yr distillery food truck tilde pitchfork.",
  3,
  2
);

INSERT INTO message (content, author_id, channel_id) VALUES (
  "Jean shorts letterpress truffaut, leggings hashtag kogi PBR&B man braid yr seitan austin asymmetrical flannel.",
  2,
  1
);

INSERT INTO message (content, author_id, channel_id) VALUES (
  "Hashtag fashion axe beard selvage, schlitz knausgaard kogi humblebrag salvia cray pour-over.",
  2,
  2
);

INSERT INTO message (content, author_id, channel_id) VALUES (
  "Godard lomo man braid kogi chillwave. Kitsch cray helvetica, mlkshk blue bottle vegan flexitarian.",
  1,
  1
);

SELECT name AS "Organizations"
  FROM organization;

SELECT name AS "Channels"
  FROM channel;

SELECT organization.name AS "Organization",
       channel.name AS "Channels"
  FROM organization, channel
  WHERE organization.id = channel.org_id;

SELECT channel.name AS "Channel",
       message.content AS "Messages",
       message.post_time AS "Time Posted"
  FROM message, channel 
  WHERE message.channel_id = channel.id
  AND message.channel_id = (SELECT channel.id
                                FROM channel
                                WHERE channel.name = "#general")
  ORDER BY message.post_time;

SELECT channel.name AS "Channel",
       user.name AS "User"
  FROM user, channel
  JOIN join_channels_users 
    ON join_channels_users.channel_id = channel.id
    AND join_channels_users.user_id = user.id
  WHERE channel.name = "#general";

SELECT user.name AS "User",
       channel.name AS "Channel",
       message.content AS "Message"
  FROM user, channel, message
  WHERE message.author_id = (SELECT id
                              FROM user
                              WHERE name = "Alice")
    AND user.id = message.author_id;

SELECT user.name AS "User",
       channel.name AS "Channel"
  FROM user, channel, join_channels_users
  WHERE join_channels_users.channel_id = channel.id
    AND join_channels_users.user_id = user.id
    AND user.id = (SELECT id
                    FROM user
                    WHERE name = "Alice");

SELECT user.name AS "User", 
       channel.name AS "Channel",
       message.content AS "Message"
  FROM user, channel, message
  WHERE message.author_id = (SELECT id
                              FROM user
                              WHERE name = "Bob")
    AND message.channel_id = (SELECT id
                                FROM channel
                                WHERE name = "#random")
    AND user.id = message.author_id
    AND channel.id = message.channel_id;

SELECT user.name AS "User Name",
       COUNT(message.content) AS "Message Count"
  FROM user, message
  WHERE user.id = message.author_id
  GROUP BY user.name;

SELECT user.name AS "User Name",
       channel.name AS "Channel",
       COUNT(message.content) AS "Message Count"
  FROM user, channel, message
  WHERE user.id = message.author_id
    AND channel.id = message.channel_id
  GROUP BY user.name, channel.name
  ORDER BY user.name;