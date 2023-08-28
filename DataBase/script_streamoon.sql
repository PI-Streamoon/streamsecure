CREATE database streamoon;
USE streamoon;
drop database streamoon;
CREATE TABLE IF NOT EXISTS empresa(
  idEmpresa INT NOT NULL auto_increment,
  nome VARCHAR(45) NULL,
  cnpj CHAR(14) NULL,
  localidade VARCHAR(45) NULL,
  PRIMARY KEY (idEmpresa))
  auto_increment = 484018;
  
  select * from empresa;

CREATE TABLE IF NOT EXISTS usuario (
  idUsuario INT NOT NULL auto_increment,
  fkEmpresa INT NOT NULL,
  fkAdmin INT,
  nome varchar(50) not null,
  senha varchar(30) not null,
  cpf char(11) not null,
  email varchar(50) not null,
  PRIMARY KEY (`idUsuario`, `fkEmpresa`),
  CONSTRAINT `fk_Usuario_Empresa`
    FOREIGN KEY (`fkEmpresa`)
    REFERENCES empresa (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Usuario1`
    FOREIGN KEY (`fkAdmin`)
    REFERENCES usuario (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    auto_increment = 1
;
  select * from usuario;

CREATE TABLE IF NOT EXISTS locais (
  idLocais INT NOT NULL auto_increment,
  fkEmpresa INT NOT NULL,
  cep VARCHAR(45) NULL,
  descricao varchar(100) null,
  PRIMARY KEY (`idLocais`),
  CONSTRAINT `fk_Locais_Empresa1`
    FOREIGN KEY (`fkEmpresa`)
    REFERENCES empresa (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    auto_increment = 100
;
select * from locais; 

CREATE TABLE IF NOT EXISTS servidor (
  idServidor INT NOT NULL auto_increment,
  fkLocais INT NOT NULL,
  PRIMARY KEY (idServidor),
  CONSTRAINT `fk_Servidor_Locais1`
    FOREIGN KEY (`fkLocais`)
    REFERENCES locais (`idLocais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    auto_increment = 2222
    ;
    select * from servidor
    join locais on fkLocais = idLocais;

CREATE TABLE IF NOT EXISTS unidadeMedida (
  idUnidadeMedida INT NOT NULL auto_increment,
  nomeMedida varchar(35) not null,
  PRIMARY KEY (`idUnidadeMedida`))
  auto_increment = 1
;
select * from unidadeMedida;

CREATE TABLE IF NOT EXISTS componente (
  idComponente INT NOT NULL auto_increment,
  fkUnidadeMedida INT NOT NULL,
  nome varchar(50) not null,
  PRIMARY KEY (`idComponente`, `fkUnidadeMedida`),
  CONSTRAINT `fk_Componente_UnidadeMedida1`
    FOREIGN KEY (`fkUnidadeMedida`)
    REFERENCES unidadeMedida (`idUnidadeMedida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    auto_increment = 100
;
select * from componente;

CREATE TABLE IF NOT EXISTS componenteServidor (
  `idComponenteServidor` INT NOT NULL auto_increment,
  `fkServidor` INT NOT NULL,
  `fkComponente` INT NOT NULL,
  PRIMARY KEY (`idComponenteServidor`, `fkServidor`, `fkComponente`),
  CONSTRAINT `fk_Componente_has_Servidor_Servidor1`
    FOREIGN KEY (`fkServidor`)
    REFERENCES servidor (`idServidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ComponenteServidor_Componente1`
    FOREIGN KEY (`fkComponente`)
    REFERENCES componente (`idComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    auto_increment = 1
;

CREATE TABLE IF NOT EXISTS registro (
  `idRegistro` INT NOT NULL auto_increment,
  `registro` INT NULL,
  `dtHora` DATETIME NULL,
  `fkComponenteServidor` INT NOT NULL,
  PRIMARY KEY (`idRegistro`, `fkComponenteServidor`),
  CONSTRAINT `fk_Registro_ComponenteServidor1`
    FOREIGN KEY (`fkComponenteServidor`)
    REFERENCES componenteServidor (`idComponenteServidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    auto_increment = 100000;
;

-- Inserção de dados

-- Tabela empresa
INSERT INTO empresa (idEmpresa, nome, cnpj, localidade)
VALUES
  (null, 'HBOMax', '12345678901234', 'Centro de São Paulo'),
  (null, 'Netflix', '98765432101234', 'São Jorge da Serra - Perdizes');
select * from empresa;
-- Tabela usuario
INSERT INTO usuario (idUsuario, fkEmpresa, fkAdmin, nome, senha, cpf, email)
VALUES
  (null, 484018, NULL, 'Fernando Brandão', '203457', '12345678901', 'brandao@gmail.com'),
  (null, 484019, 1, 'Marise', 'senha456293', '12345678902','marise@gmail.com');

-- Tabela locais
INSERT INTO locais (idLocais, fkEmpresa, cep, descricao)
VALUES
  (null, 484018, '12345-678', 'Local X, Andar 2'),
  (null, 484018, '98765-432', 'Local Y, Andar 12');
select * from locais;
-- Tabela servidor
INSERT INTO servidor (idServidor, fkLocais)
VALUES
  (null, 100),
  (null, 101);
  select * from servidor;

-- Tabela unidadeMedida
INSERT INTO unidadeMedida (idUnidadeMedida, nomeMedida)
VALUES
  (null, 'GHZ'),
  (null, 'GB'),
  (null, 'KBPS'),
  (null, '%');
select * from unidadeMedida;
 
-- Tabela componente
INSERT INTO componente (idComponente, fkUnidadeMedida, nome)
VALUES
  (null, 4, 'CPU'),
  (null, 4, 'Memória'),
  (null, 2, 'Memória Usada'),
  (null, 2, 'Memória Total'),
  (null, 4, 'Disco');
  select * from componente;

-- Tabela componenteServidor
INSERT INTO componenteServidor (idComponenteServidor, fkServidor, fkComponente)
VALUES
  (null, 2222, 100),
  (null, 2222, 101),
  (null, 2222, 102),
  (null, 2222, 103),
  (null, 2222, 104);
select * from componenteServidor;
-- Tabela registro
INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor)
VALUES
  (null, 20348034, '2023-08-01 10:00:00', 1),
  (null, 02475092, '2023-08-02 15:30:00', 2);
  select * from registro;
  select registro.registro as 'Registro', registro.dtHora as 'Momento Registro', componente.nome as 'Componente', unidadeMedida.nomeMedida as 'Símbolo', componenteServidor.idComponenteServidor from registro 
  join componenteServidor on fkComponenteServidor = idComponenteServidor
  join componente on fkComponente = idComponente
  join unidadeMedida on fkUnidadeMedida = idUnidadeMedida
  order by unidadeMedida.nomeMedida;
  
  SELECT r.registro, r.dtHora, c.nome, um.nomeMedida
FROM registro r
JOIN componenteServidor cs ON r.fkComponenteServidor = cs.idComponenteServidor
JOIN componente c ON cs.fkComponente = c.idComponente
JOIN unidadeMedida um ON c.fkUnidadeMedida = um.idUnidadeMedida;

  
  -- SELECT PARA SELEÇÃO DE TODOS OS REGISTROS DOS COMPONENTES COM SUA UNIDADE DE MEDIDA DE CADA SERVIDOR DE CADA LOCAL DE CADA EMPRESA
select empresa.nome, locais.idLocais, servidor.idServidor, 
componenteServidor.idComponenteServidor, 
componente.idComponente, unidadeMedida.nomeMedida,
registro.registro, registro.dtHora from registro
join componenteServidor on idComponenteServidor = fkComponenteServidor
join componente on idComponente = fkComponente
join unidadeMedida on idUnidadeMedida = fkUnidadeMedida
join servidor on idServidor = fkServidor
join locais on idLocais = fkLocais
join empresa on idEmpresa = fkEmpresa;

SELECT r.registro, r.dtHora, c.nome AS nomeComponente, um.nomeMedida
FROM registro r
LEFT JOIN componenteServidor cs ON r.fkComponenteServidor = cs.idComponenteServidor
LEFT JOIN componente c ON cs.fkComponente = c.idComponente
LEFT JOIN unidadeMedida um ON c.fkUnidadeMedida = um.idUnidadeMedida
ORDER BY um.nomeMedida, c.nome;



