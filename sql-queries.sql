CREATE DATABASE labNormalization;
USE labNormalization;

-- Exercise 1:

CREATE TABLE authors(
	id INT auto_increment primary key,
    name VARCHAR(50)
);

INSERT INTO authors(name) VALUES ('Maria Charlotte'),
('Juan Perez'),
('Gemma Alcocer');

CREATE TABLE blog(
	id INT auto_increment primary key,
	author_id INT not null,
    foreign key (author_id) references authors(id),
    title VARCHAR(30),
    word_count INT,
    views INT
);

INSERT INTO blog(author_id, title, word_count, views) VALUES
(1, 'Best Paint Colors', 814, 14),
(2, 'Small Space Decorating Tips', 1146, 221),
(1, 'Hot Accessories', 986, 105),
(1, 'Mixing Textures', 765, 22),
(2, 'Kitchen Refresh', 1242, 307),
(1, 'Homemade Art Hacks', 1002, 193),
(3, 'Refinishing Wood Floors', 1571, 7542);

-- Exercise 2:
CREATE TABLE aircrafts(
	id int auto_increment primary key,
    total_seats int not null,
    name varchar(30) not null
);

CREATE TABLE flights(
	id int auto_increment primary key,
    flight_number VARCHAR(10) not null unique,
    mileage int,
	aircraft_id int not null,
    foreign key (aircraft_id) references aircrafts(id),
    CHECK (mileage > 0)
);

CREATE TABLE customers(
	id int auto_increment primary key,
    name varchar(50) not null,
    status varchar(20) not null default 'None',
    CHECK(statis IN ('None','Silver','Gold')),
    total_mileage int default 0,
    CHECK (total_mileage > 0)
);

CREATE TABLE bookings(
	id int auto_increment primary key,
    customer_id int not null,
    foreign key (customer_id) references customers(id),
    flight_number varchar(10) not null,
    foreign key (flight_number) references flights(flight_number)
);

INSERT INTO aircrafts (id, name, total_seats) VALUES (1, 'Boeing 747', 400),
(2, 'Airbus A330', 236),
(3, 'Boeing 777', 264),
(4, 'Boeing 747', 531);

INSERT INTO flights (flight_number, mileage, aircraft_id) VALUES ('DL143', 135, 1),
('DL122', 4370, 2),
('DL53', 2078, 3),
('DL222', 1765, 3),
('DL37', 531, 4);

INSERT INTO customers (id, name, status, total_mileage) VALUES (1, 'Agustine Riviera', 'Silver', 115235),
(2, 'Alaina Sepulvida', 'None', 6008),
(3, 'Tom Jones', 'Gold', 205767),
(4, 'Sam Rio', 'None', 2653),
(5, 'Jessica James', 'Silver', 127656),
(6, 'Ana Janco', 'Silver', 136773),
(7, 'Jennifer Cortez', 'Gold', 300582),
(8, 'Christian Janco', 'Silver', 14642);

INSERT INTO bookings (customer_id, flight_number) VALUES (1, 'DL143'),
(1, 'DL122'),
(2, 'DL122'),
(1, 'DL143'),
(3, 'DL122'),
(3, 'DL53'),
(1, 'DL143'),
(4, 'DL143'),
(1, 'DL143'),
(3, 'DL222'),
(5, 'DL143'),
(4, 'DL143'),
(6, 'DL222'),
(7, 'DL222'),
(5, 'DL122'),
(4, 'DL37'),
(8, 'DL222');

-- Exercise 3:
SELECT COUNT(DISTINCT flight_number) FROM flights;
SELECT AVG(mileage) FROM flights;
SELECT AVG(total_seats) FROM aircrafts;
SELECT status, AVG(total_mileage) FROM customers GROUP BY status;
SELECT status, MAX(total_mileage) FROM customers GROUP BY status;
SELECT COUNT(*) FROM aircrafts WHERE name LIKE '%Boeing%';
SELECT * FROM flights WHERE mileage BETWEEN 300 AND 2000;
SELECT c.status, AVG(f.mileage)
FROM bookings b
JOIN customers c ON b.customer_id = c.id
JOIN flights f ON b.flight_number = f.flight_number
GROUP BY c.status;

SELECT a.name, COUNT(*) AS total_bookings
FROM bookings b
JOIN customers c ON b.customer_id = c.id
JOIN flights f ON b.flight_number = f.flight_number
JOIN aircrafts a ON f.aircraft_id = a.id
WHERE c.status = 'Gold'
GROUP BY a.name
ORDER BY total_bookings DESC
LIMIT 1;