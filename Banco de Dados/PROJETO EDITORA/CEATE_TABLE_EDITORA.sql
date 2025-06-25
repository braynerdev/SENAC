-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema editora_pinga
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema editora_pinga
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `editora_pinga` DEFAULT CHARACTER SET utf8 ;
USE `editora_pinga` ;

-- -----------------------------------------------------
-- Table `editora_pinga`.`autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`autor` (
  `idautor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `biografia` TEXT NOT NULL,
  `nacionalidade` VARCHAR(45) NOT NULL,
  `dt_nascimento` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  PRIMARY KEY (`idautor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`genero` (
  `idgenero` INT NOT NULL AUTO_INCREMENT,
  `genero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idgenero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`editora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`editora` (
  `ideditora` INT NOT NULL AUTO_INCREMENT,
  `editora` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ideditora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`livro` (
  `ISBN` VARCHAR(17) NOT NULL,
  `numero_pag` INT NOT NULL,
  `descricao` TEXT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `subtitulo` VARCHAR(45) NULL,
  `dt_criacao` DATE NOT NULL,
  `genero_idgenero` INT NOT NULL,
  `editora_ideditora` INT NOT NULL,
  `preco` DECIMAL(7,2) NOT NULL,
  `id_livro` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_livro_genero1_idx` (`genero_idgenero` ASC) VISIBLE,
  INDEX `fk_livro_editora1_idx` (`editora_ideditora` ASC) VISIBLE,
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC) VISIBLE,
  PRIMARY KEY (`id_livro`),
  CONSTRAINT `fk_livro_genero1`
    FOREIGN KEY (`genero_idgenero`)
    REFERENCES `editora_pinga`.`genero` (`idgenero`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_livro_editora1`
    FOREIGN KEY (`editora_ideditora`)
    REFERENCES `editora_pinga`.`editora` (`ideditora`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`exemplares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`exemplares` (
  `numero_de_serie` VARCHAR(45) NOT NULL,
  `localizacao_fisica_na_loja` VARCHAR(150) NOT NULL,
  `status` CHAR(3) NOT NULL,
  `livro_id_livro` INT NOT NULL,
  PRIMARY KEY (`numero_de_serie`),
  INDEX `fk_exemplares_livro1_idx` (`livro_id_livro` ASC) VISIBLE,
  CONSTRAINT `fk_exemplares_livro1`
    FOREIGN KEY (`livro_id_livro`)
    REFERENCES `editora_pinga`.`livro` (`id_livro`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`area_do_conhecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`area_do_conhecimento` (
  `cod_area_do_conhecimento` VARCHAR(20) NOT NULL,
  `area_do_conhecimento` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cod_area_do_conhecimento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`palavra_chave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`palavra_chave` (
  `idpalavra_chave` INT NOT NULL AUTO_INCREMENT,
  `palavra_chave` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpalavra_chave`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`funcionario` (
  `idfuncionario` INT NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `dt_nascimento` DATE NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `salario` DECIMAL(7,2) UNSIGNED NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  PRIMARY KEY (`idfuncionario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cpf_cnpj` VARCHAR(18) NOT NULL,
  `dt_nascimento` DATE NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `cpf_cnpj_UNIQUE` (`cpf_cnpj` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`endereco` (
  `idendereco` INT NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(45) NOT NULL,
  `numero` INT NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `uf` CHAR(2) NOT NULL,
  `complemento` VARCHAR(100) NULL,
  `cep` VARCHAR(9) NOT NULL,
  `funcionario_idfuncionario` INT NULL,
  `cliente_idcliente` INT NULL,
  PRIMARY KEY (`idendereco`),
  INDEX `fk_endereco_funcionario_funcionario1_idx` (`funcionario_idfuncionario` ASC) VISIBLE,
  INDEX `fk_endereco_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_funcionario_funcionario1`
    FOREIGN KEY (`funcionario_idfuncionario`)
    REFERENCES `editora_pinga`.`funcionario` (`idfuncionario`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_endereco_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `editora_pinga`.`cliente` (`idcliente`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`departamento` (
  `iddepartamento` INT NOT NULL AUTO_INCREMENT,
  `descricao_atividade` TEXT NOT NULL,
  `departamento` VARCHAR(45) NOT NULL,
  `gerente_idfuncionario` INT NULL,
  PRIMARY KEY (`iddepartamento`),
  INDEX `fk_departamento_funcionario1_idx` (`gerente_idfuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_departamento_funcionario1`
    FOREIGN KEY (`gerente_idfuncionario`)
    REFERENCES `editora_pinga`.`funcionario` (`idfuncionario`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`telefone` (
  `idtelefone` INT NOT NULL AUTO_INCREMENT,
  `telefone` VARCHAR(15) NOT NULL,
  `funcionario_idfuncionario` INT NULL,
  `departamento_iddepartamento` INT NULL,
  `cliente_idcliente` INT NULL,
  PRIMARY KEY (`idtelefone`),
  INDEX `fk_telefone_funcionario_funcionario1_idx` (`funcionario_idfuncionario` ASC) VISIBLE,
  INDEX `fk_telefone_departamento1_idx` (`departamento_iddepartamento` ASC) VISIBLE,
  INDEX `fk_telefone_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE,
  CONSTRAINT `fk_telefone_funcionario_funcionario1`
    FOREIGN KEY (`funcionario_idfuncionario`)
    REFERENCES `editora_pinga`.`funcionario` (`idfuncionario`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_telefone_departamento1`
    FOREIGN KEY (`departamento_iddepartamento`)
    REFERENCES `editora_pinga`.`departamento` (`iddepartamento`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_telefone_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `editora_pinga`.`cliente` (`idcliente`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`ferias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`ferias` (
  `idferias` INT NOT NULL AUTO_INCREMENT,
  `dt_inicio` DATE NOT NULL,
  `dt_final` DATE NOT NULL,
  `funcionario_idfuncionario` INT NOT NULL,
  PRIMARY KEY (`idferias`),
  INDEX `fk_ferias_funcionario1_idx` (`funcionario_idfuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_ferias_funcionario1`
    FOREIGN KEY (`funcionario_idfuncionario`)
    REFERENCES `editora_pinga`.`funcionario` (`idfuncionario`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`reg_ponto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`reg_ponto` (
  `idreg_ponto` INT NOT NULL AUTO_INCREMENT,
  `dt_hora` DATETIME NOT NULL,
  `tp_movimentacao` CHAR(3) NOT NULL,
  `funcionario_idfuncionario` INT NOT NULL,
  PRIMARY KEY (`idreg_ponto`),
  INDEX `fk_reg_ponto_funcionario1_idx` (`funcionario_idfuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_reg_ponto_funcionario1`
    FOREIGN KEY (`funcionario_idfuncionario`)
    REFERENCES `editora_pinga`.`funcionario` (`idfuncionario`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`cargo` (
  `idcargo` INT NOT NULL AUTO_INCREMENT,
  `cargo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idcargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`trabalhar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`trabalhar` (
  `cargo_idcargo` INT NOT NULL,
  `departamento_iddepartamento` INT NOT NULL,
  `funcionario_idfuncionario` INT NOT NULL,
  `dt_inicio` DATETIME NOT NULL,
  `dt_fim` DATETIME NULL,
  PRIMARY KEY (`cargo_idcargo`, `departamento_iddepartamento`, `funcionario_idfuncionario`),
  INDEX `fk_cargo_has_departamento_departamento1_idx` (`departamento_iddepartamento` ASC) VISIBLE,
  INDEX `fk_cargo_has_departamento_cargo1_idx` (`cargo_idcargo` ASC) VISIBLE,
  INDEX `fk_trabalhar_funcionario1_idx` (`funcionario_idfuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_cargo_has_departamento_cargo1`
    FOREIGN KEY (`cargo_idcargo`)
    REFERENCES `editora_pinga`.`cargo` (`idcargo`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_cargo_has_departamento_departamento1`
    FOREIGN KEY (`departamento_iddepartamento`)
    REFERENCES `editora_pinga`.`departamento` (`iddepartamento`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_trabalhar_funcionario1`
    FOREIGN KEY (`funcionario_idfuncionario`)
    REFERENCES `editora_pinga`.`funcionario` (`idfuncionario`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`pedido` (
  `idpedido` INT NOT NULL AUTO_INCREMENT,
  `dt_criacao` DATETIME NOT NULL,
  `status` CHAR(3) NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  PRIMARY KEY (`idpedido`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `editora_pinga`.`cliente` (`idcliente`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`item_do_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`item_do_pedido` (
  `iditem_do_pedido` INT NOT NULL AUTO_INCREMENT,
  `pedido_idpedido` INT NOT NULL,
  `exemplares_numero_de_serie` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iditem_do_pedido`),
  INDEX `fk_item_do_pedido_pedido1_idx` (`pedido_idpedido` ASC) VISIBLE,
  INDEX `fk_item_do_pedido_exemplares1_idx` (`exemplares_numero_de_serie` ASC) VISIBLE,
  CONSTRAINT `fk_item_do_pedido_pedido1`
    FOREIGN KEY (`pedido_idpedido`)
    REFERENCES `editora_pinga`.`pedido` (`idpedido`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_item_do_pedido_exemplares1`
    FOREIGN KEY (`exemplares_numero_de_serie`)
    REFERENCES `editora_pinga`.`exemplares` (`numero_de_serie`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`palavra_chave_has_livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`palavra_chave_has_livro` (
  `palavra_chave_idpalavra_chave` INT NOT NULL,
  `livro_id_livro` INT NOT NULL,
  PRIMARY KEY (`palavra_chave_idpalavra_chave`, `livro_id_livro`),
  INDEX `fk_palavra_chave_has_livro_livro1_idx` (`livro_id_livro` ASC) VISIBLE,
  INDEX `fk_palavra_chave_has_livro_palavra_chave1_idx` (`palavra_chave_idpalavra_chave` ASC) VISIBLE,
  CONSTRAINT `fk_palavra_chave_has_livro_palavra_chave1`
    FOREIGN KEY (`palavra_chave_idpalavra_chave`)
    REFERENCES `editora_pinga`.`palavra_chave` (`idpalavra_chave`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_palavra_chave_has_livro_livro1`
    FOREIGN KEY (`livro_id_livro`)
    REFERENCES `editora_pinga`.`livro` (`id_livro`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`autor_has_livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`autor_has_livro` (
  `autor_idautor` INT NOT NULL,
  `livro_id_livro` INT NOT NULL,
  PRIMARY KEY (`autor_idautor`, `livro_id_livro`),
  INDEX `fk_autor_has_livro_livro1_idx` (`livro_id_livro` ASC) VISIBLE,
  INDEX `fk_autor_has_livro_autor1_idx` (`autor_idautor` ASC) VISIBLE,
  CONSTRAINT `fk_autor_has_livro_autor1`
    FOREIGN KEY (`autor_idautor`)
    REFERENCES `editora_pinga`.`autor` (`idautor`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_autor_has_livro_livro1`
    FOREIGN KEY (`livro_id_livro`)
    REFERENCES `editora_pinga`.`livro` (`id_livro`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`livro_has_area_do_conhecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`livro_has_area_do_conhecimento` (
  `livro_id_livro` INT NOT NULL,
  `area_do_conhecimento_cod_area_do_conhecimento` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`livro_id_livro`, `area_do_conhecimento_cod_area_do_conhecimento`),
  INDEX `fk_livro_has_area_do_conhecimento_area_do_conhecimento1_idx` (`area_do_conhecimento_cod_area_do_conhecimento` ASC) VISIBLE,
  INDEX `fk_livro_has_area_do_conhecimento_livro1_idx` (`livro_id_livro` ASC) VISIBLE,
  CONSTRAINT `fk_livro_has_area_do_conhecimento_livro1`
    FOREIGN KEY (`livro_id_livro`)
    REFERENCES `editora_pinga`.`livro` (`id_livro`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_livro_has_area_do_conhecimento_area_do_conhecimento1`
    FOREIGN KEY (`area_do_conhecimento_cod_area_do_conhecimento`)
    REFERENCES `editora_pinga`.`area_do_conhecimento` (`cod_area_do_conhecimento`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_pinga`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_pinga`.`venda` (
  `idvenda` INT NOT NULL AUTO_INCREMENT,
  `valor_total` DECIMAL(7,2) UNSIGNED NOT NULL,
  `dt_pagamento` DATETIME NOT NULL,
  `pedido_idpedido` INT NOT NULL,
  `funcionario_idfuncionario` INT NOT NULL,
  PRIMARY KEY (`idvenda`),
  INDEX `fk_venda_pedido1_idx` (`pedido_idpedido` ASC) VISIBLE,
  INDEX `fk_venda_funcionario1_idx` (`funcionario_idfuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_venda_pedido1`
    FOREIGN KEY (`pedido_idpedido`)
    REFERENCES `editora_pinga`.`pedido` (`idpedido`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_venda_funcionario1`
    FOREIGN KEY (`funcionario_idfuncionario`)
    REFERENCES `editora_pinga`.`funcionario` (`idfuncionario`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE log_tabela_pedido (
  id INT AUTO_INCREMENT PRIMARY KEY,
  data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
  tipo VARCHAR(30) NOT NULL,
  cliente_idcliente INT,
  FOREIGN KEY (cliente_idcliente) REFERENCES cliente(idcliente)
);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
