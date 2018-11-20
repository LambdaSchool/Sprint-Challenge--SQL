
PRAGMA foreign_keys = OFF;

DROP TABLE IF EXISTS organization ;
DROP TABLE IF EXISTS channel;
DROP TABLE IF EXISTS user ;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS user_channel;
PRAGMA foreign_keys = On;

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    organization_id INTEGER REFERENCES organization(id) 
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
    content TEXT,
    channel_id INTEGER REFERENCES channel(id),
    user_id INTEGER REFERENCES user(id)
);

CREATE TABLE user_channel(
    channel_id INTEGER ,
    user_id INTEGER,
    FOREIGN KEY(channel_id) REFERENCES channel(id),
    FOREIGN KEY(user_id) REFERENCES user(id)
);


INSERT INTO organization (name) VALUES ('Lambda School');
INSERT INTO user (name) VALUES ('Alice'),('Bob'),('Chris');
INSERT INTO channel (name) VALUES ('general'),('random');

INSERT INTO message (user_id, channel_id,  content) 
VALUES ( 1, 1,'M0'),( 2, 2,'M1'),( 3, 1,'M2'),( 1, 1,'M3'),( 1, 1,'M4'),( 1, 1,'M5'),
( 1, 1,'M6'),( 1, 1,'M7'),( 1, 1,'M8'),( 1, 1,'M9');

INSERT INTO user_channel (user_id, channel_id)
VALUES (1, 1),(1,2),(2,1),(3,2);



SELECT organization.name FROM organization;
SELECT channel.name FROM channel;

