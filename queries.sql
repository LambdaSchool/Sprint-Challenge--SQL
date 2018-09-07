
-- * Organizations (e.g. `Lambda School`)
CREATE TABLE organizations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(256) NOT NULL UNIQUE,
)

-- * Channels (e.g. `#random`)
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE,
    organization_id INTEGER REFRENCES channel(id)
)


-- * Users (e.g. `Dave`)
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL UNIQUE
);

-- message
CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(MAX) NOT NULL,
    channel_id INTEGER REFRENCES channel(id),
    user_id INTEGER REFRENCES user(id),
    post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE subbed_channels (
    channel_id INTEGER REFRENCES channel(id),
    user_id INTEGER REFRENCES user(id)
);