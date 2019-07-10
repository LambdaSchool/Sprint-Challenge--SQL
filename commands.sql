-- .read /Users/hilalaissani/Lamda-1/lamda-projects/Sprint-Challenge--SQL/queries.sql
-- .read /Users/hilalaissani/Lamda-1/lamda-projects/Sprint-Challenge--SQL/insert.sql

select name from organization;
select name from channel;

select channel.name, organization.name  from 
channel, organization 
where channel.organization_id = organization.id
 order by organization.name


select message.content,channel.name, message.post_time 
from channel_message,message,channel
    where channel_message.channel_id = channel.id
    and channel_message.message_id = message.id
    order by message.post_time desc;


select user.name , channel.name from user, channel, user_channel
    where user_channel.user_id = user.id
    and user_channel.channel_id = channel.id;



select channel.name, user.name 
 from channel, user , user_channel
  where user_channel.user_id = user.id
  and  user_channel.channel_id = channel.id 
  and  user.name like 'Alic';

select channel.name ,user.name
from user, channel, user_channel
 where user_channel.user_id = user.id
 and  user_channel.channel_id = channel.id 
  and channel.name ='general';

select message.content, user.name, channel.name
from message, user , user_channel, channel

   where user_channel.user_id = user.id
   and  user_channel.channel_id = channel.id
   and message.user_id = user.id
   and  user.name = 'Alic';



select message.content , user.name, channel.name 
from message, user, channel , user_channel
where channel.name = "general" and user.name='Bob'
   and  user_channel.user_id = user.id
   and  user_channel.channel_id = channel.id
   and message.user_id = user.id;
  
 
select message.id ,  message.content , user.name as "User Name",
count(message.content) as "Message Count" 
 from user , message
    where message.user_id = user.id group by user.name;


    
    

select 
message.user_id as 'id',
user.name as "User Name",
channel.name  as "Channel", 
count(message.user_id) as "Message count",
message.content
 from user , message, channel, user_channel 
    where message.user_id = user.id 
    and  user_channel.user_id = user.id
    and  user_channel.channel_id = channel.id
 group by user.name, channel.name;



    
    
    

 
-- drop table message;
--  drop table channel_message;
--  drop table channel;
--  drop table organization;
--  drop table user_channel;
--  drop table user ;