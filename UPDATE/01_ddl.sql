
begin;
alter table sistema_controle.item_base
drop constraint item_base_n_unq;

alter table sistema_controle.item_base
add constraint item_base_n_unq_de unique (nome_unique, desativado_em);

commit;