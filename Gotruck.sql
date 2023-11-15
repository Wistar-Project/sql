USE wistar;

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
INSERT INTO traducciones VALUES (415, "Go back", "en");

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

/* ALMACÉN-LOTES */
INSERT INTO traducciones VALUES (416, "Crear", "es");
INSERT INTO traducciones VALUES (416, "Create", "en");
INSERT INTO traducciones VALUES (417, "Lotes", "es");
INSERT INTO traducciones VALUES (417, "Batches", "en");
INSERT INTO traducciones VALUES (418, "Información", "es");
INSERT INTO traducciones VALUES (418, "Information", "en");
INSERT INTO traducciones VALUES (419, "ID del lote:", "es");
INSERT INTO traducciones VALUES (419, "Batch ID:", "en");
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


/* ALMACÉN-PAQUETES */
INSERT INTO traducciones VALUES (428, "Paquetes", "es");
INSERT INTO traducciones VALUES (428, "Packages", "en");
INSERT INTO traducciones VALUES (429, "ID del paquete:", "es");
INSERT INTO traducciones VALUES (429, "Package ID:", "en");
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
INSERT INTO traducciones VALUES (441, "Política de privacidad", "es");
INSERT INTO traducciones VALUES (441, "Privacy policy", "en");
INSERT INTO traducciones VALUES (442, "Wistar se compremete a asegurar la protección de los datos de QuickCarry.", "es");
INSERT INTO traducciones VALUES (442, "Wistar is committed to ensuring the protection of QuickCarry data.", "en");
INSERT INTO traducciones VALUES (443, "Esto se cumplirá de multiples maneras:", "es");
INSERT INTO traducciones VALUES (443, "This will be accomplished in multiple ways:", "en");
INSERT INTO traducciones VALUES (444, "Wistar no revisará datos ingresados en GoTruck.", "es");
INSERT INTO traducciones VALUES (444, "Wistar will not review data entered into GoTruck.", "en");
INSERT INTO traducciones VALUES (445, "Wistar se asegurará de que ningún empleado deje código malicioso que les de acceso al sistema GoTruck.", "es");
INSERT INTO traducciones VALUES (445, "Wistar will ensure that no employees leave malicious code that gives them access to the GoTruck system.", "en");
INSERT INTO traducciones VALUES (446, "Una vez finalizado el desarrollo de GoTruck, los empleados necesitarán pedir una llave de acceso especial para poder acceder a la base de datos del sistema GoTruck o similares.", "es");
INSERT INTO traducciones VALUES (446, "Once GoTruck development is complete, employees will need to request a special access key to access the GoTruck system database or similar.", "en");
INSERT INTO traducciones VALUES (447, "Si cree que alguna de estas ha sido infringida por alguno de nuestros empleados y que sus datos pueden encontrarse en peligro no dude en inmediatamente contactar con soporte. Nuestro email de soporte para usted es wistar@gotruck-support.com.", "es");
INSERT INTO traducciones VALUES (447, "If you believe that any of these have been violated by any of our employees and that your data may be in danger, do not hesitate to immediately contact support. Our support email for you is wistar@gotruck-support.com.", "en");

/* SEGUIMIENTO */
INSERT INTO traducciones VALUES (448, "GoTruck - Seguimiento", "es");
INSERT INTO traducciones VALUES (448, "GoTruck - Tracking", "en");
INSERT INTO traducciones VALUES (449, "Revisa el estado de lotes en camino como sus paquetes asignados.", "es");
INSERT INTO traducciones VALUES (449, "Check the status of batches on the way as well as their assigned packages.", "en");
INSERT INTO traducciones VALUES (450, "Revisa el estado de un paquete a donde está yendo y ve en que lote está asignado.", "es");
INSERT INTO traducciones VALUES (450, "Check the status of a package where it is going and see which batch it is assigned to.", "en");

/* SEGUIMIENTO-LOTES*/
INSERT INTO traducciones VALUES (451, "Seguimiento de lotes", "es");
INSERT INTO traducciones VALUES (451, "Batch tracking", "en");
INSERT INTO traducciones VALUES (452, "Buscar", "es");
INSERT INTO traducciones VALUES (452, "Search", "en");
INSERT INTO traducciones VALUES (453, "Información del lote", "es");
INSERT INTO traducciones VALUES (453, "Batch information", "en");
INSERT INTO traducciones VALUES (454, "Estado:", "es");
INSERT INTO traducciones VALUES (454, "Status:", "en");
INSERT INTO traducciones VALUES (455, "Camión asignado:", "es");
INSERT INTO traducciones VALUES (455, "Assigned truck:", "en");
INSERT INTO traducciones VALUES (456, "Conductor a cargo:", "es");
INSERT INTO traducciones VALUES (456, "Driver in charge:", "en");
INSERT INTO traducciones VALUES (457, "Paquetes asignados", "es");
INSERT INTO traducciones VALUES (457, "Assigned packages", "en");
INSERT INTO traducciones VALUES (458, "Buscar un lote", "es");
INSERT INTO traducciones VALUES (458, "Search a batch", "en");

