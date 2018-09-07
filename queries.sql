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
}