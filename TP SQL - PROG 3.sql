IF OBJECT_ID('dbo.usuario') IS NOT NULL 
DROP TABLE dbo.usuario; 
GO

CREATE TABLE usuario (
	 id INT PRIMARY KEY IDENTITY,
	 nombre VARCHAR(50),
	 apellido VARCHAR(50), 
	 clave VARCHAR(200),
	 mail VARCHAR(100),
	 fecha_de_registro VARCHAR(10),
	 localidad VARCHAR(100)
 );
GO

INSERT INTO usuario(nombre, apellido, clave,mail, fecha_de_registro, localidad)
VALUES 
	('Esteban','Madou','2345','dkantor0@example.com','2021-07-01','Quilmes'),
	('German','Gerram','1234','ggerram1@hud.gov','2020-08-05','Berazategui'),
	('Deloris','Fosis','5678','bsharpe2@wisc.edu','2020-11-28','Avellaneda'),
	('Brok','Neiner','4567','bblazic3@desdev.cn','2020-08-12','Quilmes'),
	('Garrick','Brent','6789','gbrent4@theguardia.com','2020-11-17','Moron'),
	('Bili','Baus','0123','bhoff5@addthis.com','2020-11-27','Moreno');
GO

IF OBJECT_ID('dbo.producto') IS NOT NULL 
DROP TABLE dbo.producto; 
GO
CREATE TABLE producto (
	 id INT PRIMARY KEY IDENTITY,
	 codigo_de_barra INT,
	 nombre VARCHAR(55), 
	 tipo VARCHAR(55),
	 stock INT,
	 precio FLOAT,
	 fecha_de_creacion VARCHAR(10),
	 fecha_de_modificacion VARCHAR(10)
 );
GO

INSERT INTO producto(codigo_de_barra, nombre, tipo, stock, precio, fecha_de_creacion, fecha_de_modificacion)
VALUES 
    (77900361, 'Westmacott', 'liquido', 33, 15.87, '2021-09-02', '2020-09-26'),
    (77900362, 'Spirit', 'solido', 45, 69.74, '2020-09-18', '2020-04-14'),
    (77900363, 'Newgrosh', 'polvo', 14, 68.19, '2020-11-29', '2021-11-02'),
    (77900364, 'McNickle', 'polvo', 19, 53.51, '2020-11-28', '2020-17-04'),
    (77900365, 'Hudd', 'solido', 68, 26.56, '2020-12-19', '2020-06-19'),
    (77900366, 'Schrader', 'polvo', 17 ,96.54, '2020-08-02', '2020-04-18'),
    (77900367, 'Bachellier', 'solido', 59, 69.17,'2021-01-30', '2020-07-06'),
    (77900368, 'Fleming', 'solido', 38, 66.77, '2020-10-26', '2020-03-10'),
    (77900369, 'Hurry', 'solido', 44, 43.01, '2020-04-07', '2020-05-30'),
    (77900310, 'Krauss', 'polvo', 73, 35.73, '2021-03-03', '2020-08-30');
GO
 
IF OBJECT_ID('dbo.venta') IS NOT NULL 
DROP TABLE dbo.venta; 
GO

CREATE TABLE venta (
	id INT PRIMARY KEY IDENTITY,
	id_producto INT FOREIGN KEY REFERENCES producto(id),
	id_usuario INT FOREIGN KEY REFERENCES usuario(id), 
	cantidad INT,
	fecha_de_venta VARCHAR(10)
);
GO 

INSERT INTO venta (id_producto, id_usuario, cantidad, fecha_de_venta)
VALUES
    (1, 1, 2, '2020-07-19'),
    (8, 2, 3, '2020-08-16'),
    (7, 2, 4, '2021-01-24'),
    (6, 3, 5, '2021-01-14'),
    (3, 4, 6, '2021-03-20'),
    (5, 5, 7, '2021-02-22'),
    (3, 4, 6, '2020-02-12'),
    (3, 6, 6, '2020-10-06'),
    (2, 6, 6, '2021-04-02'),
    (1, 6, 1, '2020-05-17');
