USE airlines;
SELECT *  FROM customer;
SELECT *  FROM passengers_on_flights;
SELECT *  FROM routes;
SELECT *  FROM ticket_details;
/**2. Write a query to create a route_details table using suitable data types 
for the fields, such as route_id, flight_num, origin_airport, 
destination_airport, aircraft_id, and distance_miles; implement the 
check constraint for the flight number and unique constraint for the 
route_id fields; also, make sure that the distance miles field is greater 
than 0**/

CREATE TABLE route_details(
route_id INT PRIMARY KEY, 
flight_num  VARCHAR(10),
 origin_airport VARCHAR(50),
 destination_airport VARCHAR(50),
 aircraft_id INT,
 distance_miles INT NOT NULL); 
 
/**3. Write a query to display all the passengers (customers) who have 
traveled on routes 01 to 25; refer to the data from the 
passengers_on_flights table**/

SELECT customer_id, route_id 
FROM passengers_on_flights 
WHERE route_id BETWEEN 1 AND 25;

/**4. Write a query to identify the number of passengers and total revenue in 
business class from the ticket_details table.**/

SELECT class_id,
 count(no_of_tickets) AS Number_of_passengers,
 sum(Price_per_ticket) AS Total_Revenue
 FROM ticket_details
 WHERE class_id = "Bussiness";
 
/**5. Write a query to display the full name of the customer by extracting the 
first name and last name from the customer table.**/

SELECT 
concat_WS(' ',first_name, last_name) AS Full_Name
 FROM customer;
 
/**6. Write a query to extract the customers who have registered and 
booked a ticket. Use data from the customer and ticket_details tables.**/

SELECT DISTINCT t.customer_id, 
c.first_name, 
c.last_name,
t.no_of_tickets
FROM ticket_details AS t
INNER JOIN customer AS c
ON t.customer_id = c.customer_id
WHERE p_date IS NOT NULL
AND no_of_tickets IS NOT NULL
ORDER BY t.customer_id ASC;

/*7. Write a query to identify the customer’s first name and last name based 
on their customer ID and brand (Emirates) from the ticket_details table**/

SELECT DISTINCT t.customer_id,
t.brand,
c.first_name,
c.last_name
FROM ticket_details AS t
LEFT JOIN customer AS c
on t.customer_id = c.customer_id
WHERE t.brand = 'Emirates'
ORDER BY t.customer_id ASC;

/**8. Write a query to identify the customers who have traveled by Economy 
Plus class using Group By and Having clause on the 
passengers_on_flights table.**/

SELECT p.customer_id,
p.class_id,
c.first_name,
c.last_name
FROM passengers_on_flights AS p
LEFT JOIN customer AS c
ON p.customer_id = c.customer_id
GROUP BY p.customer_id, p.class_id, c.first_name, c.last_name
HAVING p.class_id = 'Economy Plus';

SELECT class_id,count(customer_id) AS Customers 
FROM passengers_on_flights
 WHERE class_id = "Economy Plus"
 GROUP BY class_id; 

/**Question 8 with Group by and Having**/

SELECT class_id,count(customer_id) AS Customers
 FROM passengers_on_flights
 GROUP BY class_id
 HAVING class_id = "Economy Plus";

/**Write a query to identify whether the revenue has crossed 10000 using 
the IF clause on the ticket_details table**/

SELECT SUM(Price_per_ticket*no_of_tickets) AS Total_Revenue,
IF(SUM(Price_per_ticket*no_of_tickets)>10000,'Greater then 10000', 'Less then 10000') 
Revenue_greater_10000 
FROM ticket_details;



/**11-Write a query to find the maximum ticket price for each class using 
window functions on the ticket_details table**/

SELECT  class_id, MAX(Price_per_ticket) AS max_price
FROM ticket_details
GROUP BY class_id;

/* 12. Write a query to extract the passengers whose route ID is 4 by 
improving the speed and performance of the passengers_on_flights 
table.*/
SELECT customer_id, route_id 
FROM passengers_on_flights
 WHERE route_id = "4";
 
 /*15. Write a query to create a view with only business class customers along 
with the brand of airlines. 
**/
CREATE VIEW businessclass_brand
AS
SELECT t.customer_id,
t.class_id,
t.brand,
c.first_name,
c.last_name
FROM ticket_details AS t
LEFT JOIN customer AS c
ON t.customer_id = c.customer_id
WHERE t.class_id = 'Bussiness';

SELECT * FROM airlines.businessclass_brand;

/*17. Write a query to create a stored procedure that extracts all the details 
from the routes table where the traveled distance is more than 2000 
miles.*/
SELECT * FROM routes
WHERE distance_miles > 2000;

/*Different way code*/
DELIMITER $$

CREATE PROCEDURE route_greater()

BEGIN
SELECT *
FROM routes
WHERE distance_miles > 2000;
END $$;

DELIMITER ;

CALL route_greater();
 







