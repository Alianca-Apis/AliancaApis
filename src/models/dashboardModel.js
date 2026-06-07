var database = require("../database/config");

function buscarLeitura(id_apiario) {
  var instrucaoSql = `SELECT 
    l.temperatura, 
    DATE_FORMAT(l.dataHora, '%H:%i:%s') AS momento_grafico, 
    s.fkApiario 
FROM leitura l
JOIN sensor s ON l.fkSensor = s.idSensor
WHERE s.fkApiario = ${id_apiario}
ORDER BY l.idLeitura DESC LIMIT 100;`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarKpis(empresaId) {
  var instrucaoSql = `
    SELECT
        SUM(l.temperatura BETWEEN 34.5 AND 36) AS ideal,
        SUM((l.temperatura BETWEEN 30 AND 34.4) OR (l.temperatura BETWEEN 36.1 AND 40)) AS alerta,
        SUM(l.temperatura <= 29.9 OR l.temperatura >= 40.1) AS critico
    FROM leitura l
    JOIN sensor s ON l.fkSensor = s.idSensor
    JOIN apiario a ON s.fkApiario = a.idApiario
    WHERE a.fkEmpresa = ${empresaId}
      AND l.idLeitura IN (SELECT MAX(idLeitura) FROM leitura GROUP BY fkSensor);
    `;
  return database.executar(instrucaoSql);
}

module.exports = { 
  buscarLeitura, 
  buscarKpis 
};