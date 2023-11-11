USE gotruck;

CREATE TABLE personas(
    id bigint unsigned primary key,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    updated_at datetime,-- por laravel
    deleted_at datetime,-- por laravel
    created_at datetime, -- por laravel
	foreign key (id) references users (id) -- la tabla de users sale de laravel
);

CREATE TABLE gerentes(
    id bigint unsigned primary key,
    updated_at datetime,-- por laravel
    deleted_at datetime,-- por laravel
    created_at datetime,-- por laravel
    foreign key (id) references personas(id)
);

CREATE TABLE administradores(
    id bigint unsigned primary key,
    updated_at datetime,-- por laravel
    deleted_at datetime,-- por laravel
    created_at datetime,-- por laravel
    foreign key (id) references personas(id)
);

CREATE TABLE conductores(
    id bigint unsigned primary key,
    updated_at datetime,-- por laravel
    deleted_at datetime,-- por laravel
    created_at datetime,-- por laravel
    foreign key (id) references personas(id)
);

CREATE TABLE funcionarios(
    id bigint unsigned primary key,
    updated_at datetime,-- por laravel
    deleted_at datetime,-- por laravel
    created_at datetime,-- por laravel
    foreign key (id) references personas(id)
);

CREATE VIEW personas_roles AS
    SELECT id, "gerente" rol from gerentes
    UNION
    SELECT id, "administrador" rol from administradores
    UNION
    SELECT id, "funcionario" rol from funcionarios
    UNION
    SELECT id, "conductor" rol from conductores;
    
CREATE TABLE alojamientos(
    id serial primary key,
    direccion varchar(100) unique not null,
    updated_at datetime,-- por laravel
    deleted_at datetime,-- por laravel
    created_at datetime-- por laravel
);

CREATE TABLE almacenes(
    id bigint unsigned primary key,
    updated_at datetime,-- por laravel
    deleted_at datetime,-- por laravel
    created_at datetime,-- por laravel
    foreign key (id) references alojamientos(id)
);

CREATE TABLE sedes(
    id bigint unsigned primary key,
    updated_at datetime,-- por laravel
    deleted_at datetime,-- por laravel
    created_at datetime,-- por laravel
    foreign key (id) references alojamientos(id)
);

CREATE VIEW alojamientos_tipos AS
    SELECT id, "sede" tipo from sedes
    UNION
    SELECT id, "almacén" tipo from almacenes;
    
CREATE TABLE paquetes(
    id serial primary key,
    peso_en_kg smallint not null,
    email varchar(70) not null,
    destino bigint unsigned not null,
    updated_at datetime,-- por laravel
    deleted_at datetime,-- por laravel
    created_at datetime,-- por laravel
    foreign key (destino) references sedes(id)
);

CREATE TABLE lotes(
    id serial primary key,
    destino bigint unsigned not null,
    updated_at datetime,-- por laravel
    deleted_at datetime,-- por laravel
    created_at datetime,-- por laravel
    foreign key (destino) references sedes(id)
);

CREATE TABLE lote_formado_por(
	id_paquete bigint unsigned primary key,
    id_lote bigint unsigned not null,
    updated_at datetime,-- por laravel
    created_at datetime,-- por laravel
    foreign key (id_lote) references lotes(id),
    foreign key (id_paquete) references paquetes(id)
);

CREATE TABLE vehiculos(
	id serial primary key,
	capacidad_en_toneladas smallint not null,
	updated_at datetime,-- por laravel
    created_at datetime,-- por laravel
    deleted_at datetime-- por laravel
);

CREATE TABLE camiones(
	id_vehiculo bigint unsigned primary key,
	foreign key (id_vehiculo) references vehiculos(id)
);

CREATE TABLE conductor_maneja(
	id_conductor bigint unsigned primary key,
    id_vehiculo bigint unsigned not null unique,
    foreign key (id_vehiculo) references vehiculos(id),
    foreign key (id_conductor) references conductores(id)
);

CREATE TABLE pickups(
	id_vehiculo bigint unsigned primary key,
	foreign key (id_vehiculo) references vehiculos(id)
);

CREATE TABLE lote_asignado_a_camion(
	id_lote bigint unsigned primary key,
    id_camion bigint unsigned not null,
	updated_at datetime,-- por laravel
    created_at datetime,-- por laravel
    deleted_at datetime,-- por laravel
    foreign key (id_lote) references lotes(id),
    foreign key (id_camion) references camiones(id_vehiculo)
);

CREATE TABLE paquete_asignado_a_pickup(
	id_paquete bigint unsigned primary key,
    id_pickup bigint unsigned not null,
	updated_at datetime,-- por laravel
    created_at datetime,-- por laravel
    deleted_at datetime,-- por laravel
    foreign key (id_paquete) references paquetes(id),
    foreign key (id_pickup) references pickups(id_vehiculo)
);

