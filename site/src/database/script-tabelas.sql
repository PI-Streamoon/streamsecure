CREATE database streamoon;
USE streamoon;


CREATE TABLE IF NOT EXISTS empresa(
  idEmpresa INT NOT NULL,
  nome VARCHAR(45) NULL,
  cnpj CHAR(14) NULL,
  localidade VARCHAR(45) NULL,
  PRIMARY KEY (idEmpresa));
  
  select * from empresa;

CREATE TABLE IF NOT EXISTS usuario (
  idUsuario INT NOT NULL,
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
;
  select * from usuario;

CREATE TABLE IF NOT EXISTS locais (
  idLocais INT NOT NULL,
  fkEmpresa INT NOT NULL,
  cep VARCHAR(45) NULL,
  PRIMARY KEY (`idLocais`),
  CONSTRAINT `fk_Locais_Empresa1`
    FOREIGN KEY (`fkEmpresa`)
    REFERENCES empresa (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;
select * from locais; 

CREATE TABLE IF NOT EXISTS servidor (
  idServidor INT NOT NULL,
  fkLocais INT NOT NULL,
  PRIMARY KEY (idServidor),
  CONSTRAINT `fk_Servidor_Locais1`
    FOREIGN KEY (`fkLocais`)
    REFERENCES locais (`idLocais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ;
    select * from servidor
    join locais on fkLocais = idLocais;

CREATE TABLE IF NOT EXISTS unidadeMedida (
  idUnidadeMedida INT NOT NULL,
  nomeMedida varchar(35) not null,
  PRIMARY KEY (`idUnidadeMedida`))
;
select * from unidadeMedida;

CREATE TABLE IF NOT EXISTS componente (
  idComponente INT NOT NULL,
  fkUnidadeMedida INT NOT NULL,
  nome varchar(50) not null,
  PRIMARY KEY (`idComponente`, `fkUnidadeMedida`),
  CONSTRAINT `fk_Componente_UnidadeMedida1`
    FOREIGN KEY (`fkUnidadeMedida`)
    REFERENCES unidadeMedida (`idUnidadeMedida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;
select * from componente;

CREATE TABLE IF NOT EXISTS componenteServidor (
  `idComponenteServidor` INT NOT NULL,
  `fkServidor` INT NOT NULL,
  `fkComponente` INT NOT NULL,
  `fkUnidadeMedida` INT NOT NULL,
  PRIMARY KEY (`idComponenteServidor`, `fkServidor`, `fkComponente`, `fkUnidadeMedida`),
  CONSTRAINT `fk_Componente_has_Servidor_Servidor1`
    FOREIGN KEY (`fkServidor`)
    REFERENCES servidor (`idServidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ComponenteServidor_Componente1`
    FOREIGN KEY (`fkComponente` , `fkUnidadeMedida`)
    REFERENCES componente (`idComponente` , `fkUnidadeMedida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE IF NOT EXISTS registro (
  `idRegistro` INT NOT NULL,
  `registro` INT NULL,
  `dtHora` DATETIME NULL,
  `fkComponenteServidor` INT NOT NULL,
  `fkServidor` INT NOT NULL,
  `fkComponente` INT NOT NULL,
  `fkUnidadeMedida` INT NOT NULL,
  PRIMARY KEY (`idRegistro`, `fkComponenteServidor`, `fkServidor`, `fkComponente`, `fkUnidadeMedida`),
  CONSTRAINT `fk_Registro_ComponenteServidor1`
    FOREIGN KEY (`fkComponenteServidor` , `fkServidor` , `fkComponente` , `fkUnidadeMedida`)
    REFERENCES componenteServidor (`idComponenteServidor` , `fkServidor` , `fkComponente` , `fkUnidadeMedida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

-- Inserção de dados

-- Tabela empresa
INSERT INTO empresa (idEmpresa, nome, cnpj, localidade)
VALUES
  (1, 'Empresa A', '12345678901234', 'Cidade A'),
  (2, 'Empresa B', '98765432101234', 'Cidade B');

-- Tabela usuario
INSERT INTO usuario (idUsuario, fkEmpresa, fkAdmin, nome, senha, cpf, email)
VALUES
  (1, 1, NULL, 'Usuário A', 'senha123', '12345678901', 'usuarioa@example.com'),
  (2, 2, 1, 'Usuário B', 'senha456', '98765432109', 'usuariob@example.com'),
  (3, 1, 2, 'Usuário C', 'senha789', '45678912301', 'usuarioc@example.com');

-- Tabela locais
INSERT INTO locais (idLocais, fkEmpresa, cep)
VALUES
  (1, 1, '12345-678'),
  (2, 2, '98765-432');

-- Tabela servidor
INSERT INTO servidor (idServidor, fkLocais)
VALUES
  (1, 1),
  (2, 2);

-- Tabela unidadeMedida
INSERT INTO unidadeMedida (idUnidadeMedida, nomeMedida)
VALUES
  (1, 'Unidade'),
  (2, 'Litro');

-- Tabela componente
INSERT INTO componente (idComponente, fkUnidadeMedida, nome)
VALUES
  (7, 1, 'Componente A'),
  (10, 2, 'Componente B');

-- Tabela componenteServidor
INSERT INTO componenteServidor (idComponenteServidor, fkServidor, fkComponente, fkUnidadeMedida)
VALUES
  (100, 1, 7, 1),
  (101, 2, 10, 2);

-- Tabela registro
INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor, fkServidor, fkComponente, fkUnidadeMedida)
VALUES
  (1000, 20348034, '2023-08-01 10:00:00', 100, 1, 7, 1),
  (1001, 02475092, '2023-08-02 15:30:00', 101, 2, 10, 2);


select servidor.idServidor, registro, componente.nome from registro
join componenteServidor on fkComponenteServidor = idComponenteServidor
join servidor on idServidor = registro.fkServidor
join componente on idComponente = registro.fkComponente
join unidadeMedida on idUnidadeMedida = registro.fkUnidadeMedida;

CREATE USER 'admStreamoon'@'streamoon' IDENTIFIED BY 'streamoon';
GRANT ALL privileges ON streamoon.* TO 'admStreamoon'@'streamoon';
