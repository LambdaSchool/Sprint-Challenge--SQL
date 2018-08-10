-- organization table
CREATE TABLE organization = (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  channel INTEGER REFRENCES channel(id)
);

-- channel table
CREATE TABLE channel = (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  users INTEGER REFRENCES user(id),
  organization INTEGER REFRENCES organization(id)
);

-- user table
CREATE TABLE user = (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  messages INTEGER REFRENCES message(id)
);

-- user channel table 
CREATE TABLE user_channel = (
  user INTEGER REFRENCES user(id),
  channel INTEGER REFRENCES channel(id),
)

-- message table
CREATE TABLE message = (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_time TimeStamp DEFAULT CURRENT_TIMESTAMP,
  content LongText,
  user INTEGER REFRENCES user(id),
  channel INTEGER REFRENCES channel(id)
);

-- insert organization
insert into organization (name) values ('Lambda School');

-- insert 3 users 
insert into user(name) values ('Alice');
insert into user(name) values ('Bob');
insert into user(name) values ('Chris');

-- insert 2 channels
insert into channel (name, organization) values ('#general', 1);
insert into channel (name, organization) values ('#random', 2);

-- insert Alice 
insert into user_channel (channel, user) values (1,1);
insert into user_channel (channel, user) values (2,1);

-- insert Bob 
insert into user_channel (channel, user) values (1,2);

-- insert Chris
insert into user_channel (channel, user) values (2,3);

-- insert 10 messages 
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

-- list organization names
SELECT organization.name FROM organization;

-- list channel names 
SELECT channel.name FROM channel;

-- List all channels in a specific organization by organization name
SELECT channel.name, organization.name FROM channel, organization WHERE channel.organizationid = organization.id AND organization.name = 'Lambda School';

-- List all messages in a specific channel by channel name #general in order of post_time, descending
SELECT msg.content FROM message as msg, channel as ch WHERE msg.channel = ch.id AND ch.name = '#general' ORDER BY post_time DESC;

-- List all channels to which user Alice belongs.
SELECT ch.name AS Alice_Channels, ch.id AS Channel_ID FROM channel AS ch
INNER JOIN user_channel AS cs ON ch.id IS cs.channel_
INNER JOIN user AS u ON u.id IS cs.user WHERE u.name IS 'Alice';

-- List all users that belong to channel #general
SELECT u.name FROM user as u, channel as ch, user_channel as uc
WHERE uc.user = u.id AND ch.id = uc.channel
AND ch.name = '#general';

-- List all messages in all channels by user Alice
SELECT mgs.content FROM message as mgs, user as u
WHERE mgs.user = u.id AND u.name = 'Alice';

-- List all messages in #random by user Bob
SELECT * FROM message WHERE id IS (SELECT id FROM channel WHERE name IS '#random')
AND id IS (SELECT id FROM user WHERE name IS 'Bob');

-- List the count of messages across all channels per user
SELECT COUNT(u.id) AS 'Message Count', u.name AS 'User Name' FROM message AS m 
INNER JOIN user AS u on m.user_id IS u.id 
INNER JOIN channel as c WHERE m.channel_id IS c.id GROUP BY u.id;

-- What SQL keywords or concept would you use if you wanted to 
--automatically delete all messages by a user if that user were deleted from the user table?
-- delete