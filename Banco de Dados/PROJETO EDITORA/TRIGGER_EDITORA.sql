-- 1 ALTERAR COLUNA VALIDO NA TABELA DE FUNC, SE A DT_FIM TIVER PREENCHIDA
delimiter $$
CREATE TRIGGER tgrAfterUpdateTrabalhar AFTER UPDATE ON editora_pinga.trabalhar
	FOR EACH ROW
		BEGIN
			if new.dt_fim is not null then
					BEGIN
						UPDATE editora_pinga.funcionario
							SET editora_pinga.funcionario.ativo = 0
								WHERE editora_pinga.funcionario.idfuncionario = new.funcionario_idfuncionario;
					end;
			end if;
	end $$
delimiter ; 


UPDATE editora_pinga.trabalhar
	SET dt_fim = "2023-03-14"
		where editora_pinga.trabalhar.funcionario_idfuncionario = 14;






-- 2 NÃO PERMITE DELETAR CLIENTE QUE ESTEJA COM PEDIDO QUE ESTEJA COM STATUS EM ABERTO
delimiter $$
CREATE TRIGGER tgrBeforeDeleteCliente BEFORE DELETE ON editora_pinga.cliente
	FOR EACH ROW
		BEGIN
			DECLARE qtd_pedidos_abertos INT;
            SELECT count(pedido.idpedido) INTO qtd_pedidos_abertos
				FROM editora_pinga.pedido
					WHERE pedido.cliente_idcliente = OLD.idcliente and
                    pedido.status = "ABE";
			
            if qtd_pedidos_abertos > 0 THEN
				BEGIN
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = 'Não é possível excluir o cliente. Existem pedidos associados a ele com o status em aberto.';
				END;
			END IF;
	end $$
delimiter ; 


delete from cliente
	where idcliente = 179;
    
    





-- 3 LOGS DOS PEDIDOS
delimiter $$
CREATE TRIGGER tgrAfterInsert AFTER INSERT ON editora_pinga.pedido
	FOR EACH ROW
		BEGIN
			insert into editora_pinga.log_tabela_pedido
            (tipo, cliente_idcliente)
            value
            ("INSERT", NEW.cliente_idcliente);
end $$
delimiter ; 


INSERT INTO editora_pinga.pedido (dt_criacao, `status`, cliente_idcliente)
VALUE
('2025-03-23', 'ABE', 15);



delimiter $$
CREATE TRIGGER tgrAfterDelete AFTER DELETE ON editora_pinga.pedido
	FOR EACH ROW
		BEGIN
			insert into editora_pinga.log_tabela_pedido
            (tipo, cliente_idcliente)
            value
            ("DELETE", OLD.cliente_idcliente);
end $$
delimiter ; 

DELETE from editora_pinga.pedido
where idpedido = 181;





-- 4 ALTERAR STATUS DO EXEMPLAR PARA VENDIDO SE TIVER INSERT NA TABELA DE ITEM DO PEDIDO
delimiter $$
CREATE TRIGGER tgrAfterInsertItemPedido AFTER INSERT ON editora_pinga.item_do_pedido
	FOR EACH ROW
		BEGIN
			UPDATE editora_pinga.exemplares
				SET `status` = "VEN"
                WHERE numero_de_serie = NEW.exemplares_numero_de_serie;
end $$
delimiter ;      


INSERT INTO editora_pinga.livro 
(titulo, subtitulo, isbn, genero_idgenero, editora_ideditora, dt_criacao, preco, numero_pag, descricao) 
VALUE
('As Crônicas do Vento', 'O Chamado do Norte', '9788545702239', 3, 2, '2022-08-12', 59.90, 512, 'Uma jornada épica por terras geladas, onde antigos segredos desafiam a coragem dos heróis.');

INSERT INTO editora_pinga.exemplares 
(numero_de_serie, localizacao_fisica_na_loja, `status`, livro_idlivro) 
VALUE
('EX0511', 'Prateleira A1', 'LIV', 88);

INSERT INTO editora_pinga.item_do_pedido
(pedido_idpedido, exemplares_numero_de_serie)
VALUE
(1, 'EX0511');






-- 5 ANTES DE CADASTRAR UM FUNCIONARIO, VERIFICAR SE O SALARIO É MAIOR DO QUE UM SALARIO MINIMO
delimiter $$
CREATE TRIGGER tgrBeforeInsertFuncionario BEFORE INSERT ON editora_pinga.funcionario
	FOR EACH ROW
		BEGIN
			if NEW.salario < 1804.00 THEN
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = 'o salário deve ser igual ou superior a R$ 1.804,00';
			END IF;
		END $$
delimiter ;

INSERT INTO editora_pinga.funcionario
(cpf, nome, dt_nascimento, email, salario, sexo)
VALUE
("123.456.789-10", "Ana Beatriz Costa", '1998-05-12', "ana.costa@example.com", 1000.00, 'F');






-- 6 PREVENCAO DE EXCLUSAO DE GENERO COM LIVROS ASSOCIADOS
delimiter $$
CREATE TRIGGER tgrBeforeDeleteGeneroLiterario BEFORE DELETE ON editora_pinga.genero_literario
	FOR EACH ROW
		BEGIN
			DECLARE qtdLivrosGenero int;
            SELECT COUNT(id_livro) INTO qtdLivrosGenero
            FROM editora_pinga.livro
            where genero_idgenero = OLD.idgenero;
            
            IF qtdLivrosGenero > 0 THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Não é possível excluir o gênero literário, pois existem livros associados a ele.';
            END IF;
        END $$
delimiter ;


SELECT COUNT(id_livro) 
            FROM editora_pinga.livro
            where genero_idgenero = 15;
            

drop trigger tgrBeforeDeleteGeneroLiterario;
DELETE FROM editora_pinga.genero_literario
where editora_pinga.genero_literario.idgenero = 1;