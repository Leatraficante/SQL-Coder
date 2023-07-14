use ecommerce;

/* PRIMERA TRANSACCIÓN, EN ESTA TABLA QUERÍA ELIMINAR UN REGISTRO PERO MI TIRABA ESTE ERROR: 
	"Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`estudio`.`orden_compra`, CONSTRAINT `fkID_CLIENTE_ORDEN` FOREIGN KEY (`ID_CLIENTE`) 
    REFERENCES `cliente` (`ID_CLIENTE`))"
Por eso opte por insertar un registro:*/

START TRANSACTION;
INSERT INTO cliente (nombre, apellido, email, calle, numero, localidad, tel)
VALUES ('Bautista', 'Traficante', 'bt@gmail.com', 'Calle Falsa', 123, 'CABA', 1554558899);

-- ROLLBACK;

SELECT * FROM cliente;




-- SEGUNDA TRANSACCION: INSERTAR REGISTROS CON 2 SAVEPOINTS, AGREGAR UN ROLLBACK AL FINAL CON REFERENCIA AL SAVEPOINT 1:

START TRANSACTION;
INSERT INTO producto (nombre, modelo, descripcion, cantidad, precio) 
VALUES
('AURICULARES SONY', 'SNY 456', 'Auriculares inalámbricos con cancelación de ruido, Bluetooth 5.0 y hasta 30 horas de autonomía.', 40, 8999),
('TABLET SAMSUNG', 'TAB S5', 'Pantalla Super AMOLED de 10.5 pulgadas, procesador Snapdragon 855, 6 GB de RAM y 128 GB de almacenamiento.', 30, 19999),
('CAMARA CANON', 'CN EOS 200D', 'Cámara réflex digital con sensor APS-C de 24.2 MP, grabación de video Full HD y pantalla táctil de 3 pulgadas.', 12, 29999),
('IMPRESORA EPSON', 'EPS L3150', 'Impresora multifuncional con sistema de tanque de tinta, conectividad Wi-Fi y capacidad de impresión a doble cara.', 25, 8999.5);
SAVEPOINT savepoint1;

INSERT INTO producto (nombre, modelo, descripcion, cantidad, precio)
VALUES
('TELEFONO HUAWEI', 'HUA P30', 'Pantalla OLED de 6.1 pulgadas, cámara trasera Leica de 40 MP, 128 GB de almacenamiento y desbloqueo facial.', 18, 24999),
('MONITOR LG', 'LG 27UL500', 'Monitor 4K UHD de 27 pulgadas, panel IPS, tiempo de respuesta de 5 ms y tecnología Radeon FreeSync.', 8, 17999),
('TECLADO LOGITECH', 'LOG G413', 'Teclado mecánico retroiluminado con interruptores Romer-G, conexión USB y diseño compacto.', 35, 6999),
('MOUSE RAZER', 'RZR DEATHADDER', 'Mouse gamer con sensor óptico de 16.000 DPI, retroiluminación RGB y 7 botones programables.', 50, 5000);
SAVEPOINT savepoint2;

-- ROLLBACK TO savepoint1;
-- COMMIT; 

SELECT * FROM PRODUCTO;