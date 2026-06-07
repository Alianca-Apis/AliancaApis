var express = require("express");
var router = express.Router();
var dashboardRouter = require("./dashboard");

router.get("/", function (req, res) {
    res.render("index");
});

module.exports = router;