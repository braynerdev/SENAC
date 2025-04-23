-- SELECT

-- select de todas as tabelas
select * from editora_pinga.area_do_conhecimento;
select * from editora_pinga.autor;
select * from editora_pinga.cargo;
select * from editora_pinga.cliente;
select * from editora_pinga.departamento;
select * from editora_pinga.editora;
select * from editora_pinga.endereco;
select * from editora_pinga.exemplares;
select * from editora_pinga.ferias;
select * from editora_pinga.funcionario;
select * from editora_pinga.genero_literario;
select * from editora_pinga.item_do_pedido;
select * from editora_pinga.livro;
select * from editora_pinga.livro_area_do_conhecimento;
select * from editora_pinga.livro_autor;
select * from editora_pinga.palavra_chave;
select * from editora_pinga.palavra_chave_livro;
select * from editora_pinga.pedido;
select * from editora_pinga.reg_ponto;
select * from editora_pinga.telefone;
select * from editora_pinga.trabalhar;
select * from editora_pinga.venda;



-- Quantidade de editora cadastradas
SELECT count(ideditora) "QTD DE EDITORAS CADASTRADAS" FROM editora_pinga.editora 
    order by count(ideditora) desc;

-- Quantidade de livros cadastradas
SELECT count(id_livro) "QTD DE LIVROS CADASTRADAS" FROM editora_pinga.livro
    order by count(id_livro) desc;

-- QTD E % de livros cadastrados por editora
SELECT upper(e.editora) "EDITORA", count(l.id_livro) "QTD de livro", concat(ROUND(count(e.ideditora)*100/(select count(*) from editora_pinga.livro),2),"%") "% DE LIVROS POR EDITORA" from editora_pinga.editora e 
INNER JOIN livro l on e.ideditora = l.editora_ideditora
group by e.editora
order by count(l.id_livro) desc;


-- QTD E % DE LIVROS POR AREA DE CONHECIMENTO?
SELECT upper(a.nome) "AREA DO CONHECIMENTO", count(al.area_do_conhecimento_cod_area_do_conhecimento) "QTD LIVROS POR AREA DO CONHECIMENTO", concat(ROUND(COUNT(al.area_do_conhecimento_cod_area_do_conhecimento)*100/(SELECT COUNT(*) FROM editora_pinga.livro),2), "%") "% DE LIVROS POR AREA DO CONHECIMENTO" from editora_pinga.livro_area_do_conhecimento al
INNER JOIN area_do_conhecimento a on a.codigo = al.area_do_conhecimento_cod_area_do_conhecimento
group by al.area_do_conhecimento_cod_area_do_conhecimento
order by count(al.area_do_conhecimento_cod_area_do_conhecimento) desc;

-- QTD AUTOR
select count(idautor) "QTD AUTOR" from editora_pinga.autor;

-- QTD E % pelo sexo do autor
select replace(replace(sexo, 'F','Feminino'),'M','Masculino') "Gênero", COUNT(idautor) "QTD DE AUTOR POR GÊNERO", CONCAT(ROUND(COUNT(idautor) * 100 / (select COUNT(*) FROM editora_pinga.autor),2), "%") "% AUTOR POR GÊNERO"
FROM editora_pinga.autor 
group by sexo;


-- QTD E % DE LIVROS POR AUTOR 
select upper(a.nome) "AUTOR", COUNT(la.livro_id_livro) "QTD LIVRO POR AUTOR", CONCAT(ROUND(COUNT(la.livro_id_livro)*100/(select count(*) from editora_pinga.livro),2),"%") "% DE LIVROS POR AUTOR"
FROM editora_pinga.autor a inner join editora_pinga.livro_autor la on a.idautor = la.autor_idautor
group by a.nome
order by a.nome desc;

-- QTD DE AUTORES POR LIVROS 
select upper(l.titulo) "LIVROS", COUNT(la.autor_idautor) "QTD AUTOR POR LIVRO"
FROM editora_pinga.livro l inner join editora_pinga.livro_autor la on l.id_livro = la.livro_id_livro
group by l.titulo
order by COUNT(la.autor_idautor) desc;

-- FUNCIONARIOS
SELECT idfuncionario "ID",
regexp_replace(cpf, '([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{2})', '\\1.\\2.\\3-\\4') "CPF", 
upper(nome) "NOME", 
date_format(dt_nascimento, "%d/%m/%Y") "DATA NASCIMENTO", 
upper(email) "EMAIL", 
CONCAT( "R$ ",format(salario, 2,"de_DE")) "SALÁRIO", 
replace(replace(lower(sexo), 'f',"FEMININO"),'m',"MASCULINO") "GÊNERO", 
replace(replace(ativo, 1, "SIM"),0,"NÃO") "ATIVO" 
FROM editora_pinga.funcionario
order by nome;

