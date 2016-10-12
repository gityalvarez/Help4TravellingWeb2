<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script src="js/jquery-3.1.0.min.js"></script>
    <script src="js/includes.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="css\test.css" rel="stylesheet" type="text/css">
    <script>
        $(document).ready(function () {   
            setTimeout(function(){
                <%if ((String) session.getAttribute("nickname") != null) {%>
                    $('#idIniciar').hide();
                    $('#idRegistrar').hide();
                <%} else {%> 
                    $('#idPerfil').hide();
                    $('#idReservas').hide();
                    $('#idSalir').hide();
                <%}%>;
            }, 100);
        });
    </script>
  </head>
  <body>
    <div class="navbar navbar-default navbar-fixed-top" id="header"></div>
    <!--div class="section"></div-->
    <div class="section minimo">
      <div class="container">
        <div class="row">
          <p class="default">Ofertas en Hoteles, Paquetes de viaje y más</p>
        </div>
        <div class="row">
          <div class="col-md-12">
            <ul class="breadcrumb">
              <li>
                <a href="#">Principal</a>
              </li>
              <li>
                <a href="#">Categoría</a>
              </li>
              <li class="active">Subcategoría</li>
            </ul>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="section">
              <div class="container">
                <div class="row default">
                  <div class="col-md-6">
                    <a href="#"><img src="http://guiamexico.com.mx/Imagenes/b/203688717-3-turisticos-maxani-servicios-turisticos-y-viajes-escolares.jpeg" class="img-responsive"></a>
                    <hr>
                    <div class="row">
                      <div class="col-md-4">
                        <a href="#"><img src="http://guiamexico.com.mx/Imagenes/b/203688717-3-turisticos-maxani-servicios-turisticos-y-viajes-escolares.jpeg" class="img-responsive"></a>
                      </div>
                      <div class="col-md-4">
                        <a href="#"><img src="http://3.bp.blogspot.com/-9G4QVvS1OAc/VX9qcLZVYGI/AAAAAAAAAI0/ecPY1G2OnCQ/s1600/Baner_bolg_hoteles.jpg" class="img-responsive"></a>
                      </div>
                      <div class="col-md-4">
                        <a href="#"><img src="http://www.sectur.gob.mx/wp-content/uploads/2014/01/3051.jpg" class="img-responsive"></a>
                      </div>
                    </div>
                    <hr>
                    <table class="default table table-bordered table-hover table-striped">
                      <tbody>
                        <tr class="default">
                          <td class="default" width="200">Proveedor</td>
                          <td id="nomprov">Martin Garcia</td>
                        </tr>
                        <tr>
                          <td class="default" width="200">Origen</td>
                          <td id="ciuorigen">Latveria</td>
                        </tr>
                        <tr>
                          <td class="default" width="200">Destino</td>
                          <td id="ciudestino">New York</td>
                        </tr>
                        <tr>
                          <td class="default" width="200">Precio</td>
                          <td id="precio">U$D 2000</td>
                        </tr>
                      </tbody>
                    </table>
                    <ul class="list-group"></ul>
                  </div>
                  <div class="col-md-6">
                    <h1>Servicio 1</h1>
                    <h2>Descripción:</h2>
                    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo
                      ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis
                      dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies
                      nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.
                      Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In
                      enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum
                      felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus
                      elementum semper nisi.</p>
                    <hr>
                    <h2>Precio: U$D&nbsp;</h2>
                    <form class="form-horizontal" role="form">
                      <div class="form-group">
                        <div class="col-sm-4">
                          <input type="text" class="form-control input-lg" id="inputEmail3" placeholder="Cantidad">
                        </div>
                        <button type="submit" width="5000" class="active btn btn-info btn-lg">Agregar al Carrito</button>
                      </div>
                    </form>
                    <hr class="default">
                    <h2>Categorías</h2>
                    <p class="lead">Categoría 1 | Categoría 2 | Categoría 3</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <footer class="section section-primary" id="footer"></footer>
   </body>
</html>