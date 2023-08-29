var database = require("../database/config");

function plotarGrafico() {
    console.log("ACESSEI O AMBIENTE MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function plotarGrafico() \n\n " + idRegistro);
   var instrucaoSql = `select registro, dtHora from registro join componenteServidor on fkComponenteServidor = idComponenteServidor 
    join componente on fkComponente = idComponente 
    join unidadeMedida on fkUnidadeMedida = idUnidadeMedida
    where DAY(registro.dtHora) = DAY(NOW()) and componente.nome = 'CPU' and unidadeMedida.nomeMedida = '%'`;
    } 
    /* console.log("Executando a instrução SQL: \n" + instrucaoSql); */

module.exports = {
    plotarGrafico
}
