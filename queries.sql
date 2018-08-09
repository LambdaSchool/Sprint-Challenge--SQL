DROP TABLE IF EXISTS organization;
CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

DROP TABLE IF EXISTS channel;
CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  organization_id INTEGER REFERENCES organization(id)
);

DROP TABLE IF EXISTS user;
CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

DROP TABLE IF EXISTS message;
CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  content TEXT,
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);

DROP TABLE IF EXISTS channel_user;
CREATE TABLE channel_user (
  channel_id INTEGER REFERENCES channel(id),
  user_id INTEGER REFERENCES user(id)
);

INSERT INTO organization (name) VALUES ('Lambda School');
INSERT INTO organization (name) VALUES ('Free Code Camp');
INSERT INTO organization (name) VALUES ('Edx');

INSERT INTO channel (name, organization_id) VALUES ('#general', 1);
INSERT INTO channel (name, organization_id) VALUES ('#random', 1);
INSERT INTO channel (name, organization_id) VALUES ('#computerscience', 1);
INSERT INTO channel (name, organization_id) VALUES ('#lambdalabs', 1);
INSERT INTO channel (name, organization_id) VALUES ('#careerdevelopment', 1);
INSERT INTO channel (name, organization_id) VALUES ('#isa', 1);
INSERT INTO channel (name, organization_id) VALUES ('#javascript', 2);
INSERT INTO channel (name, organization_id) VALUES ('#campfires', 2);
INSERT INTO channel (name, organization_id) VALUES ('#nonprofits', 2);
INSERT INTO channel (name, organization_id) VALUES ('#cs50', 3);
INSERT INTO channel (name, organization_id) VALUES ('#puzzleday', 3);

INSERT INTO user (name) VALUES ('Alice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');
INSERT INTO user (name) VALUES ('Devon');
INSERT INTO user (name) VALUES ('Marjoerie');
INSERT INTO user (name) VALUES ('Moonlight');
INSERT INTO user (name) VALUES ('Ponzi');
INSERT INTO user (name) VALUES ('Taylor');
INSERT INTO user (name) VALUES ('Artemis');



