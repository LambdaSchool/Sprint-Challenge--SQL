


CREATE TABLE IF NOT EXISTS organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(40) NOT NULL
)


CREATE TABLE IF NOT EXISTS channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL
    organization_id INTEGER REFERENCES organization(id)
)

CREATE TABLE IF NOT EXISTS user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL
)

CREATE TABLE IF NOT EXISTS message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT NOT NULL,
    posted datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
)


INSERT INTO organization (name) VALUES ("Lambda School");
INSERT INTO user (name) VALUES ("Steven");
INSERT INTO channel (name, organization_id) VALUES ("#cs7career",1);
INSERT INTO message (content, channel_id, user_id) VALUES ("Testing to see if it works", 1, 1)