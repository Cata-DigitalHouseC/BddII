use adventureworks;

drop procedure if exists sp_Employee_Age_Insertar;
drop procedure if exists sp_Employee_Age_Insertar_bulk;
DELIMITER $$
CREATE PROCEDURE sp_Employee_Age_Insertar(IN pFirstName varchar(50),IN pLastName varchar(50),Age INT)
BEGIN
	INSERT INTO employee_age VALUES
    (pFirstName, pLastName, Age);
END $$


DELIMITER $$
CREATE PROCEDURE sp_Employee_Age_Insertar_bulk(IN pEdad INT)
BEGIN
	DECLARE vNombre, vApellido VARCHAR(50);
    DECLARE vTerminar, vEdad TINYINT DEFAULT 0;
	DECLARE cur CURSOR FOR(SELECT c.FirstName, c.LastName, 
							fn_calcular_anios(BirthDate) as Edad FROM employee e
							INNER JOIN contact c ON e.ContactID = c.ContactID
                            WHERE fn_calcular_anios(BirthDate)=pEdad
							);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET vTerminar = 1;
	OPEN cur;
		recorre: LOOP
			FETCH cur INTO vNombre, vApellido, vEdad;
            IF vTerminar =1 THEN 
				LEAVE recorre;
			END IF;
            CALL sp_Employee_Age_Insertar(vNombre,vApellido,vEdad);
		END LOOP;
    CLOSE cur;
END $$


SET @Edad =45;

CALL sp_Employee_Age_Insertar_bulk(@Edad);
select * from employee_age;

/*Tabla temporal*/
/*CREATE TEMPORARY TABLE IF NOT EXISTS temporal
SELECT * FROM 

CREATE VIEW NOMBREVIEW AS SELECT....
*/
CREATE TEMPORARY TABLE IF NOT EXISTS temporal (Nombre VARCHAR(50), Apellido VARCHAR(50), Edad INT);
INSERT INTO temporal
SELECT * FROM employee_age;

SELECT Edad, count(*) AS CANTIDAD FROM temporal
GROUP BY Edad
HAVING CANTIDAD>1;

INSERT INTO temporal
VALUES('Cata','Hdz',21)


