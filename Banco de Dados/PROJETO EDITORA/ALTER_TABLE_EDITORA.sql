-- ALTER

rename table editora_pinga.genero to genero_literario;
rename table editora_pinga.autor_has_livro to livro_autor;
rename table editora_pinga.livro_has_area_do_conhecimento to livro_area_do_conhecimento;
rename table editora_pinga.palavra_chave_has_livro to palavra_chave_livro;


alter table editora_pinga.funcionario 
	change column salario salario decimal(10,2) unsigned zerofill not null;
    
alter table editora_pinga.funcionario 
	change column salario salario decimal(7,2) unsigned not null;
    
alter table editora_pinga.endereco
	drop column complemento;

alter table editora_pinga.funcionario
add column ativo bool not null default true;

alter table editora_pinga.editora
add column ativo bool not null default true;

alter table editora_pinga.departamento 
change column descricao_atividade descricao text not null;

alter table editora_pinga.area_do_conhecimento
change area_do_conhecimento nome varchar(100);

alter table editora_pinga.area_do_conhecimento
change cod_area_do_conhecimento codigo varchar(20);

alter table editora_pinga.exemplares
change livro_id_livro livro_idlivro int;

alter table editora_pinga.cliente
add column nome_social varchar(100) null;



