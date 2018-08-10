-- turn on foreign keys
PRAGMA foreign_keys = ON;

-- CREATE TABLE QUERIES

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nime VARCHAR(128)
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nime VARCHAR(128),
    org_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nime VARCHAR(128)
);

CREATE TABLE missage (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    post_time TIMESTAMP NOT NULL DEFAULT(DATETIME()),
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);

CREATE TABLE in_channel (
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
);


-- INSERT QUERIES

INSERT INTO organization (nime) VALUES ('Lambda School');

INSERT INTO user (nime) VALUES ("Alice");
INSERT INTO user (nime) VALUES ("Bob");
INSERT INTO user (nime) VALUES ("Chris");

INSERT INTO channel (nime, org_id) VALUES ('#general', 1);
INSERT INTO channel (nime, org_id) VALUES ('#Rrandom', 1);

INSERT INTO missage (content, user_id, channel_id) VALUES ('Hey everyone!', 1, 1);
INSERT INTO missage (content, user_id, channel_id) VALUES ('Whats new?', 3, 1);
INSERT INTO missage (content, user_id, channel_id) VALUES ('Lambda school is great!', 2, 2);
INSERT INTO missage (content, user_id, channel_id) VALUES ('What video games are you in to?', 1, 1);
INSERT INTO missage (content, user_id, channel_id) VALUES ('Anyone ever eaten lobster??', 3, 2);
INSERT INTO missage (content, user_id, channel_id) VALUES ('Who knows how to write a back end?', 1, 2);
INSERT INTO missage (content, user_id, channel_id) VALUES ('Is this the right channel to talk about comic books?', 1, 1);
INSERT INTO missage (content, user_id, channel_id) VALUES ('Favorite pasta dish?', 1, 1);
INSERT INTO missage (content, user_id, channel_id) VALUES ('Nice to meet you all!', 2, 2);
INSERT INTO missage (content, user_id, channel_id) VALUES ('Thanks for chatting!', 1, 1);

INSERT INTO in_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO in_channel (user_id, channel_id) VALUES (1, 2);
INSERT INTO in_channel (user_id, channel_id) VALUES (2, 1);
INSERT INTO in_channel (user_id, channel_id) VALUES (3, 2);

-- SELECT QUERIES

SELECT nime FROM organization;
SELECT nime FROM channel;

SELECT organization.nime AS "Organization", channel.nime AS "Channel" FROM channel JOIN organization;
SELECT missage.* FROM missage, channel WHERE missage.channel_id = channel.id AND channel.nime = "#general" ORDER BY missage.post_time DESC;
SELECT channel.* FROM channel, user, in_channel WHERE in_channel.channel_id = channel.id AND in_channel.user_id = user.id AND user.nime = "Alice";
SELECT user.* FROM channel, user, in_channel WHERE in_channel.channel_id = channel.id AND in_channel.user_id = user.id AND channel.nime = "#general"
SELECT missage.* FROM missage, user WHERE missage.user_id = user.id AND user.nime = "Alice";
SELECT missage.* FROM missage, user, channel WHERE missage.user_id = user.id AND missage.channel_id = channel.id AND channel.nime = "#random" AND user.nime = "Bob";
SELECT user.nime AS "User Nime", COUNT(missage.content) AS "Missage Count" FROM user, missage WHERE missage.user_id = user.id GROUP BY user.nime ORDER BY user.nime DESC;






