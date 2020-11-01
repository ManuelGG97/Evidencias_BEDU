USE classicmodels;
-- PREGUNTA 1
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE 'a%';
-- PREGUNTA 2
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE '%on';
-- PREGUNTA 3
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE '%on%';
-- PREGUNTA 4
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE 't%m'
AND LENGTH(firstName) = 3;
-- PREGUNTA 5
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName NOT LIKE 'B%';
-- PREGUNTA 6
SELECT productCode, productName
FROM products
WHERE productCode LIKE '%_20%';
-- PREGUNTA 7
SELECT orderNumber, sum(priceEach * quantityOrdered)
FROM orderdetails
GROUP BY orderNumber;
-- PREGUNTA 8
SELECT year(orderDate), count(*)
FROM orders
GROUP BY year(orderDate);
-- PREGUNTA 9
SELECT lastName, firstName
FROM employees
WHERE officeCode
IN (SELECT officeCode FROM offices WHERE country = 'USA');
-- PREGUNTA 10
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount IN (SELECT max(amount) FROM payments);
-- PREGUNTA 11
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount > (SELECT avg(amount) FROM payments);
-- PREGUNTA 12
SELECT customerName
FROM customers
WHERE customerNumber NOT IN (SELECT customerNumber FROM orders);
-- PREGUNTA 13
SELECT max(unidades_pedidas) AS 'maximo',
min(unidades_pedidas),
avg(unidades_pedidas)
FROM 
	(SELECT orderNumber, sum(quantityOrdered) AS 'unidades_pedidas'
	FROM orderdetails
	GROUP BY orderNumber) AS subconsulta;
-- PREGUNTA 14
SELECT count(*) AS 'pedidos_CA'
FROM orders
WHERE customerNumber IN
	(SELECT customerNumber
	FROM customers
	WHERE state = 'CA'); -- No me sale, lo intentaré después.