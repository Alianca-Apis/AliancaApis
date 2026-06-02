var database = require("../database/config");

function buscarApiariosPorEmpresa(empresaId) {
  var instrucaoSql = `
    SELECT
      a.idApiario, a.identificacaoApiario AS descricao,
      (
        SELECT l2.temperatura
        FROM sensor s2
        JOIN leitura l2 ON l2.fkSensor = s2.idSensor
        WHERE s2.fkApiario = a.idApiario
        ORDER BY l2.dataHora DESC
        LIMIT 1
      ) AS temperaturaAtual,
      ROUND(AVG(l.temperatura), 1) AS temperaturaMedia
    FROM apiario a
    LEFT JOIN sensor s ON s.fkApiario = a.idApiario
    LEFT JOIN leitura l ON l.fkSensor = s.idSensor
    WHERE a.fkEmpresa = ${empresaId}
    GROUP BY a.idApiario, a.identificacaoApiario
    ORDER BY a.idApiario;
  `;
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
