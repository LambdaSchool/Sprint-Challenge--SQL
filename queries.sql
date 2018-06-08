pragma foreign_keys = on; -- sqlite only!

create table organization (
  id integer primary key autoincrement,
  name varchar(128)
);

create table user (
  id integer primary key autoincrement,
  name varchar(128)
);

create table channel (
  id integer primary key autoincrement,
  name varchar(128),
  organization_id integer references organization(id)
);

create table message (
  id integer primary key autoincrement,
  content text,
  post_time timestamp not null default(datetime()),
  user_id integer references user(id),
  channel_id integer references channel(id)
);

create table user_channel (
  user_id integer references user(id),
  channel_id integer references channel(id)
);

insert into organization (name) values ("Lambda School");

insert into user (name) values ("Dave");
insert into user (name) values ("Albert");
insert into user (name) values ("Chris");

insert into channel (name, organization_id) values ("#general", 1);
insert into channel (name, organization_id) values ("#random", 1);

insert into message (content, channel_id, user_id) values ("Wonderful, yes it is I know.", 1, 1);
insert into message (content, channel_id, user_id) values ("Who is this?", 1, 1);
insert into message (content, channel_id, user_id) values ("Alright...", 1, 1);
insert into message (content, channel_id, user_id) values ("Did you see that new movie? It looks terrible.", 2, 1);
insert into message (content, channel_id, user_id) values ("Why would I go see a movie, my life is too exciting.", 2, 1);
insert into message (content, channel_id, user_id) values ("Always good for a chat.", 2, 3);
insert into message (content, channel_id, user_id) values ("Or not.", 2, 1);


insert into user_channel (user_id, channel_id) values (1, 1);
insert into user_channel (user_id, channel_id) values (1, 2);


insert into user_channel (user_id, channel_id) values (2, 1);


insert into user_channel (user_id, channel_id) values (3, 2);

select name from organization;

select name from channel;

select channel.name as "channel name", organization.name as "organization name"
  from channel, organization
  where channel.organization_id = organization.id
  and organization.name = "Lambda School";


select message.* from message, channel
  where message.channel_id = channel.id
  and channel.name = "#general"
  order by message.post_time desc;

select channel.* from channel, user, user_channel
  where user_channel.channel_id = channel.id
  and user_channel.user_id = user.id
  and user.name = "Dave";

select user.* from channel, user, user_channel
  where user_channel.channel_id = channel.id
  and user_channel.user_id = user.id
  and channel.name = "#general";

select message.* from message, user
  where message.user_id = user.id
  and user.name = "Dave";

select message.* from message, user, channel where message.user_id = user.id
  and message.channel_id = channel.id
  and channel.name = "#random"
  and user.name = "Albert";
