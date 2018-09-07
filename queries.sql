# Wladimir Fraga CS10

-- Create tables
CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR (64) NOT NULL UNIQUE,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR (64) NOT NULL UNIQUE,
  organization_id INTEGER REFERENCES organization(id),
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR (64) NOT NULL,
  username VARCHAR (32) NOT NULL UNIQUE,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT,
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id),
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Join tables
CREATE TABLE user_channel
(
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);


--Insert data into databse
INSERT INTO organization (name) VALUES("Lambda School");

INSERT INTO user (name, username) VALUES("Alice", "littlegirl");

INSERT INTO user (name, username) VALUES("Bob", "theboss");

INSERT INTO user (name, username) VALUES("Chris", "coolguy");

INSERT INTO channel (name, organization_id) VALUES("#general", 1);

INSERT INTO channel (name, organization_id) values("#random", 1);

--Insert 10 messages 
INSERT INTO message (content, user_id, channel_id) VALUES("Is this the lambda general channel?", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("Yes you are in the lambda general channel, the coolest channel", 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("Welcome to the lambda general channel littlegirl, I'm Bob theboss", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("Thank You guys, I'm new here there is another channel were i can post any subject", 1, 1);

INSERT INTO message (content, user_id, channel_id) VALUES("Breakout written in, uh, PDF.", 2, 2);

INSERT INTO message (content, user_id, channel_id) VALUES("Try the #random channel", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("I'm getting ready to jump into lambda labs next week", 3, 1);

INSERT INTO message (content, user_id, channel_id) VALUES("No way, Beej maybe did it, madman lol", 3, 2);

INSERT INTO message (content, user_id, channel_id) VALUES("What is lamdba labs?", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("Where the cool guys code real life apps", 3, 1);

INSERT INTO user_channel (user_id, channel_id) VALUES(1,1);
INSERT INTO user_channel (user_id, channel_id) VALUES(1,2);

INSERT INTO user_channel (user_id, channel_id) VALUES(2,1);

INSERT INTO user_channel (user_id, channel_id) VALUES(3,2);

--select data


SELECT name FROM organization;

SELECT name FROM channel;

SELECT channel.name FROM channel, organization WHERE organization_id = organization.id AND organization.name= "Lambda School";

SELECT content FROM message, channel WHERE channel_id = channel.id AND channel.name = "#general" ORDER BY message.created DESC;

SELECT channel.name FROM user, channel, user_channel WHERE user.id = user_id AND channel.id = channel_id AND user.name  = "Alice";

SELECT user.name FROM user, channel, user_channel WHERE user.id = user_id AND channel.id = channel_id AND channel.name  = "#general";

SELECT content FROM message, user WHERE user_id = user.id AND user.name = "Alice";

SELECT message.content AS "Message" FROM user, channel, message WHERE user.id=message.user_id AND channel.id=message.channel_id AND channel.name="#random" AND user.name="Bob";

.mode column
.header on
SELECT user.name AS "User Name", COUNT(message.content) AS "Message Count" FROM user, message WHERE user.id=message.user_id GROUP BY "User Name";


-- Question: What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?

-- Answer: "ON DELTE CASCADE" 