/* SEGUMIENTO-PAQUETES*/
INSERT INTO traducciones VALUES (459, "Seguimiento de paquetes", "es");
INSERT INTO traducciones VALUES (459, "Package tracking", "en");
INSERT INTO traducciones VALUES (460, "Informacion del paquete", "es");
INSERT INTO traducciones VALUES (460, "Package information", "en");
INSERT INTO traducciones VALUES (461, "Vista en el mapa", "es");
INSERT INTO traducciones VALUES (461, "Map view", "en");
INSERT INTO traducciones VALUES (462, "Buscar un paquete", "es");
INSERT INTO traducciones VALUES (462, "Find a package", "en");

/* ADMINISTRACIÓN */
INSERT INTO traducciones VALUES (463, "Usuarios", "es");
INSERT INTO traducciones VALUES (463, "Users", "en");
INSERT INTO traducciones VALUES (464, "Registra nuevos usuarios en el sistema, listalos y elimina o edita otros.", "es");
INSERT INTO traducciones VALUES (464, "Register new users in the system, list them and delete or edit others.", "en");
INSERT INTO traducciones VALUES (465, "Transporte", "es");
INSERT INTO traducciones VALUES (465, "Transport", "en");
INSERT INTO traducciones VALUES (466, "Define los vehículos que posees y asigna choferes a cargo de ellos.", "es");
INSERT INTO traducciones VALUES (466, "Define the vehicles you own and assign drivers in charge of them.", "en");
INSERT INTO traducciones VALUES (467, "Paquetería", "es");
INSERT INTO traducciones VALUES (467, "Parcel", "en");
INSERT INTO traducciones VALUES (468, "Lista paquetes o lotes, edita los que necesites o elimina los que desees.", "es");
INSERT INTO traducciones VALUES (468, "List packages or batches, edit the ones you need or delete the ones you want.", "en");
INSERT INTO traducciones VALUES (469, "Sedes", "es");
INSERT INTO traducciones VALUES (469, "Headquarters", "en");
INSERT INTO traducciones VALUES (470, "Define todas las sedes de la empresa para poder asignar camiones hacia esa dirección.", "es");
INSERT INTO traducciones VALUES (470, "Define all company headquarters to be able to assign trucks to that address.", "en");

/* ADMINISTRACIÓN-PAQUETERÍA*/
INSERT INTO traducciones VALUES (471, "Administra los lotes de los almacenes.", "es");
INSERT INTO traducciones VALUES (471, "Manage warehouse batches.", "en");
INSERT INTO traducciones VALUES (472, "Administra los paquetes de los almacenes.", "es");
INSERT INTO traducciones VALUES (472, "Manage warehouse packages.", "en");

/* ADMINISTRACIÓN-LOTES*/
INSERT INTO traducciones VALUES (473, "Eliminar lote", "es");
INSERT INTO traducciones VALUES (473, "Delete batch", "en");
INSERT INTO traducciones VALUES (474, "Desasignar", "es");
INSERT INTO traducciones VALUES (474, "Unassign", "en");
INSERT INTO traducciones VALUES (475, "Eliminar", "es");
INSERT INTO traducciones VALUES (475, "Delete", "en");

/* ADMINISTRACIÓN-PAQUETES */
INSERT INTO traducciones VALUES (476, "Eliminar paquete", "es");
INSERT INTO traducciones VALUES (476, "Delete package", "en");
INSERT INTO traducciones VALUES (477, "Fecha de creación", "es");
INSERT INTO traducciones VALUES (477, "Creation date", "en");
INSERT INTO traducciones VALUES (510, "Información del paquete", "es");
INSERT INTO traducciones VALUES (510, "Package information", "en");

/* ADMINISTRACIÓN-SEDES */
INSERT INTO traducciones VALUES (478, "Crear sede", "es");
INSERT INTO traducciones VALUES (478, "Create headquarter", "en");
INSERT INTO traducciones VALUES (511, "Dirección", "es");
INSERT INTO traducciones VALUES (511, "Adress", "en");

