-- UPDATE

SET SQL_SAFE_UPDATES = 0;

update editora_pinga.funcionario
	set salario = salario + (salario*0.1)
    where salario <= 3000;
    
update editora_pinga.funcionario
	set salario = 20000.00
    where nome like "%lucas%";
    
update editora_pinga.autor
set biografia = "nasci na cidade chamada update, e nunca errei um."
where idautor = 1;

update editora_pinga.cargo
set cargo = "Assistente de Analista Marketing"
where cargo = "Assistente de Marketing";

update editora_pinga.cargo
set cargo = "Assistente de Analista Marketing"
where cargo = "Assistente de Marketing";


UPDATE editora_pinga.funcionario
	set ativo = false
	where idfuncionario in 
    (select funcionario_idfuncionario from editora_pinga.trabalhar where dt_fim IS NOT NULL) and 
	idfuncionario not in(select funcionario_idfuncionario from editora_pinga.trabalhar where dt_fim IS NULL);
    
    
update editora_pinga.funcionario
set salario = salario + (salario*0.2)
where idfuncionario in (select funcionario_idfuncionario from editora_pinga.venda 
group by(funcionario_idfuncionario) 
having count(idvenda) > 20);

update editora_pinga.livro
set preco = preco - (preco*0.2)
where genero_idgenero in (1,2) and preco > 33.00;


update editora_pinga.pedido 
set `status` = "CAN"
where `status` = "ABE" AND cliente_idcliente % 2 = 0; 

update editora_pinga.funcionario
set nome = "casada Mariana Jurubeba Melo"
where email = "marijurubeba@hotail.com";


