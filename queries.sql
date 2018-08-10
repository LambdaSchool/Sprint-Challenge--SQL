-- organization table
CREATE TABLE organization = (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  channels INTEGER REFRENCES channel(id)
);

-- channel table
CREATE TABLE channel = (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  users INTEGER REFRENCES user(id)
);

-- user table
CREATE TABLE user = (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  channels INTEGER REFRENCES channel(id),
  messages INTEGER REFRENCES message(id)
);

-- message table
CREATE TABLE message = (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_time TimeStamp DEFAULT CURRENT_TIMESTAMP,
  content LongText,
  user INTEGER REFRENCES user(id),
  channel INTEGER REFRENCES channel(id)
);

