USE tienda;
-- ¿QUÉ ARTICULOS INCLUYEN LA PALABRA PASTA EN SU NOMBRE?
SELECT *
FROM articulo
WHERE nombre LIKE '%Pasta%';
-- ¿QUÉ ARTÍCULOS ONCLUYEN LA PALABRA Cannelloni EN SU NOMBRE?
SELECT * 
FROM articulo
WHERE nombre LIKE '%Cannelloni%';
-- ¿QUÉ NOMBRES ESTÁN SEPARADOS POR UN GUIÓN?
SELECT *
FROM articulo
WHERE nombre LIKE '%-%';