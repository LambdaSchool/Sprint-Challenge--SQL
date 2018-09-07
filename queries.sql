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
INSERT INTO user (name, username) VALUES("FCK", "teufel");
INSERT INTO user (name, username) VALUES("Kelly", "whatever");

--organizations--
INSERT INTO organization (name) VALUES("Lambda School");
INSERT INTO organization (name) VALUES("Portland");
INSERT INTO organization (name) VALUES("OHSU");

--channels--
INSERT INTO channel (name, organization_id) VALUES("#general", 1);
INSERT INTO channel (name, organization_id) VALUES("#random", 2);
INSERT INTO channel (name, organization_id) VALUES("#help", 3);
