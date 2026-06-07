var empresaModel = require("../models/empresaModel");

function listar(req, res) {
    empresaModel.listar()
        .then((resultado) => {
            if (resultado.length === 0) {
                return res.status(204).send();
            }
            res.status(200).json(resultado);
        })
        .catch((erro) => {
            console.error("Erro ao listar empresas:", erro);
            res.status(500).json({ mensagem: "Erro interno ao listar empresas." });
        });
}

module.exports = { 
  listar
};