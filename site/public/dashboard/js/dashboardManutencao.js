var labelsGeral = [];
var dadosGeral = [];
var dashboardGeral;

var labelsCpuPorcentagem = []
var dadosCpuPorcentagem = []
var dashboardCpuPorcentagem;

(function ($) {
    "use strict";

    Chart.defaults.color = "#ffffff";

    setInterval(atualizarGraficoGeral, 5000)
    setInterval(atualizarGraficoCpuPorcentagem, 1000)

    function atualizarGraficoGeral() {
        fetch(`/medidas/geral`, { cache: 'no-store' }).then(function (response) {
            if (response.ok) {
                response.json().then(function (resposta) {
                    console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);
                    resposta.reverse();
    
                    for (var i = 0; i < resposta.length; i++) {
                        var registro = resposta[i];
                        labelsGeral.push(registro.dtHora);
                        dadosGeral.datasets[0].data.push(registro.cpu);
                        dadosGeral.datasets[1].data.push(registro.memoria);
                        dadosGeral.datasets[2].data.push(registro.disco);
                    }

                    if (labelsGeral.length > 15) {
                        labelsGeral.shift()
                        dadosGeral.datasets[0].data.shift()
                        dadosGeral.datasets[1].data.shift()
                        dadosGeral.datasets[2].data.shift()
                    }

                    dashboardGeral.update()
                });
            } else {
                console.error('Nenhum dado encontrado ou erro na API');
            }
        })
            .catch(function (error) {
                console.error(`Erro na obtenção dos dados p/ gráfico: ${error.message}`);
            });
    }

    function atualizarGraficoCpuPorcentagem() {
        fetch(`/medidas/ultimas`, { cache: 'no-store' }).then(function (response) {
            if (response.ok) {
                response.json().then(function (resposta) {
                    console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);
                    resposta.reverse();
    
                    for (var i = 0; i < resposta.length; i++) {
                        var registro = resposta[i];
                        labelsCpuPorcentagem.push(registro.dtHora);
                        dadosCpuPorcentagem.datasets[0].data.push(registro.cpuPorcentagem);
                    }

                    if (labelsCpuPorcentagem.length > 10) {
                        labelsCpuPorcentagem.shift()
                        dadosCpuPorcentagem.datasets[0].data.shift()
                    } 

                    dashboardCpuPorcentagem.update()
                });
            } else {
                console.error('Nenhum dado encontrado ou erro na API');
            }
        })
            .catch(function (error) {
                console.error(`Erro na obtenção dos dados p/ gráfico: ${error.message}`);
            });
    }

    // Dashboard Geral

    labelsGeral = []
    dadosGeral = {
    labels: labelsGeral,
    datasets: [{
        label: "Uso da CPU",
        data: [],
        backgroundColor: "#6248AE"
    },
    {
        label: "Uso da Memória",
        data: [],
        backgroundColor: "#0d6efd"
    },
    {
        label: "Uso do Disco",
        data: [],
        backgroundColor: "#d63384"
    }],
    }

    dashboardGeral = new Chart(document.getElementById(`dashboardGeral`), {
        type: "bar",
        data: dadosGeral,
        options: {
            scales: {
                y: {
                    min: 0,
                    max: 100,
                }
            },
            responsive: true
        }
    });
    
    // Dashboard CPU

    labelsCpuPorcentagem = []
    dadosCpuPorcentagem = {
        labels: labelsCpuPorcentagem,
        datasets: [{
            label: "CPU Porcentagem",
            data: [],
            backgroundColor: "#6248AE"
        }]
    }

    dashboardCpuPorcentagem = new Chart(dashboardCpu, {
        type: "line",
        data: dadosCpuPorcentagem,
        options: {
            scales: {
                y: {
                    min: 0,
                    max: 100
                }
            },
            responsive: true
        }
    });

    // Dashboard Memoria
    new Chart(dashboardMemory, {
        type: "line",
        data: {
            labels: ["2016", "2017", "2018", "2019", "2020", "2021", "2022"],
            datasets: [{
                    label: "Salse",
                    data: [15, 30, 55, 45, 70, 65, 85],
                    backgroundColor: "rgba(163,45,163, .7)",
                    fill: true
                },
                {
                    label: "Revenue",
                    data: [99, 135, 170, 130, 190, 180, 270],
                    backgroundColor: "rgba(163,45,163, .5)",
                    fill: true
                }
            ]
            },
        options: {
            responsive: true
        }
    });

    // Dashboard Disco
    new Chart(dashboardDisk, {
        type: "line",
        data: {
            labels: ["2016", "2017", "2018", "2019", "2020", "2021", "2022"],
            datasets: [{
                    label: "Salse",
                    data: [15, 30, 55, 45, 70, 65, 85],
                    backgroundColor: "rgba(163,45,163, .7)",
                    fill: true
                },
                {
                    label: "Revenue",
                    data: [99, 135, 170, 130, 190, 180, 270],
                    backgroundColor: "rgba(163,45,163, .5)",
                    fill: true
                }
            ]
            },
        options: {
            responsive: true
        }
    });

    // Dashboard Upload
     new Chart(dashboardUpload, {
        type: "line",
        data: {
            labels: ["2016", "2017", "2018", "2019", "2020", "2021", "2022"],
            datasets: [{
                    label: "Salse",
                    data: [15, 30, 55, 45, 70, 65, 85],
                    backgroundColor: "rgba(163,45,163, .7)",
                    fill: true
                },
                {
                    label: "Revenue",
                    data: [99, 135, 170, 130, 190, 180, 270],
                    backgroundColor: "rgba(163,45,163, .5)",
                    fill: true
                }
            ]
            },
        options: {
            responsive: true
        }
    });

    // Dashboard Download
    new Chart(dashboardDownload, {
        type: "line",
        data: {
            labels: ["2016", "2017", "2018", "2019", "2020", "2021", "2022"],
            datasets: [{
                    label: "Salse",
                    data: [15, 30, 55, 45, 70, 65, 85],
                    backgroundColor: "rgba(163,45,163, .7)",
                    fill: true
                },
                {
                    label: "Revenue",
                    data: [99, 135, 170, 130, 190, 180, 270],
                    backgroundColor: "rgba(163,45,163, .5)",
                    fill: true
                }
            ]
            },
        options: {
            responsive: true
        }
    });

    // Dashboard Frequência
    new Chart(dashboardFreq, {
        type: "line",
        data: {
            labels: ["2016", "2017", "2018", "2019", "2020", "2021", "2023"],
            datasets: [{
                    label: "Salse",
                    data: [15, 30, 55, 45, 70, 65, 85],
                    backgroundColor: "rgba(163,45,163, .7)",
                    fill: true
                },
                {
                    label: "Revenue",
                    data: [99, 135, 170, 130, 190, 180, 270],
                    backgroundColor: "rgba(163,45,163, .5)",
                    fill: true
                }
            ]
            },
        options: {
            responsive: true
        }
    });
    
    
    // Single Line Chart
    // var ctx3 = $("#line-chart").get(0).getContext("2d");
    // var myChart3 = new Chart(ctx3, {
    //     type: "line",
    //     data: {
    //         labels: [50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150],
    //         datasets: [{
    //             label: "Salse",
    //             fill: false,
    //             backgroundColor: "rgba(163,45,163, .7)",
    //             data: [7, 8, 8, 9, 9, 9, 10, 11, 14, 14, 15]
    //         }]
    //     },
    //     options: {
    //         responsive: true
    //     }
    // });


    // Single Bar Chart
    // var ctx4 = $("#bar-chart").get(0).getContext("2d");
    // var myChart4 = new Chart(ctx4, {
    //     type: "bar",
    //     data: {
    //         labels: ["Italy", "France", "Spain", "USA", "Argentina"],
    //         datasets: [{
    //             backgroundColor: [
    //                 "rgba(163,45,163, .7)",
    //                 "rgba(163,45,163, .6)",
    //                 "rgba(163,45,163, .5)",
    //                 "rgba(163,45,163, .4)",
    //                 "rgba(163,45,163, .3)"
    //             ],
    //             data: [55, 49, 44, 24, 15]
    //         }]
    //     },
    //     options: {
    //         responsive: true
    //     }
    // });


    // Pie Chart
    // var ctx5 = $("#pie-chart").get(0).getContext("2d");
    // var myChart5 = new Chart(ctx5, {
    //     type: "pie",
    //     data: {
    //         labels: ["Italy", "France", "Spain", "USA", "Argentina"],
    //         datasets: [{
    //             backgroundColor: [
    //                 "rgba(163,45,163, .7)",
    //                 "rgba(163,45,163, .6)",
    //                 "rgba(163,45,163, .5)",
    //                 "rgba(163,45,163, .4)",
    //                 "rgba(163,45,163, .3)"
    //             ],
    //             data: [55, 49, 44, 24, 15]
    //         }]
    //     },
    //     options: {
    //         responsive: true
    //     }
    // });


    // Doughnut Chart
    // var ctx6 = $("#doughnut-chart").get(0).getContext("2d");
    // var myChart6 = new Chart(ctx6, {
    //     type: "doughnut",
    //     data: {
    //         labels: ["Italy", "France", "Spain", "USA", "Argentina"],
    //         datasets: [{
    //             backgroundColor: [
    //                 "rgba(147,115,239, .7)",
    //                 "rgba(147,115,239, .6)",
    //                 "rgba(147,115,239, .5)",
    //                 "rgba(147,115,239, .4)",
    //                 "rgba(147,115,239, .3)"
    //             ],
    //             data: [55, 49, 44, 24, 15]
    //         }]
    //     },
    //     options: {
    //         responsive: true
    //     }
    // });

    
})(jQuery);

