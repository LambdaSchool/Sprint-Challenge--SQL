create table organization(
  id integer primary key autoincrement,
  name varchar(128)
);

create table channel (
  id integer primary key autoincrement,
  name varchar(128),
  organization_id integer,
  
   CONSTRAINT fk_channel_organization_id
  foreign key (organization_id) references organization (id)
  ON DELETE CASCADE
);

create table user (
  id integer primary key autoincrement,
  name varchar(128)
);

create table message (
  id integer primary key autoincrement,
  post_time integer , 
  content text ,
  user_id integer,

  CONSTRAINT fk_message_user_id
  foreign key (user_id) references user (id)
  ON DELETE CASCADE
);






create table user_channel (
  id integer primary key autoincrement,
  channel_id integer,
  user_id integer ,

  CONSTRAINT fk_user_channel_channel_id
  foreign key (channel_id) references channel(id)
  ON DELETE CASCADE

  CONSTRAINT fk_user_channel_user_id
  foreign key (user_id) references user(id)
  ON DELETE CASCADE
);



create table channel_message (
  id integer primary key autoincrement,
  channel_id integer, 
  message_id integer ,

  CONSTRAINT fk_channel_message_channel_id
  foreign key (channel_id) references channel (id)
  ON DELETE CASCADE

  CONSTRAINT fk_channel_message_message_id
  foreign key (message_id) references message (id)
  ON DELETE CASCADE
);

