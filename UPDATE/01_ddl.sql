begin;

alter table sistema_controle.produto
alter column quantidade type numeric(7,3);

commit;