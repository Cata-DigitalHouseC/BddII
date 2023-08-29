SET @Ivana ='Cam';

SELECT @Ivana; /*Cuando cierro sesion, ahi muere la vble pq se reinician las vbles y muere la conexion a la bdd*/


use adventureworks;

/*Ejercicio 1*/
DROP PROCEDURE IF EXISTS sp_random
DELIMITER $$
CREATE PROCEDURE sp_random(IN pNum INT, OUT pCantidad INT)
BEGIN
	DECLARE pNumAb INT; /*	Opcional, puedo usar solo el set*/
    SET pNumAb= ABS(pNum);
	IF (pNumAb>=0 AND pNumAb < 10) THEN
		SET pCantidad =1;
	ELSEIF(pNumAb <100) THEN
		SET pCantidad =2;
	ELSEIF(pNumAb <1000) THEN
		SET pCantidad =3;
	END IF;
END $$

CALL sp_random(-40,@Cant1);
CALL sp_random(700,@Cant2);
SELECT @Cant1, @Cant2
SELECT ABS(-40)


/*eJERCICIO2*/
use musimundos;
DROP PROCEDURE IF EXISTS sp_insertar_generos;
DELIMITER $$
CREATE PROCEDURE sp_insertar_generos(IN pNombres VARCHAR(1000))
BEGIN
	DECLARE vGenreId TINYINT DEFAULT(SELECT MAX(id) FROM generos);
    DECLARE pNombreAInsertar VARCHAR(50);
	WHILE (LOCATE('|',pNombres) != 0) DO
		SET vGenreId= vGenreId +1;
        set pNombreAInsertar = LEFT(pNombres, LOCATE('|',pNombres)-1);
        IF (lower(pNombreAInsertar) not in (SELECT distinct lower(nombre) FROM generos)) THEN /*Exists tambien se puede*/
			INSERT INTO generos
			VALUES(vGenreId,pNombreAInsertar);
        END IF;
        set pNombres = RIGHT(pNombres, character_length(pNombres) - LOCATE('|',pNombres));
	END WHILE;	
END $$

CALL sp_insertar_generos('Champeta|Tango|Rock|Punk|');
select * from generos

DELETE FROM generos
WHERE nombre =''