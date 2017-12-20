CREATE TABLE travels.cities (
	`id` int(10) NOT NULL AUTO_INCREMENT,
	`city` varchar(255) NOT NULL,
	`country` varchar(255) NOT NULL,
	`population` int(10) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE travels.travels (
	`id` int(10) NOT NULL AUTO_INCREMENT,
	`city_id` int(10),
	`date1` date,
	`date2` date,
	PRIMARY KEY (`id`)
);


INSERT INTO travels.cities (id, city, country, population) VALUES (1, 'Madrid', 'Spain', 4500000);
INSERT INTO travels.cities (id, city, country, population) VALUES (2, 'Odessa', 'Ukraine', 1100000);
INSERT INTO travels.cities (id, city, country, population) VALUES (3, 'Yalta', 'Ukraine', 930000);
INSERT INTO travels.cities (id, city, country, population) VALUES (4, 'Paris', 'France', 6000000);

INSERT INTO travels.travels (id, city_id, date1, date2) VALUES (1, 3, '2017-12-31', '2018-01-02');

CREATE EVENT myevent ON SCHEDULE EVERY 1 WEEK DO UPDATE travels.cities SET population = population + 1000;

CREATE PROCEDURE myproc (IN param1 INT) UPDATE travels.cities SET population=param1;

SHOW PROCEDURE STATUS;

SHOW EVENTS IN travels;

SET TRANSACTION ISOLATION LEVEL repeatable read;

start transaction;
SELECT SUM(population) FROM travels.cities;
SELECT SUM(population) FROM travels.cities;

start transaction;
update travels.cities SET population=0 WHERE id=6 ;	
COMMIT;

SET TRANSACTION ISOLATION LEVEL read committed;

start transaction;
SELECT population FROM travels.cities WHERE id=6;
SELECT population FROM travels.cities WHERE id=6;