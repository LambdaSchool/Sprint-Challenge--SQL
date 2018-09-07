PRAGMA foreign_keys= ON; -- Set foreign key constraing MUST BE DO.

-- IMPROVE PRINT: Set to divede in columns and show Headers
.mode column
.headers ON

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128)
);

CREATE TABLE user_channel (
  user_id INTEGER,
  channel_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (channel_id) REFERENCES channel(id)
);

CREATE TABLE message (
  user_id INTEGER,
  channel_id INTEGER,
  post_time TEXT DEFAULT CURRENT_TIMESTAMP,
  content TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (channel_id) REFERENCES channel(id)
);