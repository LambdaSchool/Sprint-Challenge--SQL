
CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR
(256) NOT NULL UNIQUE
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR
(256) NOT NULL UNIQUE,
  organization_ref INTEGER
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR
(256) NOT NULL UNIQUE
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY  AUTOINCREMENT,
  post_time TimeStamp DEFAULT CURRENT_TIMESTAMP,
  content VARCHAR(256),
  user_ref INTEGER,
  channel_ref INTEGER
);

CREATE TABLE user_channel
(
    user_ref INTEGER,
    channel_ref INTEGER
);


INSERT INTO organization
    (name)
VALUES
    ('Lambda School');


INSERT INTO user
    (name)
VALUES
    ('Alice');

INSERT INTO user
    (name)
VALUES
    ('Chris');

INSERT INTO user
    (name)
VALUES
    ('Bob');

INSERT INTO channel
    (name, organization_ref)
VALUES
    ('#random', 1);

INSERT INTO channel
    (name, organization_ref)
VALUES
    ('#general', 1);

INSERT INTO user_channel
    (channel_ref, user_ref)
VALUES
    (1, 1);

INSERT INTO user_channel
    (channel_ref, user_ref)
VALUES(1, 2);

INSERT INTO user_channel
    (channel_ref, user_ref)
VALUES
    (2, 1);

INSERT INTO user_channel
    (channel_ref, user_ref)
VALUES
    (2, 3);

INSERT INTO message
    (content, user_ref, channel_ref)
VALUES
    ('Alice is putting a message in general', 1, 1);

INSERT INTO message
    (content, user_ref, channel_ref)
VALUES
    ('Alice is putting a message in general 2', 1, 1);

INSERT INTO message
    (content, user_ref, channel_ref)
VALUES
    ('Alice is putting a message in general', 1, 2);

INSERT INTO message
    (content, user_ref, channel_ref)
VALUES
    ('Alice is putting a message in random', 1, 2);

INSERT INTO message
    (content, user_ref, channel_ref)
VALUES
    ('Alice is putting a message in random', 2, 1);

INSERT INTO message
    (content, user_ref, channel_ref)
VALUES
    ('Alice is putting a message in random', 2, 1);

INSERT INTO message
    (content, user_ref, channel_ref)
VALUES
    ('Alice is putting a message in random', 2, 1);

INSERT INTO message
    (content, user_ref, channel_ref)
VALUES
    ('Alice is putting a message in random', 3, 2);

INSERT INTO message
    (content, user_ref, channel_ref)
VALUES
    ('Alice is putting a message in random', 2, 2);

INSERT INTO message
    (content, user_ref, channel_ref)
VALUES
    ('Alice is putting a message in random', 2, 2);

SELECT name
FROM organization;

SELECT name
FROM channel;


-- 3

SELECT ch.name
FROM channel AS ch, organization AS org
WHERE ch.organization_ref = org.id AND org.name = 'Lambda School';


-- 4

SELECT msg.content
FROM message AS msg, channel AS ch
WHERE msg.channel_ref = ch.id AND
    ch.name = '#general';


-- 5

SELECT c.name AS Alice_Channels, c.id AS Channel_ID
FROM channel AS c
    INNER JOIN user_channel AS cs ON c.id
IS cs.channel_ref
INNER JOIN user AS u ON u.id IS cs.user_ref WHERE u.name IS 'Alice';


-- 6

SELECT u.name
FROM user AS u, channel AS ch, user_channel AS uc
WHERE uc.user_ref = u.id AND ch.id = uc.channel_ref
    AND ch.name = '#general';


-- 7

SELECT mgs.content
FROM message AS mgs, user AS u
WHERE mgs.user_ref = u.id AND u.name = 'Alice';


-- 8

SELECT *
FROM message
WHERE id
IS
(SELECT id
FROM channel
WHERE name IS '#random')
AND id IS
(SELECT id
FROM user
WHERE name IS 'Bob');