var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas", function (req, res) {
    medidaController.plotarGrafico(req, res);
})

router.get("/geral", function (req, res) {
    medidaController.geral(req, res);
})

module.exports = router;