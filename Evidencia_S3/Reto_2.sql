-- RETO 2
-- ¿Cuál es el nombre de los empleados que realizaron cada venta?
SELECT id_venta, nombre, apellido_paterno, apellido_materno
FROM venta
LEFT JOIN empleado
ON venta.id_empleado = empleado.id_empleado;
-- ¿Cuál es el nombre de los artículos que se han vendido?
SELECT id_venta, nombre
FROM venta
LEFT JOIN articulo
ON venta.id_articulo = articulo.id_articulo;
-- ¿Cuál es el total de cada venta?
SELECT clave, sum(precio) AS 'Total'
FROM venta
LEFT JOIN articulo
ON venta.id_articulo = articulo.id_articulo
GROUP BY clave
ORDER BY clave;
