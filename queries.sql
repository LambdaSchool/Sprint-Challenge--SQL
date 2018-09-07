-- CREATE TABLES
CREATE TABLE organization {
  id int AUTOINCREMENT,
  organization_name varchar(255) NOT NULL,
  PRIMARY KEY (id)
};

CREATE TABLE channel {
  id int AUTOINCREMENT,
  channel_name varchar(255) NOT NULL,
  organization_id int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (organization_id) REFERENCES organization(id)
};

CREATE TABLE user {
  id int AUTOINCREMENT,
  person_name varchar(255) NOT NULL,
  PRIMARY KEY (id),
};

CREATE TABLE message {
  id int AUTOINCREMENT,
  message_content varchar(255) NOT NULL,
  channel_id int NOT NULL,
  user_id int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (channel_id) REFERENCES channel(id)
  FOREIGN KEY (user_id) REFERENCES user(id)
};

CREATE TABLE subscriptions {
  id int AUTOINCREMENT,
  channel_id int NOT NULL,
  user_id int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (channel_id) REFERENCES channel(id)
  FOREIGN KEY (user_id) REFERENCES user(id)
};

-- INSERT DATA
INSERT INTO organization
VALUES ('Lambda School');

INSERT INTO user
VALUES ('Alice');

INSERT INTO user
VALUES ('Bob');

INSERT INTO user
VALUES ('Chris');

INSERT INTO channel
VALUES ('#general', 1);

INSERT INTO channel
VALUES ('#random', 1);

INSERT INTO subscriptions
VALUES (1, 1);

INSERT INTO subscriptions
VALUES (2, 1);

INSERT INTO subscriptions
VALUES (1, 2);

INSERT INTO subscriptions
VALUES (2, 3);