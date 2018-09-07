--INSERT--

--users--
INSERT INTO user (name, username) VALUES("Starbuck", "rooster");
INSERT INTO user (name, username) VALUES("Moxie", "underfoot");
INSERT INTO user (name, username) VALUES("Brian", "the-brain");
INSERT INTO user (name, username) VALUES("Teddy", "kleinergrosser");
INSERT INTO user (name, username) VALUES("Lucky", "drooler");
INSERT INTO user (name, username) VALUES("Missy", "climber");
INSERT INTO user (name, username) VALUES("Mama", "stinky");
INSERT INTO user (name, username) VALUES("Jailbird", "purr");
INSERT INTO user (name, username) VALUES("Alice", "nonstop");
INSERT INTO user (name, username) VALUES("Bowtie", "tuxedo");
INSERT INTO user (name, username) VALUES("Bob", "teufel");
INSERT INTO user (name, username) VALUES("Chris", "whatever");


--organizations--
INSERT INTO organization (name) VALUES("Lambda School");
INSERT INTO organization (name) VALUES("Portland");
INSERT INTO organization (name) VALUES("OHSU");

--channels--
INSERT INTO channel (name, organization_id) VALUES("#general", 1);
INSERT INTO channel (name, organization_id) VALUES("#random", 2);
INSERT INTO channel (name, organization_id) VALUES("#help", 3);

--messages--
INSERT INTO message (content, user_id, channel_id) VALUES("Wake up! Wake up!", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES("Please pet me.", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("Your thoughts are glacial.", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES("Wait - is there dancing?", 4, 3);
INSERT INTO message (content, user_id, channel_id) VALUES("Incoming!", 5, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("Oops! Lemme try again.", 6, 3);
INSERT INTO message (content, user_id, channel_id) VALUES("Go away!", 7, 2);
INSERT INTO message (content, user_id, channel_id) VALUES("This is great, but -", 8, 1);
INSERT INTO message (content, user_id, channel_id) VALUES("Aint nobody got time for this!", 9, 2);
INSERT INTO message (content, user_id, channel_id) VALUES("Hello, world!", 10, 3);
INSERT INTO message (content, user_id, channel_id) VALUES("Who diss?", 11, 2);
INSERT INTO message (content, user_id, channel_id) VALUES("Did somebody say burritos?", 12, 2);

--user_channels--
INSERT INTO user_channel (user_id, channel_id) VALUES(9, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES(9, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES(11, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES(12, 2);

--What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?
--I would use "ON DELETE CASCADE" and specify it under foreign keys in the schema.
--https://en.wikipedia.org/wiki/Foreign_key
