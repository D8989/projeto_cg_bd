
begin;
--rollback;
create table sistema_controle.marca (
	id serial,
	nome varchar(50) not null,
	nome_unique varchar(50) not null,
	descricao varchar(250) null,
	constraint marca_id_pkey primary key(id),
	constraint marca_nm_unq unique (nome_unique)
);

commit;