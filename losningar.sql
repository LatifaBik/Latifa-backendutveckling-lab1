
use laboration1;
-- Moon Missions

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

-- uppguft 5
SELECT
    user_id,
    name AS username,
    password,
    CONCAT(first_name, ' ', last_name) AS name,
    ssn,
    CASE
        WHEN MOD(SUBSTRING(ssn, -2, 1), 2) = 0 THEN 'female'
        ELSE 'male'
        END AS gender
FROM account;

-- uppgift 6
-- Kontrollera först vilka rader som ska tas bort

SELECT *
FROM account
WHERE MOD(SUBSTRING(ssn, -2, 1), 2) = 0
  AND LEFT(ssn, 2) < '70';

-- Att ta bort raderna
DELETE FROM account
WHERE MOD(SUBSTRING(ssn, -2, 1), 2) = 0
  AND LEFT(ssn, 2) < '70';

-- uppgift 7
SELECT
    CASE
        WHEN MOD(SUBSTRING(ssn, -2, 1), 2) = 0 THEN 'female'
        ELSE 'male'
        END AS gender,
    AVG(
            TIMESTAMPDIFF(
                    YEAR,
                    STR_TO_DATE(CONCAT('19', LEFT(ssn, 6)), '%Y%m%d'),
                    CURDATE()
            )
    ) AS average_age
FROM account
GROUP BY gender;


-- Book Store

DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore;
USE bookstore;

-- Författare
CREATE TABLE author (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL
);

-- Böcker

CREATE TABLE language (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE book (
    isbn CHAR(13) NOT NULL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    language_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    publication_date DATE NOT NULL,
    author_id INT NOT NULL,
    CHECK (isbn REGEXP '^[0-9]{13}$'),
    FOREIGN KEY (author_id) REFERENCES author(id),
    FOREIGN KEY (language_id) REFERENCES language(id)
);
