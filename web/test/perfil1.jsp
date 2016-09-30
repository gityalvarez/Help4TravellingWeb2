<%-- 
    Document   : perfil1
    Created on : 26/09/2016, 05:07:29 PM
    Author     : HP Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Logica.Cliente" %>
<%@page import="Logica.Date" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css\test.css" rel="stylesheet" type="text/css">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
         <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
         <script>
             	$(document).ready(function(){
		
			
                        agregar();
                        agregar();
                    };

        var cont=0;
	var id_fila_selected=[];
	function agregar(){
		cont++;
		var fila='<tr class="selected" id="fila'+cont+'" onclick="seleccionar(this.id);"><td>'+cont+'</td><td>texto x defecto</td><td>0.00</td></tr>';
		$('#tabla').append(fila);
		reordenar();
	}
        agregar();
        agregar();
        agregar();
         </script>
        <title>Ver Perfil</title>
    </head>
    <body>
        <% 
            Date fecha1 = new Date(10,11,2012);
            Cliente usu  = new Cliente("juan","Perez","Juanpe","contrasenia","alfalfa@gmail.com",fecha1,"aca la imagen");
            Integer dia = usu.getNacimiento().getDia();
            Integer mes = usu.getNacimiento().getMes();
            Integer anio = usu.getNacimiento().getAno();
            String fexa= dia.toString()+"/"+mes.toString()+"/"+anio.toString() ;
           
           %>     
     <div class="section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <ul class="media-list">
                            <li class="media">
                                <a class="pull-left" href="#"><img class="media-object" src="../img/user.png" height="64" width="64"></a>
                                <div class="media-body">
                                    <h2 class="media-heading"><%= usu.getNickname() %></h2>
                                    <p><%= usu.getCorreo() %></p>
                                </div>
                            </li>
                            <li class="media"></li>
                        </ul>
                    </div>
                </div>
                <!--
                <div class="row">
                    <div class="col-md-12">
                       <!-- <ul class="nav nav-pills">
                            <li class="active">
                                <a href="#">Datos personales</a>
                            </li>
                            <li>
                                <a href="#">Reservas</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <ul class="list-group">
                            <li class="list-group-item">Nombre: </li>
                            <li class="list-group-item">Apellido:</li>
                            <li class="list-group-item">F de nac:</li>
                           
                        </ul>
                      
                    </div>
                    -->
                    <!-- Aca empieza la tabla-->
                    

                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a data-toggle="tab" href="#Datos">Datos personales</a></li>
                         <li><a data-toggle="tab" href="#reservas">Reservas</a></li>

                       </ul>
                     
                       <div class="tab-content">
                         <div id="Datos" class="tab-pane fade in active">

                            <div class="row">
                                         <div class="col-md-12">
                                             <ul class="list-group">
                                                 <li class="list-group-item">Nombre: <%= usu.getNombre()%> </li>
                                                 <li class="list-group-item">Apellido: <%= usu.getApellido() %></li>
                                                 <%--   lo ideal pero el formato Date da AAAAMMDD entonces se presenta al reves
                                                        <li class="list-group-item">F de nac: <%= usu.getNacimiento().getFecha("/")  %></li> --%>
                                                        <li class="list-group-item">F de nac: <%= fexa  %></li>
                                             </ul>

                                         </div>
                                     </div>
                         </div>
                         <div id="reservas" class="tab-pane fade">
                           <h3>Acá mostraria las reservas</h3>
                           <p>Acá diria las reservas.</p>
                          
		<table id="tabla" class="table table-bordered">
                    <thead>
                            <tr>
                                    <td>numero</td>
                                    <td>id de reserva</td>
                                    <td>Creada</td>
                                    <td>total</td>
                                    <td>Estado</td>
                            </tr>
                    </thead>
                </table>

                         </div>
                       </div>


  </div>
</div>


                    
                </div>
            </div>
       
         
    </body>
</html>
