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

module.exports = {buscarLeitura}