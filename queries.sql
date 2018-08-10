create table organization(
  id integer primary key autoincrement,
  name varchar(128)
);

create table channel (
  id integer primary key autoincrement,
  name varchar(128),
  organization_id integer,
  foreign key (organization_id) references organization (id)
);

create table user (
  id integer primary key autoincrement,
  name varchar(128)
);

create table user_channel (
  id integer primary key autoincrement,
  channel_id integer,
  user_id integer,
  foreign key (channel_id) references channel(id)
  foreign key (user_id) references user(id)
);

create table message (
  id integer primary key autoincrement,
  post_time integer , 
  content text ,
  user_id integer,
  foreign key (user_id) references user (id)
);

create table channel_message (
  id integer primary key autoincrement,
  channel_id integer, 
  message_id integer,
  foreign key (channel_id) references channel (id)
  foreign key (message_id) references message (id)
);

