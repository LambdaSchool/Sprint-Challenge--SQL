-- organization table
CREATE TABLE organization = (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  channels INTEGER REFRENCES channel(id)
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