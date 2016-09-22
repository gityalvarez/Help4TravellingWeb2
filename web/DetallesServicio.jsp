<%-- 
    Document   : DetallesServicio
    Created on : 18/09/2016, 02:35:06 PM
    Author     : yaman
    css http://dhbhdrzi4tiry.cloudfront.net/cdn/sites/foundation.min.css
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="" lang="en"><head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Foundation | Welcome</title>
        <link rel="stylesheet" href="http://dhbhdrzi4tiry.cloudfront.net/cdn/sites/foundation.min.css">
        <meta class="foundation-mq"></head>
    <body>
       
        <div class="row"
            <h6>Ofertas en Hoteles, Paquetes de viajes y más</h6>
        </div>    

        <br>
        <!-- You can now combine a row and column if you just need a 12 column row -->
        <div class="row columns">
            <nav aria-label="You are here:" role="navigation">
                <ul class="breadcrumbs">
                    <li><a href="#">Hoteles</a></li>
                    <li><a href="#">Conrad</a></li>
                    
                    <%--<li>
                        <span class="show-for-sr">Current: </span> Cloning
                    </li>
                    --%>
                </ul>
            </nav>
        </div>

        <div class="row">
            <div class="medium-6 columns">
                <img class="thumbnail" src="img/conrad1.jpg">
                <div class="row small-up-4">
                    <div class="column">
                        <img class="thumbnail" src="img/conrad2.jpg">
                    </div>
                    <div class="column">
                        <img class="thumbnail" src="img/conrad3.jpg">
                    </div>
                    <div class="column">
                        <img class="thumbnail" src="img/conrad4.jpg">
                    </div>
                    
                </div>
            </div>
                       
            
           
            <div class="medium-6 large-5 columns">
                <h3>Hotel Conrad</h3>
                <p>Nunc eu ullamcorper orci. Quisque eget odio ac lectus vestibulum faucibus eget in metus. In pellentesque faucibus vestibulum. Nulla at nulla justo, eget luctus tortor. Nulla facilisi. Duis aliquet egestas purus in.</p>

                <%--  <label>Size
                  <select>
                    <option value="husker"></option>
                    <option value="starbuck">Medium</option>
                    <option value="hotdog">Large</option>
                    <option value="apollo">Yeti</option>
                  </select>
                  </label>
                --%>

                <div class="row">
                    <h5>  Precio $88.99 </h5>
                    <div class="small-3 columns">
                        <label for="middle-label" class="middle">Cantidad</label>
                    </div>
                    <div class="small-9 columns">
                        <input type="text" id="middle-label" placeholder="Digite la cantidad">
                    </div>
                </div>

                <a href="#" class="button large expanded">AGREGAR AL CARRITO</a>

                <div class="small secondary expanded button-group">
                    <h5> Categorías </h5> 
                    <a class="button">Iberia</a>
                    <a class="button">Lowcost</a>
                    <a class="button">Hotel</a>
                    <a class="button">Montaña</a>
                </div>
            </div>
        </div>



        <div class="row column">
            <hr>
            <ul class="menu">
                <li>Help4Travelling</li>
                <li><a href="#">Home</a></li>
                <li><a href="#">About</a></li>
                <li><a href="#">Contact</a></li>
                <li class="float-right">Copyright 2016</li>
            </ul>
        </div>



        <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
        <script src="http://dhbhdrzi4tiry.cloudfront.net/cdn/sites/foundation.js"></script>
        <script>
            $(document).foundation();
        </script>




    </body></html>