begin;

grant connect on database sistema_controle_compras to usuario_api;
grant usage on schema sistema_controle to usuario_api;
grant all privileges on all tables in schema sistema_controle to usuario_api;
grant all privileges on all sequences in schema sistema_controle to usuario_api;
grant all privileges on all functions in schema sistema_controle to usuario_api;
grant all privileges on all procedures in schema sistema_controle to usuario_api;
grant all privileges on all routines in schema sistema_controle to usuario_api;

commit;