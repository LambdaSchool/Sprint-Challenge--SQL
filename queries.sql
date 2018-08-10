CREATE TABLE organizations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(256) NOT NULL
);

CREATE TABLE channels (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(256) NOT NULL,
    organization INTEGER,
    FOREIGN KEY(organization) REFERENCES organizations(id)
);

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(256) NOT NULL
);

CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time TEXT DEFAULT DATETIME(now),
    content VARCHAR(2048) NOT NULL,
    user INTEGER,
    channel INTEGER,
    FOREIGN KEY(user) REFERENCES users(id),
    FOREIGN KEY(channel) REFERENCES channels(id)
);

CREATE TABLE users_channels (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user INTEGER,
    channel INTEGER,
    FOREIGN KEY(user) REFERENCES users(id),
    FOREIGN KEY(channel) REFERENCES channels(id)
);

INSERT INTO organizations(name) VALUES('Lambda School');
INSERT INTO channels(name) VALUES('#general');
INSERT INTO channels(name) VALUES('#random');
INSERT INTO users(name) VALUES('Alice');
INSERT INTO users(name) VALUES('Bob');
INSERT INTO users(name) VALUES('Chris');
INSERT INTO users_channels(user, channel) VALUES(1,1);
INSERT INTO users_channels(user, channel) VALUES(1,2);
INSERT INTO users_channels(user, channel) VALUES(2,1);
INSERT INTO users_channels(user, channel) VALUES(3,2);

INSERT INTO messages(content, user, channel)
VALUES('Hey everyone! How is React going today?', 1, 1);
INSERT INTO messages(content, user, channel)
VALUES('LOL look at this cat picture...', 2, 2);
INSERT INTO messages(content, user, channel)
VALUES('I hear CS9 is about to start Labs. Good Luck!', 3, 1);
INSERT INTO messages(content, user, channel)
VALUES('OMG! Did you hear what Elon Musk tweeted?!', 1, 2);
INSERT INTO messages(content, user, channel)
VALUES('I found this awesome MongoDB resource, check it out!', 2, 1);
INSERT INTO messages(content, user, channel)
VALUES('Look at this cute picture of my baby :3', 3, 2);
INSERT INTO messages(content, user, channel)
VALUES('Which instructor is your favorite? (POLL)', 2, 1);
INSERT INTO messages(content, user, channel)
VALUES('I feel bored, post your favorite YouTube video!', 3, 2);
INSERT INTO messages(content, user, channel)
VALUES('Hey everyone, I start next week... What should I do to prepare?', 1, 1);
INSERT INTO messages(content, user, channel)
VALUES('Haha, look at this /r/ProgrammerHumor post from Reddit', 1, 2);

SELECT name AS org_name FROM organizations;
SELECT name AS channel_name FROM channels;
SELECT name AS lambda_channels FROM channels WHERE organization IS (SELECT id FROM organizations WHERE name IS 'Lambda School');
SELECT content FROM messages WHERE channel IS (SELECT id FROM channels WHERE name IS '#general') ORDER BY post_time DESC;
