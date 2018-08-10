


-- Organization Table

CREATE TABLE organization = (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  channel INTEGER REFRENCES channel(id)
);