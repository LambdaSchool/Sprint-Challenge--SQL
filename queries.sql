CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  channel INTEGER,
  FOREIGN KEY(channel) REFERENCES channel(id)
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  organization INTEGER,
  FOREIGN KEY(organization) REFERENCES organization(id)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_time TIMESTAMP NOT NULL DEFAULT(datetime()),
  content TEXT,
  user INTEGER,
  channel INTEGER,
  FOREIGN KEY(user) REFERENCES user(id),
  FOREIGN KEY(channel) REFERENCES channel(id)
)

