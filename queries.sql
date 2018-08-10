CREATE TABLE organization(id integer primary key autoincrement, name text);

CREATE TABLE user(id integer primary key autoincrement, name text);

CREATE TABLE channel(id integer primary key autoincrement, name text, organizationId integer, foreign key(organizationId) references organization(id));

CREATE TABLE user_channel(id integer primary key autoincrement, userId integer, channelId integer, foreign key(userId) references user(id), foreign key(channelId) references channel(id));

CREATE TABLE message(id integer primary key autoincrement, content text, userId integer, channelId integer, post_time text, foreign key(userId) references user(id), foreign key(channelId) references channel(id));

insert into organization(name) values("Lambda School");

insert into user(name) values('Alice');
insert into user(name) values('Bob');
insert into user(name) values('Chris');

insert into channel(name,organizationId) values('#general',1);
insert into channel(name,organizationId) values('#random',1);

insert into message(content,userId,channelId,post_time) values('hi',1,1,datetime('now'));
insert into message(content,userId,channelId,post_time) values('hello',2,1,datetime('now'));
insert into message(content,userId,channelId,post_time) values('tiem 2 lern',1,1,datetime('now'));
insert into message(content,userId,channelId,post_time) values('yah',2,1,datetime('now'));
insert into message(content,userId,channelId,post_time) values('hi',1,2,datetime('now'));
insert into message(content,userId,channelId,post_time) values('heya',3,2,datetime('now'));
insert into message(content,userId,channelId,post_time) values('random random',1,2,datetime('now'));
insert into message(content,userId,channelId,post_time) values('agreed',3,2,datetime('now'));
insert into message(content,userId,channelId,post_time) values('happy emoticon',1,2,datetime('now'));
insert into message(content,userId,channelId,post_time) values('smiling emoticon',3,2,datetime('now'));

insert into user_channel(userId,channelId) values(1,1);
insert into user_channel(userId,channelId) values(1,2);
insert into user_channel(userId,channelId) values(2,1);
insert into user_channel(userId,channelId) values(3,2);

select * from organization;

select name from channel;

select channel.name,organization.name from channel, organization;

select message.content, channel.name from message,channel where channel.name is '#general';

select channel.name from channel,user_channel,user where user_channel.userId = user.id and user.name = 'Alice'

select user.name from user,user_channel,channel where user.id = user_channel.userId and user_channel.channelId = channel.id and channel.name = '#general';

select message.content from message,user where message.userId = user.id and user.name = 'Alice';

select user.name,message.content,channel.name,channel.id from message,user,channel where message.userId = user.id and user.id = 2 and channel.id = message.channelId and channel.name = '#random';

select user.name,count(message.userId) as 'Message Count' from message
    left join user on message.userId = user.id
      group by user.name;

6. I would use an SQLite trigger if I wanted to automatically delete all messages by a user if that user were deleted from the user table
