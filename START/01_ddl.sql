begin;

create schema if not exists sistema_controle;

create table sistema_controle.tipo_item_base (
    id serial,
    nome varchar(50) not null,
    nome_unique varchar(50) not null,
    descricao varchar(255).
    constraint tipo_item_base_id_pkey primary key (id),
    constraint tipo_item_base_n_unq unique (nome)
);

create table sistema_controle.item_base (
    id serial,
    tipo_item_base_id integer not null,
    nome varchar(50) not null,
    nome_unique varchar(50) not null,
    descricao varchar(255),
    constraint item_base_id_pkey primary key (id),
    constraint item_base_tib_id_tipo_item_base_id_fkey foreign key (tipo_item_base_id)
        references sistema_controle.tipo_item_base (id),
    constraint item_base_n_unq unique (nome)
);

create table sistema_controle.marca (
	id serial,
	nome varchar(50) not null,
	nome_unique varchar(50) not null,
	descricao varchar(250) null,
	constraint marca_id_pkey primary key(id),
	constraint marca_nm_unq unique (nome_unique)
);

commit;