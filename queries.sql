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
INSERT INTO messages (user_id, channel_id, content) VALUES (2, 1, "Great here, do you like monkeys?");
INSERT INTO messages (user_id, channel_id, content) VALUES (1, 1, "Do you like goats?");

INSERT INTO messages (user_id, channel_id, content) VALUES (1, 2, "Hi there");
INSERT INTO messages (user_id, channel_id, content) VALUES (3, 2, "Hi");
INSERT INTO messages (user_id, channel_id, content) VALUES (1, 2, "Do you knok what it means when somebody ask you if you like monkeys????");
INSERT INTO messages (user_id, channel_id, content) VALUES (3, 2, "I'm not sure about that .... ¿?¿?");
INSERT INTO messages (user_id, channel_id, content) VALUES (1, 2, "And what about 'Do you like goats?', it has no sense, isn't it?...");


SELECT * FROM organizations;
SELECT * FROM users;
SELECT * FROM channels;
SELECT * FROM user_channel;
