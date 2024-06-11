begin;

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

commit;