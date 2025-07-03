CREATE DATABASE IF NOT EXISTS comics;
USE comics;

CREATE TABLE personajes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    especie VARCHAR(80),
    frase_favorita VARCHAR(255)
);

INSERT INTO personajes (nombre, especie, frase_favorita) VALUES
('Spider-Man', 'Humano', 'Con gran poder, viene gran responsabilidad'),
('Batman', 'Humano', 'Soy la noche'),
('Wolverine', 'Mutante', 'Soy el mejor en lo que hago, pero lo que hago no es muy agradable'),
('Goku', 'Saiyan', 'Quieres pelar?!'),
('Naruto Uzumaki', 'Humano', 'Mi camino ninja'),
('Luffy', 'Humano', '¡Carne!');

SELECT * FROM personajes;

UPDATE personajes
SET nombre = 'Monkey D. Luffy'
WHERE id = 6;

SELECT * FROM personajes;

/* 
CREATE TABLE `comics`.`autores_comic` (
  `idAutores` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `fecha_nacimiento` DATE NULL,
  `alta_registro` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `modificacion_registro` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAutores`));
*/

SELECT * FROM comics.autores_comic;

-- tuve que insetarlo con codigo que al poner las fechas a mi workbench se le ocurria cerrarse

INSERT INTO autores_comic (nombre, apellido, fecha_nacimiento) VALUES
('Stan', 'Lee', '1922-12-28'),
('Bob', 'Kane', '1915-10-24'),
('Frank', 'Miller', '1957-01-27'),
('Chris', 'Claremont', '1950-05-25'),
('Jack', 'Kirby', '1917-08-28');

-- tabla paises

/*
CREATE TABLE `comics`.`paises` (
  `idpais` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `capital` VARCHAR(45) NULL,
  `pib_per_capita_usd` DECIMAL(10,2) NULL,
  `indice_riqueza` VARCHAR(20)
  );
*/



SELECT * FROM comics.paises;

ALTER TABLE paises
CHANGE COLUMN pib_per_capita_usd pib_per_capita_usd_FMI DECIMAL(15,2);

-- mismo error al insertar con visual lo haré manual

/*
INSERT INTO paises (nombre, capital, pib_per_capita_usd_FMI, indice_riqueza) VALUES
('Luxemburgo', 'Luxemburgo', 131384.00, 'Alto'),
('España', 'Madrid', 34045.00, 'Medio'),
('Irlanda', 'Dublín', 106059.00, 'Alto'),
('Arabia Saudita', 'Riad', 33040.00, 'Medio'),
('México', 'Ciudad de México', 15249.00, 'Medio');
*/
DESC paises;

SELECT nombre from personajes;

SELECT nombre, apellido 
from autores_comic
WHERE fecha_nacimiento BETWEEN '1950-01-01' AND '1970-01-01';

SELECT * 
FROM paises
WHERE indice_riqueza = 'Medio'
;

SELECT nombre,frase_favorita
from personajes
WHERE frase_favorita LIKE "%?%";

-- no funcionará por el safe mode
UPDATE personajes
SET frase_favorita = "Quieres pelear?!"
WHERE nombre = "Goku";


UPDATE personajes
SET frase_favorita = "Quieres pelear?!"
WHERE id = (SELECT id 
FROM personajes 
WHERE nombre = "Goku");

SELECT *
FROM personajes;
