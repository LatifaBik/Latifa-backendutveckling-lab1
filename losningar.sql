
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

-- Boöcker

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

-- bookstore

create table bookstore (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    boutique_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL
    );

-- inventory

CREATE TABLE inventory (
    store_id INT NOT NULL,
    isbn CHAR(13) NOT NULL,
    amount INT NOT NULL CHECK (amount >= 0),
    PRIMARY KEY (store_id, isbn),
    FOREIGN KEY (store_id) REFERENCES bookstore(id),
    FOREIGN KEY (isbn) REFERENCES book(isbn)
);

-- Att lägga till data

USE bookstore;

-- Författare
INSERT INTO author (first_name, last_name, birth_date)
VALUES
    ('Anna', 'Andersson', '1980-05-12'),
    ('Erik', 'Svensson', '1975-09-23');

-- Språk
INSERT INTO language (name)
VALUES ('Svenska'), ('Engelska');

-- Böcker med påhittade titlar för övningen
INSERT INTO book
(isbn, title, language_id, price, publication_date, author_id)
VALUES
    ('9780140328721', 'Skogens hemlighet', 1, 149.00, '2020-03-15', 1),
    ('9780306406157', 'En lång resa', 2, 199.00, '2022-08-20', 2);

-- Butiker
INSERT INTO bookstore (boutique_name, city)
VALUES
    ('Bokhörnan', 'Stockholm'),
    ('Läsglädje', 'Uppsala');

-- Antal exemplar av varje bok i varje butik
INSERT INTO inventory (store_id, isbn, amount)
VALUES
    (1, '9780140328721', 5),
    (1, '9780306406157', 3),
    (2, '9780140328721', 8),
    (2, '9780306406157', 4);


-- Vy: en rad per författare
CREATE VIEW total_author_book_value AS
SELECT
    CONCAT(a.first_name, ' ', a.last_name) AS name,
    TIMESTAMPDIFF(YEAR, a.birth_date, CURDATE()) AS age,
    COUNT(DISTINCT b.isbn) AS book_title_count,
    COALESCE(SUM(b.price * i.amount), 0) AS inventory_value
FROM author a
         LEFT JOIN book b ON a.id = b.author_id
         LEFT JOIN inventory i ON b.isbn = i.isbn
GROUP BY a.id, a.first_name, a.last_name, a.birth_date;


-- Kontrollera resultatet

SELECT * FROM total_author_book_value;
SELECT * FROM bookstore.total_author_book_value;

SELECT * FROM bookstore.author;
