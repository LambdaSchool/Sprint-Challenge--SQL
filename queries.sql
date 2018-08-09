DROP TABLE IF EXISTS organization;
CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

DROP TABLE IF EXISTS channel;
CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  organization_id INTEGER REFERENCES organization(id)
);

DROP TABLE IF EXISTS user;
CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

DROP TABLE IF EXISTS message;
CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  content TEXT,
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);

DROP TABLE IF EXISTS channel_user;
CREATE TABLE channel_user (
  channel_id INTEGER REFERENCES channel(id),
  user_id INTEGER REFERENCES user(id)
);

INSERT INTO organization (name) VALUES ('Lambda School');
INSERT INTO organization (name) VALUES ('Free Code Camp');
INSERT INTO organization (name) VALUES ('Edx');

INSERT INTO channel (name, organization_id) VALUES ('#general', 1);
INSERT INTO channel (name, organization_id) VALUES ('#random', 1);
INSERT INTO channel (name, organization_id) VALUES ('#computerscience', 1);
INSERT INTO channel (name, organization_id) VALUES ('#lambdalabs', 1);
INSERT INTO channel (name, organization_id) VALUES ('#careerdevelopment', 1);
INSERT INTO channel (name, organization_id) VALUES ('#isa', 1);
INSERT INTO channel (name, organization_id) VALUES ('#javascript', 2);
INSERT INTO channel (name, organization_id) VALUES ('#campfires', 2);
INSERT INTO channel (name, organization_id) VALUES ('#nonprofits', 2);
INSERT INTO channel (name, organization_id) VALUES ('#cs50', 3);
INSERT INTO channel (name, organization_id) VALUES ('#puzzleday', 3);

INSERT INTO user (name) VALUES ('Alice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');
INSERT INTO user (name) VALUES ('Devon');
INSERT INTO user (name) VALUES ('Marjoerie');
INSERT INTO user (name) VALUES ('Moonlight');
INSERT INTO user (name) VALUES ('Ponzi');
INSERT INTO user (name) VALUES ('Taylor');
INSERT INTO user (name) VALUES ('Artemis');

INSERT INTO message (content, user_id, channel_id) VALUES ('Goes down the rabbit whole.', 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('The clock goes "tick tock, tick tock"!', 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('The builder, CAN HE DO IT!?!', 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Rock, Brown, Hemsworth?...', 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('Computer Science at Lambda School is AWESOME!', 4, 3);
INSERT INTO message (content, user_id, channel_id) VALUES ('Learning Javascrip with Free Code Camp School is SHWEET!', 4, 7);
INSERT INTO message (content, user_id, channel_id) VALUES ('CS50 was the SHIT!', 4, 10);
INSERT INTO message (content, user_id, channel_id) VALUES ('Make all the MONEIES!', 5, 5);
INSERT INTO message (content, user_id, channel_id) VALUES ('Da fuq is a non-profit!?', 5, 9);
INSERT INTO message (content, user_id, channel_id) VALUES ('Can has puzzle?', 6, 11);
INSERT INTO message (content, user_id, channel_id) VALUES ('The ideas are flowing.', 7, 4);
INSERT INTO message (content, user_id, channel_id) VALUES ('FIRE!!!', 7, 8);
INSERT INTO message (content, user_id, channel_id) VALUES ('Do it for SCIENCE!', 7, 3);
INSERT INTO message (content, user_id, channel_id) VALUES ('Insane smile assault?', 8, 6);
INSERT INTO message (content, user_id, channel_id) VALUES ('FIRE!!!', 8, 8);
INSERT INTO message (content, user_id, channel_id) VALUES ('I can keyboard too.', 9, 7);

INSERT INTO channel_user (channel_id, user_id) VALUES (1, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 2);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 3);
INSERT INTO channel_user (channel_id, user_id) VALUES (3, 4);
INSERT INTO channel_user (channel_id, user_id) VALUES (3, 7);
INSERT INTO channel_user (channel_id, user_id) VALUES (4, 7);
INSERT INTO channel_user (channel_id, user_id) VALUES (5, 5);
INSERT INTO channel_user (channel_id, user_id) VALUES (6, 8);
INSERT INTO channel_user (channel_id, user_id) VALUES (7, 4);
INSERT INTO channel_user (channel_id, user_id) VALUES (7, 9);
INSERT INTO channel_user (channel_id, user_id) VALUES (8, 7);
INSERT INTO channel_user (channel_id, user_id) VALUES (8, 8);
INSERT INTO channel_user (channel_id, user_id) VALUES (9, 5);
INSERT INTO channel_user (channel_id, user_id) VALUES (10, 4);
INSERT INTO channel_user (channel_id, user_id) VALUES (11, 6);

----- Base Line of all rows -----
SELECT * FROM organization;
SELECT * FROM channel;
SELECT * FROM user;
SELECT * FROM message;
SELECT * FROM channel_user;

----- All organization names -----
SELECT name FROM organization;

----- All channel names -----
SELECT name FROM channel;

----- All channel names that belong to specific organization -----
SELECT channel.name 
  FROM organization, channel 
  WHERE organization.id = channel.organization_id 
  AND organization.name = 'Lambda School';

----- All messages in specific channel -----
SELECT user.name, message.content, message.post_time 
  FROM user, message, channel 
  WHERE user.id = message.user_id 
  AND channel.id = message.channel_id
  AND channel.name = '#javascript';

----- All channels with Alice -----
SELECT channel.name
  FROM channel, user, channel_user
  WHERE channel.id = channel_user.channel_id
  AND user.id = channel_user.user_id
  AND user.name = 'Alice';

----- All users in #general -----
SELECT user.name
  FROM user, channel, channel_user
  WHERE channel.id = channel_user.channel_id
  AND user.id = channel_user.user_id
  AND channel.name = '#general';

----- All messages from Alice -----
SELECT channel.name, message.content
  FROM channel, user, message
  WHERE channel.id = message.channel_id
  AND user.id = message.user_id
  AND user.name = 'Alice';

----- All messages in #random from Bob -----
SELECT message.content
  FROM message, channel, user
  WHERE message.channel_id = channel.id
  AND message.user_id = user.id
  AND channel.name = '#random'
  AND user.name = 'Bob';

----- Count messages per user -----
SELECT user.name AS 'User', COUNT(message.id) AS 'Message Count'
  FROM message, channel, user
  WHERE message.channel_id = channel.id
  AND message.user_id = user.id
  GROUP BY user.name;



