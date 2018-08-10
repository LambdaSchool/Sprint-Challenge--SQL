CREATE TABLE organization(id integer primary key autoincrement, name text);

CREATE TABLE user(id integer primary key autoincrement, name text);

CREATE TABLE channel(id integer primary key autoincrement, name text, organizationId integer, foreign key(organizationId) references organization(id));

CREATE TABLE user_channel(id integer primary key autoincrement, userId integer, channelId integer, foreign key(userId) references user(id), foreign key(channelId) references channel(id));

CREATE TABLE message(id integer primary key autoincrement, content text, userId integer, post_time text, foreign key(userId) references user(id));

