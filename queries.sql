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
insert into channel (name, organization_fk) values ('#random', 2);

-- Alice both channels
insert into user_channel(channel_kf, user_fk) values (1,1);
insert into user_channel(channel_kf, user_fk) values (2,1);

-- Bob in general channel
insert into user_channel(channel_kf, user_fk) values(1,2);

-- Chris in random
insert into user_channel(channel_kf, user_fk) values (2,3);
