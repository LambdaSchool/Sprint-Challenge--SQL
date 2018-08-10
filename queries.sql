PRAGMA foreign_keys = 1;

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR,
  organization_id INTEGER,

  FOREIGN KEY(organization_id) REFERENCES organization(id)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR
  -- organization_id INTEGER,

  -- FOREIGN KEY(organization_id) REFERENCES organization(id)
);

CREATE TABLE user_channel (
  user_id INTEGER,
  channel_id INTEGER,

  FOREIGN KEY(user_id) REFERENCES user(id),
  FOREIGN KEY(channel_id) REFERENCES channel(id)
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content VARCHAR,
  user_id INTEGER,
  channel_id INTEGER,

  timestamp DATE DEFAULT (datetime('now','localtime')),
  FOREIGN KEY(channel_id) REFERENCES channel(id)
);

INSERT INTO organization (name) VALUES ('Lambda School');

INSERT INTO user (name) VALUES ('Alice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');

INSERT INTO channel (name, organization_id) VALUES ('general', 1);
INSERT INTO channel (name, organization_id) VALUES ('random', 1);

INSERT INTO user_channel VALUES (1, 1);
INSERT INTO user_channel VALUES (1, 2);

INSERT INTO user_channel VALUES (2, 1);

INSERT INTO user_channel VALUES (3, 2);

INSERT INTO message (content, user_id, channel_id) VALUES ("Yo, I'm here!", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("I don't know", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("I love Python!", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("When is Lambda Labs?", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("What time is it?", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Well, that's interesting", 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("SQL rocks!", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("I can't wait to get a job!", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("I'm working on my sprint", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hmmmm....", 1, 1);


SELECT name FROM organization;

SELECT name FROM channel;

SELECT channel.name
  FROM channel JOIN organization
  WHERE channel.organization_id = organization.id
  AND organization.name = 'Lambda School';

SELECT message.content
  FROM message JOIN channel
  WHERE message.channel_id = channel.id
  AND channel.name = 'general'
  ORDER BY message.timestamp DESC;

SELECT channel.name FROM user JOIN user_channel JOIN channel
  WHERE user.id = user_channel.user_id AND channel.id = user_channel.channel_id 
  AND user.name = 'Alice';

SELECT user.name FROM user JOIN user_channel JOIN channel
  WHERE user.id = user_channel.user_id AND channel.id = user_channel.channel_id 
  AND channel.name = 'general';

SELECT message.content 
  FROM user JOIN message
  WHERE message.user_id = user.id
  AND user.name = 'Alice';

SELECT message.content, channel.name, user.name
  FROM message JOIN channel JOIN user 
  WHERE message.channel_id = channel.id
  AND user.id = message.user_id
  AND channel.name = 'random'
  AND user.name = 'Bob';

SELECT user.name, count(message.content)
  FROM user JOIN message
  WHERE message.user_id = user.id
  GROUP BY user.id;


SELECT user.name, channel.name, count(message.content)
  FROM message JOIN channel JOIN user_channel JOIN user
  WHERE message.channel_id = channel.id
  AND channel.id = user_channel.channel_id
  GROUP BY channel.id;

6. What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?

cascade on delete



-- example of multiple subselects for an INSERT
-- INSERT INTO user (name, organization_id, channel_id)
--   SELECT 'Alice',
--     (SELECT id FROM organization WHERE name = 'Lambda School'),
--     (SELECT id FROM channel WHERE name = 'general');
