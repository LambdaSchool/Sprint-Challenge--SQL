# Sprint Challenge: SQL

Design a database for an online chat system.

## Deliverables

Add a file called `queries.sql` that runs all of the `CREATE TABLE`,
`INSERT`, and `SELECT` queries, below.

The last question is a fill-in-the-blank. You can add that as a SQL
comment to the end of `queries.sql`.

## Details

The chat system has an arbitrary number of:

* Organizations (e.g. `Lambda School`)
* Channels (e.g. `#random`)
* Users (e.g. `Dave`)

The following relationships exist:

* An organization can have many channels.
* A channel can belong to one organization.
* A channel can have many users subscribed.
* A user can be subscribed to many channels.
* Additionally, a user can post messages to a channel. (Note that a user might have
posted messages to a channel to which they subscribed in the past, but they no
longer subscribe to now.)

In the following, there will be more columns that you have to add in
various tables, not just the columns listed here.

1. Write `CREATE TABLE` statements for tables `organization`, `channel`, `user`,
   and `message`.

   1. `organization`. This table should at least have column(s):
      * `name`

   2. `channel`. This table should at least have column(s):
      * `name`

   3. `user`. This table should at least have column(s):
      * `name`

   4. `message`. This table should have at least columns(s):

      * `post_time`--the timestamp of when the message was posted
        * See [Date types in
          SQLite](https://www.sqlite.org/datatype3.html#date_and_time_datatype).
          Also see the SQLite function `datetime()`.

      * `content`--the message content itself

2. Add additional foreign keys needed to the above tables, if any.

3. Add additional join tables needed, if any.

4. Write `INSERT` queries to add information to the database.

   For these `INSERT`s, it is OK to refer to users, channels, and organization
   by their `id`s. No need to do a subselect unless you want to.

   1. One organization, `Lambda School`
   2. Three users, `Alice`, `Bob`, and `Chris`
   3. Two channels, `#general` and `#random`
   4. 10 messages (at least one per user, and at least one per channel).
   5. `Alice` should be in `#general` and `#random`.
   6. `Bob` should be in `#general`.
   7. `Chris` should be in `#random`.

5. Write `SELECT` queries to:

   For these `SELECT`s, it is **NOT** OK to refer to users, channels, and
   organization by their `id`s. You must join in those cases.

   1. List all organization `name`s.
   
      SELECT name FROM organization;

      name         
      -------------
      Lambda School

   2. List all channel `name`s.

      SELECT name FROM channel;

      name      
      ----------
      #general  
      #random 

   3. List all channels in a specific organization by organization `name`.

      SELECT channel.name, organization.name FROM channel, organization 
      WHERE channel.organization = organization.id;

      name        name         
      ----------  -------------
      #general    Lambda School
      #random     Lambda School

   4. List all messages in a specific channel by channel `name` `#general` in
      order of `post_time`, descending. (Hint: `ORDER BY`. Because your
      `INSERT`s might have all taken place at the exact same time, this might
      not return meaningful results. But humor us with the `ORDER BY` anyway.)

      SELECT post_time, content FROM messages, channel 
      WHERE channel.name = "#general" 
      AND channel.name = messages.channel 
      ORDER BY post_time DESC;

      post_time            content    
      -------------------  -----------
      2018-08-10 16:33:57  i like dogs
      2018-08-10 16:33:48  i like the 
      2018-08-10 16:33:40  hi my name 
      2018-08-10 16:33:02  i like the 
      2018-08-10 16:32:34  hi my name 

   5. List all channels to which user `Alice` belongs.

      SELECT channel.name FROM channel, user 
      WHERE user.name = "Alice" 
      AND channel.user = user.name;

   6. List all users that belong to channel `#general`.

      SELECT user FROM channel WHERE channel.name = "#general";

   7. List all messages in all channels by user `Alice`.

      SELECT content, name FROM messages, user WHERE user.name = "Alice" AND user.id = messages.user;

   8. List all messages in `#random` by user `Bob`.


      SELECT messages.content, user.name FROM messages, user, channel WHERE channel.name = "#random" AND user.name = "Bob" AND user.id = messages.user;

   9. List the count of messages across all channels per user. (Hint:
      `COUNT`, `GROUP BY`.)
      
      The title of the user's name column should be `User Name` and the title of
      the count column should be `Message Count`. (The SQLite commands
	  `.mode column` and `.header on` might be useful here.)

      The user names should be listed in reverse alphabetical order.
      
      Example:

      ```
      User Name   Message Count
      ----------  -------------
      Chris       4
      Bob         3
      Alice       3
      ```


      SELECT user.name, COUNT(messages.content) FROM user, messages 
      WHERE user.id = messages.user 
      GROUP BY user.name 
      ORDER BY user.name DESC;


   10. [Stretch!] List the count of messages per user per channel.

       Example:

       ```
       User        Channel     Message Count
       ----------  ----------  -------------
       Alice       #general    1
       Bob         #general    1
       Chris       #general    2
       Alice       #random     2
       Bob         #random     2
       Chris       #random     2
       ```

6. What SQL keywords or concept would you use if you wanted to automatically
   delete all messages by a user if that user were deleted from the `user`
   table?
