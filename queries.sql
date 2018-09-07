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