.mode COLUMN
.header ON

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    organization_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
)

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content LONGTEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
)

--i
INSERT INTO organization (name) VALUES ('Lambda School');

--ii
INSERT INTO user (name) VALUES ('Alice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');

--iii
INSERT INTO channel (name) VALUES ('#general');
INSERT INTO channel (name) VALUES ('#random');

--iv
INSERT INTO message (content, user_id, channel_id) VALUES ('Alice random message', 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Alice random message 2', 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('Alice random message 3', 1, 2);

INSERT INTO message (content, user_id, channel_id) VALUES ('Bob random message', 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Bob random message 1', 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Bob random message 2', 2, 2);

INSERT INTO message (content, user_id, channel_id) VALUES ('Chris random message', 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Chris random message 1', 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('Chris random message 2', 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('Chris random message 3', 3, 2);

--5
--i
SELECT name FROM organization;

--ii
SELECT names FROM channel;

--iii
SELECT  channel.name AS 'channels', organization.name as 'organization' from channel, organization
WHERE channel.organization_id = organization_id AND organization.name = 'Lambda School';

--iv
SELECT message.content FROM message, channel WHERE message.channel_id = channel_id
AND channel.name = '#general'

--v
SELECT channel.name FROM user INNER JOIN channel
WHERE user.channel = channel.id WHERE user.name = 'Alice';

--vi
SELECT user.name FROM channel INNER JOIN user WHERE user.channel = channel.id
AND channel_id = 1;

--vii
SELECT message.content, user.name FROM message INNER JOIN user WHERE user.name = 'ALICE'
AND message.user = user_id;