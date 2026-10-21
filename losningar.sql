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
-- Här skriver du lösningen till uppgift 2.
SHOW DATABASES;
