create table if not exists users (
  id serial primary key,
  email varchar(128) not null unique,
  password char(40) not null,
  name varchar(32),
  validated_at int,
  created_at int default (strftime('%s','now')),
  updated_at int default (strftime('%s','now'))
);

create table if not exists docs (
  id varchar(8) primary key,
  user_id int not null references users(id),
  title varchar(128),
  description text,
  options text,
  content text,
  created_at int default (strftime('%s','now')),
  updated_at int default (strftime('%s','now'))
);