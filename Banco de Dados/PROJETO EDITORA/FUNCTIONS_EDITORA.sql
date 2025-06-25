-- Função para calcular o total gasto somando todos os pedidos pelo ID do Cliente
create function fn_valor_total_pedidos_cliente(id_cliente int)
returns decimal(10,2)
deterministic
return (
    select ifnull(sum(v.valor_total), 0)
    from pedido p
    join venda v on v.pedido_idpedido = p.idpedido
    where p.cliente_idcliente = id_cliente
);

-- Função para calcular a quantidade de livros publicados por autor

create function fn_livros_por_autor(id_autor int)
returns int
deterministic
return (
    select count(*) 
    from autor_has_livro 
    where autor_idautor = id_autor
);

-- Função para contar quantas vendas foram feitas por um determinado funcionário.

create function fn_qtd_vendas_funcionario(id_funcionario int)
returns int
deterministic
return (
    select count(*) 
    from venda 
    where funcionario_idfuncionario = id_funcionario
);

-- Funçao para calcular quantos exemplares de um livro foram vendidos
create function fn_total_exemplares_vendidos_livro(id_livro int)
returns int
deterministic
return (
    select count(*) 
    from item_do_pedido i
    join exemplares e on e.numero_de_serie = i.exemplares_numero_de_serie
    where e.livro_id_livro = id_livro
);

-- Função para calular a quantidade de itens dentro de um pedido
create function fn_qtd_itens_pedido(id_pedido int)
returns int
deterministic
return (
    select count(*) 
    from item_do_pedido 
    where pedido_idpedido = id_pedido
);

-- Função para calular o valor total de um pedido com base nos exemplares

create function fn_valor_total_pedido(id_pedido int)
returns decimal(10,2)
deterministic
return (
    select sum(l.preco)
    from item_do_pedido i
    join exemplares e on e.numero_de_serie = i.exemplares_numero_de_serie
    join livro l on l.id_livro = e.livro_id_livro
    where i.pedido_idpedido = id_pedido
);

-- Função para Concatenar o endereço Completo

create function fn_endereco_formatado(id_endereco int)
returns text
deterministic
return (
    select concat(logradouro, ', ', numero, 
        if(complemento is not null, concat(' - ', complemento), ''), 
        ', ', bairro, ', ', cidade, '/', uf, ' - CEP: ', cep)
    from endereco
    where idendereco = id_endereco
);