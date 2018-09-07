CREATE TABLE organization(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE channel(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  organization_id INTEGER REFERENCES organization(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE user_channel(
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE message(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT,
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id),
  post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  update_post TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);

INSERT INTO message (content, user_id, channel_id) VALUES ("first from  alice", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("second from alice", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("third from alice", 1, 2);

INSERT INTO message (content, user_id, channel_id) VALUES ("first from bob", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("second from bob", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("third from bob", 2, 2);

INSERT INTO message (content, user_id, channel_id) VALUES ("first from chris", 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("second from chris", 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("third from chris", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("forth from chris", 3, 2);