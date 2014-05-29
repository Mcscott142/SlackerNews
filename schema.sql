CREATE TABLE articles(
id serial PRIMARY KEY,
title varchar(500) NOT NULL,
url varchar(1000) NOT NULL,
description varchar(1000)
);

CREATE TABLE comments(
id serial PRIMARY KEY,
title varchar(500) NOT NULL,
description varchar(1000) NOT NULL
);
