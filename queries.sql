CREATE TABLE organization(
  organization_id INTEGER PRIMARY KEY AUTOINCREMENT,
  organization_name  VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE channel(
  channel_id INTEGER PRIMARY KEY AUTOINCREMENT,
  channel_name VARCHAR(50),
  organization_id INTEGER
   NOT NULL REFERENCES organization(organization_id)
);

CREATE TABLE user(
  u_id INTEGER PRIMARY KEY AUTOINCREMENT,
  username VARCHAR(50),
  firstname VARCHAR(50),
  lastname VARCHAR(50)
);

CREATE TABLE message(
  message_id INTEGER PRIMARY KEY AUTOINCREMENT,
  message_content VARCHAR(128),
  u_id  INTEGER NOT NULL REFERENCES user(u_id),
  channel_id INTEGER NOT NULL REFERENCES channel(channel_id),
  post_time timestamp DATE DEFAULT(DATETIME('NOW', 'LOCALTIME'))
);

CREATE TABLE channel_user(
  u_id INTEGER REFERENCES user(u_id),
  channel_id INTEGER REFERENCES channel(channel_id)
);

INSERT INTO organization(organization_name) VALUES('PFIZER');
INSERT INTO organization(organization_name) VALUES('ALU');
INSERT INTO organization(organization_name) VALUES('Lambda School');
INSERT INTO organization(organization_name) VALUES('NOKIA');

INSERT INTO user(username, firstname, lastname) VALUES('alicejones','Alice','Johns');
INSERT INTO user(username, firstname, lastname) VALUES('bobM','Bob','Marley');
INSERT INTO user(username, firstname, lastname) VALUES('ChrisR','Chris','Rock');