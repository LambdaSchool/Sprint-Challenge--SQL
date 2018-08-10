insert into organization(name) values ('lambda school');

insert into channel(name,organization_id) values ( 'general', 1);
insert into channel(name,organization_id) values ( 'random', 1);




insert into user(name) values ( 'Alic');   --1
insert into user(name) values ( 'bill');    --2
insert into user(name ) values ( 'Chris');  --3
insert into user(name ) values ( 'Ala');   --4
insert into user(name) values ( 'Bob');   --5
insert into user(name ) values ( 'Christy'); --6
insert into user(name) values ( 'steve'); --7
insert into user(name) values ( 'frank'); --8
insert into user(name) values ( 'thomas'); --9
insert into user(name) values ( 'jhon'); --10

insert into message(user_id,content,post_time ) values ( 1,'hello guys','10-03-2018' );
insert into message(user_id,content,post_time ) values ( 2,'i am super happy', '01-07-2016');
insert into message(user_id,content,post_time ) values ( 3,'thx god we made it sofar ', '07-22-2016');
insert into message(user_id,content,post_time) values ( 4,'ohhhh really!!1 ', '04-02-2015');
insert into message(user_id,content,post_time) values ( 5,'goood boy', '09-14-2013');
insert into message(user_id,content,post_time) values ( 5,'helo heloo', '08-11-2012');
insert into message(user_id,content,post_time) values ( 7,'nice to meet u', '07-30-2018');
insert into message(user_id,content,post_time) values ( 10,'woooooeeee', '01-08-2015');
insert into message(user_id,content,post_time) values ( 7,'what is your name', '03-03-2017');
insert into message(user_id,content,post_time ) values ( 3,'they call me bob','02-06-2013');
insert into message(user_id,content,post_time) values (6 ,'are u working?', '01-11-2014');
insert into message(user_id,content,post_time) values ( 2,'they lost yesterday', '01-20-2016');
insert into message(user_id,content,post_time ) values ( 9,'they call me bob','02-06-2013');
insert into message(user_id,content,post_time) values (3 ,'are u working?', '01-11-2014');
insert into message(user_id,content,post_time) values ( 3,'they lost yesterday', '01-20-2016');


insert into user_channel(channel_id, user_id) values(1,2);
insert into user_channel(channel_id, user_id) values(1,7);
insert into user_channel(channel_id, user_id) values(2,8);
insert into user_channel(channel_id, user_id) values(2,9);
insert into user_channel(channel_id, user_id) values(2,10);
insert into user_channel(channel_id, user_id) values(2,6);
insert into user_channel(channel_id, user_id) values(1,4);
insert into user_channel(channel_id, user_id) values(1,5);
insert into user_channel(channel_id, user_id) values(2,4);
insert into user_channel(channel_id, user_id) values(1,3);
insert into user_channel(channel_id, user_id) values(1,1);
insert into user_channel(channel_id, user_id) values(2,1);


INSERT INTO channel_message (channel_id, message_id) VALUES (1, 1);
INSERT INTO channel_message (channel_id, message_id) VALUES (1, 2);
INSERT INTO channel_message (channel_id, message_id) VALUES (1, 3);
INSERT INTO channel_message (channel_id, message_id) VALUES (2, 4);
INSERT INTO channel_message (channel_id, message_id) VALUES (2, 5);
INSERT INTO channel_message (channel_id, message_id) VALUES (2, 6);
INSERT INTO channel_message (channel_id, message_id) VALUES (2, 7);
INSERT INTO channel_message (channel_id, message_id) VALUES (1, 8);
INSERT INTO channel_message (channel_id, message_id) VALUES (2, 9);
INSERT INTO channel_message (channel_id, message_id) VALUES (1, 10);
INSERT INTO channel_message (channel_id, message_id) VALUES (2, 11);
INSERT INTO channel_message (channel_id, message_id) VALUES (1, 12);
INSERT INTO channel_message (channel_id, message_id) VALUES (1, 13);
INSERT INTO channel_message (channel_id, message_id) VALUES (1, 14);
INSERT INTO channel_message (channel_id, message_id) VALUES (1, 15);
