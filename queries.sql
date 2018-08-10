CREATE TABLE organizations(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE channel(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    orgID INTEGER,
    FOREIGN KEY (orgID) REFERENCES Organizations(id)
);

CREATE TABLE users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR (128) NOT NULL
);

CREATE TABLE messages(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    msgChannel INTEGER,
    userID INTEGER,
    FOREIGN KEY (msgChannel) REFERENCES Channels(id),
    FOREIGN KEY (userID) REFERENCES Users(id)
);

INSERT INTO organization (name) VALUES ("Lambda School");


-- Note: See if there's a easier way to add inserts for multiple names at once
INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");



