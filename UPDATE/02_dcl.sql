begin;

grant all privileges on table sistema_controle.marca, sistema_controle.produto to usuario_api;
grant all privileges on all sequences in schema sistema_controle to usuario_api;

commit;