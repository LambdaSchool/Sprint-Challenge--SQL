-- Organization Table --
CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Channel Table --
CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    organization_id INTEGER REFERENCES organization(id),
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User Table --
CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    username VARCHAR(32) NOT NULL UNIQUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Message Table --
CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id),
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- user_channel --
CREATE TABLE user_channel (
  user_id INTEGER REFERENCES user(id),
  channel_id INTEGER REFERENCES channel(id)
);

-- inserting data into database
INSERT INTO user
(name, username)
VALUES("Alice", "A_wonderLand");

INSERT INTO user
(name, username)
VALUES("Bob", "Pyscho_B_N_Springfield");

INSERT INTO user
(name, username)
VALUES("Chris Hensworth", "Thor");


-- organizations --
INSERT INTO organization
(name)
VALUES("Lambda School");


-- channels --
INSERT INTO channel
(name, organization_id)
VALUES("#general", 1);

INSERT INTO channel
(name, organization_id)
VALUES("#random", 2);
