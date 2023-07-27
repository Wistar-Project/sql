# Crear base de datos

CREATE DATABASE gotruck;
USE gotruck;

# Crear tablas 
# ejecutar php artisan migrate
# en ouath antes de crearlas

CREATE TABLE personas(
    id bigint unsigned primary key,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    updated_at datetime,
    deleted_at datetime,
    created_at datetime,
	foreign key (id) references users (id)
);

CREATE TABLE gerentes(
    id bigint unsigned primary key,
    updated_at datetime,
    deleted_at datetime,
    created_at datetime,
    foreign key (id) references personas(id)
);

CREATE TABLE administradores(
    id bigint unsigned primary key,
    updated_at datetime,
    deleted_at datetime,
    created_at datetime,
    foreign key (id) references personas(id)
);

CREATE TABLE conductores(
    id bigint unsigned primary key,
    updated_at datetime,
    deleted_at datetime,
    created_at datetime,
    foreign key (id) references personas(id)
);

CREATE TABLE funcionarios(
    id bigint unsigned primary key,
    updated_at datetime,
    deleted_at datetime,
    created_at datetime,
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
    deleted_at datetime,
    created_at datetime
);

CREATE TABLE almacenes(
    id bigint unsigned primary key,
    deleted_at datetime,
    created_at datetime,
    foreign key (id) references alojamientos(id)
);

CREATE TABLE sede_hogar(
    id bigint unsigned primary key,
    deleted_at datetime,
    created_at datetime,
    foreign key (id) references alojamientos(id)
);

CREATE TABLE sedes(
    id bigint unsigned primary key,
    deleted_at datetime,
    created_at datetime,
    foreign key (id) references sede_hogar(id)
);

CREATE TABLE hogares(
    id bigint unsigned primary key,
    deleted_at datetime,
    created_at datetime,
    foreign key (id) references sede_hogar(id)
);
CREATE VIEW alojamientos_tipos AS
    SELECT id, "sede" tipo from sedes
    UNION
    SELECT id, "almacén" tipo from almacenes
    UNION
    SELECT id, "hogar" tipo from hogares;
    
CREATE TABLE paquetes(
    id serial primary key,
    peso_en_kg smallint not null,
    destino bigint unsigned not null,
    deleted_at datetime,
    created_at datetime,
    foreign key (destino) references sede_hogar(id)
);

CREATE TABLE lotes(
    id serial primary key,
    destino bigint unsigned not null,
    deleted_at datetime,
    created_at datetime,
    foreign key (destino) references sedes(id)
);

CREATE TABLE lote_formado_por(
    id_lote bigint unsigned not null,
    id_paquete bigint unsigned not null,
    updated_at datetime,
    created_at datetime,
    foreign key (id_lote) references lotes(id),
    foreign key (id_paquete) references paquetes(id),
    primary key (id_lote, id_paquete)
);

# Crear usuarios

CREATE USER backoffice IDENTIFIED BY "1000";
GRANT SELECT, UPDATE, INSERT ON personas TO backoffice;
GRANT SELECT, UPDATE, INSERT ON users TO backoffice;
GRANT SELECT ON personas_roles TO backoffice;
GRANT SELECT, INSERT ON alojamientos TO backoffice;
GRANT INSERT ON sede_hogar TO backoffice;
GRANT INSERT ON sedes TO backoffice;
GRANT INSERT ON hogares TO backoffice;
GRANT INSERT ON almacenes TO backoffice;
GRANT SELECT, INSERT ON alojamientos_tipos TO backoffice;
GRANT SELECT, INSERT, DELETE ON lote_formado_por TO backoffice;
GRANT SELECT, INSERT ON paquetes TO backoffice;
GRANT SELECT, INSERT ON lotes TO backoffice;

CREATE USER oauth IDENTIFIED BY "2000";
GRANT SELECT, INSERT ON users TO oauth;
GRANT INSERT ON personas TO oauth;
GRANT INSERT ON conductores TO oauth;
GRANT INSERT ON administradores TO oauth;
GRANT INSERT ON funcionarios TO oauth;
GRANT ALL ON password_resets TO oauth;
GRANT ALL ON failed_jobs to oauth;
GRANT ALL ON personal_access_tokens TO oauth;

CREATE USER almacen IDENTIFIED BY "3000";
GRANT SELECT, INSERT ON paquetes TO almacen;
GRANT SELECT ON sede_hogar TO almacen;
GRANT SELECT, INSERT ON lotes TO almacen;
GRANT SELECT ON sedes TO almacen;
GRANT INSERT ON lote_formado_por TO almacen;