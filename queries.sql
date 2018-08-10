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
    organization_id INTEGER NOT NULL,
    FOREIGN KEY(organization) REFERERENCES organization(id)
   );


