var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas", function (req, res) {
    medidaController.cpuPorcentagem(req, res);
})

router.get("/geral", function (req, res) {
    medidaController.geral(req, res);
})

/* router.get("/tempo-real/:idAquario", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
}) */

module.exports = router;