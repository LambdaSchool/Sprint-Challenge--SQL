PRAGMA foreign_keys= ON; -- Set foreign key constraing MUST BE DO.

-- IMPROVE PRINT: Set to divede in columns and show Headers
.mode column
.headers ON

CREATE TABLE organizations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)

);

CREATE TABLE channels (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128),
  organization_id INTEGER,
  FOREIGN KEY (organization_id) REFERENCES organizations(id)
);

CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
);

CREATE TABLE user_channel (
  user_id INTEGER,
  channel_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (channel_id) REFERENCES channels(id)
);

CREATE TABLE messages (
  user_id INTEGER,
  channel_id INTEGER,
  post_time TEXT DEFAULT CURRENT_TIMESTAMP,
  content TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (channel_id) REFERENCES channels(id)
);

-- INSERT
-- organizations
INSERT INTO organizations (name) VALUES ("Lambda School");

-- Users
INSERT INTO users (name) VALUES ("Alice");
INSERT INTO users (name) VALUES ("Bob");
INSERT INTO users (name) VALUES ("Chris");

-- Channels
INSERT INTO channels (name, organization_id) VALUES ("#general", 1);
INSERT INTO channels (name, organization_id) VALUES ("#random", 1);

-- Put users into channels
INSERT INTO user_channel (user_id, channel_id) VALUES (1,1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1,2);
INSERT INTO user_channel (user_id, channel_id) VALUES (2,1);
INSERT INTO user_channel (user_id, channel_id) VALUES (3,2);

-- Add messages
INSERT INTO messages (user_id, channel_id, content) VALUES (1, 1, "Hi");
INSERT INTO messages (user_id, channel_id, content) VALUES (2, 1, "Eyyy!");
INSERT INTO messages (user_id, channel_id, content) VALUES (1, 1, "How are you doing?");
INSERT INTO messages (user_id, channel_id, content) VALUES (2, 1, "Aparently we are in a granular world, not in a continuous as Newton suggested O_O");
INSERT INTO messages (user_id, channel_id, content) VALUES (1, 1, "Wow, and space_time is anther field, like the electro-magnetic; and its sahpe can be described by a 3-sphere -> Is a circular/spherical universe!!!");
INSERT INTO messages (user_id, channel_id, content) VALUES (1, 1, "BYE");

INSERT INTO messages (user_id, channel_id, content) VALUES (1, 2, "Hi there");
INSERT INTO messages (user_id, channel_id, content) VALUES (3, 2, "Hi");
INSERT INTO messages (user_id, channel_id, content) VALUES (1, 2, "Do you knok what it means when somebody ask you if you like monkeys????");
INSERT INTO messages (user_id, channel_id, content) VALUES (3, 2, "I'm not sure about that .... ¿?¿?");
INSERT INTO messages (user_id, channel_id, content) VALUES (1, 2, "And what about 'Do you like goats?', it has no sense, isn't it?...");


-- SELECTS
-- List all organization names.
SELECT * FROM organizations;
  -- sqlite> SELECT * FROM organizations;
  -- id          name
  -- ----------  -------------
  -- 1           Lambda School



-- List all channel names.
SELECT id, name FROM channels;
  -- sqlite> SELECT id, name FROM channels;
  -- id          name
  -- ----------  ----------
  -- 1           #general
  -- 2           #random


-- List all channels in a specific organization by organization name.
SELECT organizations.name AS Organization, channels.name AS Channels
  FROM organizations, channels
  WHERE organizations.id=channels.organization_id
  AND organizations.name="Lambda School";
  --   sqlite> SELECT organizations.name AS Organization, channels.name AS Channels
  --    ...>   FROM organizations, channels
  --    ...>   WHERE organizations.id=channels.organization_id
  --    ...>   AND organizations.name="Lambda School";
  -- Organization   Channels
  -- -------------  ----------
  -- Lambda School  #general
  -- Lambda School  #random


