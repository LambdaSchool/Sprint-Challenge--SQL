-- Please note that SQLite syntax will be in use.

PRAGMA foreign_keys = ON;

.mode column
.header on

DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  organization_id INTEGER REFERENCES organization(id) ON DELETE CASCADE NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  channel_id INTEGER REFERENCES channel(id),
  name TEXT NOT NULL
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER REFERENCES user(id) ON DELETE CASCADE NOT NULL,
  post_time TEXT NOT NULL,
  content TEXT NOT NULL
);

CREATE TABLE user_organization (
  user_id INTEGER REFERENCES user(id),
  organization_id INTEGER REFERENCES organization(id)
);