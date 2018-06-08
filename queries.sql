
DROP TABLE IF EXISTS organization;
DROP TABLE IF EXISTS channel; 
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS message;

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL
);
CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL
);
CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255),
  org_id INTEGER,
  FOREIGN KEY(org_id) REFERENCES organization(id)
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content VARCHAR(512) NOT NULL,
  post_time DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  channel_id INTEGER,
  user_id INTEGER,
  FOREIGN KEY(user_id) REFERENCES user(id),
  FOREIGN KEY(channel_id) REFERENCES channel(id)
);

PRAGMA foreign_keys = ON;

INSERT INTO organization (name) VALUES ("Lambda School");
INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");
-- INSERT INTO channel (name) VALUES ("#random");

INSERT INTO user (org_id)
   SELECT id
   FROM organization
   WHERE organization.name = "Lambda School";