begin;

-- Alterações na tabela produto
alter table sistema_controle.produto
alter column quantidade drop not null;

alter table sistema_controle.produto
alter column gramatura drop not null;

alter table sistema_controle.produto
add column has_embalagem boolean not null default true;

commit;