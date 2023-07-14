-- función para ver el monto total de las ordenes de compra canceladas en 2023
delimiter $$
CREATE FUNCTION total_cancelados_2023() 
RETURNS DECIMAL(50,2)
DETERMINISTIC
BEGIN
    DECLARE monto_total DECIMAL(50,2);
	SELECT SUM(precio) INTO monto_total
    FROM metodo_pago
    WHERE YEAR(fecha) = 2023
    AND descripcion = 'CANCELADO';
    RETURN monto_total;
END $$

-- funcion que me pertmite ver la cantidad de clientes en CABA
delimiter $$
CREATE FUNCTION clientes_caba()
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total_caba INT;
  SELECT COUNT(*) INTO total_caba
  FROM cliente
  WHERE localidad = 'CABA';
  RETURN total_caba;
END $$



/* la siguiente funcion era para calcular el precio final de un producto a partir de su id; en caso de querer hacer un aumento % de precio*/ 
delimiter $$
CREATE FUNCTION precio_final_aumento2 (id_producto1 INT, 
									aumento float) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE precio_original DECIMAL(10, 2);
    DECLARE precio_final DECIMAL(10, 2);
        SELECT precio INTO precio_original FROM producto WHERE id_producto = id_producto1;
        SET precio_final = precio_original + (precio_original * (aumento / 100));
        RETURN precio_final;
END $$

select precio_final_aumento2 (1, 7.00)