-- List all messages in a specific channel by channel name #general in order of post_time, descending.
SELECT messages.post_time AS Posted_on, content AS Message
  FROM channels, messages
  WHERE channels.id=messages.channel_id
  AND channels.name="#general"
  ORDER BY Posted_on DESC;
  -- sqlite> SELECT messages.post_time AS Posted_on, content AS Message
  --    ...>   FROM channels, messages
  --    ...>   WHERE channels.id=messages.channel_id
  --    ...>   AND channels.name="#general"
  --    ...>   ORDER BY Posted_on DESC;
  -- Posted_on            Message
  -- -------------------  ----------
  -- 2018-09-07 16:50:14  BYE
  -- 2018-09-07 16:27:10  Hi
  -- 2018-09-07 16:27:10  Eyyy!
  -- 2018-09-07 16:27:10  How are yo
  -- 2018-09-07 16:27:10  Great here
  -- 2018-09-07 16:27:10  Do you lik


-- List all channels to which user Alice belongs.
SELECT channels.name AS "User's channels"
  FROM users, user_channel, channels
  WHERE users.id=user_channel.user_id
  AND user_channel.channel_id=channels.id
  AND users.name="Alice";
  -- sqlite> SELECT channels.name AS "User's channels"
  --    ...>   FROM users, user_channel, channels
  --    ...>   WHERE users.id=user_channel.user_id
  --    ...>   AND user_channel.channel_id=channels.id
  --    ...>   AND users.name="Alice";
  -- User's channels
  -- ---------------
  -- #general
  -- #random


-- List all users that belong to channel #general.
SELECT users.name AS "Users in channel"
  FROM users, user_channel, channels
  WHERE users.id=user_channel.user_id
  AND user_channel.channel_id=channels.id
  AND channels.name="#general";
  -- sqlite> SELECT users.name AS "Users in channel"
  --    ...>   FROM users, user_channel, channels
  --    ...>   WHERE users.id=user_channel.user_id
  --    ...>   AND user_channel.channel_id=channels.id
  --    ...>   AND channels.name="#general";
  -- Users in channel
  -- ----------------
  -- Alice
  -- Bob


-- List all messages in all channels by user Alice.
SELECT channels.name AS Channel, messages.content AS "Message"
  FROM users, channels, messages
  WHERE users.id=messages.user_id
  AND channels.id=messages.channel_id
  AND users.name="Alice"
  ORDER BY Channel;
  -- sqlite> SELECT channels.name AS Channel, messages.content AS "Message"
  --    ...>   FROM users, channels, messages
  --    ...>   WHERE users.id=messages.user_id
  --    ...>   AND channels.id=messages.channel_id
  --    ...>   AND users.name="Alice"
  --    ...>   ORDER BY Channel;
  -- Channel     Message
  -- ----------  ----------
  -- #general    Hi
  -- #general    How are yo
  -- #general    Do you lik
  -- #general    BYE
  -- #random     Hi there
  -- #random     Do you kno
  -- #random     And what a



-- List all messages in #random by user Bob.
SELECT messages.content AS "Message"
  FROM users, channels, messages
  WHERE users.id=messages.user_id
  AND channels.id=messages.channel_id
  AND channels.name="#random"
  AND users.name="Alice";
  -- Bob has no message in #random


-- List the count of messages across all channels per user.
SELECT users.name AS "User Name", COUNT(messages.content) AS "Message Count"
  FROM users, messages
  WHERE users.id=messages.user_id
  GROUP BY "User Name";
  -- sqlite> SELECT users.name AS "User Name", COUNT(messages.content) AS"Message Count"
  --  ...>   FROM users, messages
  --  ...>   WHERE users.id=messages.user_id
  --  ...>   GROUP BY "User Name";
  -- User Name   Message Count
  -- ----------  -------------
  -- Alice       7
  -- Bob         2
  -- Chris       2




-- [Stretch!] List the count of messages per user per channel.
SELECT users.name AS User,
  channels.name AS Channel,
  COUNT(messages.content) AS "Message Count"
  FROM users, channels, messages
  WHERE users.id=messages.user_id
  AND channels.id=messages.channel_id
  GROUP BY User, Channel
  ORDER BY User;
  -- sqlite> SELECT users.name AS User,
  --    ...>   channels.name AS Channel,
  --    ...>   COUNT(messages.content) AS "Message Count"
  --    ...>   FROM users, channels, messages
  --    ...>   WHERE users.id=messages.user_id
  --    ...>   AND channels.id=messages.channel_id
  --    ...>   GROUP BY User, Channel
  --    ...>   ORDER BY User;
  -- User        Channel     Message Count
  -- ----------  ----------  -------------
  -- Alice       #general    4
  -- Alice       #random     3
  -- Bob         #general    2
  -- Chris       #random     2


-- What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?
-- "ON DELTE CASCADE"