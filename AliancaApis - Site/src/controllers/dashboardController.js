var dashboardModel = require("../models/dashboardModel");

function buscarLeitura(req, res) {
  var id_apiario = req.params.id_apiario;

  dashboardModel.buscarLeitura(id_apiario).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar os apiários: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

module.exports = {
  buscarLeitura
};