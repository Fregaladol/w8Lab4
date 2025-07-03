-- Ejercicio 1; una parte la hago visual y la otra en codigo que me falla la app

USE inventario;

show tables;

SHOW CREATE TABLE productos;
SHOW CREATE TABLE categorias;

-- renombrar tabla por error de dedo
rename table Productos to productos;

-- agregar la nueva columna
ALTER TABLE productos
ADD COLUMN categoriaid INT;

-- crear la clave foránea
ALTER TABLE productos
ADD CONSTRAINT fk_categoria
FOREIGN KEY (categoriaid)
REFERENCES categorias(idcategoria)
ON DELETE SET NULL
ON UPDATE CASCADE;

desc categorias;
desc productos;

-- error en el tipo de dato se cambia al correcto
ALTER TABLE productos
MODIFY cantidad_existencia INT DEFAULT NULL;

INSERT INTO productos (nombre, precio, cantidad_existencia, categoriaid) VALUES
('Manzana Roja', 1.50, 100, 1),
('Banano', 1.70, 120, 1),
('Zanahoria', 0.95, 100, 2),
('Brócoli', 1.26, 80, 2),
('Leche Entera', 0.95, 200, 3),
('Queso Gouda', 2.55, 70, 3),
('Pechuga de Pollo Entera', 6.80, 120, 4),
('Carne Molida de Res', 5.20, 95, 4),
('Arroz Blanco', 1.10, 100, 5),
('Copos de Avena', 1.00, 70, 5);

select * from productos;
select * from categorias;

-- cambiamos el id de una categoria, que dispare el update on cascade
UPDATE categorias
SET idcategoria = 15
WHERE idcategoria = 5;

-- Se realiza el cambio en cascada como se puede observar
select * from productos;

select p.nombre, p.categoriaid, c.nombre_categoria
from productos p, categorias c
where p.idProducto = c.idcategoria;

-- Ejercicio 2

USE comics;
show tables;

desc autores_comic;
desc paises;
desc personajes;

select * from autores_comic;
select * from paises;
select * from personajes;

SHOW CREATE TABLE paises;
SHOW CREATE TABLE personajes;

-- agregamos las columnas 
ALTER TABLE autores_comic
ADD COLUMN personajesid INT,
ADD COLUMN paisid INT;

-- primeroa el fk pais
ALTER TABLE autores_comic
ADD CONSTRAINT fk_pais
FOREIGN KEY (paisid)
REFERENCES paises(idpais)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- ahora el de personajes
ALTER TABLE autores_comic
ADD CONSTRAINT fk_personajes
FOREIGN KEY (personajesid)
REFERENCES personajes(id)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- agregar algunos datos faltantes
INSERT INTO paises (nombre, capital, pib_per_capita_usd_FMI, indice_riqueza)
VALUES ('USA', 'Washington D.C.', 85373.00, 'Alto');

UPDATE autores_comic SET personajesid = 1, paisid = 6 WHERE idAutores = 1; 
UPDATE autores_comic SET personajesid = 2, paisid = 6 WHERE idAutores = 2; 
UPDATE autores_comic SET personajesid = 3, paisid = 6 WHERE idAutores = 3; 
UPDATE autores_comic SET personajesid = 3, paisid = 6 WHERE idAutores = 4; 
UPDATE autores_comic SET personajesid = 1, paisid = 6 WHERE idAutores = 5; 

-- query para quedarnos con el nombre
SELECT ac.nombre as nombre, ac.apellido, pa.nombre, pe.nombre
FROM autores_comic ac
left join paises pa ON pa.idpais = ac.paisid
left join personajes pe ON pe.id = ac.personajesid;
