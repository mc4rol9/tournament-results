-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here. 


-- everytime this script runs, database will be created again
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament

-- create tables
CREATE TABLE players ( 
	id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE matches ( 
	match SERIAL PRIMARY KEY,
    winner INTEGER REFERENCES players(id),
    loser INTEGER REFERENCES players(id)
);

-- create views
CREATE VIEW standings AS
	SELECT players.id, 
		   players.name, 
		   (SELECT count(*) FROM matches WHERE players.id = matches.winner) AS wins,
		   (SELECT count(*) FROM matches WHERE players.id = matches.winner OR players.id = matches.loser) AS matches
	FROM players
	ORDER BY wins DESC;



