CREATE database streamoon;
USE streamoon;
drop database streamoon;
CREATE TABLE IF NOT EXISTS empresa (
    idEmpresa INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NULL,
    cnpj CHAR(14) NULL,
    localidade VARCHAR(45) NULL,
    PRIMARY KEY (idEmpresa)
)  AUTO_INCREMENT=484018;

CREATE TABLE IF NOT EXISTS usuario (
    idUsuario INT NOT NULL AUTO_INCREMENT,
    fkEmpresa INT NOT NULL,
    fkAdmin INT,
    nome VARCHAR(50) NOT NULL,
    senha VARCHAR(30) NOT NULL,
    cpf CHAR(11) NOT NULL,
    email VARCHAR(50) NOT NULL,
    PRIMARY KEY (`idUsuario` , `fkEmpresa`),
    CONSTRAINT `fk_Usuario_Empresa` FOREIGN KEY (`fkEmpresa`)
        REFERENCES empresa (`idEmpresa`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_Usuario_Usuario1` FOREIGN KEY (`fkAdmin`)
        REFERENCES usuario (`idUsuario`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  AUTO_INCREMENT=1
;

CREATE TABLE IF NOT EXISTS locais (
    idLocais INT NOT NULL AUTO_INCREMENT,
    fkEmpresa INT NOT NULL,
    cep VARCHAR(45) NULL,
    descricao VARCHAR(100) NULL,
    PRIMARY KEY (`idLocais`),
    CONSTRAINT `fk_Locais_Empresa1` FOREIGN KEY (`fkEmpresa`)
        REFERENCES empresa (`idEmpresa`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  AUTO_INCREMENT=100
;

CREATE TABLE IF NOT EXISTS servidor (
    idServidor INT NOT NULL AUTO_INCREMENT,
    fkLocais INT NOT NULL,
    PRIMARY KEY (idServidor),
    CONSTRAINT `fk_Servidor_Locais1` FOREIGN KEY (`fkLocais`)
        REFERENCES locais (`idLocais`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  AUTO_INCREMENT=2222
;

CREATE TABLE IF NOT EXISTS unidadeMedida (
    idUnidadeMedida INT NOT NULL AUTO_INCREMENT,
    nomeMedida VARCHAR(35) NOT NULL,
    PRIMARY KEY (`idUnidadeMedida`)
)  AUTO_INCREMENT=1
;

CREATE TABLE IF NOT EXISTS componente (
    idComponente INT NOT NULL AUTO_INCREMENT,
    fkUnidadeMedida INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (`idComponente` , `fkUnidadeMedida`),
    CONSTRAINT `fk_Componente_UnidadeMedida1` FOREIGN KEY (`fkUnidadeMedida`)
        REFERENCES unidadeMedida (`idUnidadeMedida`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  AUTO_INCREMENT=100;

CREATE TABLE IF NOT EXISTS componenteServidor (
    `idComponenteServidor` INT NOT NULL AUTO_INCREMENT,
    `fkServidor` INT NOT NULL,
    `fkComponente` INT NOT NULL,
    PRIMARY KEY (`idComponenteServidor` , `fkServidor` , `fkComponente`),
    CONSTRAINT `fk_Componente_has_Servidor_Servidor1` FOREIGN KEY (`fkServidor`)
        REFERENCES servidor (`idServidor`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_ComponenteServidor_Componente1` FOREIGN KEY (`fkComponente`)
        REFERENCES componente (`idComponente`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  AUTO_INCREMENT=1;

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

-- Criação das Views
select * from registro;
  CREATE VIEW tabelaRegistros AS
    SELECT 
        registro.registro AS 'Registro',
        registro.dtHora AS 'MomentoRegistro',
        componente.nome AS 'Componente',
        unidadeMedida.nomeMedida AS 'Símbolo',
        componenteServidor.idComponenteServidor,
        servidor.idServidor AS 'idServidor'
    FROM
        registro
            JOIN
        componenteServidor ON fkComponenteServidor = idComponenteServidor
            JOIN
        servidor ON fkServidor = idServidor
            JOIN
        componente ON fkComponente = idComponente
            JOIN
        unidadeMedida ON fkUnidadeMedida = idUnidadeMedida
    ORDER BY 2 AND 3 AND 4
    LIMIT 10000;

CREATE VIEW infoServidor AS
    SELECT 
        servidor.idServidor, locais.cep, empresa.nome
    FROM
        servidor
            JOIN
        locais ON fkLocais = idLocais
            JOIN
        empresa ON fkEmpresa = idEmpresa;
        
        CREATE VIEW infoUsuario AS
    SELECT 
        u.nome AS 'Nome Usuário',
        u.email AS 'Email Usuário',
        empresa.nome AS 'Nome Empresa'
    FROM
        usuario AS u
            JOIN
        empresa ON fkEmpresa = idEmpresa;
        SELECT 
    *
FROM
    infoUsuario;
        
-- Inserção de dados
-- Tabela empresa
INSERT INTO empresa (idEmpresa, nome, cnpj, localidade)
VALUES
  (null, 'HBOMax', '12345678901234', 'Centro de São Paulo'),
  (null, 'Netflix', '98765432101234', 'São Jorge da Serra - Perdizes');

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

-- Tabela servidor
INSERT INTO servidor (idServidor, fkLocais)
VALUES
  (null, 100),
  (null, 101);

-- Tabela unidadeMedida
INSERT INTO unidadeMedida (idUnidadeMedida, nomeMedida)
VALUES
  (null, 'GHZ'),
  (null, 'GB'),
  (null, 'KBPS'),
  (null, '%');
 
-- Tabela componente
INSERT INTO componente (idComponente, fkUnidadeMedida, nome)
VALUES
  (null, 4, 'CPU'),
  (null, 4, 'Memoria'),
  (null, 2, 'MemoriaUsada'),
  (null, 2, 'MemoriaTotal'),
  (null, 4, 'Disco');

-- Tabela componenteServidor
INSERT INTO componenteServidor (idComponenteServidor, fkServidor, fkComponente)
VALUES
  (null, 2222, 100),
  (null, 2222, 101),
  (null, 2222, 102),
  (null, 2222, 103),
  (null, 2222, 104);

-- Tabela registro
INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor)
VALUES
  (null, 20348034, '2023-08-01 10:00:00', 1),
  (null, 02475092, '2023-08-02 15:30:00', 2);

-- CÓDIGO DA CRIAÇÃO DA VIEW PARA VISUALIZAÇÃO DOS DADOS EM TABELA --------------------------------------------------------------------------------------------
SET @sql = NULL; -- Criando uma variável para armazenar o comando

SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'max(case when Componente = ''',
      Componente, -- aqui vem o nome que você setou para os componentes na view!
      ''' then Registro end) ',
      Componente -- aqui vem o nome que você setou para os componentes na view!
    )
  )
INTO @sql

FROM
  tabelaRegistros; -- Aqui vem o nome da sua view!
  
-- max(case when Componente = 'Componente1' then Registro end) Componente1,
-- max(case when Componente = 'Componente2' then Registro end) Componente2, .....
select @sql;


SET @sql = CONCAT('SELECT idServidor, MomentoRegistro, ', @sql, '
                 
FROM tabelaRegistros
                   
GROUP BY idServidor, MomentoRegistro'); -- Lembra de trocar as informações (idServidor, MomentoRegistro, tabelaRegistros) pelos nomes que você usou na view

select @sql;

PREPARE stmt FROM @sql; -- Prepara um statement para executar o comando guardado na variável @sql

EXECUTE stmt; -- Executa o statement

DEALLOCATE PREPARE stmt;
-- FIM DO CÓDIGO PARA VIEW------------------------------------------------------------------------------------------------------------------------------------------- 

-- Selects de Teste
  select * from tabelaRegistros;

  select MomentoRegistro, 
  max(case when Componente = 'CPU' then Registro end) 'CPU',
  max(case when Componente = 'Memoria' then Registro end) 'Memória',
  max(case when Componente = 'MemoriaTotal' then Registro end) 'Memória Total',
  max(case when Componente = 'MemoriaUsada' then Registro end) 'Memória Usada'
  from tabelaRegistros
  group by MomentoRegistro;
  
    select MomentoRegistro, Registro, Componente
  from tabelaRegistros
  group by MomentoRegistro, Registro, Componente
  order by MomentoRegistro;
  
  select * from registro;
  select * from componenteServidor;
  
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