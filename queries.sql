.mode column
.header on
-- Create a DB for the Online Chat System

PRAGMA foreign_keys = ON;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    posted_at DATETIME
    DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(2000) NOT NULL,
    channel_id INTEGER, 
    user_id INTEGER,
    post_time TIMESTAMP
    DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(channel_id) REFERENCES channel(id),
    FOREIGN KEY(user_id) REFERENCES user(id)
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    organization_id INTEGER, --foreign key
    FOREIGN KEY(organization_id) REFERENCES organization(id)

);


-------------------------------------------------------------------------

-- join tables --

CREATE TABLE channel_subs (
    channel_id INTEGER,
    users_id INTEGER,
    FOREIGN KEY(users_id) REFERENCES user(id),
    FOREIGN KEY(channel_id) REFERENCES channel(id)
);





-- insert one organization -- 
 INSERT INTO organization (name) VALUES ("Lambda School");

-- insert 3 users -- 
 INSERT INTO user (name) VALUES ("Alice");
 INSERT INTO user (name) VALUES ("Bob");
 INSERT INTO user (name) VALUES ("Chris");

 -- insert two channels --
 INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
 INSERT INTO channel (name, organization_id) VALUES ("#random", 1);

-- insert certain users into certain channels --
-- Alice should be in #general and #random. --
-- Bob should be in #general. --
-- Chris should be in #random. --
 INSERT INTO channel_subs (channel_id, users_id) VALUES (1,1);
 INSERT INTO channel_subs (channel_id, users_id) VALUES (2,1);
 INSERT INTO channel_subs (channel_id, users_id) VALUES (1,2);
 INSERT INTO channel_subs (channel_id, users_id) VALUES (2,2);



INSERT INTO messages (content, channel_id, user_id) VALUES ('hello bob this is a message', 1, 1);
INSERT INTO messages (content, channel_id, user_id) VALUES ('hello alice this is a message', 1, 2);
INSERT INTO messages (content, channel_id, user_id) VALUES ('hello jim this is a message', 1, 3);
INSERT INTO messages (content, channel_id, user_id) VALUES ('hello tammy this is a message', 2, 1);
INSERT INTO messages (content, channel_id, user_id) VALUES ('hello carie this is a message', 2, 1);
INSERT INTO messages (content, channel_id, user_id) VALUES ('hello bob this is a test', 2, 1);
INSERT INTO messages (content, channel_id, user_id) VALUES ('The force is strong with this one', 1, 2);
INSERT INTO messages (content, channel_id, user_id) VALUES ('I wonder what my limit is? ', 2, 3);
INSERT INTO messages (content, channel_id, user_id) VALUES ("What happens if i quote inside this statment", 1, 2);
INSERT INTO messages (content, channel_id, user_id) VALUES ('hello bob this is a message2', 1, 2);

-- List all organization names --
SELECT * FROM organization;

-- List all channel names. --
SELECT * FROM channel;

-- List all channels in a specific organization by organization name. --
SELECT * FROM channel.name where organization.name = 'Lambda School';


-- List all messages in a specific channel by channel name #general in order of post_time, descending. (Hint: ORDER BY. --
-- Because your INSERTs might have all taken place at the exact same time, this might not return meaningful results. --
-- But humor us with the ORDER BY anyway.) --
SELECT * FROM messages where channel_id = 1 ORDER BY post_time desc;

-- List all channels to which user Alice belongs. --
SELECT * FROM channel, channel_subs, user where channel_subs.users_id = user.id AND user.name = 'Alice';

-- List all users that belong to channel #general. --
SELECT * FROM user, channel_subs, channel where channel_subs.channel_id = channel.id AND channel.name = '#general';

-- List all messages in all channels by user Alice --
SELECT * FROM messages, channel_subs, user where channel_subs.users_id = user.id AND user.name = 'Alice';

-- List all messages in #random by user Bob. --
SELECT * FROM messages, user, channel_subs, channel where channel_subs.channel_id = channel.id AND channel.name = '#random' AND user.name = 'Bob';

-- List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.) --
-- The title of the user's name column should be User Name and the title of the count column should be Message Count. --
SELECT user.name, count(*) FROM user, messages GROUP BY messages.user_id;
-- SELECT * from messages, channel, user where channel.name = '#random' AND channel.user_id = user.id AND user.name = 'bob';

