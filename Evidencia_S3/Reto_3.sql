-- RETO 3
USE tienda;
-- Obterner el puesto de un empleado
CREATE VIEW empleado_puesto108 AS
	SELECT e.nombre, e.apellido_paterno, e.apellido_materno, p.nombre AS 'puesto'
	FROM empleado AS e
	LEFT JOIN puesto AS p
	ON e.id_puesto = p.id_puesto;
-- Saber qué articulos ha vendido cada empleado
CREATE VIEW empleado_ventas108 AS
	SELECT e.id_empleado, v.id_venta, a.nombre
	FROM venta AS v
	LEFT JOIN empleado AS e
	ON v.id_empleado = e.id_empleado
	LEFT JOIN articulo AS a
	ON v.id_articulo = a.id_articulo
	ORDER BY e.id_empleado;
-- Saber qué puesto ha tenido más ventas
CREATE VIEW puesto_ventas108 AS
	SELECT puesto, count(*) AS 'ventas_totales'
	FROM(
		SELECT p.nombre AS 'puesto', v.id_venta
		FROM venta AS v
		LEFT JOIN empleado AS e
		ON v.id_empleado = e.id_empleado
		LEFT JOIN puesto AS p
		ON e.id_puesto = p.id_puesto) AS tabla1
	GROUP BY puesto
	ORDER BY ventas_totales DESC;
SELECT *