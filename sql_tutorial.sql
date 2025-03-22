USE db_sql_tutorial;
SELECT 
	first_name,
    country
FROM customers;


-- List all countries of all customers without duplicates
SELECT DISTINCT 
	country
FROM customers;

-- Retrieve all customers where the result is sorted by score(smallest first)
SELECT *
FROM customers
ORDER BY score ASC;

-- Retrieve all customers where the result is sorted by country(alphabetically) and then by score(highest first)
SELECT *
FROM customers
ORDER BY country ASC, score DESC;

-- Retrieve only German customers
SELECT * 
FROM customers
WHERE country = 'Germany';

SELECT * 
FROM customers
Where score <= 500;

-- Find all customers whose scores falls between 100 and 500
SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500;

-- Find customers whose ID is equal to 1,2 or 5
SELECT * 
FROM customers
WHERE customer_id IN (1,2,5);

-- LIKE PATERN
-- find all customers whose firstname strats with m
SELECT * 
FROM customers
WHERE first_name LIKE 'M%';

-- find all customers whose firstname ends with n
SELECT * 
FROM customers
WHERE first_name LIKE '%n';

-- find all customers whose firstname contains r
SELECT * 
FROM customers
WHERE first_name LIKE '%r%';

-- find all customers whose firstname contains r in 3rd position
SELECT * 
FROM customers
WHERE first_name LIKE '__r%';

-- List customers id, firstname, orderid, quantity.
-- Exclude the customers who have not placed any orders
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id,
    o.quantity
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

-- List customersid, firstname, orderid, quantity.
-- include the customers who have not placed any orders
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id,
    o.quantity
FROM customers AS c
LEFT JOIN orders AS o
on c.customer_id = o.customer_id;

-- Aggreage functions
-- find the total number of customers in the db
SELECT COUNT(*) AS total_customers
FROM customers;
-- find the total quanity of all orders
SELECT SUM(quantity) AS total_quantity
FROM orders;

-- find the average score of all customers
SELECT AVG(score) AS average_score
FROM customers;

-- String functions
-- List all customer names where the name is combination of firstname and lastname
SELECT 
concat(first_name, ' ',  last_name) AS customer_name
FROM customers;

-- remove whitespaces in the lastname
SELECT 
	TRIM(last_name) AS clean_name,
	LENGTH(last_name) AS len_name,
	LENGTH(TRIM(last_name)) AS clean_len_name
FROM customers;

-- Advanced topics
-- Find the total number of customers for each country
SELECT 
	COUNT(*) AS total_customers,
    country
FROM customers
GROUP BY country;

-- Find the total number of customers for each country and sort the result by total(lowest first)
SELECT 
	COUNT(*) AS total_customers,
    country
FROM customers
GROUP BY country
ORDER BY total_customers ASC;

-- Find the highest score of customers for each country
SELECT 
	MAX(score) AS highest_score,
	country
FROM customers
GROUP BY country;

-- HAVING
-- Find the total customers for each country and only include countries that have more than one customers
SELECT 
	COUNT(*) AS total_customers,
	country
FROM customers
GROUP BY country
HAVING total_customers > 1;

-- SUBQUERIES
-- Find all orders placed from customers whose score are higher than 500 using the customer id
SELECT *
FROM orders
WHERE customer_id IN 
	(
		SELECT customer_id
        FROM customers
        WHERE score > 500
    )