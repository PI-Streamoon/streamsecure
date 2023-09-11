var database = require("../database/config");

function plotarGrafico() {
    var instrucao = ``;
   
    instrucao = `select registro as cpuPorcentagem, DATE_FORMAT((dtHora), '%d-%m-%Y %H:%i:%s') as dtHora from registro join componenteServidor on fkComponenteServidor = idComponenteServidor 
     join componente on fkComponente = idComponente 
     join unidadeMedida on fkUnidadeMedida = idUnidadeMedida
     where DAY(registro.dtHora) = DAY(NOW()) and componente.nome = 'CPU' and unidadeMedida.nomeMedida = '%' order by dtHora desc LIMIT 1;`;

    return database.executar(instrucao);
    } 
    /* console.log("Executando a instrução SQL: \n" + instrucaoSql); */


function buscarUltimasMedidas(idAquario, limite_linhas) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top ${limite_linhas}
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        momento,
                        FORMAT(momento, 'HH:mm:ss') as momento_grafico
                    from medida
                    where fk_aquario = ${idAquario}
                    order by id desc`;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    from medida
                    where fk_aquario = ${idAquario}
                    order by id desc limit ${limite_linhas}`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idAquario) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        CONVERT(varchar, momento, 108) as momento_grafico, 
                        fk_aquario 
                        from medida where fk_aquario = ${idAquario} 
                    order by id desc`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
                        fk_aquario 
                        from medida where fk_aquario = ${idAquario} 
                    order by id desc limit 1`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function geral() {
    var instrucao = ``

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucao = `
        `;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucao = `
        SELECT DATE_FORMAT((dtHora), '%d-%m-%Y %H:%i:%s') as dtHora,
        max(CASE WHEN fkComponenteServidor = 1 THEN registro END) AS 'cpu',
        max(CASE WHEN fkComponenteServidor = 2 THEN registro END) AS 'memoria',
        max(CASE WHEN fkComponenteServidor = 5 THEN registro END) AS 'disco'
        FROM registro GROUP BY dtHora ORDER BY dtHora DESC LIMIT 1;
        `;
    } else {
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = {
    plotarGrafico,
    geral
}