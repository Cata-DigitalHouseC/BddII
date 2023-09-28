DELIMITER $$
CREATE PROCEDURE sp_cliente_insertC1(IN pCedula varchar(10), IN pApellido VARCHAR(45), IN pNombres VARCHAR(100), IN pFechaNac DATE)
BEGIN
	/*IF NOT EXISTS (SELECT idCleintes FROM clientes WHERE cedulaint = pCedula)*/
	IF ((SELECT COUNT(*) FROM CLIENTES WHERE cedulaident = pCedula)=0) THEN
		INSERT INTO clientes
		VALUES(default, pCedula,pApellidos,pNombres,pFechaNac, NULL);
    END IF;
END $$

DELIMITER $$
	CREATE FUNCTION fn_valida_edadC1(fechaNac DATE, fechaIniPrest DATE, cantCuotas INT)
    RETURNS TINYINT DETERMINISTIC 
    BEGIN
		DECLARE result TINYINT DEFAULT 1;
        DECLARE vCumple80 DATE DEFAULT DATE_ADD(fechaNac, INTERVAL 80 YEAR);
        DECLARE vFinPrestamo DATE DEFAULT DATE_ADD(FECHAiNIpREST,INTERVAL cantCuotas MONTH);
        
        IF vCumple80 < vFinPrestamo THEN
			SET result = 0;
		END IF;
        RETURN result;
END $$

select fn_valida_edadC1('1997-07-07',NOW(),1000);

DROP FUNCTION IF EXISTS fn_dia_habil_C1;
DELIMITER $$
CREATE FUNCTION fn_dia_habil_C1(fecha DATE)
RETURNS DATE DETERMINISTIC
BEGIN
	DECLARE result DATE DEFAULT fecha;
    IF(WEEKDAY(fecha)=5) THEN
		SET result = DATE_ADD(fecha, INTERVAL 2 DAY);
    ELSEIF (WEEKDAY(fecha)=6) THEN
		SET result = DATE_ADD(fecha, INTERVAL 1 DAY);
	END IF;
RETURN result;
END $$

SELECT fn_dia_habil_C1(NOW());
SELECT fn_dia_habil_C1('2023-09-03')