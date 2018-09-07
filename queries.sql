-- CREATE TABLES --
CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR (64) NOT NULL UNIQUE,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR (64) NOT NULL UNIQUE,
  username VARCHAR (32) NOT NULL UNIQUE,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR (64) NOT NULL UNIQUE,
  organization_id INTEGER REFERENCES organization (id),
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT,
  user_id INTEGER REFERENCES user (id),
  channel_id INTEGER REFERENCES channel (id),
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_channel (
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);



-- INSERT STUFF --

INSERT INTO user
  (name, username)
  VALUES("Vekh", "vivec2002");

INSERT INTO user
  (name, username)
  VALUES("Seht", "s-sil");

INSERT INTO user
  (name, username)
  VALUES("Ayem", "lexie");

INSERT INTO user
  (name, username)
  VALUES("Nerevar", "hortator1");

INSERT INTO user
  (name, username)
  VALUES("Kagrenac", "1337toolz");

INSERT INTO user
  (name, username)
  VALUES("Dagoth Ur", "ursharmat");
