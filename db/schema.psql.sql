--
-- PostgreSQL schema file for Typo
-- Modified by Robby Russell <robby@planetargon.com>
--

CREATE TABLE users (
  id SERIAL PRIMARY KEY NOT NULL,
  login varchar(40) default NULL,
  password varchar(40) default NULL,
  UNIQUE (login)
);

CREATE TABLE articles (
  id SERIAL PRIMARY KEY NOT NULL,
  title varchar(255) default NULL,
  author varchar(255) default NULL,
  body text,
  body_html text,
  extended text,
  extended_html text,
  excerpt text,
  keywords varchar(255) default NULL,
  allow_comments int default NULL,
  allow_pings int default NULL,
  published int NOT NULL default '1',
  text_filter varchar(20) default NULL,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY NOT NULL,
  name varchar(255) default NULL,
  position int NOT NULL default '0'
);

CREATE TABLE articles_categories (
  article_id int,
  category_id int,
  is_primary int NOT NULL DEFAULT 0
);

CREATE TABLE blacklist_patterns (
  id SERIAL PRIMARY KEY NOT NULL,
  type varchar(15) default NULL,
  pattern varchar(255) default NULL
);

CREATE INDEX idx_blacklist_pattern ON blacklist_patterns (pattern);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY NOT NULL,
  article_id int NOT NULL,
  title varchar(255) default NULL,
  author varchar(255) default NULL,
  email varchar(255) default NULL,
  url varchar(255) default NULL,
  ip varchar(15) default NULL,
  body text,
  body_html text,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

CREATE INDEX idx_comments_article_id ON comments (article_id);

CREATE TABLE pings (
  id SERIAL PRIMARY KEY NOT NULL,
  article_id int NOT NULL,
  url varchar(255) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT now()
);

CREATE INDEX idx_pings_article_id ON pings (article_id);

CREATE TABLE resources (
  id SERIAL PRIMARY KEY NOT NULL,
  size int default NULL,
  filename varchar(255) default NULL,
  mime varchar(255) default NULL,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

CREATE TABLE sessions (
  id SERIAL PRIMARY KEY NOT NULL,
  sessid varchar(255) default NULL,
  data text,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);                                                                                                                                                                  

CREATE TABLE settings (
  id SERIAL PRIMARY KEY NOT NULL,
  name varchar(255) default NULL,
  value varchar(255) default NULL,
  position int default NULL
);

CREATE TABLE trackbacks (
  id SERIAL PRIMARY KEY NOT NULL,
  article_id int,
  blog_name varchar(255) default NULL,
  title varchar(255) default NULL,
  excerpt varchar(255) default NULL,
  url varchar(255) default NULL,
  ip varchar(15) default NULL,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

CREATE INDEX idx_trackbacks_article_id ON trackbacks (article_id);

CREATE TABLE schema_info (
  version integer
);

INSERT into schema_info VALUES (1);
