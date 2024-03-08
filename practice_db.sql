SELECT * FROM classroom

CREATE TABLE classroom
(
rollno int8 PRIMARY KEY,
name varchar(50) NOT NULL,
house char(12) NOT NULL,
grade char(1)
);

INSERT INTO classroom
(rollno, name, house, grade)
VALUES
(1, 'Sam', 'Akash', 'B'),
(2, 'Ram', 'Agni', 'A'),
(3, 'Shyam', 'Jal', 'B'),
(4, 'Sundar', 'Agni', 'A'),
(5, 'Ram', 'Yayu', 'B');

SELECT rollno, name FROM classroom
SELECT rollno, name, grade FROM classroom
SELECT DISTINCT grade FROM classroom

SELECT * FROM classroom
WHERE grade = 'A' AND rollno >3

SELECT * FROM classroom
WHERE grade = 'A' AND rollno >3

CREATE TABLE public.customer
(
    customet_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(100),
    address_id character varying(100),
    PRIMARY KEY (customet_id)
);

CREATE TABLE customer1(
customer_id int8 PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(100),
	address_id int8
)

CREATE TABLE payment1(
customer_id int8 PRIMARY KEY,
	amount int8 NOT NULL,
	mode varchar(50),
	payment_date date
)


COPY customer1(customer_id, first_name, last_name, email, address_id)
FROM 'C:\Users\abdul\OneDrive\Desktop\SQL\raishab\customer.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM customer1
SELECT * FROM customer
SELECT * FROM payment
SELECT * FROM payment1

DROP TABLE customer
DROP TABLE payment

INSERT INTO customer
(customer_id, first_name, last_name, address_id)
VALUES
(1, 'Mary', 'Smith', '5'),
(2, 'Madan', 'Mohan', '6'),
(3, 'Linda', 'Williams', '7'),
(4, 'Barbara', 'Jones', '8'),
(5, 'Elizabeth', 'Brown', '9');

INSERT INTO customer
(customer_id, first_name, last_name, address_id)
VALUES
(11, 'Mary', 'Smith', '5'),
(12, 'Madan', 'Mohan', '6'),
(13, 'Linda', 'Williams', '7');

INSERT INTO payment
(customer_id, amount, mode, payment_date)
VALUES
(1, '60', 'Cash', '2020-09-24'),
(2, '30', 'Credit Card', '2020-04-27'),
(3, '90', 'Credit Card', '2020-07-07'),
(4, '50', 'Debit Card', '2020-02-12'),
(5, '40', 'Mobile Payment', '2020-11-20');

INSERT INTO payment
(customer_id, amount, mode, payment_date)
VALUES
(6, '60', 'Cash', '2020-09-24'),
(7, '30', 'Credit Card', '2020-04-27'),
(8, '90', 'Credit Card', '2020-07-07');


CREATE TABLE public.payment
(
    customer_id integer NOT NULL,
    amount numeric,
    mode character varying(50),
    payment_date character varying(100),
    PRIMARY KEY (customer_id)
);


SELECT * FROM customer
ORDER BY first_name ASC

SELECT * FROM customer
LIMIT 5

SELECT UPPER (first_name) FROM customer
SELECT LOWER (first_name) FROM customer
SELECT LENGTH (first_name), first_name FROM customer
SELECT SUBSTRING (first_name,1,3), first_name FROM customer
SELECT CONCAT (first_name, ' ', last_name),first_name, last_name FROM customer
SELECT REPLACE (first_name, 'Mary', 'Mohan'),first_name, last_name FROM customer

SELECT * FROM payment1
SELECT COUNT(amount) FROM payment1
SELECT SUM(amount) FROM payment1
SELECT MAX(amount) FROM payment1
SELECT MIN(amount) FROM payment1
SELECT AVG(amount) FROM payment1
SELECT ROUND(AVG(amount),2) FROM payment1

SELECT mode,SUM(amount) AS Total 
FROM payment1
GROUP BY mode

SELECT mode,SUM(amount) AS total 
FROM payment1
GROUP BY mode
ORDER BY total ASC

SELECT mode,SUM(amount) AS total 
FROM payment1
GROUP BY mode
HAVING SUM(amount) >= 100
ORDER BY total ASC

SELECT mode,COUNT(amount) AS total 
FROM payment1
GROUP BY mode
HAVING COUNT(amount) >= 3
ORDER BY total ASC

SELECT mode,COUNT(amount) AS total 
FROM payment1
GROUP BY mode
HAVING COUNT(amount) >= 2 AND COUNT (amount) < 4
ORDER BY total ASC


SHOW TIMEZONE
SELECT NOW()
SELECT TIMEOFDAY()
SELECT CURRENT_TIME
SELECT CURRENT_DATE

