/**
 * CREATION QUERIES
 */
-- create organization
CREATE TABLE organizations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL,
  date_created DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- create channels
CREATE TABLE channels (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL,
  date_created DATETIME DEFAULT CURRENT_TIMESTAMP,
  organization_id INTEGER NOT NULL,
  FOREIGN KEY (organization_id) REFERENCES organizations(id)
);

-- create users
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL,
  date_created DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- create messages
CREATE TABLE messages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT NOT NULL,
  date_created DATETIME DEFAULT CURRENT_TIMESTAMP,
  channel_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (channel_id) REFERENCES channel(id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);

-- create users_channels: user to channel relationships
CREATE TABLE users_channels (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  channel_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (channel_id) REFERENCES channels(id)
);


/**
 * INSERT QUERIES
 */
-- insert lambda_school into organizations table
INSERT INTO organizations (name)
VALUES ('Lambda_School');

-- insert three users, Alice, Bob, Chris into users
Insert into users (name)
VALUES ('Alice');
INSERT INTO users_channels (user_id, channel_id)
VALUES (1, 1);
INSERT INTO users_channels (user_id, channel_id)
VALUES (1, 2);

Insert into users (name)
VALUES ('Bob');
INSERT INTO users_channels (user_id, channel_id)
VALUES (2, 1);

Insert into users (name)
VALUES ('Chris');
INSERT INTO users_channels (user_id, channel_id)
VALUES (3, 2);

-- insert two channels, #general, #random, into channels
Insert into channels (name, organization_id)
VALUES ('#general', 1);

Insert into channels (name, organization_id)
VALUES ('#random', 1);

-- insert 10 messages into messages
INSERT INTO messages (content, channel_id, user_id)
VALUES ('Alice 1', 1, 1);

INSERT INTO messages (content, channel_id, user_id)
VALUES ('Alice 2', 1, 1);

INSERT INTO messages (content, channel_id, user_id)
VALUES ('Alice 3', 1, 1);

INSERT INTO messages (content, channel_id, user_id)
VALUES ('Alice 4', 2, 1);

INSERT INTO messages (content, channel_id, user_id)
VALUES ('Bob 1', 1, 2);

INSERT INTO messages (content, channel_id, user_id)
VALUES ('Bob 2', 1, 2);

INSERT INTO messages (content, channel_id, user_id)
VALUES ('Bob 3', 1, 2);

INSERT INTO messages (content, channel_id, user_id)
VALUES ('Chris 1', 2, 3);

INSERT INTO messages (content, channel_id, user_id)
VALUES ('Chris 2', 2, 3);

INSERT INTO messages (content, channel_id, user_id)
VALUES ('Chris 3', 2, 3);


/**
 * SELECT QUERIES
 */
-- list all organization names
SELECT name FROM organizations;

-- list all channel names
SELECT name FROM channels;

-- list all channels in a specific organization, Lambda School, by the
-- organizations name
SELECT channels.name FROM channels, organizations
WHERE organizations.name IS 'Lambda_School'
AND organizations.id IS channels.organization_id;

-- list all messages in a specific channel, #general, in descending order
SELECT messages.content, messages.date_created FROM messages, channels
WHERE channels.name IS '#general'
AND channels.id IS messages.channel_id
ORDER BY messages.date_created DESC;

-- list channels that Alice belongs in
SELECT channels.name FROM channels, users, users_channels
WHERE users.name IS 'Alice'
AND users.id IS users_channels.user_id
AND channels.id IS users_channels.channel_id;

-- list all users who belong to channel #general
SELECT users.name FROM users, channels, users_channels
WHERE channels.name IS '#general'
AND channels.id IS users_channels.channel_id
AND users.id IS users_channels.user_id;

-- list all messages by user Alice
SELECT content from messages, users
WHERE users.name IS 'Alice'
AND messages.user_id IS users.id;

-- list all messages in #random by Bob
SELECT messages.content FROM messages, users, channels
WHERE channels.name IS '#random'
AND channels.id IS messages.channel_id
AND users.name IS 'Bob'
AND users.id IS messages.user_id;


-- list a count of all messages across all channels
/*

User Name   Message Count
----------  -------------
Chris       4 
Bob         3
Alice       3

*/
SELECT name AS 'User Name', COUNT(messages.id) AS 'Message Count'
FROM users, messages
WHERE users.id IS messages.user_id
GROUP BY users.name;