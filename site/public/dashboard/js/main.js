(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner();
    
    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
        return false;
    });


    // Sidebar Toggler
    $('.sidebar-toggler').click(function () {
        $('.sidebar, .content').toggleClass("open");
        return false;
    });


    // Progress Bar
    $('.pg-bar').waypoint(function () {
        $('.progress .progress-bar').each(function () {
            $(this).css("width", $(this).attr("aria-valuenow") + '%');
        });
    }, {offset: '80%'});


    // Calender
    $('#calender').datetimepicker({
        inline: true,
        format: 'L'
    });


    // Testimonials carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1000,
        items: 1,
        dots: true,
        loop: true,
        nav : false
    });


    // Chart Global Color
    Chart.defaults.color = "#fff";
    Chart.defaults.borderColor = "#141414";

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
    dashboardTitle.innerHTML = "Servidor - CPU"
}

function showMemory() {
    dashboardMemory.classList.remove(`invisivel`)
    dashboardTitle.innerHTML = "Servidor - Memória"
}

function showDisk() {
    dashboardDisk.classList.remove(`invisivel`)
    dashboardTitle.innerHTML = "Servidor - Disco"
}

function showUpload() {
    dashboardUpload.classList.remove(`invisivel`)
    dashboardTitle.innerHTML = "Servidor - Upload"
}

function showDownload() {
    dashboardDownload.classList.remove(`invisivel`)
    dashboardTitle.innerHTML = "Servidor - Download"
}

function showFreq() {
    dashboardFreq.classList.remove(`invisivel`)
    dashboardTitle.innerHTML = "Servidor - Frequência da CPU"
}
