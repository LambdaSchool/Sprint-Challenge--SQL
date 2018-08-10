PRAGMA foreign_keys = 1;

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR,
  organization_id INTEGER,

  FOREIGN KEY(organization_id) REFERENCES organization(id)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR,
  organization_id INTEGER,
  channel_id INTEGER,

  FOREIGN KEY(organization_id) REFERENCES organization(id),
  FOREIGN KEY(channel_id) REFERENCES channel(id)
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR,
  VARCHAR content,
  user_id INTEGER,

  timestamp DATE DEFAULT (datetime('now','localtime')),
  FOREIGN KEY(user_id) REFERENCES user(id)
);

INSERT INTO organization (name) VALUES ('Lambda School');
INSERT INTO channel (name) VALUES ('general');
INSERT INTO channel (name) VALUES ('random');

INSERT INTO user (name, organization_id, channel_id)
  SELECT 'Alice',
    (SELECT id FROM organization WHERE name = 'Lambda School'),
    (SELECT id FROM channel WHERE name = 'general');

-- INSERT INTO user (name, organization_id, channel_id) VALUES ('Bob');
-- INSERT INTO user (name, organization_id, channel_id) VALUES ('Chris');
--
-- INSERT INTO channel VALUES ()