-- funcionarios + enderecos
SELECT f.idfuncionario "ID FUNCIONÁRIO",
regexp_replace(f.cpf, '([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{2})', '\\1.\\2.\\3-\\4') "CPF", 
upper(f.nome) "NOME", 
date_format(f.dt_nascimento, "%d/%m/%Y") "DATA NASCIMENTO", 
upper(f.email) "EMAIL", 
CONCAT( "R$ ",format(f.salario, 2,"de_DE")) "SALÁRIO", 
replace(replace(lower(f.sexo), 'f',"FEMININO"),'m',"MASCULINO") "GÊNERO", 
replace(replace(f.ativo, 1, "SIM"),0,"NÃO") "ATIVO" ,
upper(e.logradouro) "LOGRADOURO",
e.numero "NÚMERO",
upper(e.bairro) "BAIRRO",
upper(e.cidade) "CIDADE",
upper(e.uf) "UF",
upper(e.cep) "CEP"
FROM editora_pinga.funcionario f inner join editora_pinga.endereco e on e.funcionario_idfuncionario = f.idfuncionario
order by nome;

-- funcionarios ativos + enderecos
SELECT f.idfuncionario "ID FUNCIONÁRIO", regexp_replace(f.cpf, '([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{2})', '\\1.\\2.\\3-\\4') "CPF", upper(f.nome) "NOME", 
date_format(f.dt_nascimento, "%d/%m/%Y") "DATA NASCIMENTO", upper(f.email) "EMAIL", CONCAT( "R$ ",format(f.salario, 2,"de_DE")) "SALÁRIO", 
replace(replace(lower(f.sexo), 'f',"FEMININO"),'m',"MASCULINO") "GÊNERO", replace(replace(f.ativo, 1, "SIM"),0,"NÃO") "ATIVO" ,upper(e.logradouro) "LOGRADOURO",
e.numero "NÚMERO", upper(e.bairro) "BAIRRO", upper(e.cidade) "CIDADE", upper(e.uf) "UF", upper(e.cep) "CEP"
FROM editora_pinga.funcionario f inner join editora_pinga.endereco e on e.funcionario_idfuncionario = f.idfuncionario
WHERE f.ativo = 1
order by nome;


-- QTD, %, MEDIA SALARIAL DE FUNCIONARIOS ATIVOS POR GENERO
select 
replace(replace(lower(sexo),'f',"FEMININO"),'m', "MACULINO") "GÊNERO", 
COUNT(idfuncionario) "QTD POR GÊNERO", 
CONCAT(ROUND(COUNT(idfuncionario)*100/(SELECT COUNT(*) FROM editora_pinga.funcionario) ,2),"%") "% POR GÊNERO",
CONCAT("R$ ", FORMAT(AVG(salario), 2, "de_DE")) "MEDIA SALARIAL POR GÊNERO"
FROM editora_pinga.funcionario 
WHERE editora_pinga.funcionario.ativo = 1
GROUP BY editora_pinga.funcionario.sexo;

-- MAIOR SALARIO
SELECT MAX(salario) "MAIOR SALÁRIO" FROM editora_pinga.funcionario WHERE editora_pinga.funcionario.ativo = 1;

-- MENOR SALARIO
SELECT MIN(salario) "MAIOR SALÁRIO" FROM editora_pinga.funcionario WHERE editora_pinga.funcionario.ativo = 1;


-- FUNCIONARIOS ATIVOS COM O MENOR SALARIO
SELECT idfuncionario "ID FUNCIONÁRIO",
UPPER(nome) "NOME", 
CONCAT("R$ ",FORMAT(salario,2,"de_DE")) "MAIOR SALÁRIO",
regexp_replace(cpf, '([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{2})', '\\1.\\2.\\3-\\4') "CPF",
date_format(dt_nascimento, "%d/%m/%Y") "DATA NASCIMENTO", 
upper(email) "EMAIL", 
CONCAT( "R$ ",format(salario, 2,"de_DE")) "SALÁRIO", 
replace(replace(lower(sexo), 'f',"FEMININO"),'m',"MASCULINO") "GÊNERO", 
replace(replace(ativo, 1, "SIM"),0,"NÃO") "ATIVO"
FROM editora_pinga.funcionario
where editora_pinga.funcionario.salario = (SELECT MIN(salario) FROM editora_pinga.funcionario WHERE editora_pinga.funcionario.ativo = 1)
AND editora_pinga.funcionario.ativo = 1
order by nome;

