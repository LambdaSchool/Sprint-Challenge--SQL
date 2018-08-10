CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
)

-- CREATE TABLE organ_channels (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   organ_id INTEGER,
--   channel_id INTEGER,
--   FOREIGN KEY organ_id REFERENCES organization(id)
--   FOREIGN KEY channel_id REFERENCES channel(id)
-- )

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,  
  name VARCHAR(128),
  org_id INTEGER,
  FOREIGN KEY org_id REFERENCES organization(id)
)

CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,    
  name VARCHAR(128)
  channel_id VARCHAR(128),
  FOREIGN KEY channel_id REFERENCES user_channels(id)
)

CREATE TABLE user_channels (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  channel_id INTEGER
  FOREIGN KEY user_id REFERENCES user(id)
  FOREIGN KEY channel_id REFERENCES channel(id)
)

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,  
  post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  content VARCHAR(128)
  FOREIGN KEY id REFERENCES user(message_id)
)

CREATE TABLE user_messages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  message_id INTEGER
  FOREIGN KEY user_id REFERENCES user(id)
  FOREIGN KEY message_id REFERENCES message(id)
)

INSERT INTO organization (name) VALUES ('Lambda School')

INSERT INTO users (name, channel_id, message_id) VALUES ('Alice', 1, 1)
INSERT INTO users (name, channel_id, message_id) VALUES ('Bob', 2, 2)
INSERT INTO users (name, channel_id, message_id) VALUES ('Chris', 3, 3)

INSERT INTO channel (name, org_id) VALUES ('Chris', 3, 3)
INSERT INTO users (name, channel_id, message_id) VALUES ('Chris', 3, 3)


