-- Trigger que audita cada vez que hay una variacion en el stock de los productos: 

drop trigger if exists trg_auditoria_stock;
drop table if exists trg_auditoria_stock;

CREATE TABLE trg_auditoria_stock (
	id_auditoria int auto_increment not null,
	id_producto INT not null,
    usuario VARCHAR (50) not null,
	fecha TIMESTAMP not null,
	cantidad_anterior INT not null,
	cantidad_actual INT not null,
    PRIMARY KEY (id_auditoria) 
) ENGINE = InnoDB;


DELIMITER $$
CREATE TRIGGER trg_auditoria_stock AFTER UPDATE ON producto 
FOR EACH ROW 
BEGIN
    IF OLD.cantidad <> NEW.cantidad THEN
        INSERT INTO trg_auditoria_stock (id_producto, usuario, fecha, cantidad_anterior, cantidad_actual)
        VALUES (OLD.id_producto, 'usuario', CURRENT_TIMESTAMP, OLD.cantidad, NEW.cantidad); 
    END IF;
END$$
DELIMITER ;

-- Trigger que audita cada vez que se registra un nuevo cliente: 


create table log_cliente (
id_log int auto_increment,
id_cliente int not null,
nombre varchar (50) not null,
apellido varchar (50) not null,
email varchar (50) not null,
calle varchar (50) not null,
numero int not null,
localidad varchar (50) not null,
tel int not null,
PRIMARY KEY (id_log)
) ENGINE = InnoDB; 

delimiter $$
create trigger trg_log_cliente 
before insert on cliente 
for each row 
begin 
	insert into log_cliente (id_cliente, nombre, apellido, email, calle, numero, localidad, tel)
    values (new.id_cliente, new.nombre, new.apellido, new.email, new.calle, new.numero, new.localidad, new.tel);
end$$
delimiter 

/* EJEMPLO:
INSERT INTO cliente (id_cliente, nombre, apellido, email, calle, numero, localidad, tel)
VALUES (888, 'Leandro', 'Traficante', 'aa@aaa.com', 'asd', '1234', 'caba', '1555556666');

select * from log_cliente */


