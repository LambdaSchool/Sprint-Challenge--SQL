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

/***************************************************************************************/
/***************************************************************************************/
/***************************************************************************************/

/*
  Populate chat database.
  For these INSERTs, it is OK to refer to users, channels, and organization by their ids.
*/
-- INSERT INTO organzation
INSERT INTO organization (name) VALUES ('Lambda School');

-- INSERT INTO channel
INSERT INTO channel (name, organization_id) VALUES ('#general', 1);
INSERT INTO channel (name, organization_id) VALUES ('#random', 1);

-- INSERT INTO user
INSERT INTO user (name) VALUES ('Alice');
INSERT INTO user (name) VALUES ('Bob');
INSERT INTO user (name) VALUES ('Chris');

-- INSERT INTO user_channel
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (1, 2);
INSERT INTO user_channel (user_id, channel_id) VALUES (2, 1);
INSERT INTO user_channel (user_id, channel_id) VALUES (3, 2);

-- INSERT INTO message
INSERT INTO message (user_id, channel_id, content) VALUES (1, 1, 'scelerisque mauris sit amet eros suspendisse');
INSERT INTO message (user_id, channel_id, content) VALUES (1, 1, 'in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes');
INSERT INTO message (user_id, channel_id, content) VALUES (1, 1, 'leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras');
INSERT INTO message (user_id, channel_id, content) VALUES (1, 2, 'proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante');
INSERT INTO message (user_id, channel_id, content) VALUES (1, 2, 'ligula nec sem duis aliquam');
INSERT INTO message (user_id, channel_id, content) VALUES (2, 1, 'tincidunt eget tempus vel pede');
INSERT INTO message (user_id, channel_id, content) VALUES (3, 2, 'risus semper porta volutpat quam pede lobortis ligula sit amet');
INSERT INTO message (user_id, channel_id, content) VALUES (3, 2, 'quisque arcu libero rutrum ac lobortis vel dapibus');
INSERT INTO message (user_id, channel_id, content) VALUES (3, 2, 'tincidunt nulla mollis molestie lorem quisque ut erat curabitur');
INSERT INTO message (user_id, channel_id, content) VALUES (3, 2, 'faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit');

/***************************************************************************************/
/***************************************************************************************/
/***************************************************************************************/

/*
  SELECT queries.
  For these SELECTs, it is NOT OK to refer to users, channels, and organization by their ids.
*/

-- List all organization names
SELECT name FROM organization;