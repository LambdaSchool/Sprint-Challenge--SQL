-- user table
-- name must be unique
create table user (
  id Integer PRIMARY KEY AUTOINCREMENT,
  name varchar(255) not null UNIQUE
);

-- organization table
-- name must be unique
create table organization (
  id Integer PRIMARY KEY AUTOINCREMENT,
  name varchar(255) not null UNIQUE

);

-- channel table
-- name must be unique
create table channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name varchar(255) not null UNIQUE,
  organization_fk Integer REFERENCES organization(id)
);


-- message table
create table message (

  id Integer PRIMARY KEY  AUTOINCREMENT,
  post_time TimeStamp DEFAULT CURRENT_TIMESTAMP,
  content LongText,
  user_fk Integer REFERENCES user(id),
  channel_kf Integer REFERENCES channel(id)

);

-- user_channel table
create table user_channel (
  user_fk Integer REFERENCES user(id),
  channel_kf Integer REFERENCES channel(id)
);


-- insert organization
insert  into organization (name) values ('Lambda School');


-- insert into user
insert into user(name) values ('Alice');
insert into user(name) values ('Bob');
insert into user(name) values ('Chris');

-- insert into channels
insert into channel (name, organization_fk) values ('#general', 1);
insert into channel (name, organization_fk) values ('#random', 1);

-- Alice both channels
insert into user_channel(channel_kf, user_fk) values (1,1);
insert into user_channel(channel_kf, user_fk) values (2,1);

-- Bob in general channel
insert into user_channel(channel_kf, user_fk) values(1,2);

-- Chris in random
insert into user_channel(channel_kf, user_fk) values (2,3);

-- insert into message
---- Alice
--  general
insert into message(content, user_fk, channel_kf) values ('Alice general message test', 1,1);
insert into message(content, user_fk, channel_kf) values ('Alice general message test 2', 1,1);
-- Alice
-- random
insert into message(content, user_fk, channel_kf) values ('Alice general message test', 1,2);
insert into message(content, user_fk, channel_kf) values ('Alice random message test 2', 1,2);

-- Bob
-- general
insert into message(content, user_fk, channel_kf) values ('Alice random message test', 2,1);
insert into message(content, user_fk, channel_kf) values ('Alice random message test 2', 2,1);
insert into message(content, user_fk, channel_kf) values ('Alice random message test 3', 2,1);

-- Chris
insert into message(content, user_fk, channel_kf) values ('Alice random message test', 3,2);
insert into message(content, user_fk, channel_kf) values ('Alice random message test 2', 2,2);
insert into message(content, user_fk, channel_kf) values ('Alice random message test 3', 2,2);

-- queries
-- 1 list all organisation names
select name from organization;

-- 2 list all channel names
select name from channel;

-- 3
SELECT ch.name from channel as ch, organization as org
where ch.organization_fk = org.id and org.name = 'Lambda School';

-- 4
select msg.content from message as msg, channel as ch
where msg.channel_kf = ch.id and
ch.name = '#general';

-- 5
SELECT c.name AS Alice_Channels, c.id AS Channel_ID FROM channel AS c
INNER JOIN user_channel AS cs ON c.id IS cs.channel_kf
INNER JOIN user AS u ON u.id IS cs.user_fk WHERE u.name IS 'Alice';

-- 6
select u.name from user as u, channel as ch, user_channel as uc
where uc.user_fk = u.id and ch.id = uc.channel_kf
and ch.name = '#general';

-- 7
select mgs.content from message as mgs, user as u
where mgs.user_fk = u.id and u.name = 'Alice';

-- 8
SELECT * FROM message WHERE id IS (SELECT id FROM channel WHERE name IS '#random')
AND id IS (SELECT id FROM user WHERE name IS 'Bob');
