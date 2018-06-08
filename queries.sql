PRAGMA foreign_keys = ON

DROP TABLE IF EXISTS organization
DROP TABLE IF EXISTS channel
DROP TABLE IF EXISTS user
DROP TABLE IF EXISTS message


CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
)

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
)

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL
)

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT,
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id),
  post_time TIMESTAMP NOT NULL DEFAULT(DATETIME()),
)

CREATE TABLE user_channel (
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
)

INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO user (name) VALUES ("Mike");
INSERT INTO user (name) VALUES ("Rob");
INSERT INTO user (name) VALUES ("Dan");

INSERT INTO message (content, user_id, channel_id) VALUES ('test', 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('test2', 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('test3', 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('test4', 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ('test5', 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ('test6', 3, 2);
