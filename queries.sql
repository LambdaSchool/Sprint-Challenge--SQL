-- CREATE TABLES
CREATE TABLE organization {
  id int AUTOINCREMENT,
  organization_name varchar(255) NOT NULL,
  PRIMARY KEY (id)
};

CREATE TABLE channel {
  id int AUTOINCREMENT,
  channel_name varchar(255) NOT NULL,
  organization_id int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (organization_id) REFERENCES organization(id)
};

CREATE TABLE user {
  id int AUTOINCREMENT,
  person_name varchar(255) NOT NULL,
  PRIMARY KEY (id),
};

CREATE TABLE message {
  id int AUTOINCREMENT,
  content varchar(255) NOT NULL,
  channel_id int NOT NULL,
  post_time default current_timestamp
  user_id int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (channel_id) REFERENCES channel(id)
  FOREIGN KEY (user_id) REFERENCES user(id)
};

CREATE TABLE subscriptions {
  id int AUTOINCREMENT,
  channel_id int NOT NULL,
  user_id int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (channel_id) REFERENCES channel(id)
  FOREIGN KEY (user_id) REFERENCES user(id)
};

-- INSERT DATA
INSERT INTO organization
VALUES ('Lambda School');

INSERT INTO user
VALUES ('Alice');

INSERT INTO user
VALUES ('Bob');

INSERT INTO user
VALUES ('Chris');

INSERT INTO channel
VALUES ('#general', 1);

INSERT INTO channel
VALUES ('#random', 1);

INSERT INTO subscriptions
VALUES (1, 1);

INSERT INTO subscriptions
VALUES (2, 1);

INSERT INTO subscriptions
VALUES (1, 2);

INSERT INTO subscriptions
VALUES (2, 3);

-- SELECT QUERIES

-- 1
SELECT organization_name FROM organization;

-- 2
SELECT channel_name FROM channel;

-- 3
SELECT channel_name FROM channel, organization 
WHERE organization_id = organization.id
AND organization_name = 'Lambda School';

-- 4
SELECT content FROM channel, message
WHERE channel_id = message.channel_id
AND channel_name = '#general'
ORDER BY post_time;

-- 5
SELECT channel_name FROM user, channel, subscriptions
WHERE subscriptions.user_id = user.id
AND subscriptions.channel_id = channel.id
AND person_name = 'Alice';

-- 6
SELECT person_name from user, channel, subscriptions
WHERE subscriptions.user_id = user.id
AND subscriptions.channel_id = channel.id
AND channel_name = '#general';

-- 7
SELECT content FROM message, user
WHERE message.user_id = user.id
AND user.person_name = 'Alice';

-- 8
SELECT content FROM message, user, channel
WHERE channel_id = message.channel_id
AND message.user_id = user.id
AND channel_name = '#random'
AND person_name = 'Bob';

-- 9
.mode column
.headers on
SELECT user.person_name AS 'User Name', COUNT(message.id) as 'Message Count'
FROM message, user
WHERE message.user_id = user.id
GROUP BY user.person_name;