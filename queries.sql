PRAGMA foreign_keys = ON;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    channel_id INTEGER, --foreign key
    FOREIGN KEY(channel_id) REFERENCES channel(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    message_id INTEGER, --foreign key
    channel_id INTEGER, --foreign key
    FOREIGN KEY(channel_id) REFERENCES channel(id),
    FOREIGN KEY(message_id) REFERENCES messages(id)
);

CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    post_time TEXT TIMESTAMP,
    content VARCHAR(2000) NOT NULL
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    organization_id INTEGER, --foreign key
    user_id INTEGER, -- foreign key
    FOREIGN KEY(organization_id) REFERENCES organization(id),
    FOREIGN KEY(user_id) REFERENCES user(id)

);




INSERT INTO organization (name) VALUES ("Lambda School");


INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");


INSERT INTO channel (name) VALUES ("#general");
INSERT INTO channel (name) VALUES ("#random");


INSERT INTO channel (name, user_id) VALUES ('#general',1);
INSERT INTO channel (name, user_id) VALUES ('#random',1);
INSERT INTO channel (name, user_id) VALUES ('#general',2);
INSERT INTO channel (name, user_id) VALUES ('#random',3);



-- INSERT INTO user (message_id, name) VALUES ('hello bob', 'bob');
-- INSERT INTO user (message_id, name) VALUES ('what a nice day', 'Alice');
-- INSERT INTO user (message_id, name) VALUES ('tommy is coming', 'Chris');
-- INSERT INTO channel (message_id, channel_id) VALUES ('once i knew the information', 3);
-- INSERT INTO channel (message_id, channel_id) VALUES ('this is somewhat difficult', 4);

-- INSERT INTO user (message_id, name) VALUES ('hello alice', 2);
-- INSERT INTO user (message_id, name) VALUES ('what a nice day bob', 1);
-- INSERT INTO user (message_id, name) VALUES ('tommy is coming home', 3);
-- INSERT INTO channel (message_id, channel_id) VALUES ('once i knew the information i am king', 3);
-- INSERT INTO channel (message_id, channel_id) VALUES ('this is somewhat difficult or so i assume', 4);



-- SELECT * FROM organization;


-- SELECT * FROM channel;

-- SELECT * FROM channel.name where organization.name = 'Lambda School';


-- SELECT * FROM channel, user where channel.user_id = user.id AND user.name = 'Alice';

-- SELECT * FROM user.name, channel where user.channel_id = channel.id AND channel.name = '#general';

-- SELECT * from messages, user where user.name = 'Alice';

-- SELECT * from messages, channel, user where channel.name = '#random' AND channel.user_id = user.id AND user.name = 'bob';

