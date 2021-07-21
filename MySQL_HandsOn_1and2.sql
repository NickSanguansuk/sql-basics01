
-- ---------- ---------- ---------- ---------- ---------- 

-- Members
-- 		Shayla 		Wright
-- 		Ferhat		Habouche
-- 		Samir		Hachemi
-- 		Jorge		Rodriguez
-- 		McKinley	Williams
-- 		Wasin		Sanguansuk

-- ---------- ---------- ---------- ---------- ---------- 

USE classicmodels;

-- ---------- ---------- ---------- ---------- ---------- 

-- 7/19/2021 - Per Scholas
-- MySQL Hands-On #1: Simple Queries

-- ----------
-- 1.1 	Write a query to display the name, product line, and buy price of all products. 
-- 	 	The output columns should display as “Name”, “Product Line”, and “Buy Price”. 
-- 	 	The output should display the most expensive items first.

SELECT * FROM products;

SELECT productName AS `Name`, productLine AS `Product Line`, buyPrice AS `Buy Price`
FROM products
ORDER BY buyPrice DESC;

-- ----------
-- 1.2 	Write a query to display the first name, last name, and city for all customers from Germany. 
-- 		Columns should display as “First Name”, “Last Name”, and “City”. 
-- 		The output should be sorted by the customer’s last name (ascending).

SELECT * FROM customers;

SELECT contactFirstName AS `First Name`, contactLastName AS `Last Name`, city AS `City`
FROM customers
WHERE country = 'Germany'
ORDER BY contactLastName;

-- ----------
-- 1.3 	Write a query to display each of the unique values of the status field in the orders table. 
-- 		The output should be sorted alphabetically increasing. 
-- 		Hint: the output should show exactly 6 rows.

SELECT * FROM orders;

SELECT status 
FROM orders
GROUP BY status
ORDER BY STATUS;

-- or

SELECT DISTINCT status 
FROM orders
ORDER BY STATUS;

-- ----------
-- 1.4 	Select all fields from the payments table for payments made on or after January 1, 2005. 
-- 		Output should be sorted by increasing payment date.

SELECT * FROM payments;

SELECT *
FROM payments
WHERE paymentDate >= '2005-1-1'
ORDER BY paymentDate;

-- ----------
-- 1.5 	Write a query to display all Last Name, First Name, Email and Job Title of all employees working out of the San Francisco office. 
-- 		Output should be sorted by last name.

SELECT * FROM employees;
SELECT * FROM offices;

SELECT lastName, firstName, email, jobTitle
FROM employees
WHERE officeCode <> 1
ORDER BY lastName;

-- or

SELECT lastName, firstName, email, jobTitle
FROM employees
WHERE officeCode <> (SELECT officeCode
						  FROM offices
						  WHERE city = 'San Francisco')
ORDER BY lastName;
						
-- ----------
-- 1.6 	Write a query to display the Name, Product Line, Scale, and Vendor of all of the car products – both classic and vintage. 
-- 		The output should display all vintage cars first (sorted alphabetically by name), and all classic cars last (also sorted alphabetically by name).

SELECT * FROM products;

SELECT productName, productLine, productScale, productVendor
FROM products
WHERE productLine = 'Classic Cars' OR productLine = 'Vintage Cars'
ORDER BY productLine DESC, productName;

-- ---------- ---------- ---------- ---------- ---------- 

-- 7/20/2021 - Per Scholas
-- MySQL Hands-On #2: Joins & Grouping

-- ----------
-- 2.1 	Write a query to display each customer’s name (as “Customer Name”) alongside the name of the employee who is responsible for that customer’s orders. 
-- 	 	The employee name should be in a single “Sales Rep” column formatted as “lastName, firstName”. 
-- 		The output should be sorted alphabetically by customer name.

SELECT * FROM customers;
SELECT * FROM employees;

SELECT c.customerName, CONCAT(e.lastName, ', ', e.firstName) AS `Sales Rep`
FROM customers AS c INNER JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
ORDER BY c.customerName;

-- ----------
-- 2.2 	Determine which products are most popular with our customers. 
-- 		For each product, list the total quantity ordered along with the total sale generated (total quantity ordered * priceEach) for that product. 
-- 		The column headers should be “Product Name”, “Total # Ordered” and “Total Sale”. 
-- 		List the products by Total Sale descending.

SELECT * FROM products;
SELECT * FROM orderdetails;

SELECT p.productName AS `Product Name`, 
	   SUM(od.quantityOrdered) AS `Total # Ordered`, 
	   SUM(od.quantityOrdered) * od.priceEach AS `Total Sale` 
FROM products AS p INNER JOIN orderdetails AS od ON p.productCode = od.productCode
GROUP BY p.productCode
ORDER BY `Total Sale` DESC;

-- ----------
-- 2.3 	Write a query which lists order status and the # of orders with that status. 
-- 		Column headers should be “Order Status” and “# Orders”. 
-- 		Sort alphabetically by status.

SELECT * FROM orders;
SELECT * FROM orderdetails;

SELECT o.status, COUNT(o.status) AS `count`
FROM orders AS o -- INNER JOIN orderdetails AS od ON 
GROUP BY o.status;

-- ----------
-- 2.4 	Write a query to list, for each product line, the total # of products sold from that product line. 
-- 		The first column should be “Product Line” and the second should be “# Sold”. 
-- 	 	Order by the second column descending.

SELECT DISTINCT status FROM orders;
SELECT * FROM productlines;

SELECT p.productLine AS `Product Line`, SUM(od.quantityOrdered) AS `# Sold`
FROM (products AS p INNER JOIN orderdetails AS od USING(productCode)) INNER JOIN orders AS o USING(orderNumber)
WHERE o.status = 'Shipped'
GROUP BY `Product Line`
ORDER BY `# Sold` DESC;

-- ----------
-- 2.5 	For each employee who represents customers, output the total # of orders that employee’s customers have placed alongside the total sale amount of those orders. 
-- 		The employee name should be output as a single column named “Sales Rep” formatted as “lastName, firstName”. 
-- 		The second column should be titled “# Orders” and the third should be “Total Sales”. 
-- 		Sort the output by Total Sales descending. 
-- 	 	Only (and all) employees with the job title ‘Sales Rep’ should be included in the output, and if the employee made no sales the Total Sales should display as “0.00”.

SELECT * FROM employees;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderdetails;

SELECT CONCAT(e.lastName, ', ', e.firstName) AS `Sales Rep`, 
	   COUNT(DISTINCT o.orderNumber) AS `# Orders`,
	   COALESCE(SUM(od.quantityOrdered * od.priceEach), 0.00) AS `Total Sales`
FROM ((employees AS e LEFT JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber)
	 LEFT JOIN orders AS o USING(customerNumber))
	 LEFT JOIN orderdetails AS od USING(orderNumber)		
WHERE e.jobTitle = 'Sales Rep'				
GROUP BY e.employeeNumber
ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC;

-- ----------
-- 2.6 	Your product team is requesting data to help them create a bar-chart of monthly sales since the company’s inception. 
-- 		Write a query to output the month (January, February, etc.), 4-digit year, and total sales for that month. 
-- 	 	The first column should be labeled ‘Month’, the second ‘Year’, and the third should be ‘Payments Received’. 
-- 	  	Values in the third column should be formatted as numbers with two decimals – for example: 694,292.68.

SELECT 






-- ---------- ---------- ---------- ---------- ---------- 


















































