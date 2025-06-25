

-- PROCEDURE 1 ADICIONA LIVROS, EDITORAS E GENEROS AO ESTOQUE DA EDITORA CASO JÁ NÃO EXISTA.

DELIMITER $$

CREATE PROCEDURE AdicionaLivroEstoque (
    IN p_isbn VARCHAR(17),
    IN p_numero_pag INT,
    IN p_descricao TEXT,
    IN p_titulo VARCHAR(255),
    IN p_subtitulo VARCHAR(255),
    IN p_dt_criacao DATE,
    IN p_genero_nome VARCHAR(45),
    IN p_editora_nome VARCHAR(100),
    IN p_preco DECIMAL(10,2)
)
BEGIN
    DECLARE v_idgenero INT;
    DECLARE v_ideditora INT;

    SELECT idgenero INTO v_idgenero
    FROM genero_literario
    WHERE genero = p_genero_nome
    LIMIT 1;

    IF v_idgenero IS NULL THEN
        INSERT INTO genero_literario (genero)
        VALUES (p_genero_nome);
        SET v_idgenero = LAST_INSERT_ID();
    END IF;

    SELECT ideditora INTO v_ideditora
    FROM editora
    WHERE editora = p_editora_nome
    LIMIT 1;

    IF v_ideditora IS NULL THEN
        INSERT INTO editora (editora, ativo)
        VALUES (p_editora_nome, 1);
        SET v_ideditora = LAST_INSERT_ID();
    END IF;

    INSERT INTO livro (
        isbn,
        numero_pag,
        descricao,
        titulo,
        subtitulo,
        dt_criacao,
        genero_idgenero,
        editora_ideditora,
        preco
    )
    VALUES (
        p_isbn,
        p_numero_pag,
        p_descricao,
        p_titulo,
        p_subtitulo,
        p_dt_criacao,
        v_idgenero,
        v_ideditora,
        p_preco
    );
END $$

DELIMITER ;

CALL AdicionaLivroEstoque(
    '978-85-7522-123-4',
    320,
    'Introdução ao MySQL com exemplos.',
    'MySQL Essencial',
    'Do básico ao avançado',
    '2025-06-21',
    'Banco de Dados',
    'Alta Books',
    79.90
);

-- PROCEDURE 2 EXIBE RELATORIO DE VENDA POR PERIODO ESPECIFICO


DELIMITER $$
CREATE PROCEDURE RelatorioVendasPeriodo(
    IN data_inicio DATE,
    IN data_fim DATE
)
BEGIN
    SELECT
        v.idvenda AS 'Venda ID',
        DATE(v.dt_pagamento) AS 'Data Pagamento',
        c.nome AS 'Cliente',
        f.nome AS 'Funcionário',
        v.valor_total AS 'Total (R$)',
        COUNT(ip.iditem_do_pedido) AS 'Itens Vendidos'
    FROM venda v
    JOIN pedido p ON v.pedido_idpedido = p.idpedido
    JOIN cliente c ON p.cliente_idcliente = c.idcliente
    JOIN funcionario f ON v.funcionario_idfuncionario = f.idfuncionario
    JOIN item_do_pedido ip ON p.idpedido = ip.pedido_idpedido
    WHERE v.dt_pagamento BETWEEN data_inicio AND data_fim
    GROUP BY v.idvenda
    ORDER BY v.dt_pagamento DESC;
END $$
DELIMITER ;

CALL RelatorioVendasPeriodo('2025-01-01', '2025-12-31');


-- PROCEDURE 3 GERA UM RELATORIO DE DESEMPENHO DE CADA FUNCIONARIO COM RELAÇÃO A SUAS VENDAS

DELIMITER $$
CREATE PROCEDURE DesempenhoVendasFuncionarios(
    IN data_inicio DATE,
    IN data_fim DATE
)
BEGIN
    SELECT
        f.nome AS 'Funcionário',
        d.departamento AS 'Departamento',
        COUNT(v.idvenda) AS 'Vendas Realizadas',
        SUM(v.valor_total) AS 'Total Vendido (R$)'
    FROM venda v
    JOIN funcionario f ON v.funcionario_idfuncionario = f.idfuncionario
    JOIN trabalhar t ON f.idfuncionario = t.funcionario_idfuncionario
    JOIN departamento d ON t.departamento_iddepartamento = d.iddepartamento
    WHERE v.dt_pagamento BETWEEN data_inicio AND data_fim
        AND t.dt_fim IS NULL -- Posição atual
    GROUP BY f.idfuncionario, f.nome, d.departamento
    ORDER BY SUM(v.valor_total) DESC;
END $$
DELIMITER ;


CALL DesempenhoVendasFuncionarios('2025-01-01', '2025-03-31');

-- PROCEDURE 4 GERA RELATORIO DE HISTORICO DE COMPAS POR CLIENTES

DELIMITER $$
CREATE PROCEDURE HistoricoComprasCliente(
    IN cliente_id INT
)
BEGIN
    SELECT
        c.nome AS 'Cliente',
        p.idpedido AS 'Pedido ID',
        DATE(p.dt_criacao) AS 'Data Pedido',
        l.titulo AS 'Livro',
        COUNT(ip.iditem_do_pedido) AS 'Itens',
        v.valor_total AS 'Total (R$)'
    FROM cliente c
    JOIN pedido p ON c.idcliente = p.cliente_idcliente
    JOIN venda v ON p.idpedido = v.pedido_idpedido
    JOIN item_do_pedido ip ON p.idpedido = ip.pedido_idpedido
    JOIN livro l ON id_livro = l.id_livro
    WHERE c.idcliente = cliente_id
    GROUP BY 
        c.nome, p.idpedido, p.dt_criacao, l.titulo, v.valor_total
    ORDER BY p.dt_criacao DESC;
END $$
DELIMITER ;

CALL HistoricoComprasCliente(5);


-- PROCEDURE 5  GERA UM RELATORIO DE LIVROS POR GENERO, COM QUANTIDADE E PREÇO MEDIO


DELIMITER $$
CREATE PROCEDURE RelatorioLivrosPorGenero()
BEGIN
    SELECT 
        g.genero AS 'Gênero',
        COUNT(l.id_livro) AS 'Quantidade de Livros',
        ROUND(AVG(l.preco), 2) AS 'Preço Médio (R$)'
    FROM genero_literario g
    LEFT JOIN livro l ON l.genero_idgenero = g.idgenero
    GROUP BY g.idgenero, g.genero
    ORDER BY COUNT(l.id_livro) DESC, g.genero ASC;
END $$
DELIMITER ;

CALL RelatorioLivrosPorGenero();

-- PROCEDURE 6 GERA UM RELATORIO DE QUAL O CARGO DE CADA FUNCIONARIO

DELIMITER $$
CREATE PROCEDURE FuncionariosECargosAtuais()
BEGIN
    SELECT 
        f.nome AS 'Funcionário',
        c.cargo AS 'Cargo',
        d.departamento AS 'Departamento',
        t.dt_inicio AS 'Desde'
    FROM funcionario f
    JOIN trabalhar t ON t.funcionario_idfuncionario = f.idfuncionario
    JOIN cargo c ON c.idcargo = t.cargo_idcargo
    JOIN departamento d ON d.iddepartamento = t.departamento_iddepartamento
    WHERE t.dt_fim IS NULL
    ORDER BY d.departamento, c.cargo, f.nome;
END $$
DELIMITER ;

CALL FuncionariosECargosAtuais();