CREATE VIEW vehiculos_tipos AS
    SELECT id_vehiculo, "camión" tipo from camiones
    UNION
    SELECT id_vehiculo, "pickup" tipo from pickups;

CREATE TABLE traducciones(
	id bigint,
    texto varchar(1000) not null,
    idioma enum('es', 'en'),
    primary key (id, idioma)
);

/* TITULOS */
INSERT INTO traducciones VALUES (1, "GoTruck - Iniciar sesión", "es");
INSERT INTO traducciones VALUES (1, "GoTruck - Log in", "en");

/* HEADER */
INSERT INTO traducciones VALUES (100, "Cerrar sesión", "es");
INSERT INTO traducciones VALUES (100, "Sign out", "en");

/* GENERAL */
INSERT INTO traducciones VALUES (415, "Volver", "es");
INSERT INTO traducciones VALUES (415, "Back", "en");

/* FOOTER */
INSERT INTO traducciones VALUES (200, "Política y privacidad", "es");
INSERT INTO traducciones VALUES (200, "Policy and privacy", "en");
INSERT INTO traducciones VALUES (201, "Contacto", "es");
INSERT INTO traducciones VALUES (201, "Contact", "en");
INSERT INTO traducciones VALUES (202, "Todos los derechos reservados", "es");
INSERT INTO traducciones VALUES (202, "All rights reserved", "en");

/* PÁGINA DE INICIO DE SESIÓN */
INSERT INTO traducciones VALUES (300, "Iniciar sesión", "es");
INSERT INTO traducciones VALUES (300, "Log in", "en");
INSERT INTO traducciones VALUES (301, "Datos para iniciar sesión", "es");
INSERT INTO traducciones VALUES (301, "Login information", "en");
INSERT INTO traducciones VALUES (302, "Inicie sesión para acceder al sitio", "es");
INSERT INTO traducciones VALUES (302, "Log in to access the site", "en");
INSERT INTO traducciones VALUES (303, "Contraseña", "es");
INSERT INTO traducciones VALUES (303, "Password", "en");
INSERT INTO traducciones VALUES (304, "Ha ocurrido un error. Revise los campos por favor.", "es");
INSERT INTO traducciones VALUES (304, "An error has ocurred. Please check your input.", "en");

/* PÁGINA PRINCIPAL */
INSERT INTO traducciones VALUES (400, "Aplicaciones", "es");
INSERT INTO traducciones VALUES (400, "Applications", "en");
INSERT INTO traducciones VALUES (401, "Seguimiento", "es");
INSERT INTO traducciones VALUES (401, "Tracking", "en");
INSERT INTO traducciones VALUES (402, "Ve el estado de una entrega buscándola por su id.", "es");
INSERT INTO traducciones VALUES (402, "View the status of a delivery by searching its id.", "en");
INSERT INTO traducciones VALUES (403, "Choferes", "es");
INSERT INTO traducciones VALUES (403, "Drivers", "en");
INSERT INTO traducciones VALUES (404, "Visualiza las entregas pendientes y el trayecto hacia la sede más cercana.", "es");
INSERT INTO traducciones VALUES (404, "View pending deliveries and the route to the nearest location.", "en");
INSERT INTO traducciones VALUES (405, "Almacén", "es");
INSERT INTO traducciones VALUES (405, "Warehouse", "en");
INSERT INTO traducciones VALUES (406, "Gestiona lotes con sus paquetes y asígnalos a un camión para ser entregados.", "es");
INSERT INTO traducciones VALUES (406, "Manage batches with your packages and assign them to a truck for delivery.", "en");
INSERT INTO traducciones VALUES (407, "Administración", "es");
INSERT INTO traducciones VALUES (407, "Administration", "en");
INSERT INTO traducciones VALUES (408, "Adéntrese en el mundo corporativo y gestione su equipo de trabajo.", "es");
INSERT INTO traducciones VALUES (408, "Join the corporate world and manage your team.", "en");

/* ALMACEN */
INSERT INTO traducciones VALUES (409, "GoTruck - Almacenes", "es");
INSERT INTO traducciones VALUES (409, "GoTruck - Warehouses", "en");
INSERT INTO traducciones VALUES (410, "Almacenes", "es");
INSERT INTO traducciones VALUES (410 , "Warehouses", "en");
INSERT INTO traducciones VALUES (411 , "Lotes", "es");
INSERT INTO traducciones VALUES (411 , "Batches", "en");
INSERT INTO traducciones VALUES (412, "Administra los lotes de las almacenes.", "es");
INSERT INTO traducciones VALUES (412, "Manage warehouse batches.", "en");
INSERT INTO traducciones VALUES (413, "Paquetes", "es");
INSERT INTO traducciones VALUES (413, "Packages", "en");
INSERT INTO traducciones VALUES (414, "Administra los paquetes de las almacenes.", "es");
INSERT INTO traducciones VALUES (414, "Manage warehouse packages.", "en");

