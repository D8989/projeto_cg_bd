begin;

create table sistema_controle.compra (
	id serial,
	loja_id integer not null,
	codigo integer not null,
	data_compra timestamptz not null,
	criado_em timestamptz default now(),
	atualizado_em timestamptz null,
	desativado_em timestamptz null,
	constraint compra_id_pkey primary key(id),
	constraint compra_l_id_loja_id_fkey foreign key(loja_id)
		references sistema_controle.loja (id)
		on update cascade
		on delete no action,
	constraint compra_c_uniq unique(codigo)
);

create table sistema_controle.usuario (
	id serial,
	nome varchar(100) not null,
	nome_unique varchar(100) not null,
	constraint usuario_id_pkey primary key (id),
	constraint ususario_n_u_unq unique(nome_unique)
);

create table sistema_controle.pagamento (
	id serial,
	usuario_id integer not null,
	compra_id integer not null,
	valor numeric(6,2) not null,
	forma_pagamento varchar(10) not null,
	constraint pagamento_id_pkey primary key (id),
	constraint pagamento_u_ud_usuario_id_fkey foreign key (usuario_id)
		references sistema_controle.usuario (id)
		on update cascade
		on delete no action,
	constraint pagamento_c_id_compra_id_fkey foreign key (compra_id)
		references sistema_controle.compra (id)
		on update cascade
		on delete no action,
	constraint pagamento_u_id_c_id_unq unique(usuario_id, compra_id),
	constraint pagamento_fp_valid check(forma_pagamento in('DINHEIRO', 'DEBITO', 'CREDITO'))
);

create table sistema_controle.item_compra (
	id serial,
	produto_id integer not null,
	compra_id integer not null,
	quantidade numeric(7,3) not null,
	custo numeric(6,2) not null,
	gramatura varchar(10) not null,
	constraint item_compra_id_pk primary key(id),
	constraint item_compra_p_id_produto_id_fkey foreign key(produto_id)
		references sistema_controle.produto (id)
		on update cascade
		on delete no action,
	constraint item_compra_c_id_compra_id_fkey foreign key(compra_id)
		references sistema_controle.compra (id)
		on update cascade
		on delete no action,
	constraint item_compra_p_id_c_id_unq unique(produto_id, compra_id),
	constraint item_compra_quantidade_valid check (quantidade > 0),
	constraint item_compra_custo_valid check (custo > 0)
);

commit;