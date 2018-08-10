CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);


CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  organization_id INTEGER REFERENCES organization(id)
);


CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);


CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  posted_by INTEGER REFERENCES user(id),
  content TEXT,
  channel_id INTEGER REFERENCES channel(id)
);


CREATE TABLE subscription (
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);


-- 


INSERT INTO organization(name) VALUES ("Lambda School");


INSERT INTO  channel(name, organization_id) VALUES ("#general", 1);
INSERT INTO  channel(name, organization_id) VALUES ("#random", 1);


INSERT INTO  user(name) VALUES ("Alice");
INSERT INTO  user(name) VALUES ("Bob");
INSERT INTO  user(name) VALUES ("Chris");


INSERT INTO subscription VALUES (1, 1); -- Alice in #general
INSERT INTO subscription VALUES (1, 2); -- Alice in #random
INSERT INTO subscription VALUES (2, 1); -- Bob in #general
INSERT INTO subscription VALUES (3, 2); -- Chris in #random


INSERT INTO message(posted_by, channel_id, content) VALUES (1, 1, "Here's a message from Alice in #general.");
INSERT INTO message(posted_by, channel_id, content) VALUES (1, 2, "Here's a message from Alice in #random.");
INSERT INTO message(posted_by, channel_id, content) VALUES (2, 1, "Here's a message from Bob in #general.");
INSERT INTO message(posted_by, channel_id, content) VALUES (2, 1, "Here's a message from Bob in #general.");
INSERT INTO message(posted_by, channel_id, content) VALUES (3, 2, "Here's a message from Chris in #random.");
INSERT INTO message(posted_by, channel_id, content) VALUES (3, 2, "Here's a message from Chris in #random.");
INSERT INTO message(posted_by, channel_id, content) VALUES (3, 2, "Here's a message from Chris in #random.");
INSERT INTO message(posted_by, channel_id, content) VALUES (3, 2, "Here's a message from Chris in #random.");
INSERT INTO message(posted_by, channel_id, content) VALUES (2, 1, "Here's a message from Bob in #general.");
INSERT INTO message(posted_by, channel_id, content) VALUES (1, 2, "Here's a message from Alice in #random.");


--


-- List all ogranization names
SELECT name FROM organization;

-- List all channel names
SELECT name from channel;

-- List all channels in a specific organization by organization name
SELECT organization.name, channel.name FROM channel, organization
  WHERE channel.organization_id IS organization.id;

-- List all messages in a specific channel by channel name #general in order of post_time, descending. 
  -- (Hint: ORDER BY. Because your INSERTs might have all taken place at the exact same time, 
  -- this might not return meaningful results. But humor us with the ORDER BY anyway.)
SELECT message.post_time, message.posted_by, message.content FROM message, channel
  WHERE channel.name IS "#general"
  AND channel.id IS message.channel_id
  ORDER BY message.post_time ASC;

-- List all channels to which user Alice belongs.
SELECT channel.name FROM channel, user, subscription
  WHERE user.name IS "Alice"
  AND user.id IS subscription.user_id
  AND channel.id IS subscription.channel_id;=

-- List all users that belong to channel #general
SELECT user.name from user, channel, subscription
  WHERE channel.name IS "#general"
    AND channel.id IS subscription.channel_id
    AND user.id IS subscription.user_id;


-- List all messages in all channels by user Alice.
SELECT message.post_time, user.name, message.content 
  FROM message, user
    WHERE user.name IS "Alice"
    AND user.id IS message.posted_by;

-- List all messages in #random by user Bob.
SELECT message.post_time, user.name, message.content
  FROM message, user, channel
    WHERE user.name IS "Bob" 
    AND channel.name IS "#random"
    AND message.posted_by IS user.id
    AND message.channel_id IS channel.id;

-- List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.)
SELECT user.name AS "User Name", COUNT() AS "Message Count" 
  FROM user, message, channel
    WHERE user.id IS message.posted_by
    AND channel.id IS message.channel_id
      GROUP BY user.name
      ORDER BY user.name ASC;

-- [Stretch!] List the count of messages per user per channel.
SELECT user.name AS "User", channel.name AS "Channel", Count(*) AS "Message Count"
  FROM user, channel, message
    WHERE message.posted_by IS user.id
    AND message.channel_id IS channel.id
      GROUP BY user.name, channel.name
      ORDER BY channel.name ASC;


--


-- What SQL keywords or concept would you use if you wanted to automatically delete all messages 
-- by a user if that user were deleted from the user table?

  -- ON DELETE CASCADE