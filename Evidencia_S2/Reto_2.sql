USE tienda;
-- ¿Cuál es el promedio de salario de los puestos?
SELECT avg(salario) AS 'Salario Promedio'
FROM puesto;
-- ¿Cuántos articulos incuyen la palabra pasta en su nombre?
SELECT count(*) AS 'Conteo'
FROM articulo
WHERE nombre LIKE '%Pasta%';
-- ¿Cuál es el alrio mínimo y máximo?
SELECT min(salario) AS 'Salario Minimo', max(salario) AS 'Salario Máximo'
FROM puesto;
-- ¿Cuál es la suma del salario de los últimos cinco puestos agregados?
SELECT sum(salario)
FROM puesto
WHERE id_puesto >= 995;