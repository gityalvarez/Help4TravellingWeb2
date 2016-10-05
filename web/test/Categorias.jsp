<%-- 
    Document   : newjsp1
    Created on : 05/10/2016, 07:59:31 AM
    Author     : yaman
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Demo</title>
    <script src="js/jquery-3.1.1.js"></script>
    <script src="js/jstree.min.js"></script>
    <script>
        $(document).ready(function(){
            $("#selector").jstree();
        });
    </script>
</head>
<body>
    <div id="selector">
        <ul>
            <li class="jstree-open"><a>Categorias</a>
                <ul>
                    <li><a>Alojamientos</a>
                        <ul>
                            <li><a>Habitaciones</a>
                                <ul>
                                    <li><a>1 ambiente </a></li>
                                    <li><a>1 dormitorio </a></li>
                                    <li><a>2 dormitorios </a></li>
                                </ul>    
                            </li>
                            <li><a>Tipo Alojamiento</a>
                                <ul>
                                    <li><a>Apartamento</a></li>
                                    <li><a>Casa</a></li>
                                    <li><a>Hostal</a></li>
                                    <li><a>Hotel</a></li>
                                </ul>    
                            </li>
                            <li><a>Ubicacion</a>
                                <ul>
                                    <li><a>Montaña</a></li>
                                    <li><a>Playa</a></li>
                                    <li><a>Rural</a></li>
                                </ul>           
                            </li>    
                        </ul>
                    </li>
                    <li><a>Automoviles</a>
                        <ul>
                            <li><a>Marca</a>
                                <ul>
                                    <li><a>Chevrolet</a></li>
                                    <li><a>Daihatsu</a></li>
                                    <li><a>Fiat</a></li>
                                    <li><a>Ford</a></li>
                                    <li><a>Peugeot</a></li>
                                </ul>                                
                            </li>
                            <li><a>Tarifa</a>
                                <ul>
                                    <li><a>Economico</a></li>
                                    <li><a>Full</a></li>
                                    <li><a>Mini</a></li>
                                    <li><a>Standard</a></li>
                                </ul>
                            </li>
                            <li><a>Tipo Vehiculo</a>
                                <ul>
                                    <li><a>Auto</a></li>
                                    <li><a>Camion</a></li>
                                    <li><a>Camioneta</a></li>
                                    <li><a>Moto</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li><a>Cruceros</a>
                        <ul>
                            <li><a>Alaska</a></li>
                            <li><a>Caribe</a></li>
                            <li><a>Mar negro</a></li>
                            <li><a>Mediterraneo</a></li>
                            <li><a>Nilo</a></li>
                        </ul>
                    </li>
                    <li><a>Vuelos</a>
                        <ul>
                            <li><a>Empresas</a>
                                <ul>
                                    <li><a>Air France</a></li>
                                    <li><a>American Airlines</a></li>
                                    <li><a>Iberia</a></li>
                                    <li><a>TAM</a></li>
                                </ul>                                
                            </li>
                            <li><a>Tipo Vuelo</a>
                                <ul>
                                    <li><a>First Class</a></li>
                                    <li><a>LowCost</a></li>
                                    <li><a>Standard</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>                    
                </ul>
            </li>
        </ul>
    </div>
</body>
</html>
