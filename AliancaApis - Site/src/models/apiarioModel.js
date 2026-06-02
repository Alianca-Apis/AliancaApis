var database = require("../database/config");

function buscarApiariosPorEmpresa(empresaId) {
  var instrucaoSql = `
  SELECT a.idApiario, l.temperatura, AVG(l.temperatura) FROM apiario a
  JOIN sensor s ON s.fkApiario = a.idApiario
  JOIN leitura l ON l.fkSensor = s.idSensor
  WHERE idApiario = ${apiarioId} AND a.fkEmpresa = ${empresaId}
  GROUP BY a.idApiario, l.temperatura;
  `
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresaId, descricao) {

  var instrucaoSql = `INSERT INTO apiario (identificacaoApiario, fkEmpresa) VALUES ('${descricao}', ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarApiariosPorEmpresa,
  cadastrar
}
