CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
)

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,  
  name VARCHAR(128),
  org_id INTEGER,
  FOREIGN KEY org_id REFERENCES organization(id)
)

CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,    
  name VARCHAR(128)
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
  channel_id INTEGER
  user_id INTEGER
  FOREIGN KEY channel_id REFERENCES channel(id)
  FOREIGN KEY user_id REFERENCES user(id)
)

CREATE TABLE user_messages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  channel_id INTEGER
  FOREIGN KEY user_id REFERENCES user(id)
  FOREIGN KEY message_id REFERENCES channel(id)
)

INSERT INTO organization (name) VALUES ('Lambda School')

INSERT INTO users (name) VALUES ('Alice')
INSERT INTO users (name) VALUES ('Bob')
INSERT INTO users (name) VALUES ('Chris')

INSERT INTO channel (name, org_id) VALUES ('#general', 1)
INSERT INTO channel (name, org_id) VALUES ('#random', 1)

INSERT INTO message (content, channel_id, user_id) VALUES ('Message1', 1, 1)
INSERT INTO message (content, channel_id, user_id) VALUES ('Message2', 2, 1)
INSERT INTO message (content, channel_id, user_id) VALUES ('Message3', 2, 1)
INSERT INTO message (content, channel_id, user_id) VALUES ('Message4', 1, 2)
INSERT INTO message (content, channel_id, user_id) VALUES ('Message5', 2, 2)
INSERT INTO message (content, channel_id, user_id) VALUES ('Message6', 1, 2)
INSERT INTO message (content, channel_id, user_id) VALUES ('Message7', 1, 3)
INSERT INTO message (content, channel_id, user_id) VALUES ('Message8', 1, 3)
INSERT INTO message (content, channel_id, user_id) VALUES ('Message9', 2, 3)
INSERT INTO message (content, channel_id, user_id) VALUES ('Message10', 2, 3)

-- channel: 1 is general, 2 is random
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1)
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2)
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1)
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2)
