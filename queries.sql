
CREATE TABLE organization(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(100) not null UNIQUE
);

CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL UNIQUE,
  org_id INTEGER,
  FOREIGN KEY (org_id) REFERENCES organization(id)
);

CREATE TABLE messages(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content MEDIUMTEXT NOT NULL,
    post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    channel_id INTEGER,
    users_id INTEGER,
    FOREIGN KEY (channel_id) REFERENCES channels(id),
    FOREIGN KEY (users_id) REFERENCES users(id)
);
CREATE TABLE users_channel (
  users_id INTEGER,
  channel_id INTEGER,
  FOREIGN KEY (users_id) REFERENCES users(id),
  FOREIGN KEY (channel_id) REFERENCES channel(id)
);


INSERT INTO organization (name) VALUES ('Lambda School');

INSERT INTO users (name) VALUES ('Alice');
INSERT INTO users (name) VALUES ('Bob');
INSERT INTO users (name) VALUES ('Chris');

INSERT INTO channel (name, org_id) VALUES ('#general', 1);
INSERT INTO channel (name, org_id) VALUES ('#random', 1);

-- Alice
INSERT INTO users_channel(channel_id, users_id) VALUES (1,1);
INSERT INTO users_channel(channel_id, users_id) VALUES (2,1);

--BOB TABLES lol :)
INSERT INTO users_channel(channel_id, users_id) VALUES(1,2);
--CHRIS
INSERT INTO users_channel(channel_id, users_id) VALUES (2,3);



INSERT INTO messages (content, channel_id, users_id) VALUES ('Alice messages Once', 1, 1);
INSERT INTO messages (content, channel_id, users_id) VALUES ('Alice messages twice', 2, 1);
INSERT INTO messages (content, channel_id, users_id) VALUES ('Bobs messages OK', 1, 2);
INSERT INTO messages (content, channel_id, users_id) VALUES ('Chris messages random', 2, 3);

SELECT name FROM organization;
SELECT name FROM channel;

SELECT channel.name from channel, organization
    WHERE channel.org_id = organization.id
    AND organization.name = "Lambda School";

SELECT messages.content, messages.post_time, messages.users_id FROM messages, channel
        WHERE channel_id = channel.id
        AND channel.name = "#general"
        ORDER BY post_time;

SELECT channel.name as Channel_Name FROM channel, messages, users
      WHERE channel.id = messages.channel_id
      AND messages.users_id = users.id
      AND users.name = "Alice"
      GROUP BY channel.name;

SELECT messages.id, messages.content, messages.post_time, messages.channel_id, messages.users_id
      FROM messages, channel, users
      WHERE messages.users_id = users.id
      AND users.name = "Bob"
      AND messages.channel_id = channel.id
      AND channel.name = "#random";