SELECT EXTRACT(MONTH FROM payment_date) AS payment_month, payment_date FROM payment1
SELECT EXTRACT(YEAR FROM payment_date) AS payment_year, payment_date FROM payment1
SELECT EXTRACT(DOW FROM payment_date) AS payment_DOW, payment_date FROM payment1
SELECT EXTRACT(DAY FROM payment_date) AS payment_DAY, payment_date FROM payment1
SELECT EXTRACT(QUARTER FROM payment_date) AS payment_QUARTER, payment_date FROM payment1
SELECT EXTRACT(DOY FROM payment_date) AS payment_DOY, payment_date FROM payment1

SELECT * 
FROM customer AS c
INNER JOIN payment AS p
ON c.customer_id = p.customer_id

SELECT c.first_name, p.amount, p.mode
FROM customer AS c
INNER JOIN payment AS p
ON c.customer_id = p.customer_id

SELECT * 
FROM customer AS c
LEFT JOIN payment AS p
ON c.customer_id = p.customer_id

SELECT * 
FROM customer AS c
RIGHT JOIN payment AS p
ON c.customer_id = p.customer_id


SELECT * 
FROM customer AS c
FULL OUTER JOIN payment AS p
ON c.customer_id = p.customer_id

INSERT INTO emp
(empid, empname, manager_id)
VALUES
(1, 'Agni', '3'),
(2, 'Akash', '4'),
(3, 'Dharti', '2'),
(4, 'Vaya', '3');

SELECT * 
FROM emp AS T1
JOIN emp AS T2
ON T2.empid = T1.manager_id

SELECT T1.empname AS employee_name, T2.empname AS manager_name
FROM emp AS T1
JOIN emp AS T2
ON T2.empid = T1.manager_id

INSERT INTO cust
(cust_name, cust_amount)
VALUES
('Madan Mohan', '2100'),
('Gopi Nath', '1200'),
('Govind Dev','5000');

INSERT INTO custb
(cust_name, cust_amount)
VALUES
('Madan Mohan', 2100),
('Gopal Bhat', 1200);


SELECT * from custb
SELECT * from cust

SELECT cust_name, cust_amount FROM cust
UNION
SELECT cust_name, cust_amount FROM custB

SELECT cust_name, cust_amount FROM cust
UNION ALL
SELECT cust_name, cust_amount FROM custB

SELECT customer_id, amount FROM payment1
WHERE amount >
(SELECT ROUND(AVG(amount),2) from payment1)

SELECT c.customer_id,CONCAT(c.first_name,' ', c.last_name) AS customer_name, p.amount FROM payment1 AS p
RIGHT JOIN customer1 AS c
ON p.customer_id = c.customer_id
WHERE amount >
(SELECT ROUND(AVG(amount),2) from payment1)


SELECT customer_id, amount, mode
FROM payment
where customer_id IN (SELECT customer_id FROM customer)

SELECT first_name, last_name
FROM customer c
WHERE EXISTS (SELECT customer_id, amount 
			 	FROM payment p
			    WHERE p.customer_id = c.customer_id
			  	AND amount >= 50 )
				
SELECT * FROM payment

SELECT customer_id, amount,
CASE
	WHEN amount > 50 THEN 'Expensive product'
	WHEN amount = 50 THEN 'Moderate product'
	ELSE 'Inexpensive product' 
END AS ProductStatus
FROM payment

SELECT customer_id,
CASE amount
	WHEN 60 THEN 'Prime Customer'
	WHEN 90 THEN 'Plus Customer'
	ELSE 'Regular Customer'
END AS CustomerStatus
FROM payment

WITH my_cte AS (
	SELECT *, AVG(amount) OVER(ORDER BY 
	p.customer_id) AS "Average_Price", 
	COUNT(address_id) OVER(ORDER BY 
	c.customer_id) AS "Count"
	FROM payment as p
	INNER JOIN customer AS c
	ON p.customer_id = c.customer_id
)
SELECT first_name, last_name, amount
FROM my_cte


WITH my_cp AS (
SELECT *, AVG(amount) OVER(ORDER BY p.customer_id) 
AS "Average_Price", 
COUNT(address_id) OVER(ORDER BY c.customer_id) AS 
"Count"
FROM payment as p
INNER JOIN customer AS c
ON p.customer_id = c.customer_id
),
my_ca AS (
SELECT *
FROM customer as c
INNER JOIN address AS a
ON a.address_id = c.address_id
INNER JOIN country as cc
ON cc.city_id = a.city_id
)
SELECT cp.first_name, cp.last_name, ca.city, ca.country, cp.amount
FROM my_ca as ca , my_cp as cp

WITH my_cte AS (
SELECT mode, MAX(amount) AS highest_price, 
SUM(amount) AS total_price
FROM payment
GROUP BY mode
)
SELECT payment.*, my.highest_price, my.total_price
FROM payment
JOIN my_cte my
ON payment.mode = my.mode
ORDER BY payment.mode