GO 

 -- EJERCICIOS:
SELECT * FROM usuario ORDER BY apellido, nombre ASC -- 1
GO 

SELECT * FROM producto WHERE tipo = 'liquido' -- 2
GO 

SELECT * FROM venta WHERE (cantidad BETWEEN 6 AND 10) -- 3
GO 

SELECT cantidadVentas = SUM(cantidad) FROM venta -- 4
GO 

SELECT TOP 3 * FROM venta ORDER BY fecha_de_venta ASC -- 5
GO 

SELECT  -- 6
    nombreUsuario = u.nombre,
	apellidoUsuario = u.apellido,
    nombreProducto = p.nombre,
	tipoProducto = p.tipo
FROM usuario u
INNER JOIN venta v ON v.id_usuario = u.id
INNER JOIN producto p ON p.id = v.id_producto 
GO 

-- 7) Indicar el monto (cantidad * precio) por cada una de las ventas.
SELECT
	producto = p.nombre,
	precioUnidadProducto = p.precio,
	cantidadAComprar = v.cantidad,
	montoFinal = (v.cantidad * p.precio),
	fecha_de_venta = v.fecha_de_venta
FROM venta v
INNER JOIN producto p ON v.id_producto = p.id
GO 

-- 8) Obtener la cantidad total del producto 1003 vendido por el usuario 104.
SELECT 
	cantidadTotal = SUM(cantidad)
FROM venta WHERE id_producto = 3 AND id_usuario = 4
GO 

-- 9)Obtener todos los números de los productos vendidos por algún usuario de ‘Avellaneda’.
SELECT
	nombreUsuario = u.nombre,
	apellidoUsuario = u.apellido,
	producto = p.nombre,
	numero = p.codigo_de_barra
FROM venta v
	INNER JOIN producto p ON v.id_producto = p.id
	INNER JOIN usuario u ON v.id_usuario = u.id
WHERE u.localidad = 'Avellaneda'
GO 

-- 10) Obtener los datos completos de los usuarios cuyos nombres contengan la letra ‘u’.
SELECT * FROM usuario WHERE (nombre LIKE '%u%' OR apellido LIKE '%u%')
GO 

-- 11)Traer las ventas entre junio del 2020 y febrero 2021.
SELECT * FROM venta WHERE (fecha_de_venta BETWEEN '2020-06-01' AND '2021-02-28') ORDER BY fecha_de_venta ASC 
GO 

--12) Obtener los usuarios registrados antes del 2021.
SELECT * FROM usuario WHERE YEAR(fecha_de_registro) < '2021' ORDER BY fecha_de_registro ASC
GO 

--13.Agregar el producto llamado ‘Chocolate’, de tipo Sólido y con un precio de 25,35.
INSERT INTO producto(codigo_de_barra, nombre, tipo, stock, precio, fecha_de_creacion, fecha_de_modificacion)
VALUES 
    (77900371, 'Chocolate', 'solido', 33, 25.35, '2022-04-24', '')
GO 

--14.Insertar un nuevo usuario
INSERT INTO usuario(nombre, apellido, clave,mail, fecha_de_registro, localidad)
VALUES 
('Valentin','Laplume','1234','laplu.me.valen@gmail.com','2022-04-24','Burzaco')
GO 

--15.Cambiar los precios de los productos de tipo sólido a 66,60.
UPDATE producto SET precio = 66.60 WHERE tipo = 'solido'
GO 

--16.Cambiar el stock a 0 de todos los productos cuyas cantidades de stock sean menores
--a 20 inclusive.
UPDATE producto SET stock = 0 WHERE stock < 21
GO 

--17.Eliminar el producto número 1010.
DELETE producto where id = 10
GO 

--18.Eliminar a todos los usuarios que no han vendido productos.
DELETE u
FROM usuario u
	WHERE NOT EXISTS (SELECT 1 FROM venta
						WHERE id_usuario = u.id)
GO 



