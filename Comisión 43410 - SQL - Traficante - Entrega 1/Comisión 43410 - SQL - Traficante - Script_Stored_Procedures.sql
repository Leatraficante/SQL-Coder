-- procedure para ver la cantidad de productos que tienen stock <= "X"
delimiter $$
CREATE PROCEDURE stock_productos (in p_dato_stock int)
begin 
	select * from producto
    where cantidad <= p_dato_stock;
end $$

call stock_productos(10)


-- procedure para obtener las Ordenes de Compra segun el estado en el que se encuentre
delimiter $$
CREATE PROCEDURE oc_estados (IN p_estado VARCHAR(50))
BEGIN
    SELECT * FROM orden_compra WHERE estado = p_estado;
END $$

call oc_estados("COMPLETA") -- puede ser "COMPLETA" "CANCELADA" "EN PROCESO"


-- SP para agregar un cliente, ID_Cliente seria autoincremental:
DELIMITER $$
CREATE PROCEDURE InsertarCliente(
    IN nombre VARCHAR(20),
    IN apellido VARCHAR(20),
    IN email VARCHAR(100),
    IN calle VARCHAR(20),
    IN numero INT,
    IN localidad VARCHAR(20),
    IN tel INT
)
BEGIN
    INSERT INTO cliente (nombre, apellido, email, calle, numero, localidad, tel)
    VALUES (nombre, apellido, email, calle, numero, localidad, tel);
END $$
CALL InsertarCliente('Leandro', 'Traficante', 'leatrafi@gmail.com', 'Llalal', '23', 'Martinez', '5555555');
select * from cliente


-- SP para ordenar la tabla segun el parametro deseado y en ASC / DSC:
DELIMITER //
CREATE PROCEDURE sp_ordenar_clientes(IN campo VARCHAR(20), IN orden VARCHAR(4))
BEGIN
    SET @query = CONCAT('SELECT * FROM cliente ORDER BY ', campo, ' ', orden);
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

CALL sp_ordenar_clientes('calle', 'desc');