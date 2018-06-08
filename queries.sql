PRAGMA foreign_keys = ON; -- SQLite Only!

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,  
  name VARCHAR(128)
  organization_id INTEGER REFERENCES organization(id) -- A channel can belong to one organization
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT,
  post_time TIMESTAMP NOT NULL DEFAULT(DATETIME()),
  user_id INTEGER REFERENCES user(id), --  a user can post messages to a channel
  channel_id INTEGER REFERENCES channel(id)
);


-- A channel can have many users subscribed.
-- A user can be subscribed to many channels.
CREATE TABLE user_channel (
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);