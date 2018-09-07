# Wladimir Fraga CS10

-- Create tables
CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR (64) NOT NULL UNIQUE,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR (64) NOT NULL UNIQUE,
  organization_id INTEGER REFERENCES organization(id),
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR (64) NOT NULL,
  username VARCHAR (32) NOT NULL UNIQUE,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT,
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id),
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Join tables
CREATE TABLE user_channel
(
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);


--Insert data into databse
INSERT INTO organization (name) VALUES("Lambda School");

INSERT INTO user (name, username) VALUES("Alice", "littlegirl");

INSERT INTO user (name, username) VALUES("Bob", "theboss");

INSERT INTO user (name, username) VALUES("Chris", "coolguy");

INSERT INTO channel (name, organization_id) VALUES("#general", 1);

INSERT INTO channel (name, organization_id) values("#random", 1);