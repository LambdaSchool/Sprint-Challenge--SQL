Drop table if exists organization;--
Drop table if exists channel;--
Drop table if exists user;--
Drop table if exists message;--


create table organization (
  id integer primary key autoincrement,
  name varchar(120) not null
);

create table channel(
  id integer primary key autoincrement,
  name varchar(120) not null,
  organization_id integer,
  foreign key (organization_id) references organization(id)
);

create table user (
  id integer primary key autoincrement,
  name varchar(120) not null
);

create table message (
  id integer primary key autoincrement,
  name varchar(120) not null,
  content varchar(120) not null,
  post_time datetime not null,
  user_id integer,
  channel_id integer,
  foreign key (channel_id) references channel(id),
  foreign key (user_id) references user(id) 
);

