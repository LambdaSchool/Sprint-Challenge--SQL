-- Table Setup
CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  channel_id INTEGER,
  FOREIGN KEY(channel_id) REFERENCES organization(id)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  message_id INTEGER,
  channel_id INTEGER,
  FOREIGN KEY(channel_id) REFERENCES channel(id),
  FOREIGN KEY(messages_id) REFERENCES messages(id),
);

CREATE TABLE messages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  post_time TEXT TIMESTAMP,
  content VARCHAR(4000) NOT NULL,
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  organization_id INTEGER,
  user_id INTEGER,
  FOREIGN KEY(organization_id) REFERENCES organization(id),
  FOREIGN KEY(user_id) REFERENCES user(id),
);
