begin;

create schema if not exists sistema_controle;

create table sistema_controle.tipo_item_base (
    id serial,
    nome varchar(50) not null,
    nome_unique varchar(50) not null,
    descricao varchar(255),
	criado_em timestamptz default now(),
	atualizado_em timestamptz null,
	desativado_em timestamptz null,
    constraint tipo_item_base_id_pkey primary key (id),
    constraint tipo_item_base_n_unq unique (nome)
);

create table sistema_controle.item_base (
    id serial,
    tipo_item_base_id integer not null,
    nome varchar(50) not null,
    nome_unique varchar(50) not null,
    descricao varchar(255),
	criado_em timestamptz default now(),
	atualizado_em timestamptz null,
	desativado_em timestamptz null,
    constraint item_base_id_pkey primary key (id),
    constraint item_base_tib_id_tipo_item_base_id_fkey foreign key (tipo_item_base_id)
        references sistema_controle.tipo_item_base (id),
    constraint item_base_n_unq_de unique (nome, desativado_em)
);

create table sistema_controle.marca (
	id serial,
	nome varchar(50) not null,
	nome_unique varchar(50) not null,
	descricao varchar(250) null,
	criado_em timestamptz default now(),
	atualizado_em timestamptz null,
	desativado_em timestamptz null,
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
	quantidade integer,
	gramatura varchar(10),
	criado_em timestamptz default now(),
	atualizado_em timestamptz null,
	desativado_em timestamptz null,
	has_embalagem boolean not null default TRUE,
	constraint produto_id_pkey primary key(id),
	constraint produto_nu_m_id_ib_id_q_de_unq unique (nome_unique, marca_id, item_base_id, quantidade, desativado_em),
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

create table sistema_controle.loja (
	id serial,
	nome varchar(100) not null,
	nome_unique varchar(100) not null,
	apelido varchar(100) not null,
	tipo_loja_id integer not null,
	rua varchar(200) not null,
	numero varchar(10) not null default 'n/a',
	cep varchar(20) not null default '00000000',
	bairro varchar(50) not null,
	cidade varchar(50) not null,
	referencia varchar(100) not null default 'n/a',
	criado_em timestamptz default now(),
	atualizado_em timestamptz null,
	desativado_em timestamptz null,
	constraint loja_id_pkey primary key(id),
	constraint loja_id_tl_id_fkey foreign key(tipo_loja_id)
		references sistema_controle.tipo_loja(id)
		on update cascade
		on delete no action,
	constraint loja_nu_de_uniq unique(nome_unique, desativado_em)
);
comment on table sistema_controle.loja is 'LOJA onde é feito as compras';

create table sistema_controle.tipo_loja (
	id serial,
	nome varchar(100) not null,
	nome_unique varchar(100) not null,
	descricao varchar(200) null,
	criado_em timestamptz default now(),
	atualizado_em timestamptz null,
	desativado_em timestamptz null,
	constraint tipo_loja_id_pkey primary key(id),
	constraint tipo_loja_nu_de_uniq unique(nome_unique, desativado_em)
);

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
	constraint usuario_id_pkey primary key (id)
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