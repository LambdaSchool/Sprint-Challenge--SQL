-- CREATE TABLES
CREATE TABLE organization {
  id int NOT NULL,
  organization_name varchar(255) NOT NULL,
  PRIMARY KEY (id)
};

CREATE TABLE channel {
  id int NOT NULL,
  channel_name varchar(255) NOT NULL,
  organization_id int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (organization_id) REFERENCES organization(id)
};

CREATE TABLE user {
  id int NOT NULL,
  person_name varchar(255) NOT NULL,
  PRIMARY KEY (id),
};

CREATE TABLE message {
  id int NOT NULL,
  message_content varchar(255) NOT NULL,
  channel_id int NOT NULL,
  user_id int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (channel_id) REFERENCES channel(id)
  FOREIGN KEY (user_id) REFERENCES user(id)
};

CREATE TABLE subscriptions {
  id int NOT NULL,
  channel_id int NOT NULL,
  user_id int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (channel_id) REFERENCES channel(id)
  FOREIGN KEY (user_id) REFERENCES user(id)
};

-- INSERT DATA
INSERT INTO organization
VALUES (1, 'Lambda School');

INSERT INTO user
VALUES (1, 'Alice');

INSERT INTO user
VALUES (2, 'Bob');

INSERT INTO user
VALUES (3, 'Chris');

INSERT INTO channel
VALUES (1, '#general', 1);

INSERT INTO channel
VALUES (2, '#random', 1);

INSERT INTO subscriptions
VALUES (1, 1, 1);

INSERT INTO subscriptions
VALUES (2, 2, 1);

INSERT INTO subscriptions
VALUES (3, 1, 2);

INSERT INTO subscriptions
VALUES (4, 2, 3);