function change() {
    dashboardCpu.classList.add(`invisivel`)
    dashboardMemory.classList.add(`invisivel`)
    dashboardDisk.classList.add(`invisivel`)
    dashboardUpload.classList.add(`invisivel`)
    dashboardDownload.classList.add(`invisivel`)
    dashboardFreq.classList.add(`invisivel`)
}

function showCpu() {
    dashboardCpu.classList.remove(`invisivel`)
    dashboardTitle.innerHTML = "Servidor - Uso da CPU (%)"
}

function showMemory() {
    dashboardMemory.classList.remove(`invisivel`)
    dashboardTitle.innerHTML = "Servidor - Uso da Memória (%)"
}

function showDisk() {
    dashboardDisk.classList.remove(`invisivel`)
    dashboardTitle.innerHTML = "Servidor - Uso do Disco (%)"
}

function showUpload() {
    dashboardUpload.classList.remove(`invisivel`)
    dashboardTitle.innerHTML = "Servidor - Velocidade de Upload (Kb / s)"
}

function showDownload() {
    dashboardDownload.classList.remove(`invisivel`)
    dashboardTitle.innerHTML = "Servidor - Velocidade de Download (Kb / s)"
}

function showFreq() {
    dashboardFreq.classList.remove(`invisivel`)
    dashboardTitle.innerHTML = "Servidor - Frequência da CPU (Ghz)"
}