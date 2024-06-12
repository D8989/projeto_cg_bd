begin;

grant all privileges on table sistema_controle.loja, sistema_controle.tipo_loja to usuario_api;
grant all privileges on all sequences in schema sistema_controle to usuario_api;
grant all privileges on all functions in schema sistema_controle to usuario_api;
grant all privileges on all procedures in schema sistema_controle to usuario_api;
grant all privileges on all routines in schema sistema_controle to usuario_api;

commit;