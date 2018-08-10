   5. List all channels to which user `Alice` belongs.

   6. List all users that belong to channel `#general`.

   7. List all messages in all channels by user `Alice`.

   8. List all messages in `#random` by user `Bob`.

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
