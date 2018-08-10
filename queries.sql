CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    channel_id INTEGER, --foreign key
    FOREIGN KEY(channel_id) REFRENCES channel(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    message_id INTEGER, --foreign key
    user_id INTEGER, --foreign key
    FOREIGN KEY(user_id) REFRENCES user(id),
    FOREIGN KEY(message_id) REFRENCES messages(id)
);

CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    post_time TEXT,
    content VARCHAR(MAX) NOT NULL
)

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    organization_id INTEGER, --foreign key
    user_id INTEGER, -- foreign key
    FOREIGN KEY(organization_id) REFERENCES organization(id),
    FOREIGN KEY(user_id) REFERENCES user(id)

);