-- how many home wins does each team have
SELECT full_name, COUNT(game.win_home) AS home_wins
FROM team
JOIN game ON team.id = game.team_home_id
WHERE game.win_home = 'W'
GROUP BY full_name
ORDER BY COUNT(game.win_home) DESC; 


-- how many players retired before 1990
SELECT COUNT(*)
FROM player
WHERE end_year < 1990;

-- what players have played for the lakers and have at least 10 seasons played
SELECT player.first, player.last, (player.end_year - player.start_year) AS experience
FROM player
JOIN team ON player.team_id = team.id
WHERE team.abbreviation = 'LAL' AND (player.end_year - player.start_year) >= 10
ORDER BY (player.end_year - player.start_year) DESC;

-- which team scores less than 101 points on average at home
SELECT team.full_name, CAST(AVG(pts_home) AS NUMERIC(4, 1)) AS average_home_points
FROM game
JOIN team ON team.id = game.team_home_id
GROUP BY team.full_name
HAVING AVG(pts_home) < 101;

-- how many active players have over 15 seasons player
SELECT player.first, player.last, (player.end_year - player.start_year) AS experience
FROM player
JOIN team ON player.team_id = team.id
WHERE (player.end_year - player.start_year) >= 15 AND end_year = 2023
ORDER BY (player.end_year - player.start_year) DESC;

-- how many players went undrafted from each country
SELECT country, COUNT(*)
FROM player
WHERE draft_year = 'Undrafted'
GROUP BY country
ORDER BY COUNT(*) DESC;

-- how many players from each couuntry have played in the nba
SELECT country, COUNT(*)
FROM player
GROUP BY country
ORDER BY COUNT(*) DESC;

-- how many players weight at least 300 pounds in history
SELECT first, last, weight
FROM player
WHERE weight >= 300;

-- what players are over 7' 2" in history
SELECT first, last, height
FROM player
WHERE CAST(SUBSTRING(height, 1, 1) AS NUMERIC(1)) >= 7 AND CAST(SUBSTRING(height, 3, 1) as NUMERIC(1)) >= 2
ORDER BY CAST(SUBSTRING(height, 3, 1) as NUMERIC(1)) DESC;

-- denver nuggets wins each year
SELECT team.full_name, EXTRACT(YEAR from game.date) AS season, COUNT(*) AS wins
FROM team
JOIN game ON (game.team_home_id = team.id AND game.win_home = 'W') OR (game.team_away_id = team.id AND game.win_home = 'L')
WHERE team.abbreviation = 'DEN'
GROUP BY team.full_name, EXTRACT(year from game.date)
ORDER BY extract(year from game.date);
