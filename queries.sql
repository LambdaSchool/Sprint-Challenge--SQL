CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,  
  name VARCHAR(128) NOT NULL,
  org_id INTEGER,
  FOREIGN KEY(org_id) REFERENCES organization(id)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,    
  name VARCHAR(128) NOT NULL
);

CREATE TABLE user_channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  channel_id INTEGER,
  FOREIGN KEY(user_id) REFERENCES user(id),
  FOREIGN KEY(channel_id) REFERENCES channel(id)
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,  
  post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  content VARCHAR(128),
  channel_id INTEGER,
  user_id INTEGER,
  FOREIGN KEY(channel_id) REFERENCES channel(id),
  FOREIGN KEY(user_id) REFERENCES user(id)
);

INSERT INTO organization (name) VALUES ('Lambda School');

INSERT INTO user (name) VALUES ('Alice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');

INSERT INTO channel (name, org_id) VALUES ('#general', 1);
INSERT INTO channel (name, org_id) VALUES ('#random', 1);

INSERT INTO message (content, channel_id, user_id) VALUES ('Message1', 1, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ('Message2', 2, 1);;
INSERT INTO message (content, channel_id, user_id) VALUES ('Message3', 2, 1);
INSERT INTO message (content, channel_id, user_id) VALUES ('Message4', 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ('Message5', 2, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ('Message6', 1, 2);
INSERT INTO message (content, channel_id, user_id) VALUES ('Message7', 1, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ('Message8', 1, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ('Message9', 2, 3);
INSERT INTO message (content, channel_id, user_id) VALUES ('Message10', 2, 3);

-- channel: 1 is general, 2 is random
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);

-- SELECT Task 1-5
SELECT name from organization;
SELECT name from channel;
SELECT channel.name from channel, organization where channel.org_id = organization.id;
SELECT content from message ORDER BY post_time DESC;
SELECT channel.name from channel, user, user_channel where user.id = user_channel.user_id AND channel.id = user_channel.channel_id and user.name = 'Alice';
-- SELECT Task 6-9
SELECT user.name from channel, user, user_channel where user.id = user_channel.user_id AND channel.id = user_channel.channel_id and channel.name = '#general';
SELECT message.content from user, message where message.user_id = user.id and user.name = 'Alice';
SELECT message.content from user, message, channel where message.user_id = user.id and message.channel_id = channel.id and user.name = 'Bob' and channel.name = '#random';
SELECT user.name as User_Name, count(message.content) as Messagee_Count from user, message where message.user_id = user.id group by user.name order by user.name DESC;
-- Stretch
SELECT user.name as User_Name, channel.name as Channel, count(message.content) as Messagee_Count 
from channel, user, message 
where message.user_id = user.id, message.channel_id = channel.id
group by user.name, channel.name 
order by user.name DESC;

-- For Question 6: using ON DELETE CASCADE will delete child data from child table as soon as the parent data is deleted.