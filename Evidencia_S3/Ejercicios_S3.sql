USE classicmodels;
-- ##########################################################################################
-- 1.- Usa RIGHT JOIN para obtener el código del producto, nombre del producto y descripción
-- de todos los productos
SELECT productCode, productName, productDescription
FROM products;
-- ##########################################################################################
-- 2.- Usa RIGHT JOIN para obtener el númeor de orden, estado y costo total de cada orden
SELECT tabla1.orderNumber, tabla2.status, tabla1.total
FROM (
	SELECT orderNumber, sum(totalParcial) AS 'total'
	FROM(
		SELECT orderNumber, (quantityOrdered * priceEach) AS 'totalParcial'
		FROM orderdetails) AS aux
	GROUP BY orderNumber) AS tabla1
RIGHT JOIN orders AS tabla2
ON tabla1.orderNumber = tabla2.orderNumber;
-- #########################################################################################
-- 3.- Usar RIGHT JOIN para obtener el número de orden, fecha de orden, línea de orden
-- nombre del producto, cantidad ordenada y precio de cada pieza que muestre los detalles
-- de cada orden.
SELECT orderNUmber, orderDate, orderLineNumber, productName, quantityOrdered, priceEach
FROM products AS tabla1
RIGHT JOIN (
	SELECT tabla2.orderNUmber, tabla2.orderDate, tabla3.orderLineNumber, productCode, quantityOrdered, priceEach
	FROM orders AS tabla2
	RIGHT JOIN orderdetails AS tabla3
	ON tabla2.orderNumber = tabla3.orderNumber) AS tabla4
ON tabla1.productCode = tabla4.productCode;
-- #########################################################################################
-- 4.- Usar RIGHT JOIN para obtener el número de orden, nombre del producto
-- el precio sugerido de fábrica y precio de cada pieza
SELECT orderNumber, productName, MSRP, priceEach
FROM products AS tabla1
RIGHT JOIN orderdetails AS tabla2
ON tabla1.productCode = tabla2.productCode;
-- #########################################################################################
-- 5.- Usar LEFT JOIN para obtener número de cliente, nombre de cliente, número de orden
-- y estado de cada cliente
SELECT orders.customerNumber, customerName, orderNumber, state
FROM orders
LEFT JOIN customers
ON orders.customerNumber = customers.customerNumber;
-- ########################################################################################
-- 6.- Usar LEFT JOIN para obtener los clientes que no tiene una orden asociada
SELECT *
FROM customers
WHERE customerNumber NOT IN (
	SELECT orders.customerNumber
	FROM orders
	LEFT JOIN customers
	ON orders.customerNumber = customers.customerNumber);
-- ########################################################################################
-- 7.- Usar LEFT JOIN para obtener el apellido del empleado, nombre del empleado, nombre del cliente
-- número de cheque y total, es decir, los clientes asociados a cada empleado
SELECT lastName, firstName, customerName, checkNumber, amount
FROM customers
LEFT JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
LEFT JOIN payments
ON customers.customerNumber = payments.customerNumber
ORDER BY employeeNumber;
-- ########################################################################################
-- 8.1.- Usar RIGHT JOIN para obtener número de cliente, nombre de cliente, número de orden
-- y estado de cada cliente
SELECT orders.customerNumber, customerName, orderNumber, state
FROM customers
RIGHT JOIN orders
ON customers.customerNumber = orders.customerNumber;
-- ########################################################################################
-- 8.2.- Usar RIGHT JOIN para obtener los clientes que no tienen una orden asociada
SELECT *
FROM customers
WHERE customerNumber NOT IN(
	SELECT orders.customerNumber
	FROM customers
	RIGHT JOIN orders
	ON customers.customerNumber = orders.customerNumber);
-- ########################################################################################
-- 8.3.- Usar RIGHT JOIN para obtener el apellido del empleado, nombre del empleado, nombre del cliente
-- número de cheque y total, es decir, los clientes asociados a cada empleado
SELECT lastName, firstName, customerName, checkNumber, amount
FROM payments AS tabla1
RIGHT JOIN (
	SELECT *
	FROM employees
    RIGHT JOIN customers
    ON employees.employeeNumber = customers.salesRepEmployeeNumber) AS tabla2
ON tabla1.customerNumber = tabla2.customerNumber
ORDER BY employeeNumber;
-- ##########################################################################################
-- 9.- Escoge 3 consultas de los ejercicios anteriores, crea una vista y escribe una consulta
-- para cada una
-- 9.1.- 
CREATE VIEW describe_product108 AS
	SELECT productCode, productName, productDescription
	FROM products;
-- No tengo permisos para crear vistas