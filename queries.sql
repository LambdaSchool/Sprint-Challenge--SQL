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
  content varchar(120) not null,
  user_id integer,
  channel_id integer,
  post_time datetime default current_timestamp,
  foreign key (channel_id) references channel(id),
  foreign key (user_id) references user(id)
);

create table user_channels (
    user_id integer,
    channel_id integer,
    foreign key (user_id) references user(id),
    foreign key (channel_id) references channel(id)
);

insert into organization (name) values ("Lambda School");

insert into user (name) values ("Alice");
insert into user (name) values ("Bob");
insert into user (name) values ("Chris");

insert into channel (name) values ("#general");
insert into channel (name) values ("#random");

insert into message (content, user_id, channel_id) values ("Hey Alice!", 2, 1);
insert into message (content, user_id, channel_id) values ("Hey Bob...", 1, 1);
insert into message (content, user_id, channel_id) values ("I love go", 3, 2);
insert into message (content, user_id, channel_id) values ("Go go go go go", 3, 2);
insert into message (content, user_id, channel_id) values ("How are the reports coming Alice?", 2, 1);
insert into message (content, user_id, channel_id) values ("On track to finish by 2pm!", 1, 1);
insert into message (content, user_id, channel_id) values ("Cool, see you then ", 2, 1);
insert into message (content, user_id, channel_id) values ("Having inernet issues", 2, 1);
insert into message (content, user_id, channel_id) values ("I like dogs", 3, 2);
insert into message (content, user_id, channel_id) values ("Cats are better", 1, 2);

insert into user_channels (user_id, channel_id) values (1, 1);
insert into user_channels (user_id, channel_id) values (1, 2);
insert into user_channels (user_id, channel_id) values (2, 1);
insert into user_channels (user_id, channel_id) values (3, 2);


select (name) from organization;
select (name) from channel;
select channel.name as "Channel", organization.name as "Organization" from channel join organization;
select * from message where message.channel_id = 2  order by post_time desc;