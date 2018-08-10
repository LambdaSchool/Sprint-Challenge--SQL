PRAGMA foreign_keys = ON;

CREATE TABLE organizations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE channels (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    organization_id INTEGER NOT NULL,
    FOREIGN KEY(organization_id) REFERENCES organizations(id) ON DELETE CASCADE
);

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    content TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    channel_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(channel_id) REFERENCES channels(id) ON DELETE CASCADE
);

CREATE TABLE users_channels (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  channel_id INTEGER,
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY(channel_id) REFERENCES channels(id) ON DELETE CASCADE
);


INSERT INTO organizations (name) VALUES ("Lambda School");
INSERT INTO organizations (name) VALUES ("Placeholder");

INSERT INTO users (name) VALUES ("Alice");
INSERT INTO users (name) VALUES ("Bob");
INSERT INTO users (name) VALUES ("Chris");

INSERT INTO channels (name, organization_id) VALUES ("#general", 1);
INSERT INTO channels (name, organization_id) VALUES ("#random", 1);
INSERT INTO channels (name, organization_id) VALUES ("#placeholdertotestplaceholder", 2);

INSERT INTO users_channels (user_id, channel_id) VALUES (1, 1);
INSERT INTO users_channels (user_id, channel_id) VALUES (1, 2);
INSERT INTO users_channels (user_id, channel_id) VALUES (2, 1);
INSERT INTO users_channels (user_id, channel_id) VALUES (3, 2);

INSERT INTO messages (content, user_id, channel_id) VALUES ("alicealicealice general", 1, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("bobbobbob general", 2, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("bobbobbob random", 2, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ("bobbobbob generalalso", 2, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("crhssissrchris random", 3, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ("alicealicealice random", 1, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ("bobbobbob general2", 2, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("bobbobbob random2", 2, 2);
INSERT INTO messages (content, user_id, channel_id) VALUES ("bobbiebobbie general", 2, 1);
INSERT INTO messages (content, user_id, channel_id) VALUES ("chrisrchrist random2", 3, 2);



-- List all organization names.
SELECT name FROM organizations;

-- List all channel names.
SELECT name FROM channels;

-- List all channels in a specific organization by organization name.
SELECT channels.name FROM channels, organizations
WHERE channels.organization_id = organizations.id
AND organizations.name = "Lambda School";

-- List all messages in a specific channel by channel name #general in order of post_time, descending. (Hint: ORDER BY. Because your INSERTs might have all taken place at the exact same time, this might not return meaningful results. But humor us with the ORDER BY anyway.)
SELECT messages.* FROM messages, channels
WHERE messages.channel_id = channels.id
AND channels.name = "#general"
ORDER BY messages.post_time DESC;

-- List all channels to which user Alice belongs.
SELECT channels.name FROM users_channels, users, channels
WHERE users.name = "Alice"
AND users_channels.user_id = users.id
AND users_channels.channel_id = channels.id;
-- GROUP BY channels.name;

-- List all users that belong to channel #general.
SELECT users.name FROM users_channels, users, channels
WHERE channels.name = "#general"
AND users_channels.user_id = users.id
AND users_channels.channel_id = channels.id;
-- GROUP BY users.name;

-- List all messages in all channels by user Alice.
SELECT messages.* FROM users, messages
WHERE users.name = "Alice"
AND messages.user_id = users.id
GROUP BY messages.id;

-- List all messages in #random by user Bob.
SELECT messages.* FROM users, messages, channels
WHERE users.name = "Bob"
AND messages.channel_id = channels.id
AND channels.name = "#random"
AND messages.user_id = users.id
GROUP BY messages.id;

-- List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.)
SELECT users.name, COUNT(messages.id) FROM users, messages
WHERE messages.user_id = users.id
GROUP BY users.name
ORDER BY users.name DESC;

-- [Stretch!] List the count of messages per user per channel.
SELECT users.name, channels.name, COUNT(messages.id)
FROM users, channels, messages
WHERE messages.channel_id = channels.id
AND messages.user_id = users.id
GROUP BY users.name, channels.name
ORDER BY channels.name;




--What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?
--you use ON DELETE CASCADE so when the thing the object refers to is deleted, it gets deleted as well.