var database = require("../database/config");

function listar() {
    var instrucaoSql = `SELECT idEmpresa, razaoSocial, nomeFantasia, cnpj FROM empresa ORDER BY nomeFantasia`;
    return database.executar(instrucaoSql);
}

module.exports = { 
  listar
};