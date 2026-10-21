-- Moon Missions
use laboration1;
-- kontrollera uppdraget__
select * from moon_mission;
-- Uppgift 1
CREATE TABLE successful_mission AS
SELECT *
FROM moon_mission
WHERE outcome = 'Successful';

SELECT * FROM successful_mission;


-- Uppgift 2
ALTER TABLE successful_mission
    MODIFY COLUMN mission_id SMALLINT NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (mission_id);

-- Kontrollera att mission_id är primärnyckel och har auto_increment
show columns from successful_mission;