/* LOTES */
INSERT INTO traducciones VALUES (416, "Crear", "es");
INSERT INTO traducciones VALUES (416, "Create", "en");
INSERT INTO traducciones VALUES (417, "Lotes", "es");
INSERT INTO traducciones VALUES (417, "Batches", "en");
INSERT INTO traducciones VALUES (418, "Información", "es");
INSERT INTO traducciones VALUES (418, "Information", "en");
INSERT INTO traducciones VALUES (419, "Id del lote:", "es");
INSERT INTO traducciones VALUES (419, "Batch Id:", "en");
INSERT INTO traducciones VALUES (420, "Peso (kg):", "es");
INSERT INTO traducciones VALUES (420, "Weight (kg):", "en");
INSERT INTO traducciones VALUES (421, "Vehiculo asignado:", "es");
INSERT INTO traducciones VALUES (421, "Assigned vehicle:", "en");
INSERT INTO traducciones VALUES (422, "Dirección destino:", "es");
INSERT INTO traducciones VALUES (422, "Destination address:", "en");
INSERT INTO traducciones VALUES (423, "Cantidad de paquetes:", "es");
INSERT INTO traducciones VALUES (423, "Package quantity:", "en");
INSERT INTO traducciones VALUES (424, "Crear lote", "es");
INSERT INTO traducciones VALUES (424, "Create batch", "en");
INSERT INTO traducciones VALUES (425, "Destino:", "es");
INSERT INTO traducciones VALUES (425, "Destination:", "en");
INSERT INTO traducciones VALUES (426, "Paquetes a agregar", "es");
INSERT INTO traducciones VALUES (426, "Packages to add", "en");
INSERT INTO traducciones VALUES (427, "Asignar", "es");
INSERT INTO traducciones VALUES (427, "Assign", "en");


/* PAQUETES */
INSERT INTO traducciones VALUES (428, "Paquetes", "es");
INSERT INTO traducciones VALUES (428, "Packages", "en");
INSERT INTO traducciones VALUES (429, "Id del paquete:", "es");
INSERT INTO traducciones VALUES (429, "Package Id:", "en");
INSERT INTO traducciones VALUES (430, "Fecha de modificación:", "es");
INSERT INTO traducciones VALUES (430, "Modification date:", "en");
INSERT INTO traducciones VALUES (431, "Lote asignado:", "es");
INSERT INTO traducciones VALUES (431, "Assigned batch", "en");
INSERT INTO traducciones VALUES (432, "Crear Paquetes", "es");
INSERT INTO traducciones VALUES (432, "Create Packages", "en");
INSERT INTO traducciones VALUES (433, "Peso(kg):", "es");
INSERT INTO traducciones VALUES (433, "Weight(kg):", "en");
INSERT INTO traducciones VALUES (434, "Lotes para asignar", "es");
INSERT INTO traducciones VALUES (434, "Batches to assign", "en");

/* 
INSERT INTO traducciones VALUES (, "", "es");
INSERT INTO traducciones VALUES (, "", "en");
*/

/* CHOFERES */
INSERT INTO traducciones VALUES (435, "Mostrar solo pendientes", "es");
INSERT INTO traducciones VALUES (435, "Show only pending", "en");
INSERT INTO traducciones VALUES (436, "Mostrar todos", "es");
INSERT INTO traducciones VALUES (436, "Show all", "en");
INSERT INTO traducciones VALUES (437, "¡Felicidades!", "es");
INSERT INTO traducciones VALUES (437, "Congratulations!", "en");
INSERT INTO traducciones VALUES (438, "No tienes entregas restantes por realizar.", "es");
INSERT INTO traducciones VALUES (438, "You have no remaining deliveries to make.", "en");
INSERT INTO traducciones VALUES (439, "Todas las entregas", "es");
INSERT INTO traducciones VALUES (439, "All deliveries", "en");
INSERT INTO traducciones VALUES (440, "Mapa con ruta", "es");
INSERT INTO traducciones VALUES (440, "Map with route", "en");