/* ADMINISTRACIÓN-VEHÍCULOS*/
INSERT INTO traducciones VALUES (479, "Vehículos", "es");
INSERT INTO traducciones VALUES (479, "Vehicles", "en");
INSERT INTO traducciones VALUES (480, "Mostrar solo...", "es");
INSERT INTO traducciones VALUES (480, "Show only...", "en");
INSERT INTO traducciones VALUES (481, "Camiones", "es");
INSERT INTO traducciones VALUES (481, "Trucks", "en");
INSERT INTO traducciones VALUES (482, "Pickups", "es");
INSERT INTO traducciones VALUES (482, "Pickups", "en");
INSERT INTO traducciones VALUES (483, "Reiniciar filtro", "es");
INSERT INTO traducciones VALUES (483, "Reset filter", "en");
INSERT INTO traducciones VALUES (484, "Información del vehículo", "es");
INSERT INTO traducciones VALUES (484, "Vehicle information", "en");
INSERT INTO traducciones VALUES (485, "Tipo", "es");
INSERT INTO traducciones VALUES (485, "Type", "en");
INSERT INTO traducciones VALUES (486, "Conductor asignado", "es");
INSERT INTO traducciones VALUES (486, "Assigned driver", "en");
INSERT INTO traducciones VALUES (487, "Capacidad(t)", "es");
INSERT INTO traducciones VALUES (487, "Capacity(t)", "en");
INSERT INTO traducciones VALUES (488, "Lotes/Paquetes asignados", "es");
INSERT INTO traducciones VALUES (488, "Assigned Batches/Packages", "en");
INSERT INTO traducciones VALUES (489, "Lotes asignados", "es");
INSERT INTO traducciones VALUES (489, "Assigned batches", "en");
INSERT INTO traducciones VALUES (490, "Opciones", "es");
INSERT INTO traducciones VALUES (490, "Options", "en");
INSERT INTO traducciones VALUES (491, "Ver más información", "es");
INSERT INTO traducciones VALUES (491, "See more information", "en");
INSERT INTO traducciones VALUES (492, "Desasignar del vehículo", "es");
INSERT INTO traducciones VALUES (492, "Unassign from vehicle", "en");

/* ADMINSTRACIÓN-USUARIO*/
INSERT INTO traducciones VALUES (495, "Mostrar todos", "es");
INSERT INTO traducciones VALUES (495, "Show all", "en");
INSERT INTO traducciones VALUES (496, "Buscar por", "es");
INSERT INTO traducciones VALUES (496, "Look for", "en");
INSERT INTO traducciones VALUES (497, "Nombre", "es");
INSERT INTO traducciones VALUES (497, "Name", "en");
INSERT INTO traducciones VALUES (498, "Borrar filtro", "es");
INSERT INTO traducciones VALUES (498, "Delete filter", "en");
INSERT INTO traducciones VALUES (499, "Información del usuario", "es");
INSERT INTO traducciones VALUES (499, "User information", "en");
INSERT INTO traducciones VALUES (500, "Datos modificables", "es");
INSERT INTO traducciones VALUES (500, "Modifiable data", "en");
INSERT INTO traducciones VALUES (501, "Nombre completo", "es");
INSERT INTO traducciones VALUES (501, "Full name", "en");
INSERT INTO traducciones VALUES (502, "email", "es");
INSERT INTO traducciones VALUES (502, "e-mail", "en");
INSERT INTO traducciones VALUES (503, "Estado", "es");
INSERT INTO traducciones VALUES (503, "State", "en");
INSERT INTO traducciones VALUES (504, "Rol/es", "es");
INSERT INTO traducciones VALUES (504, "Role/s", "en");
INSERT INTO traducciones VALUES (505, "Foto de perfil:", "es");
INSERT INTO traducciones VALUES (505, "Profile picture:", "en");
INSERT INTO traducciones VALUES (506, "Guardar cambios", "es");
INSERT INTO traducciones VALUES (506, "Save Changes", "en");
INSERT INTO traducciones VALUES (507, "Eliminar usuario", "es");
INSERT INTO traducciones VALUES (507, "Delete user", "en");
INSERT INTO traducciones VALUES (508, "Contraseña", "es");
INSERT INTO traducciones VALUES (508, "Password", "en");
INSERT INTO traducciones VALUES (509, "Confirmación", "es");
INSERT INTO traducciones VALUES (509, "Confirmation", "en");
INSERT INTO traducciones VALUES (512, "Editar usuario", "es");
INSERT INTO traducciones VALUES (512, "Edit user", "en");
INSERT INTO traducciones VALUES (513, "Crear usuario", "es");
INSERT INTO traducciones VALUES (513, "Create user", "en");
INSERT INTO traducciones VALUES (514, "Apellido", "es");
INSERT INTO traducciones VALUES (514, "Last name", "en");
INSERT INTO traducciones VALUES (515, "Rol", "es");
INSERT INTO traducciones VALUES (515, "Role", "en");
INSERT INTO traducciones VALUES (516, "Administrador", "es");
INSERT INTO traducciones VALUES (516, "Administrator", "en");
INSERT INTO traducciones VALUES (517, "Funcionario", "es");
INSERT INTO traducciones VALUES (517, "Official", "en");
INSERT INTO traducciones VALUES (518, "Conductor", "es");
INSERT INTO traducciones VALUES (518, "Driver", "en");
INSERT INTO traducciones VALUES (519, "Confirmar", "es");
INSERT INTO traducciones VALUES (519, "Confirm", "en");
INSERT INTO traducciones VALUES (520, "Crear vehículo", "es");
INSERT INTO traducciones VALUES (520, "Create vehicle", "en");
INSERT INTO traducciones VALUES (521, "Camión", "es");
INSERT INTO traducciones VALUES (521, "Truck", "en");
INSERT INTO traducciones VALUES (522, "Peso (t)", "es");
INSERT INTO traducciones VALUES (522, "Weight (t)", "en");
INSERT INTO traducciones VALUES (523, "Eliminar vehículo", "es");
INSERT INTO traducciones VALUES (523, "Remove vehicle", "en");

