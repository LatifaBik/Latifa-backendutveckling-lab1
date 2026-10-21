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

-- Uppgift 3
UPDATE successful_mission
SET operator = REPLACE(operator, ' ', '');

UPDATE moon_mission
SET operator = REPLACE(operator, ' ', '');

-- Kontrollera resultat--
SELECT operator FROM successful_mission;
SELECT operator FROM moon_mission;

-- Uppgift 4
-- Kontrollera först vilka rader som ska tas bort --
select * from successful_mission
where launch_date >= '2010-01-01';

-- Ta bort raderna --
delete from successful_mission
     where launch_date >= '2010-01-01';

select * from successful_mission;
