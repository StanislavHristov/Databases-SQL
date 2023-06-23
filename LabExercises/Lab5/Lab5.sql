DROP DATABASE IF EXISTS cinema;
CREATE DATABASE cinema;
USE cinema;

CREATE TABLE cinemas (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL
);

CREATE TABLE halls (
id INT AUTO_INCREMENT PRIMARY KEY,
cinema_id INT NOT NULL,
name VARCHAR(255) NOT NULL,
capacity INT NOT NULL,
hall_status VARCHAR(50),
CONSTRAINT FOREIGN KEY (cinema_id) REFERENCES cinemas(id)
);

CREATE TABLE films (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
year INT NOT NULL,
country VARCHAR(255) NOT NULL
);

CREATE TABLE projections (
id INT AUTO_INCREMENT PRIMARY KEY,
hall_id INT NOT NULL,
film_id INT NOT NULL,
broadcasting_time DATETIME NOT NULL,
audience INT NOT NULL,
CONSTRAINT FOREIGN KEY (hall_id) REFERENCES halls(id),
CONSTRAINT FOREIGN KEY (film_id) REFERENCES films(id)
);

INSERT INTO cinemas
	VALUES (NULL, 'Arena Mladost', 'Okolovrasten Pat');
INSERT INTO halls (cinema_id, name, capacity, hall_status) 
	VALUES (1, 'Zala 1', 200, 'VIP');
INSERT INTO films (name, year, country) 
	VALUES ('Final Destinaton 7', 1994, 'USA');
INSERT INTO projections (hall_id, film_id, broadcasting_time, audience) 
	VALUES (1, 1, '2023-03-22 18:30:00', 150);
    
-- 2    
SELECT c.name AS cinema_name, h.name AS hall_name, p.broadcasting_time
FROM cinemas AS c
INNER JOIN halls AS h ON c.id = h.cinema_id
INNER JOIN projections AS p ON h.id = p.hall_id
INNER JOIN films AS f ON p.film_id = f.id
WHERE (h.hall_status = 'VIP' OR h.hall_status = 'Deluxe') AND f.name = 'Final Destinaton 7'
ORDER BY c.name, h.name;

-- 3
SELECT SUM(p.audience) AS total_audience
FROM cinemas AS c
INNER JOIN halls AS h ON c.id = h.cinema_id
INNER JOIN projections AS p ON h.id = p.hall_id
INNER JOIN films AS f ON p.film_id = f.id
WHERE h.hall_status = 'VIP' AND f.name = 'Final Destinaton 7' AND c.name = 'Arena Mladost';


SELECT DISTINCT CONCAT(s1.name, ' and ', s2.name) AS pairs, sg.location, sg.dayOfWeek, sg.hourOfTraining
FROM student_sport ss1
JOIN student_sport ss2 ON ss1.sportGroup_id = ss2.sportGroup_id AND ss1.student_id < ss2.student_id
JOIN students s1 ON s1.id = ss1.student_id
JOIN students s2 ON s2.id = ss2.student_id
JOIN sportGroups sg ON sg.id = ss1.sportGroup_id
ORDER BY sg.location, sg.dayOfWeek, sg.hourOfTraining;


CREATE VIEW sp (Student_name, Class, Location, Coach_name) AS
SELECT students.name, students.class, sportGroups.location, coaches.name FROM students JOIN student_sport ON 
students.id=student_sport.student_id JOIN sportGroups ON 
student_sport.sportGroup_id=sportGroups.id JOIN coaches ON
sportGroups.coach_id=coaches.id 
WHERE sportGroups.hourOfTraining LIKE '08:00:00';
SELECT * FROM sp;


SELECT s.name AS sport, COUNT(DISTINCT student_sport.student_id) AS number_of_students
FROM sports AS s
LEFT JOIN sportGroups ON s.id = sportGroups.sport_id
LEFT JOIN student_sport ON sportGroups.id = student_sport.sportGroup_id
GROUP BY s.name;