/* POLÍTICA DE PRIVACIDAD*/
INSERT INTO traducciones VALUES (435, "Política de privacidad", "es");
INSERT INTO traducciones VALUES (435, "Privacy policy", "en");
INSERT INTO traducciones VALUES (436, "Wistar se compremete a asegurar la protección de los datos de QuickCarry.", "es");
INSERT INTO traducciones VALUES (436, "Wistar is committed to ensuring the protection of QuickCarry data.", "en");
INSERT INTO traducciones VALUES (437, "Esto se cumplirá de multiples maneras:", "es");
INSERT INTO traducciones VALUES (437, "This will be accomplished in multiple ways:", "en");
INSERT INTO traducciones VALUES (438, "Wistar no revisará datos ingresados en GoTruck.", "es");
INSERT INTO traducciones VALUES (438, "Wistar will not review data entered into GoTruck.", "en");
INSERT INTO traducciones VALUES (439, "Wistar se asegurará de que ningún empleado deje código malicioso que les de acceso al sistema GoTruck.", "es");
INSERT INTO traducciones VALUES (439, "Wistar will ensure that no employees leave malicious code that gives them access to the GoTruck system.", "en");
INSERT INTO traducciones VALUES (440, "Una vez finalizado el desarrollo de GoTruck, los empleados necesitarán pedir una llave de acceso especial para poder acceder a la base de datos del sistema GoTruck o similares.", "es");
INSERT INTO traducciones VALUES (440, "Once GoTruck development is complete, employees will need to request a special access key to access the GoTruck system database or similar.", "en");
INSERT INTO traducciones VALUES (441, "Si cree que alguna de estas ha sido infringida por alguno de nuestros empleados y que sus datos pueden encontrarse en peligro no dude en inmediatamente contactar con soporte. Nuestro email de soporte para usted es wistar@gotruck-support.com.", "es");
INSERT INTO traducciones VALUES (441, "If you believe that any of these have been violated by any of our employees and that your data may be in danger, do not hesitate to immediately contact support. Our support email for you is wistar@gotruck-support.com.", "en");



# Crear usuarios

CREATE USER backoffice@localhost IDENTIFIED BY "1234";
GRANT SELECT, UPDATE, INSERT ON personas TO backoffice@localhost;
GRANT SELECT, UPDATE, INSERT ON users TO backoffice@localhost;
GRANT SELECT ON personas_roles TO backoffice@localhost;
GRANT SELECT, INSERT ON alojamientos TO backoffice@localhost;
GRANT INSERT ON sedes TO backoffice@localhost;
GRANT INSERT ON almacenes TO backoffice@localhost;
GRANT SELECT, INSERT ON alojamientos_tipos TO backoffice@localhost;
GRANT SELECT, INSERT, DELETE ON lote_formado_por TO backoffice@localhost;
GRANT SELECT, INSERT ON paquetes TO backoffice@localhost;
GRANT SELECT, INSERT ON lotes TO backoffice@localhost;
GRANT SELECT ON conductores TO backoffice@localhost;
GRANT SELECT, INSERT ON conductor_maneja TO backoffice@localhost;
GRANT SELECT ON vehiculos TO backoffice@localhost;

CREATE USER oauth@localhost IDENTIFIED BY "9876";
GRANT SELECT, INSERT ON users TO oauth@localhost;
GRANT INSERT, SELECT ON personas TO oauth@localhost;
GRANT INSERT ON conductores TO oauth@localhost;
GRANT INSERT ON administradores TO oauth@localhost;
GRANT INSERT ON funcionarios TO oauth@localhost;
GRANT SELECT ON personas_roles TO oauth@localhost;
GRANT INSERT ON gerentes TO oauth@localhost;
GRANT ALL ON password_resets TO oauth@localhost;
GRANT ALL ON failed_jobs TO oauth@localhost;
GRANT ALL ON personal_access_tokens TO oauth@localhost;
GRANT ALL ON migrations TO oauth@localhost;
GRANT ALL ON oauth_access_tokens TO oauth@localhost;
GRANT ALL ON oauth_auth_codes TO oauth@localhost;
GRANT ALL ON oauth_clients TO oauth@localhost;
GRANT ALL ON oauth_personal_access_clients TO oauth@localhost;
GRANT ALL ON oauth_refresh_tokens TO oauth@localhost;

CREATE USER almacen@localhost IDENTIFIED BY "abcd";
GRANT SELECT, INSERT ON paquetes TO almacen@localhost;
GRANT SELECT, INSERT ON lotes TO almacen@localhost;
GRANT SELECT ON sedes TO almacen@localhost;
GRANT SELECT, INSERT ON lote_formado_por TO almacen@localhost;
GRANT SELECT ON alojamientos TO almacen@localhost;
GRANT SELECT ON lote_asignado_a_camion TO almacen@localhost;

CREATE USER traductor@localhost IDENTIFIED BY "qwer";
GRANT SELECT ON traducciones TO traductor@localhost;