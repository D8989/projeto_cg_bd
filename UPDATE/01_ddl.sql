
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

create table sistema_controle.produto (
	id serial,
	marca_id integer not null,
	item_base_id integer not null,
	nome varchar(50) not null,
	nome_unique varchar(50) not null,
	descricao varchar(250) null,
	quantidade integer not null,
	gramatura varchar(10) not null,
	constraint produto_id_pkey primary key(id),
	constraint produto_nu_m_id_ib_id_q_unq unique (nome_unique, marca_id, item_base_id, quantidade),
	constraint produto_m_id_fkey foreign key (marca_id)
		references sistema_controle.marca (id)
			on update cascade
			on delete no action,
	constraint produto_ib_id_fkey foreign key (item_base_id)
		references sistema_controle.item_base (id)
			on update cascade
			on delete no action,
	constraint produto_gramatura_valid check (gramatura in('Kg', 'g', 'l', 'ml'))
);
comment on table sistema_controle.produto is 'PRODUTO de um ITEM-BASE na tal MARCA';

commit;