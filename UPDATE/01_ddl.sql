begin;

alter table sistema_controle.produto
alter column quantidade type numeric(7,3);

alter table sistema_controle.produto
	drop constraint produto_gramatura_valid;

alter table sistema_controle.produto
	add constraint produto_gramatura_valid CHECK (gramatura::text = ANY (ARRAY['Kg'::character varying, 'g'::character varying, 'l'::character varying, 'ml'::character varying, 'unid'::character varying]::text[]));

commit;