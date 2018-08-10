pragma foreign_keys = on; -- sqlite only!

create table organization (
  id integer primary key autoincrement,
  name varchar(128) not null unique
)

create table channel (
  id integer primary key autoincrement,
  name varchar(28) not null uniqe,
  organization_id integer references organization(id)
  
)

create table user (
  id integer primary key autoincrement,
  name varchar(38) not null unique,
  
)

create table message (
  id integer primary key autoincrement,
  content text,
  post_time timestamp not null default(datetime()),
  user_id integer references user(id),
  channel_id integer references channel(id)
)

create table user_subs (
  user_id integer references user(id),
  channel_id integer references channel(id)
)