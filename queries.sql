/*
  CREATE tables for an online chat system database

  The chat system has an arbitrary number of:
  - Organizations (e.g. Lambda School)
  - Channels (e.g. #random)
  - Users (e.g. Dave)

  The following relationships exist:
  - An organization can have MANY channels.
  - A channel can belong to ONE organization.
  - A channel can have MANY users subscribed.
  - A user can be subscribed to MANY channels.
  - A user can post MANY messages to a channel.
*/

/*
  TABLE: organization
  COLUMNS: id (PK), name
*/
CREATE TABLE organization (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE
);

/*
  TABLE: channel
  COLUMNS: id, name, organization_id (FK)
*/
CREATE TABLE channel (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE,
  organization_id INTEGER NOT NULL,
  FOREIGN KEY (organization_id) REFERENCES organization (id)
    ON DELETE CASCADE
);

/*
  TABLE: user
  COLUMNS: id (PK), name
*/
CREATE TABLE user (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL UNIQUE
);

/*
  TABLE: user_channel
  COLUMNS: user_id (FK), channel_id (FK), user_id channel_id (PK)
*/
CREATE TABLE user_channel (
  user_id INTEGER NOT NULL,
  channel_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, channel_id),
  FOREIGN KEY (user_id) REFERENCES user (id)
    ON DELETE CASCADE,
  FOREIGN KEY (channel_id) REFERENCES channel (id)
    ON DELETE CASCADE
);

/*
  TABLE: message
  COLUMNS: id (PK), user_id (FK), channel_id (FK), post_time, content
*/
CREATE TABLE message (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  channel_id INTEGER NOT NULL,
  post_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  content BLOB NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user (id)
    ON DELETE SET NULL,
  FOREIGN KEY (channel_id) REFERENCES channel (id)
    ON DELETE CASCADE,
  FOREIGN KEY (user_id, channel_id) REFERENCES user_channel (user_id, channel_id)
    ON DELETE SET NULL
);
