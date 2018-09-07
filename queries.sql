-- Organization table
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (128) NOT NULL UNIQUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Channel table
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (128) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES organization(id),
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User table
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (128) NOT NULL UNIQUE,
    username VARCHAR (128) NOT NULL UNQIUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP    
);

-- Message table
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content text,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
    -- A SQLite data type used as a timestamp.
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Writing the INSERT queries to populate the tables/databases.

-- One organization, Lambda School
INSERT INTO organization (name, username) VALUES ("Lambda School");

-- Three users, Alice, Bob, and Chris
INSERT INTO user (name, username) VALUES ("Alice", "aliceinchains");
INSERT INTO user (name, username) VALUES ("Bob", "bobmarley");
INSERT INTO user (name, username) VALUES ("Chris", "chriscornell");

-- Two channels, #general and #random
INSERT INTO channel (name, organization_id) VALUES ("#general", 1);
INSERT INTO channel (name, organization_id) VALUES ("#random", 2);

-- 10 messages (at least one per user, and at least one per channel).
INSERT INTO message (content, user_id, channel_id) VALUES ("Hello, I'm Alice.", 1, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hey, I'm Bob.", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Hi, I'm Chris.", 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("You know, from Alice in Wonderland.", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Marley.", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Just Chris.", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("I'm serious. I'm not a figment of your imagination.", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("But you can call me Bob Marley and the Wailers, for short.", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("Family name's also Chris. So call me Chris Chris.", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("Bye!", 1, 1);

