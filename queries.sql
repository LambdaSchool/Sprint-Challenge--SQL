PRAGMA foreign_keys = ON;


-- Organization Table

CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  channel INTEGER REFRENCES channel(id)
);

-- Channel Table

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    users INTEGER REFRENCES user(id),
    organization INTEGER REFRENCES organization(id)
);

-- User Table
CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  messages INTEGER REFRENCES message(id)
);

-- Message Table
CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_time TimeStamp DEFAULT CURRENT_TIMESTAMP,
  content LongText,
  user INTEGER REFRENCES user(id),
  channel INTEGER REFRENCES channel(id)
);

-- Insert Organization
insert into organization (name) values ('Lambda School');

-- Insert Users 
insert into user(name) values ('Alice');
insert into user(name) values ('Bob');
insert into user(name) values ('Chris');

-- Insert Channels
insert into channel (name, organization) values ('#general', 1);
insert into channel (name, organization) values ('#random', 2);

-- Alice 
insert into user_channel (channel, user) values (1,1);
insert into user_channel (channel, user) values (2,1);

-- Bob 
insert into user_channel (channel, user) values (1,2);

-- Chris
insert into user_channel (channel, user) values (2,3);

-- Messages 
insert into message (content, user, channel) values ('Random Message 1', 1, 2);
insert into message (content, user, channel) values ('Random Message 2', 2, 2);
insert into message (content, user, channel) values ('Random Message 3', 1, 1);
insert into message (content, user, channel) values ('Random Message 4', 3, 2);
insert into message (content, user, channel) values ('Random Message 5', 3, 1);
insert into message (content, user, channel) values ('Random Message 6', 1, 1);
insert into message (content, user, channel) values ('Random Message 7', 2, 1);
insert into message (content, user, channel) values ('Random Message 8', 1, 2);
insert into message (content, user, channel) values ('Random Message 9', 2, 2);
insert into message (content, user, channel) values ('Random Message 10', 3, 2);


-- List Organization Names
SELECT organization.name FROM organization;

-- List Channel Names 
SELECT channel.name FROM channel;

-- List All Channels In A Specific Organization By Organization name
SELECT channel.name, organization.name FROM channel, organization WHERE channel.organizationid = organization.id AND organization.name = 'Lambda School';

-- List All Messages In A Specific Channel By Channel Name
SELECT msg.content FROM message as msg, channel as ch WHERE msg.channel = ch.id AND ch.name = '#general' ORDER BY post_time DESC;

-- List All Channels To Which User Alice Belongs.
SELECT ch.name AS Alice_Channels, ch.id AS Channel_ID FROM channel AS ch
INNER JOIN user_channel AS cs ON ch.id IS cs.channel_
INNER JOIN user AS u ON u.id IS cs.user WHERE u.name IS 'Alice';

-- List All Users That Belong To Channel #general
SELECT u.name FROM user as u, channel as ch, user_channel as uc
WHERE uc.user = u.id AND ch.id = uc.channel
AND ch.name = '#general';

-- List All Messages In All Channels By User Alice
SELECT mgs.content FROM message as mgs, user as u
WHERE mgs.user = u.id AND u.name = 'Alice';

-- List All Messages In #random By User Bob
SELECT * FROM message WHERE id IS (SELECT id FROM channel WHERE name IS '#random')
AND id IS (SELECT id FROM user WHERE name IS 'Bob');


-- List The Count Of Messages Across All Channels Per User
SELECT COUNT(u.id) AS 'Message Count', u.name AS 'User Name' FROM message AS m 
INNER JOIN user AS u on m.user_id IS u.id 
INNER JOIN channel as c WHERE m.channel_id IS c.id GROUP BY u.id;



-- Question Number 6
-- ON DELETE CASCADE would be use to delete the data