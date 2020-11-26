USE bedu_test;
CREATE TABLE IF NOT EXISTS movies (
id INT PRIMARY KEY,
title VARCHAR(80),
generos VARCHAR(80)
);

CREATE TABLE IF NOT EXISTS ratings (
user_id INT,
movie_id INT,
rating INT,
date_ BIGINT
);
