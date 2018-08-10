-- user table
-- name must be unique
create table user (
  id Integer PRIMARY KEY AUTOINCREMENT,
  name varchar(255) not null UNIQUE
);

-- organization table
-- name must be unique
create table organization (
  id Integer PRIMARY KEY AUTOINCREMENT,
  name varchar(255) not null UNIQUE

);

-- channel table
-- name must be unique
create table channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name varchar(255) not null UNIQUE,
  organization_fk Integer REFERENCES organization(id)
);
