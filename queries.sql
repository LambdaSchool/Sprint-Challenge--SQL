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

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  content VARCHAR(1024),
  userID INTEGER,
  channelID INTEGER,
  FOREIGN KEY (userID) REFERENCES user(id),
  FOREIGN KEY (channelID) REFERENCES channel(id)  
);

CREATE TABLE channel_user (
  channelID INTEGER,
  userID INTEGER,
  FOREIGN KEY (channelID) REFERENCES channel(id),
  FOREIGN KEY (userID) REFERENCES user(id)
);

CREATE TABLE organization_channel (
  organizationID INTEGER,
  channelID INTEGER,
  FOREIGN KEY (organizationID) REFERENCES organization(id),
  FOREIGN KEY (channelID) REFERENCES channel(id)
);

INSERT INTO organization (name) VALUES ('Lambda School');

INSERT INTO user (name)  VALUES ('Alice');
INSERT INTO user (name)  VALUES ('Bob');
INSERT INTO user (name)  VALUES ('Chris');

INSERT INTO channel (name) VALUES('#general');
INSERT INTO organization_channel (organizationID, channelID) VALUES (1, 1);

INSERT INTO channel_user (channelID, userID) VALUES (1,1);
INSERT INTO channel_user (channelID, userID) VALUES (1,2);

INSERT INTO channel (name) VALUES('#random');
INSERT INTO organization_channel (organizationID, channelID) VALUES (1, 2);

INSERT INTO channel_user (channelID, userID) VALUES (2,1);
INSERT INTO channel_user (channelID, userID) VALUES (2,3);


INSERT INTO message (content, userID, channelID) VALUES ('hey', 1, 1);
INSERT INTO message (content, userID, channelID) VALUES ('hi, whats up', 2, 1);
INSERT INTO message (content, userID, channelID) VALUES ('are you done yet?', 1, 1);
INSERT INTO message (content, userID, channelID) VALUES ('almost, gimme 5 minutes', 2, 1);
INSERT INTO message (content, userID, channelID) VALUES ('aaand done, ready?', 2, 1);
INSERT INTO message (content, userID, channelID) VALUES ('finally lets go', 1, 1);

INSERT INTO message (content, userID, channelID) VALUES ('yo check this out', 3, 2);
INSERT INTO message (content, userID, channelID) VALUES ('okie', 1, 2);
INSERT INTO message (content, userID, channelID) VALUES ('you gonna follow up on that?', 1, 2);
INSERT INTO message (content, userID, channelID) VALUES ('nope :P', 3, 2);