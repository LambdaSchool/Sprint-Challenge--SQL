-- Organization Table --
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Channel Table --
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES organization(id),
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User Table --
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    username VARCHAR(32) NOT NULL UNIQUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Message Table --
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- user_channel --
CREATE TABLE user_channel (
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);

-- inserting data into database
INSERT INTO user
(name, username)
VALUES("Alice", "A_wonderLand");

INSERT INTO user
(name, username)
VALUES("Bob", "Pyscho_B_N_Springfield");

INSERT INTO user
(name, username)
VALUES("Chris Hensworth", "Thor");


-- organizations --
INSERT INTO organization
(name)
VALUES("Lambda School");


-- channels --
INSERT INTO channel
(name, organization_id)
VALUES("#general", 1);

INSERT INTO channel
(name, organization_id)
VALUES("#random", 2);

-- messages --
INSERT INTO message
  (content, user_id, channel_id)
VALUES("I'M THE KING OF THE WORLD", 3, 2);

INSERT INTO message
  (content, user_id, channel_id)
VALUES("OH, you did an actual query.  That’s awesome lol", 2, 1);

INSERT INTO message
  (content, user_id, channel_id)
VALUES("So many repos.", 1, 1);

INSERT INTO message
  (content, user_id, channel_id)
VALUES("Don't worry guys.", 1, 2);

INSERT INTO message
  (content, user_id, channel_id)
VALUES("Why do I type so slow?", 3, 2);

INSERT INTO message
  (content, user_id, channel_id)
VALUES("Two hours of sleep is rough.", 3, 2);

INSERT INTO message
  (content, user_id, channel_id)
VALUES("What's the repo for today?", 2, 1);

INSERT INTO message
  (content, user_id, channel_id)
VALUES("Can you make a PR request please", 1, 1);

INSERT INTO message
  (content, user_id, channel_id)
VALUES("Are we doing #after-hours?", 2, 2);

INSERT INTO message
  (content, user_id, channel_id)
VALUES("Don’t forget to put your name on your pull request.", 3, 1);

INSERT INTO message
  (content, user_id, channel_id)
VALUES("Please take a moment to reflect upon your day and fill out your Daily Standup report: https:\/\/airtable.com\/shr8ZYuNjevMLRsxI", 1, 1);

-- SELECT QUERIES -- 
SELECT name
    from organization;

SELECT name
    from channel;

SELECT channel.name
    FROM channel, organization
    WHERE organization_id = organization.id
    AND organization.name = "Lambda School";

SELECT content
    FROM message AS
    "GENERAL MESSAGES" WHERE channel_id IS
    (SELECT id FROM channel
    WHERE name IS '#general')
    ORDER BY created DESC;

SELECT content FROM message INNER JOIN user ON message.user_id IS user.id WHERE user.name IS "Alice";

SELECT content
FROM message, channel, user
WHERE user_id = user.id
  AND channel_id = channel.id
  AND channel.name = "#random"
  AND user.name = "Bob"

SELECT COUNT(user.id) AS "MESSAGE COUNT", user.name AS "Name"
FROM message
INNER JOIN user
  ON message.user_id
IS user.id 
INNER JOIN channel 
WHERE message.channel_id IS channel.id 
GROUP BY user.id;

-- DROP USER [ IF EXISTS ] user_name --