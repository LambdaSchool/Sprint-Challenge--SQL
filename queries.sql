-- CREATE TABLES --
CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR (64) NOT NULL UNIQUE,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR (64) NOT NULL UNIQUE,
  username VARCHAR (32) NOT NULL UNIQUE,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR (64) NOT NULL UNIQUE,
  organization_id INTEGER REFERENCES organization (id),
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT,
  user_id INTEGER REFERENCES user (id),
  channel_id INTEGER REFERENCES channel (id),
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_channel (
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);



-- INSERT STUFF --

INSERT INTO user
  (name, username)
  VALUES("Vekh", "vivec2002");

INSERT INTO user
  (name, username)
  VALUES("Seht", "s-sil");

INSERT INTO user
  (name, username)
  VALUES("Ayem", "lexie");

INSERT INTO user
  (name, username)
  VALUES("Nerevar", "hortator1");

INSERT INTO user
  (name, username)
  VALUES("Kagrenac", "1337toolz");

INSERT INTO user
  (name, username)
  VALUES("Dagoth Ur", "ursharmat");

INSERT INTO organization
  (name)
  VALUES("ALMSIVI");

INSERT INTO organization
  (name)
  VALUES("Morrowind");

INSERT INTO channel
  (name, organization_id)
  VALUES("#CHIMtips", 1);

INSERT INTO channel
  (name, organization_id)
  VALUES("#divinediscussion", 1);

INSERT INTO channel
  (name, organization_id)
  VALUES("#guarpics", 2);

INSERT INTO channel
  (name, organization_id)
  VALUES("#livingwithcorprus", 2);

INSERT INTO message
  (content, user_id, channel_id)
  VALUES("The sage who suppresses his best aphorism: cut off his hands, for he is a thief.", 1, 1);

INSERT INTO message
  (content, user_id, channel_id)
  VALUES("lol wut?", 2, 1);

INSERT INTO message
  (content, user_id, channel_id)
  VALUES("What do you guys do when your followers pray to you too much?", 3, 2);

INSERT INTO message
  (content, user_id, channel_id)
  VALUES("There is once more the case of the symbolic and barren. The true prince that is cursed and demonized will be adored at last with full hearts. According to the Codes of Mephala there can be no official art, only fixation points of complexity that will erase from the awe of the people given enough time. This is a secret that hides another. An impersonal survival is not the way of the ruling king. Embrace the art of the people and marry it and by that I mean secretly have it murdered.", 1, 2);

INSERT INTO message
  (content, user_id, channel_id)
  VALUES("Uh, OK, thanks.", 3, 2);

INSERT INTO message
  (content, user_id, channel_id)
  VALUES("Guys, I got locked out of the ALMSIVI channels, you need to reinvite me.  Guys?  Are you seeing this?", 4, 3);

INSERT INTO user_channel
  (user_id, channel_id)
  VALUES(1, 1);

INSERT INTO user_channel
  (user_id, channel_id)
  VALUES(3, 2);

INSERT INTO user_channel
  (user_id, channel_id)
  VALUES(6, 4);

INSERT INTO user_channel
  (user_id, channel_id)
  VALUES(5, 3);