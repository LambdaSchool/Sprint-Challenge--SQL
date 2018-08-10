PRAGMA foreign_keys = ON;


-- Organization Table

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  channel INTEGER REFRENCES channel(id)
);

-- Channel Table

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    users INTEGER REFRENCES user(id),
    organization INTEGER REFRENCES organization(id)
);

-- User Table
CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  messages INTEGER REFRENCES message(id)
);


