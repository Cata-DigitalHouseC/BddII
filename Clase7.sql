use adventureworks;

/*Creat tabla*/
CREATE TABLE IF NOT EXISTS Employee_Age_hist(FirstName VARCHAR(50),LastName VARCHAR(50), Age INT, 
											Accion VARCHAR(25), FechaHora DATETIME, Responsable VARCHAR(100));

/*Trigger para insertar*/
DELIMITER $$
CREATE TRIGGER tr_insertar_employee 
AFTER INSERT ON Employee_Age FOR EACH ROW
BEGIN
	INSERT INTO Employee_Age_hist
    VALUES(NEW.FirstName,NEW.LastName,NEW.Age,'INSERT',NOW(),CURRENT_USER());
END $$

/*Trigger para UPDATE*/
DELIMITER $$
CREATE TRIGGER tr_modificar_employee 
BEFORE UPDATE ON Employee_Age FOR EACH ROW
BEGIN
	INSERT INTO Employee_Age_hist
    VALUES(OLD.FirstName,OLD.LastName,NEW.Age,'UPDATE',NOW(),CURRENT_USER());
END $$

/*Trigger para DELETE*/
DELIMITER $$
CREATE TRIGGER tr_eliminar_employee 
BEFORE DELETE ON Employee_Age FOR EACH ROW
BEGIN
	INSERT INTO Employee_Age_hist
    VALUES(OLD.FirstName,OLD.LastName,OLD.Age,'DELETE',NOW(),CURRENT_USER());
END $$


SELECT * FROM employee_age;
INSERT INTO employee_age
VALUES('Cata',NULL,33);

UPDATE employee_age
SET LastName='Casas'
WHERE FirstName ='Cata' AND LastName IS NULL;

DELETE FROM employee_age
WHERE FirstName='Cata' AND LastName LIKE 'Casas'
SELECT * FROM employee_age
SELECT * FROM employee_age_hist

SET @territory = (SELECT TerritoryID FROM customer WHERE CustomerID = 1);
SELECT @territory
