var express = require("express");
var router = express.Router();

var apiarioController = require("../controllers/apiarioController");

router.get("/:empresaId", function (req, res) {
  apiarioController.buscarApiariosPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  apiarioController.cadastrar(req, res);
})

module.exports = router;