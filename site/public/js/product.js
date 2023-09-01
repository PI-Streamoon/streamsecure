
  window.onresize = ()=>{
    var largura = window.innerWidth

    console.log('aaa')
    console.log(largura)

    if(largura < 800){
      document.getElementById('logo-navbar').setAttribute('src', './features/img/logo.png')
    }else if(largura > 801){
      document.getElementById('logo-navbar').setAttribute('src', './features/img/nome-e-logo 1.png')
    }
  }


    function openModal() {
        document.getElementById("fade").style.display = "flex";
        document.getElementById("modal").style.display = "flex";
      }
      function closeModal() {
        document.getElementById("fade").style.display = "none";
        document.getElementById("modal").style.display = "none";
      }
  
     
