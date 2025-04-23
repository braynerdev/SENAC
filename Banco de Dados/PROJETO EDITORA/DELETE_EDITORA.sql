-- DELETE

start transaction;


delete from editora_pinga.funcionario 
where idfuncionario in (select funcionario_idfuncionario from editora_pinga.endereco where cidade like "%recife%");

delete from editora_pinga.autor
where nacionalidade like "brasileir%";

delete from editora_pinga.pedido
where `status` = "ABE";

delete from editora_pinga.reg_ponto
where DATE_FORMAT(dt_hora, '%m/%Y') = '01/2023';

delete from editora_pinga.exemplares
where localizacao_fisica_na_loja like "Prateleira Y%";

delete from editora_pinga.exemplares
where localizacao_fisica_na_loja like "Prateleira Y%" OR localizacao_fisica_na_loja like "Prateleira Z%";

delete from editora_pinga.telefone
where cliente_idcliente in (select idcliente from editora_pinga.cliente where idcliente > 30);

delete from editora_pinga.trabalhar 
where year(dt_fim) = "2024";


delete from editora_pinga.venda 
where date_format(dt_pagamento, "%d/%m/%Y") BETWEEN '09/04/2024' and '18/04/2024';

delete from editora_pinga.area_do_conhecimento
where nome like "M%";


# commit;
rollback;