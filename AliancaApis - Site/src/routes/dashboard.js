var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.get("/buscarLeitura/:id_apiario", function (req, res) {
    dashboardController.buscarLeitura(req, res);
})

module.exports = router;