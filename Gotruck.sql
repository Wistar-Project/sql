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