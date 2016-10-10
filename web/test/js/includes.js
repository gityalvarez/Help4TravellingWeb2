
//Espera a que el documento esta totalmente cargado
$(document).ready(function () {    
     $("#header").load("header.html", function () {
         $("#footer").load("footer.html", function () {
         });
     });
});


