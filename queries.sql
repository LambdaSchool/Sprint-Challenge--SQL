pragma foreign_keys = on; -- sqlite only!


create table organization (
  id integer primary key autoincrement,
  name varchar(128) not null unique
);

create table channel (
  id integer primary key autoincrement,
  name varchar(28) not null unique,
  organization_id integer references organization(id)
  
);

create table user (
  id integer primary key autoincrement,
  name varchar(38) not null unique
  
);

create table message (
  id integer primary key autoincrement,
  content text,
  post_time timestamp not null default(datetime()),
  user_id integer references user(id),
  channel_id integer references channel(id)
);

create table user_subs (
  user_id integer references user(id),
  channel_id integer references channel(id)
);

insert into organization (name) values ("Lambda School");

insert into user ( name ) values ("Alice"), ("Bob"), ("Chris");

insert into channel (name, organization_id) values ("#general", 1), ("#random", 1);

insert into message (content, channel_id, user_id) values ("i like potato", 1, 1);
insert into message (content, channel_id, user_id) values ("rly?", 1, 2);
insert into message (content, channel_id, user_id) values ("ya rly", 1, 1);
insert into message (content, channel_id, user_id) values ("anyone wanna play wow.", 2, 3);
insert into message (content, channel_id, user_id) values ("Why would I play games.", 2, 1);
insert into message (content, channel_id, user_id) values ("Always good to chill", 2, 3);
insert into message (content, channel_id, user_id) values ("Better learn js", 2, 1);
insert into message (content, channel_id, user_id) values ("hello peeps", 1, 2);
insert into message (content, channel_id, user_id) values ("yo whats up", 1, 1);
insert into message (content, channel_id, user_id) values ("i wanna play games", 2, 3);

insert into user_subs (user_id, channel_id) values (1, 1);
insert into user_subs (user_id, channel_id) values (1, 2);
insert into user_subs (user_id, channel_id) values (2, 1);
insert into user_subs (user_id, channel_id) values (3, 2);

select name from organization;

select name from channel;


select channel.name as "ls_channels", organization.name as "organization" from channel, organization
where channel.organization_id = organization.id
and organization.name = "Lambda School";


select message.content from message, channel
where message.channel_id = channel.id
and channel.name = "#general"
order by post_time desc;

select channel.name as "Alice's subs" from channel, user, user_subs
where user_subs.channel_id = channel.id
and user_subs.user_id = user.id
and user.name = "Alice";


select user.name as "name" from user, channel, user_subs
where user_subs.channel_id = channel.id
and channel.name = "#general"
and user_subs.user_id = user.id;

select message.content as "Alices messages", message.post_time as "Posted on" from message, user
where message.user_id = user.id
and user.name = "Alice";

select message.content as "Bob's messages", message.post_time as "Posted on" from message, channel, user
where message.user_id = user.id
and message.channel_id = channel.id
and user.name = "Bob"
and channel.name = "#random";

select count (message.content) as "Message Count", user.name as "User Name" from message, user
where message.user_id = user.id
group by user.id
order by user.name desc;

select count (message.content) as "Message Count", user.name as "User", channel.name as "Channel" from message, user, channel
where message.user_id = user.id
and channel_id = channel.id
group by channel.name, user.name;


-- Question:

-- What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?

-- Answer:

-- I would use "ON DELETE CASCADE". As per wikipedia - A foreign key with cascade delete means that if a record in the parent table is deleted, 
-- then the corresponding records in the child table will automatically be deleted. This is called a cascade delete in SQL Server.
