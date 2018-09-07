--org table

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (128) NOT NULL UNIQUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--channel table
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (128) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES organization(id),
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--user table
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content text,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
    crated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--message table
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content text,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO organization (name, username) VALUES ("Lambda School");

INSERT INTO user (name, username) VALUES ("Alice", "alice_wonderland");
INSERT INTO user (name, username) VALUES ("Bod", "bob_marley");
INSERT INTO user (name, username) VALUES ("Chris", "chrisrock");

INSERT into channel (name, organization_id) VALUES ("#general", 1);
INSERT into channel (name, organization_id) VALUES ("#random", 2);

INSERT into message (content, user_id, channel_id) VALUES ("Hello, I'm Alice. What's up?", 1, 1);
INSERT into message (content, user_id, channel_id) VALUES ("Hello, I'm Bob. What's up?", 2, 1);
INSERT into message (content, user_id, channel_id VALUES ("Hello, I'm Chris. What's up?", 3, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("I'm from Kansas City.", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("How's it going, I'm Bob", 2, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("How's it going, I'm Chris", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("How to get back to Kansas?", 1, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("I like chilling", 2, 1);
INSERT INTO message (content, user_id, channel_id) VALUES ("How's it going, I'm also Chris", 3, 2);
INSERT INTO message (content, user_id, channel_id) VALUES ("See ya later", 1, 1);
