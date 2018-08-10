create table user (
    name varchar(256) not null unique,
    id integer primary key autoincrement
);

create table organization (
    id integer primary key autoincrement,
    name varchar(256) not null unique
);

create table channel (
    id integer primary key autoincrement,
    name varchar(256) not null unique,
    organization_id integer reference organization(id)
);

create table message (
    id integer primary key autoincrement,
    post_time Timestamp default current_timestamp,
    content varchar(512),
    user_id integer references user(id),
    channel_id integer reference channel(id)
);

create table user_channel (
    user_id integer references user(id),
    channel_id integer references channel(id)
);

-- 4
insert into organization (name) values ('Lambda School');
insert into user (name) values ('Alice');
insert into user (name) values ('Bob');
insert into user (name) values ('Chris');

insert into channel (name, organization_id) values ('#general', 1);
insert into channel (name, organization_id) values ('#random', 1);

-- 10 messages
insert into message (content, user_id, channel_id) values ('blah', 1, 1)
insert into message (content, user_id, channel_id) values ('blah1', 1, 1)
insert into message (content, user_id, channel_id) values ('blah2', 1, 1)
insert into message (content, user_id, channel_id) values ('blah3', 1, 1)
insert into message (content, user_id, channel_id) values ('blah4', 1, 1)
insert into message (content, user_id, channel_id) values ('blah5', 1, 1)
insert into message (content, user_id, channel_id) values ('blah6', 1, 1)
insert into message (content, user_id, channel_id) values ('blah7', 1, 1)
insert into message (content, user_id, channel_id) values ('blah8', 1, 1)
insert into message (content, user_id, channel_id) values ('blah9', 1, 1)

insert into message (content, user_id, channel_id) values ('blah', 2, 2)
insert into message (content, user_id, channel_id) values ('blah1', 2, 2)
insert into message (content, user_id, channel_id) values ('blah2', 2, 2)
insert into message (content, user_id, channel_id) values ('blah3', 2, 2)
insert into message (content, user_id, channel_id) values ('blah4', 2, 2)
insert into message (content, user_id, channel_id) values ('blah5', 2, 2)
insert into message (content, user_id, channel_id) values ('blah6', 2, 2)
insert into message (content, user_id, channel_id) values ('blah7', 2, 2)
insert into message (content, user_id, channel_id) values ('blah8', 2, 2)
insert into message (content, user_id, channel_id) values ('blah9', 2, 2)

insert into user_channel (channel_id, user_id) values (1,1);
insert into user_channel (channel_id, user_id) values (2,1);

insert into user_channel (channel_id, user_id) values (1,2);
insert into user_channel (channel_id, user_id) values (2,3);

-- selects
select name from organization;

select name from channel;

select channel.name, organization.name 
from channel, organization
    where organization_id = organization.id;

select name, content
from message, channel
    where name = '#general'
        and
    channel_id = channel.id
    order by post_time;

select channel.name
from channel, user, channel_user
    where user.name = 'Alice'
        and
    user_id = user.id
        and
    channel_id = channel.id;

select user.name
from channel, user, channel_user
    where channel.name = '#general'
        and
    user_id = user.id
        and
    channel_id = channel.id;

select message.content, user.name, channel.name
from message, user, channel
    where user.name = 'Alice'
        and
    user_id = user.id
        and
    channel_id = channel.id;

select post_time, content, user.name, channel.name
from message, user, channel
    where user.name = 'Bob'
        and
    channel.name = '#random'
        and
    message.user_id = user.id
        and
    message.channel_id = channel.id;

select name as 'User Name', count() as 'Message Count'
from message, user
    where user_id = user.id
    group by user.name;

select user.name as 'User', channel.name as 'Channel', count() as 'Message Count'
from message, user, channel
    where user_id = user.id
        and
    channel_id = channel.id
    group by user.name, channel.name;