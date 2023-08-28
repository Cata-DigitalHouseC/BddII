/*SELECT * FROM adventureworks.employee;*/
SET @Edad =48;
SELECT c.FirstName, c.LastName, TIMESTAMPDIFF(YEAR, e.BirthDate, NOW()) as Edad FROM employee e
INNER JOIN contact c ON e.ContactID = c.ContactID
WHERE TIMESTAMPDIFF(YEAR, e.BirthDate, NOW())=@Edad;


/*1. Crear una funcion*/
DELIMITER $$
CREATE FUNCTION fn_calcular_anios(pFecha DATE)
RETURNS INT DETERMINISTIC
BEGIN
	/*RETURN (TIMESTAMPDIFF(YEAR, e.BirthDate, NOW()));*/
    /*DECLARE Anios INT DEFAULT (TIMESTAMPDIFF(YEAR, pFecha, NOW()));*/
    DECLARE Anios INT;
    SET Anios = TIMESTAMPDIFF(YEAR, pFecha, NOW());
    /*SELECT TIMESTAMPDIFF(YEAR, pFecha, NOW()) INTO Anios;*/
    /*SELECT Nombre, Apellido INTO pNom, pApe FROM empleados where empleadoId=X*/
    RETURN Anios;
END $$


/*Usar la Funcion*/
SET @Edad =48;
SELECT c.FirstName, c.LastName, TIMESTAMPDIFF(YEAR, e.BirthDate, NOW()) as Edad FROM employee e
INNER JOIN contact c ON e.ContactID = c.ContactID
WHERE fn_calcular_anios(BirthDate)=@Edad;


/*Una vez probada la fn, creamos el SP*/
DROP PROCEDURE sp_insertar_employee_age
create procedure sp_insertar_employee_age(IN pEdad INT)
BEGIN
	CREATE TABLE IF NOT EXISTS Employee_Age(FirstName Varchar(50), LastName VARCHAR(50), Age INT);
    
    INSERT INTO Employee_Age
    SELECT c.FirstName, c.LastName, TIMESTAMPDIFF(YEAR, e.BirthDate, NOW()) as Edad FROM employee e
	INNER JOIN contact c ON e.ContactID = c.ContactID
	WHERE fn_calcular_anios(BirthDate)=pEdad;
END $$

/*eJECUTAR EL SP*/
SET @Edad=51;
CALL sp_insertar_employee_age(@Edad);
SELECT * FROM Employee_Age;

