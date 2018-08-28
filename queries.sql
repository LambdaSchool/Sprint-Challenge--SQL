CREATE TABLE organization(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL UNIQUE,
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL UNIQUE,
  organization_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  time_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  content VARCHAR(255) NOT NULL,
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id),
);

-- channel id that user id belongs to
CREATE TABLE channel_subs (
  channel_id INTEGER REFERENCES channel(id),
  user_id INTEGER REFERENCES user(id)
);

-- Inserts
-- i
INSERT INTO organization (name)VALUES('Lambda School');

-- ii
INSERT INTO user (name)VALUES('Alice'); -- user_1
INSERT INTO user (name)VALUES('Bob'); -- user_2
INSERT INTO user (name)VALUES('Chris'); -- user_3

-- iii
INSERT INTO channel (name, organization_id)VALUES('#general', 1); -- channel_1
INSERT INTO channel (name, organization_id)VALUES('#random', 1); -- channel_2

-- iv
INSERT INTO message (content, user_id, channel_id)VALUES('My name is Alice and #general is my favorite channel in Lambda School', 1, 1);
INSERT INTO message (content, user_id, channel_id)VALUES('My name is Alice and #random is my favorite channel in Lambda School', 1, 1);
INSERT INTO message (content, user_id, channel_id)VALUES('My name is Bob and #general is my favorite channel in Lambda School', 2, 1);
INSERT INTO message (content, user_id, channel_id)VALUES('My name is Bob and #general is still my favorite channel in Lambda School', 2, 1);
INSERT INTO message (content, user_id, channel_id)VALUES('My name is Bob. Did I mention #general is my favorite channel?', 2, 1);
INSERT INTO message (content, user_id, channel_id)VALUES('My name is Chris and I am liek so #random', 3, 2);
INSERT INTO message (content, user_id, channel_id)VALUES('PICKLED PEPPER PICKED A PECKPER OH I MESSED UP #random', 3, 2);
INSERT INTO message (content, user_id, channel_id)VALUES('My name is Alice and #general is my favorite channel in Lambda School', 1, 1);
INSERT INTO message (content, user_id, channel_id)VALUES('My name is Bob and #general discussion is my kind of thing', 2, 1);
INSERT INTO message (content, user_id, channel_id)VALUES('My name is Chris and liek me too!!! #random', 3, 2);

-- v
INSERT INTO channel_subs (channel_id, user_id)VALUES(1, 1); -- Alice in general
INSERT INTO channel_subs (channel_id, user_id)VALUES(1, 2); -- Alice in random
INSERT INTO channel_subs (channel_id, user_id)VALUES(2, 1); -- Bob in general
INSERT INTO channel_subs (channel_id, user_id)VALUES(3, 2); -- Chris in random

-- SELECTS
-- i
SELECT name FROM organization;
-- ii
SELECT name FROM channel;
-- iii
SELECT name AS LambdaSchool_Channels FROM channel WHERE organization_id IS (SELECT id FROM organization WHERE name IS 'Lambda School');
-- iv
SELECT * FROM message WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#general') ORDER BY post_time DESC;
-- v
-- SELECT * from channel join join_channel_user on join_channel_user.channel_id = channel.id join user on user.id = join_channel_user.user_id where user.user_name = "Alice";
-- vi
-- placeholder
-- vii
-- placeholder
-- viii
SELECT message.content FROM message, user, channel WHERE user.id = message.user_id AND channel.name='#random' AND user.name='Bob';
-- ix
SELECT user.name as "User", channel.name AS "Channel", COUNT(*) AS "Message Count" FROM user, message, channel WHERE user_id = user.id AND channel_id = channel.id GROUP BY channel.name, user.name;

-- Question
