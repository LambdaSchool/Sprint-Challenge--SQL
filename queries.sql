CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(128),
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(128),
    organization_id INTEGER,
    FOREIGN KEY(organization_id) REFERENCES organization(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(128),
);

CREATE TABLE user_channels (
    userid INTEGER,
    channel_id INTEGER,
    FOREIGN KEY(userid) REFERENCES user(id),
    FOREIGN KEY(channel_id) REFERENCES channel(id)
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(128),
    post_time DATETIME('now')
    channel_id INTEGER
    author_id INTEGER
    FOREIGN KEY(channel_id) REFERENCES channel(id)
    FOREIGN KEY(author_id) REFERENCES user(id)
);

INSERT INTO organization (title) VALUES ("Lambda School");

INSERT INTO user (title) VALUES ("Alice");
INSERT INTO user (title) VALUES ("Bob");
INSERT INTO user (title) VALUES ("Chris");

INSERT INTO channel (title, organization_id) VALUES ("#general", 1);
INSERT INTO channel (title, organization_id) VALUES ("#random", 1);

