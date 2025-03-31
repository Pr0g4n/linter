CREATE SCHEMA users;
CREATE SCHEMA store;
CREATE SCHEMA buys;
CREATE SCHEMA promotion;
CREATE SCHEMA sale;

CREATE TABLE sale.sale(
	id SERIAL,
	id_user INTEGER NOT NULL,
	id_client INTEGER NOT NULL,
	id_detail INTEGER NOT NULL,
	date_sale DATE DEFAULT CURRENT_TIMESTAMP,
	stock INTEGER NULL,

	CONSTRAINT pk_sale PRIMARY KEY(id),
	CONSTRAINT fk_users_user FOREIGN KEY(id_user) REFERENCES users.users(id),
	CONSTRAINT fk_sale_client FOREIGN KEY(id_client) REFERENCES sale.client(id),
	CONSTRAINT fk_sale_detail FOREIGN KEY(id_detail) REFERENCES sale.sale_detail(id),
	CONSTRAINT stock_valid CHECK (stock>=0)
);

CREATE TABLE sale.client(
	id SERIAL,
	name_client TEXT NOT NULL,

	CONSTRAINT pk_client PRIMARY KEY(id)
);

CREATE TABLE sale.sale_detail(
	id SERIAL,
	id_item INTEGER NOT NULL,
	cost_detail INTEGER NOT NULL,
	amount INTEGER NULL,

	CONSTRAINT pk_detail PRIMARY KEY(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT amount_valid CHECK (amount>=0)
);

CREATE TABLE store.store(
	id SERIAL,
	id_user INTEGER NOT NULL,
	id_item INTEGER NOT NULL,
	date_store DATE DEFAULT CURRENT_TIMESTAMP,
	motion CHAR(1) NOT NULL,
	amount_store INTEGER NULL,
	final_amount INTEGER NULL,

	CONSTRAINT pk_store PRIMARY KEY(id),
	CONSTRAINT fk_users_user FOREIGN KEY(id_user) REFERENCES users.users(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT motion_valid CHECK (motion IN ('i', 's')),
	CONSTRAINT amount_valid CHECK (amount_store>=0)
);

CREATE TABLE store.item(
	id SERIAL,
	name_item TEXT NOT NULL,
	description_item TEXT NOT NULL,

	CONSTRAINT pk_item PRIMARY KEY(id)
);
CREATE TABLE users.users(
	id SERIAL,
	name_user TEXT NOT NULL,
	password_user TEXT NOT NULL,

	CONSTRAINT pk_user PRIMARY KEY(id)
);

CREATE TABLE users.employee (
    id SERIAL,
    id_users INTEGER NOT NULL,
    name_employee TEXT NOT NULL,
    ap_paterno TEXT NULL,
    ap_materno TEXT NULL,

    CONSTRAINT pk_users_employee PRIMARY KEY(id),
    CONSTRAINT fk_users_user FOREIGN KEY(id_users) REFERENCES users.users(id)
);

CREATE TABLE users.contrat(
	id SERIAL,
	id_employee INTEGER NOT NULL,
	id_position INTEGER NOT NULL,
	date_contract DATE DEFAULT CURRENT_TIMESTAMP,
	type_contract TEXT NOT NULL,
	time_contrat INTEGER,
	
	CONSTRAINT pk_users_contract PRIMARY KEY(id),
	CONSTRAINT fk_uers_employee FOREIGN KEY(id_employee) REFERENCES users.employee(id),
	CONSTRAINT fk_uers_position FOREIGN KEY(id_position) REFERENCES users.position(id),
	CONSTRAINT time_valid CHECK (time_contrat>0)
);

CREATE TABLE users.position(
	id SERIAL,
	name_position TEXT,
	description_position TEXT,

	CONSTRAINT pk_users_position PRIMARY KEY(id)
);

CREATE TABLE users.area (
    id SERIAL,
    id_users_employee INTEGER NOT NULL,
    id_users_area INTEGER NOT NULL,

    CONSTRAINT pk_users_assing_area PRIMARY KEY(id),
    CONSTRAINT fk_users_employee FOREIGN KEY(id_users_employee) REFERENCES users.employee(id),
    CONSTRAINT fk_users_area FOREIGN KEY(id_users_area) REFERENCES users.area(id)
);

CREATE TABLE users.control_access(
	id SERIAL,
	id_user INTEGER NOT NULL,
	admin_control_access TEXT NULL,
	buys_control_access TEXT NULL,
	sale_control_access TEXT NULL,
	store_control_access TEXT NULL,

	CONSTRAINT pk_users_control_access PRIMARY KEY(id),
	CONSTRAINT fk_users_user FOREIGN KEY(id_user) REFERENCES users.users(id)
);

CREATE TABLE buys.buys(
	id SERIAL,
	id_user INTEGER NOT NULL,
	id_buys_detail INTEGER NOT NULL,
	id_buys_supplier INTEGER NOT NULL,
	date_buys DATE DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_buys PRIMARY KEY(id),
	CONSTRAINT fk_users_user FOREIGN KEY(id_user) REFERENCES users.users(id),
	CONSTRAINT fk_buys_detail FOREIGN KEY(id_buys_detail) REFERENCES buys.buys_detail(id),
	CONSTRAINT fk_buys_supplier FOREIGN KEY(id_buys_supplier) REFERENCES buys.buys_supplier(id)
);

CREATE TABLE buys.buys_detail(
	id SERIAL,
	id_item INTEGER NOT NULL,
	cost_detail INTEGER NOT NULL,
	amount_detail INTEGER NULL,

	CONSTRAINT pk_detail PRIMARY KEY(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT cost_valid CHECK (cost_detail>=0),
	CONSTRAINT amount_valid CHECK (amount_detail>=0)
);

CREATE TABLE buys.buys_supplier(
	id SERIAL,
	supplier_name TEXT NOT NULL,
	company_name TEXT NOT NULL,
	email TEXT NOT NULL,
	number_phone TEXT NOT NULL,

	CONSTRAINT pk_buys_supplier PRIMARY KEY(id)
);

CREATE TABLE promotion.promotion(
	id SERIAL,
	id_item INTEGER NOT NULL,
	date_promotion DATE DEFAULT CURRENT_TIMESTAMP,
	amount_promotion INTEGER NULL,
	discount INTEGER NULL,
	
	CONSTRAINT pk_promotion PRIMARY KEY(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT amount_valid CHECK (amount_promotion>=0),
	CONSTRAINT discount_valid CHECK (discount>0)
);

---te muestra las funciones

INSERT INTO users.users (name_user, password_user) VALUES
('user1', 'password1'),
('user2', 'password2'),
('user3', 'password3'),
('user4', 'password4'),
('user5', 'password5'),
('user6', 'password6'),
('user7', 'password7'),
('user8', 'password8'),
('user9', 'password9'),
('user10', 'password10');

SELECT * FROM users.employee;

INSERT INTO users.employee (id_users, name_employee, ap_paterno, ap_materno) VALUES
(1, 'John', 'Doe', 'Smith'),
(2, 'Jane', 'Doe', 'Johnson'),
(3, 'Jake', 'Smith', 'Brown'),
(4, 'Emily', 'Davis', 'Wilson'),
(5, 'Michael', 'Jones', 'Taylor'),
(6, 'Sarah', 'Brown', 'Lee'),
(7, 'David', 'Johnson', 'Harris'),
(8, 'Laura', 'Moore', 'Martin'),
(9, 'James', 'Taylor', 'Clark'),
(10, 'Olivia', 'Lewis', 'Walker');

SELECT * FROM users.position;

INSERT INTO users.position (name_position, description_position) VALUES
('Gerente', 'Responsable de supervisar las operaciones'),
('Empleado', 'Trabaja bajo gestión y se encarga de las tareas diarias.'),
('Administrador', 'Tiene acceso de administrador del sistema'),
('Recursos Humanos', 'Maneja recursos humanos y personal.'),
('Vendedor', 'Vende productos a los clientes'),
('Cajero', 'Maneja la caja registradora y las transacciones.'),
('Supervisor', 'Supervisa el trabajo de los empleados.'),
('Técnico', 'Se encarga del mantenimiento y reparación de sistemas.'),
('Marketing', 'Maneja la publicidad y la interacción con el cliente.'),
('Soporte', 'Proporciona servicio y soporte al cliente.');

SELECT * FROM store.item;

INSERT INTO store.item (name_item, description_item) VALUES
('Laptop', 'Portátil de alto rendimiento para profesionales'),
('Smartphone', 'Teléfono inteligente de último modelo con funciones avanzadas'),
('Tablet', 'Tableta portátil para entretenimiento y trabajo.'),
('Auriculares', 'Auriculares inalámbricos con cancelación de ruido'),
('Monitor', 'Monitor LED de 24 pulgadas para oficina en casa'),
('Mouse', 'Ratón inalámbrico con diseño ergonómico'),
('Teclado', 'Teclado mecánico con retroiluminación'),
('Smartwatch', 'Reloj inteligente con seguimiento de actividad física y notificaciones'),
('Camara', 'Cámara digital para entusiastas de la fotografía.'),
('Speaker', 'Altavoz Bluetooth con graves profundos');

SELECT * FROM store.store;

INSERT INTO store.store (id_user, id_item, motion, amount_store, final_amount) VALUES
(1, 1, 'i', 10, 50),
(2, 2, 'i', 20, 40),
(3, 3, 'i', 15, 35),
(4, 4, 'i', 25, 75),
(5, 5, 's', 5, 15),
(6, 6, 's', 10, 30),
(7, 7, 's', 5, 15),
(8, 8, 'i', 50, 100),
(9, 9, 'i', 30, 90),
(10, 10, 's', 8, 24);

SELECT * FROM sale.client;

INSERT INTO sale.client (name_client) VALUES
('Client A'),
('Client B'),
('Client C'),
('Client D'),
('Client E'),
('Client F'),
('Client G'),
('Client H'),
('Client I'),
('Client J');

SELECT * FROM sale.sale_detail;

INSERT INTO sale.sale_detail (id_item, cost_detail, amount) VALUES
(1, 1000, 2),
(2, 800, 1),
(3, 500, 3),
(4, 200, 4),
(5, 300, 2),
(6, 150, 5),
(7, 250, 1),
(8, 150, 6),
(9, 120, 3),
(10, 100, 4);

INSERT INTO sale.sale (id_user, id_client, id_detail, stock) VALUES
(1, 1, 1, 5),
(2, 2, 2, 10),
(3, 3, 3, 4),
(4, 4, 4, 8),
(5, 5, 5, 6),
(6, 6, 6, 3),
(7, 7, 7, 2),
(8, 8, 8, 7),
(9, 9, 9, 9),
(10, 10, 10, 1);

SELECT * FROM sale.sale; ---te muestra las tablas

INSERT INTO buys.buys_supplier (supplier_name, company_name, email, number_phone) VALUES
('Supplier 1', 'Company A', 'supplier1@company.com', '12345678'),
('Proveedor 2', 'Empresa B', 'supplier2@company.com', '23456789'),
('Supplier 3', 'Company C', 'supplier3@company.com', '34567890'),
('Supplier 4', 'Company D', 'supplier4@company.com', '45678901'),
('Supplier 5', 'Company E', 'supplier5@company.com', '56789012'),
('Supplier 6', 'Company F', 'supplier6@company.com', '67890123'),
('Supplier 7', 'Company G', 'supplier7@company.com', '78901234'),
('Supplier 8', 'Company H', 'supplier8@company.com', '89012345'),
('Supplier 9', 'Company I', 'supplier9@company.com', '90123456'),
('Supplier 10', 'Company J', 'supplier10@company.com', '01234567');

SELECT * FROM buys.buys_supplier;


SELECT * FROM promotion.promotion;

INSERT INTO promotion.promotion (id_item, amount_promotion, discount) VALUES
(1, 10, 5),
(2, 15, 10),
(3, 20, 5),
(4, 30, 15),
(5, 25, 10),
(6, 35, 20),
(7, 40, 10),
(8, 50, 25),
(9, 60, 30),
(10, 70, 20);

SELECT * FROM buys.buys_detail;

INSERT INTO buys.buys_detail (id_item, cost_detail, amount_detail) VALUES
(1, 900, 5),
(2, 700, 8),
(3, 450, 10),
(4, 180, 12),
(5, 220, 15),
(6, 120, 20),
(7, 230, 6),
(8, 140, 25),
(9, 100, 30),
(10, 90, 7);

SELECT * FROM buys.buys;

INSERT INTO buys.buys (id_user, id_buys_detail, id_buys_supplier) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);

 SELECT p.name_product AS nombre FROM product p;

 --- que promociones ha tenido un producto x?
 SELECT 
 
SELECT p.id, p.date_promotion, p.amount_promotion, p.discount
FROM promotion.promotion p
WHERE p.id_item = 5;
 
--- mostrar las ventas realizadas por un usuario x.

SELECT 
    s.id AS sale_id,
    s.date_sale,
    s.stock,
    c.name_client,
    sd.id_item,
    sd.cost_detail,
    sd.amount,
    i.name_item
FROM 
    sale.sale s
JOIN 
    sale.client c ON s.id_client = c.id
JOIN 
    sale.sale_detail sd ON s.id_detail = sd.id
JOIN 
    store.item i ON sd.id_item = i.id
WHERE 
    s.id_user = 1;


--- mostrar la lista de empleados en un usuario x?

SELECT 
    e.id AS employee_id,
    e.name_employee,
    e.ap_paterno,
    e.ap_materno,
    u.name_user
FROM 
    users.employee e
JOIN 
    users.users u ON e.id_users = u.id
WHERE 
    u.id = 1;

--- mostrar una lista de empleados que allá realizado una compra y saber el cargo.

SELECT 
    e.id AS employee_id,
    e.name_employee,
    e.ap_paterno,
    e.ap_materno,
    p.name_position,
    b.id AS buy_id,
    b.date_buys
FROM 
    users.employee e
JOIN 
    users.contrat c ON e.id = c.id_employee  -- Relacionamos la tabla de empleados con la de contratos
JOIN 
    users.position p ON c.id_position = p.id  -- Obtenemos la posición desde el contrato
JOIN 
    users.users u ON e.id_users = u.id  -- Relacionamos el empleado con el usuario
JOIN 
    buys.buys b ON u.id = b.id_user  -- Relacionamos el usuario con las compras realizadas
ORDER BY 
    e.id;

--- saber cuanto queda de un producto x.

SELECT 
    i.name_item,
    (COALESCE(SUM(CASE WHEN s.motion = 'i' THEN s.amount_store ELSE 0 END), 0) - 
     COALESCE(SUM(CASE WHEN sa.stock IS NOT NULL THEN sa.stock ELSE 0 END), 0)) AS remaining_stock
FROM 
    store.item i
LEFT JOIN 
    store.store s ON i.id = s.id_item
LEFT JOIN 
    sale.sale sa ON sa.id_detail IN (SELECT id FROM sale.sale_detail WHERE id_item = i.id)
WHERE 
    i.id = 1
GROUP BY 
    i.id, i.name_item;


---mostrar la lista de proveedores que venden un producto x.

SELECT 
    b.supplier_name, 
    b.company_name, 
    b.email, 
    b.number_phone
FROM 
    buys.buys bu
JOIN 
    buys.buys_detail bd ON bu.id_buys_detail = bd.id  -- Relacionamos las compras con los detalles de la compra
JOIN 
    buys.buys_supplier b ON bu.id_buys_supplier = b.id  -- Relacionamos las compras con los proveedores
JOIN 
    store.item i ON bd.id_item = i.id  -- Relacionamos los detalles de compra con los productos
WHERE 
    i.name_item = 'Producto X';


---saber cuanto ha sido el ingreso por ventas realizadas por un mes x.

SELECT 
    EXTRACT(MONTH FROM s.date_sale) AS month,
    EXTRACT(YEAR FROM s.date_sale) AS year,
    SUM(sd.cost_detail * s.stock) AS total_income
FROM 
    sale.sale s
JOIN 
    sale.sale_detail sd ON s.id_detail = sd.id  -- Relacionamos la venta con los detalles de la venta
GROUP BY 
    EXTRACT(MONTH FROM s.date_sale), EXTRACT(YEAR FROM s.date_sale)
ORDER BY 
    year, month;

----conocer el producto mas vendido.

SELECT 
    i.name_item, 
    SUM(s.stock) AS total_sold
FROM 
    sale.sale s
JOIN 
    sale.sale_detail sd ON s.id_detail = sd.id  -- Relacionamos las ventas con los detalles
JOIN 
    store.item i ON sd.id_item = i.id  -- Relacionamos los detalles con los productos
GROUP BY 
    i.name_item
ORDER BY 
    total_sold DESC
LIMIT 1;

---conocer al cliente que mas productos ha comprado.

SELECT 
    c.name_client, 
    SUM(sd.amount) AS total_products_bought
FROM 
    sale.sale s
JOIN 
    sale.sale_detail sd ON s.id_detail = sd.id  -- Relacionamos la venta con los detalles de la venta
JOIN 
    sale.client c ON s.id_client = c.id  -- Relacionamos las ventas con los clientes
GROUP BY 
    c.name_client
ORDER BY 
    total_products_bought DESC
LIMIT 1;

---conocer al cliente con el costo mas alto de compra.

SELECT 
    c.name_client, 
    SUM(sd.cost_detail * sd.amount) AS total_spent
FROM 
    sale.sale s
JOIN 
    sale.sale_detail sd ON s.id_detail = sd.id  -- Relacionamos la venta con los detalles de la venta
JOIN 
    sale.client c ON s.id_client = c.id  -- Relacionamos las ventas con los clientes
GROUP BY 
    c.name_client
ORDER BY 
    total_spent DESC
LIMIT 1;

---mostrar la cantidad de clientes que se tiene.

SELECT 
    COUNT(*) AS total_clients
FROM 
    sale.client;


---mostrar los productos con un stock menor a 10.

SELECT 
    i.name_item, 
    s.amount_store AS stock
FROM 
    store.store s
JOIN 
    store.item i ON s.id_item = i.id  -- Relacionamos los productos con su nombre
WHERE 
    s.amount_store < 10;


 