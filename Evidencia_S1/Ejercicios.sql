-- PARA CONOCER LA BASE DE DATOS:
SHOW DATABASES;
-- PREGUNTA 1
USE classicmodels;
SHOW TABLES;
DESCRIBE employees;
-- PREGUNTA 2
SELECT lastName FROM employees;
-- PREGUNTA 3
SELECT lastName, firstName, jobTitle
FROM employees;
-- PREGUNTA 4
SELECT * FROM employees;
-- PREGUNTA 5
SELECT lastName, firstName, jobTitle
FROM employees
WHERE jobTitle = 'Sales Rep';
-- PREGUNTA 6
SELECT lastName, firstName, jobTitle, officeCode
FROM employees
WHERE jobTitle = 'Sales Rep'
AND officeCode = 1;
-- PREGUNTA 7
SELECT lastName, firstName, jobTitle, officeCode
FROM employees
WHERE jobTitle = 'Sales Rep'
OR officeCode = 1;
-- PREGUNTA 8
SELECT lastName, firstName, officeCode
FROM employees
WHERE officeCode IN (1,2,3);
-- PREGUNTA 9
SELECT lastName, firstName, jobTitle
FROM employees
WHERE jobTitle != 'Sales Rep';
-- PREGUNTA 10
SELECT lastName, firstName, officeCode
FROM employees
WHERE officeCode > 5;
-- PREGUNTA 11
SELECT lastName, firstName, officeCode
FROM employees
WHERE officeCode <= 4;
-- PREGUNTA 12
SELECT customerName, country, state
FROM customers
WHERE country = 'USA'
AND state = 'CA';
-- PREGUNTA 13
SELECT customerName, country, state, creditLimit
FROM customers
WHERE country = 'USA'
AND state = 'CA'
AND creditLimit > 100000;
-- PREGUNTA 14
SELECT customerName, country
FROM customers
WHERE country = 'USA'
OR country = 'France';
-- PREGUNTA 15
SELECT customerName, country, creditLimit
FROM customers
WHERE country IN ('USA','France')
AND creditLimit > 100000;
-- PREGUNTA 16
SELECT officeCode, city, phone, country
FROM offices
WHERE country = 'USA'
OR country = 'France';
-- PREGUNTA 17
SELECT officeCode, phone, country
FROM offices
WHERE country != 'USA'
AND country != 'France';
-- PREGUNTA 18
SELECT orderNumber, customerNumber, shippedDate, status
FROM orders
WHERE orderNumber IN (10165,10287,10310);
-- PREGUNTA 19
SELECT contactLastName, contactFirstName
FROM customers
ORDER BY contactLastName ASC;
-- PREGUNTA 20
SELECT contactLastName, contactFirstName
FROM customers
ORDER BY contactLastName DESC;
-- PREGUNTA 21
SELECT contactLastName, contactFirstName
FROM customers
ORDER BY contactLastName DESC, contactFirstName ASC;
-- PREGUNTA 22
SELECT customerNumber, customerName, creditLimit
FROM customers
ORDER BY creditLimit DESC
LIMIT 5;
-- PREGUNTA 23
SELECT customerNumber, customerName, creditLimit
FROM customers
ORDER BY creditLimit DESC
LIMIT 5;