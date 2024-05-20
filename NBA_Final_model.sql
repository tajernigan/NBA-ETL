/*
    Lab 5 - ERD to SQL conversion script
    
    Name: Tommy Jernigan
 */
 
-- Set your search path to include your username and public, 
-- but *not* in this script.

-- Windows psql needs the following line uncommented
-- \encoding utf-8

-- Add other environment changes here (pager, etc.)

-- Add the SQL for each step that needs SQL after the appropriate comment 
-- below. You may not need to do every single step, depending on your
-- model.
DROP TABLE IF EXISTS game CASCADE;
DROP TABLE IF EXISTS team CASCADE;
DROP TABLE IF EXISTS player CASCADE;
DROP TABLE IF EXISTS draft CASCADE;
/*
   Step 1: Regular entities
 */

CREATE TABLE game (
   id INTEGER PRIMARY KEY,
   date DATE, -- could have an issue
   --attendence NUMERIC(10, 1), -- can come back to it
   win_home TEXT,
   reb_home NUMERIC(4),
   ast_home NUMERIC(4),
   stl_home NUMERIC(4),
   blk_home NUMERIC(4),
   pts_home NUMERIC(4),
   reb_away NUMERIC(4),
   ast_away NUMERIC(4),
   stl_away NUMERIC(4),
   blk_away NUMERIC(4),
   pts_away NUMERIC(4),
   team_home_id INTEGER, -- team home id
   team_away_id INTEGER -- team away id
);

CREATE TABLE team (
   id INTEGER PRIMARY KEY,
   full_name TEXT,
   abbreviation TEXT,
   nickname TEXT,
   city TEXT,
   state TEXT,
   year_founded NUMERIC(4)
);

CREATE TABLE player (
   id INTEGER PRIMARY KEY,
   first TEXT,
   last TEXT,
   birthdate DATE, -- date time 
   school TEXT,
   country TEXT,
   height TEXT,
   weight INTEGER,
   position TEXT,
   start_year NUMERIC(4),
   end_year NUMERIC(4),
   draft_year TEXT, -- needed to make text since some player undrafted (can cast as int for qiuries )
   team_id INTEGER
);

/*
   Step 2: Weak entities
 */
CREATE TABLE draft (
   player_id INTEGER PRIMARY KEY,
   year NUMERIC(4),
   overall_pick INTEGER,
   team_id INTEGER
);

/*
   Step 3: 1:1 Relationships
 */
-- none

/*
   Step 4: 1:N Relationships
 */
-- did this step after copying info from csv files, it was easier to transform data in sql and then make certain attributes keys

/*
   Step 5: N:M Relationships
 */

/*
   Step 6: Multi-valued attributes
 */

/*
   Step 7: N-ary Relationships
 */
--none

/*
   load data into tables
*/

\COPY team FROM 'team.csv' WITH (FORMAT CSV, HEADER);

\COPY game FROM 'game_dropped.csv' WITH (FORMAT CSV, HEADER); 

DELETE FROM game WHERE team_home_id NOT IN (SELECT id FROM team) OR team_away_id NOT IN (SELECT id FROM team);

ALTER TABLE game
   ADD FOREIGN KEY (team_home_id) REFERENCES team(id);

ALTER TABLE game
   ADD FOREIGN KEY (team_away_id) REFERENCES team(id);

\COPY player FROM 'player.csv' WITH (FORMAT CSV, HEADER);

DELETE FROM player WHERE team_id NOT IN (SELECT id FROM team);

ALTER TABLE player
   ADD FOREIGN KEY (team_id) REFERENCES team(id);

\COPY draft FROM 'draft.csv' WITH (FORMAT CSV, HEADER);

