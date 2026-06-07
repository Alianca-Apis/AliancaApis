var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/buscarLeitura/:id_apiario", function (req, res) {
    dashboardController.buscarLeitura(req, res);
})

router.get("/kpis", function (req, res) {
    dashboardController.buscarKpis(req, res);
});

module.exports = router;