-- FUNCIONARIOS ATIVOS COM O MAIOR SALARIO
SELECT idfuncionario "ID FUNCIONÁRIO",
UPPER(nome) "NOME", 
CONCAT("R$ ",FORMAT(salario,2,"de_DE")) "MAIOR SALÁRIO",
regexp_replace(cpf, '([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{2})', '\\1.\\2.\\3-\\4') "CPF",
date_format(dt_nascimento, "%d/%m/%Y") "DATA NASCIMENTO", 
upper(email) "EMAIL", 
CONCAT( "R$ ",format(salario, 2,"de_DE")) "SALÁRIO", 
replace(replace(lower(sexo), 'f',"FEMININO"),'m',"MASCULINO") "GÊNERO", 
replace(replace(ativo, 1, "SIM"),0,"NÃO") "ATIVO"
FROM editora_pinga.funcionario
where editora_pinga.funcionario.salario = (SELECT MAX(salario) FROM editora_pinga.funcionario WHERE editora_pinga.funcionario.ativo = 1)
AND editora_pinga.funcionario.ativo = 1
order by nome;
 
 
-- QTD VENDAS POR MES DO VENDEDOR ATIVO
SELECT 
UPPER(f.nome) "NOME",
COUNT(v.idvenda) "QTD VENDAS", 
CONCAT("R$ ",FORMAT(SUM(v.valor_total),2,"de_DE")) "VALOR TOTAL DE VENDA POR VENDEDOR",
date_format(v.dt_pagamento, "%m/%Y") 
FROM editora_pinga.funcionario f
INNER JOIN editora_pinga.venda v on v.funcionario_idfuncionario = f.idfuncionario
WHERE f.ativo = 1
group by UPPER(f.nome),date_format(v.dt_pagamento, "%m/%Y")
order by date_format(v.dt_pagamento, "%m/%Y") desc, nome;


-- MAIOR VALOR DE UMA VENDA DE TODO O BANCO
SELECT 
upper(f.nome) "NOME", 
CONCAT("R$ ",FORMAT(MAX(v.valor_total),2,"de_DE")) "MAIOR VENDA",
date_format(MAX(v.dt_pagamento), "%d/%m/%Y") "DATA PAGAMENTO"
FROM editora_pinga.funcionario f 
inner join editora_pinga.venda v 
on v.funcionario_idfuncionario = f.idfuncionario
where v.valor_total = (select max(valor_total) from editora_pinga.venda)
group by f.nome;


-- CLIENTES CADASTRADOS
SELECT 
idcliente "ID", UPPER(nome) "NOME", 
CASE
when length(cpf_cnpj) = 11 THEN regexp_replace(cpf_cnpj, "([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{2})", "\\1.\\2.\\3-\\4")
ELSE regexp_replace(cpf_cnpj, "([0-9]{2})([0-9]{3})([0-9]{3})([0-9]{4}([0-9]{2}))", "\\1.\\2.\\3/\\5-\\4")
END AS "CPF|CNPJ",
date_format(dt_nascimento, "%d/%m/%Y") "DATA DE NASCIMENTO",
upper(email) "EMAIL",
CASE
when sexo != "n" then replace(replace(lower(sexo), 'f',"FEMININO"),'m',"MASCULINO")
else "EMPRESA"
END AS "GÊNERO",
upper(nome_social) "NOME SOCIAL"
FROM editora_pinga.cliente;



-- CLIENTES E QUANTO ELES JA GASTARAM
SELECT 
c.idcliente "ID",
UPPER(c.nome) "NOME", 
CASE
when length(c.cpf_cnpj) = 11 THEN regexp_replace(c.cpf_cnpj, '([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{2})', '\\1.\\2.\\3-\\4')
ELSE regexp_replace(c.cpf_cnpj, '([0-9]{2})([0-9]{3})([0-9]{3})([0-9]{4}([0-9]{2}))', '\\1.\\2.\\3/\\5-\\4')
END AS "CPF|CNPJ",
sum(v.valor_total) "VALOR TOTAL"
from editora_pinga.cliente c 
inner join editora_pinga.venda v on v.pedido_idpedido in (select idpedido from editora_pinga.pedido where cliente_idcliente = c.idcliente)
group by c.idcliente,c.nome
order by SUM(valor_total) desc;