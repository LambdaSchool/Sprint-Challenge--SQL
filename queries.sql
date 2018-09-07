-- queries below for chat room

--users--
INSERT INTO user (name, username) VALUES("Alice", "newgirl");
INSERT INTO user (name, username) VALUES("Bob", "lead pm");
INSERT INTO user (name, username) VALUES("Chris", "transfer");


--organizations--
INSERT INTO organization (name) VALUES("Lambda School");

--channels--
INSERT INTO channel (name, organization_id) VALUES("#general", 1);
INSERT INTO channel (name, organization_id) VALUES("#random", 2);

--messages--
INSERT INTO message (content, user_id, channel_id) VALUES("Happy Friday", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES("Morning guys.", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("JavaScript is hard.", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES("Can we go over that again?", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES("Happy last day of class!", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("Thanks for your help.", 3, 1);

--user_channels--
INSERT INTO user_channel (user_id, channel_id) VALUES(1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES(1, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES(2, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES(3, 2);

-- Q&A below:
--What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?
-- "ON DELETE CASCADE" and put it under under the foreign keys in the schema 
