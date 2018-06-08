DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;


CREATE TABLE organization(
  id INTERGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(32) NOT NULL
);

CREATE TABLE channel(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  organization_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  content VARCHAR(128) NOT NULL,
  post_time DATETIME NOT NULL,
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE channel_user (
  channel_id INTEGER REFERENCES channel(id)
  user_id INTEGER REFERENCES user(id)
);

INSERT INTO organization (name) VALUES ("Lambda School")
INSERT INTO user (name) VALUES ("Alice")
INSERT INTO user (name) VALUES ("Bob")
INSERT INTO user (name) VALUES ("Chris")
INSERT INTO channel (name) VALUES ("#general")
INSERT INTO channel (name) VALUES ("#random")