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









