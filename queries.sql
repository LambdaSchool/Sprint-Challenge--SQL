.mode column
.header on

CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    org_id INTEGER,
    FOREIGN KEY(org_id) REFERENCES organization(id)
);

CREATE TABLE user (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   name VARCHAR(128) NOT NULL
);

CREATE TABLE message (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(140) NOT NULL,
    post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    u_id INTEGER,
    ch_id INTEGER,
   FOREIGN KEY(ch_id) REFERENCES channel(id),
   FOREIGN KEY(u_id) REFERENCES user(id)
);

CREATE TABLE addid (
   u_id INTEGER,
   ch_id INTEGER,
   FOREIGN KEY(ch_id) REFERENCES channel(id),
   FOREIGN KEY(u_id) REFERENCES user(id)
);

INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel (name, org_id) VALUES("#random", 1);
INSERT INTO channel (name, org_id) VALUES("#general", 1);

INSERT INTO addid (u_id, ch_id) VALUES (1, 1);
INSERT INTO addid (u_id, ch_id) VALUES (1, 2);
INSERT INTO addid (u_id, ch_id) VALUES (2, 2);
INSERT INTO addid (u_id, ch_id) VALUES (3, 1);

INSERT INTO message (content, u_id, ch_id) VALUES ("Ayyyyy", 1, 1);
INSERT INTO message (content, u_id, ch_id) VALUES ("HEY", 1, 2);
INSERT INTO message (content, u_id, ch_id) VALUES ("HEYYYYYY", 2, 2);
INSERT INTO message (content, u_id, ch_id) VALUES ("WHERE DA AIR", 3, 1);
INSERT INTO message (content, u_id, ch_id) VALUES ("YALL TRIPPIN", 1, 1);
INSERT INTO message (content, u_id, ch_id) VALUES ("FURRY CLOTHING", 2, 2);
INSERT INTO message (content, u_id, ch_id) VALUES ("WHO LET THE DOGS OUT", 1, 1);
INSERT INTO message (content, u_id, ch_id) VALUES ("IDK", 3, 1);
INSERT INTO message (content, u_id, ch_id) VALUES ("FREEDOM", 2, 2);
INSERT INTO message (content, u_id, ch_id) VALUES ("GREETINGS NOT ROBOTS", 1, 1);

SELECT name FROM organization;

SELECT name FROM channel;

SELECT name FROM channel WHERE org_id IS (SELECT id FROM organization WHERE name IS "Lambda School");

SELECT * FROM message WHERE ch_id IS (SELECT id FROM channel WHERE name IS "#general") ORDER BY post_time DESC;

SELECT channel.name FROM channel, user, addid
    WHERE addid.ch_id = channel.id
    AND addid.u_id = user.id
    AND user.name IS "Alice";

SELECT user.name FROM user, addid, channel
    WHERE addid.u_id = user.id
    AND addid.ch_id = channel.id
    AND channel.name IS "#general";

SELECT * FROM message WHERE u_id IS(SELECT id from user WHERE name IS "Alice");

SELECT * FROM message WHERE ch_id IS(SELECT id FROM channel WHERE name IS "#random") 
    AND u_id IS(SELECT id FROM user WHERE name IS "Bob");

SELECT name AS "User Name", COUNT(content) as "Message Count" FROM user, message
    WHERE message.u_id = user.id
    GROUP BY user.name
    ORDER BY user.name DESC;

--6. ON DELETE CASCADE deletes everything once the parent element is gone