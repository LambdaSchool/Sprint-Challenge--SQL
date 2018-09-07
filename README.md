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

```sql
CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  org_id INTEGER NOT NULL,
  FOREIGN KEY (org_id) REFERENCES organization(id)
    ON DELETE CASCADE
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

CREATE TABLE join_channels_users (
  user_id INTEGER NOT NULL,
  channel_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, channel_id),
  FOREIGN KEY (user_id) REFERENCES user(id)
    ON DELETE CASCADE,
  FOREIGN KEY (channel_id) REFERENCES channel(id)
    ON DELETE CASCADE
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  content TEXT,
  author_id INTEGER,
  channel_id INTEGER,
  FOREIGN KEY (author_id) REFERENCES user(id)
    ON DELETE SET NULL,
  FOREIGN KEY (channel_id) REFERENCES channel(id)
    ON DELETE CASCADE
);
```

*Note: I could have probably used the association table to connect messages with users and channels instead of separate foreign keys, but I have gone too far now. I cannot turn back, lest I become salty.*

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

You may look at the entries in `queries.sql`.

5. Write `SELECT` queries to:

   For these `SELECT`s, it is **NOT** OK to refer to users, channels, and
   organization by their `id`s. You must join in those cases.

   1. List all organization `name`s.

  ```sql
  SELECT name AS "Organizations"
    FROM organization;
  ```

   2. List all channel `name`s.

  ```sql
  SELECT name AS "Channels"
    FROM channel;
  ```

   3. List all channels in a specific organization by organization `name`.

  ```sql
  SELECT organization.name AS "Organization",
       channel.name AS "Channels"
    FROM organization, channel
    WHERE organization.id = channel.org_id;
  ```

   4. List all messages in a specific channel by channel `name` `#general` in
      order of `post_time`, descending. (Hint: `ORDER BY`. Because your
      `INSERT`s might have all taken place at the exact same time, this might
      not return meaningful results. But humor us with the `ORDER BY` anyway.)

  ```sql
  SELECT channel.name AS "Channel",
        message.content AS "Messages",
        message.post_time AS "Time Posted"
    FROM message, channel 
    WHERE message.channel_id = channel.id
    AND message.channel_id = (SELECT channel.id
                                  FROM channel
                                  WHERE channel.name = "#general")
    ORDER BY message.post_time;
  ```

   5. List all channels to which user `Alice` belongs.

  ```sql
  SELECT user.name AS "User",
        channel.name AS "Channel"
    FROM user, channel, join_channels_users
    WHERE join_channels_users.channel_id = channel.id
      AND join_channels_users.user_id = user.id
      AND user.id = (SELECT id
                      FROM user
                      WHERE name = "Alice");
  ```

   6. List all users that belong to channel `#general`.

  ```sql
  SELECT channel.name AS "Channel",
        user.name AS "User"
    FROM user, channel
    JOIN join_channels_users 
      ON join_channels_users.channel_id = channel.id
      AND join_channels_users.user_id = user.id
    WHERE channel.name = "#general";
  ```

   7. List all messages in all channels by user `Alice`.

  ```sql
  SELECT user.name AS "User",
        channel.name AS "Channel",
        message.content AS "Message"
    FROM user, channel, message
    WHERE message.author_id = (SELECT id
                                FROM user
                                WHERE name = "Alice")
      AND user.id = message.author_id;
  ```

   8. List all messages in `#random` by user `Bob`.

  ```sql
  SELECT user.name AS "User", 
        channel.name AS "Channel",
        message.content AS "Message"
    FROM user, channel, message
    WHERE message.author_id = (SELECT id
                                FROM user
                                WHERE name = "Bob")
      AND message.channel_id = (SELECT id
                                  FROM channel
                                  WHERE name = "#random")
      AND user.id = message.author_id
      AND channel.id = message.channel_id;
  ```
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

    ```sql
    SELECT user.name AS "User Name",
          COUNT(message.content) AS "Message Count"
      FROM user, message
      WHERE user.id = message.author_id
      GROUP BY user.name;
    ```

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

    ```sql
    SELECT user.name AS "User Name",
          channel.name AS "Channel",
          COUNT(message.content) AS "Message Count"
      FROM user, channel, message
      WHERE user.id = message.author_id
        AND channel.id = message.channel_id
      GROUP BY user.name, channel.name
      ORDER BY user.name;
    ```
6. What SQL keywords or concept would you use if you wanted to automatically
   delete all messages by a user if that user were deleted from the `user`
   table?

  `ON DELETE CASCADE` This will ensure all records with a foreign key pointing to the pending record to be deleted will also be deleted as well. In this DB, all messages have a foreign key pointing to a user, so if we set `ON DELETE CASCADE`, all messages related to a user being deleted will be deleted first before the user itself.