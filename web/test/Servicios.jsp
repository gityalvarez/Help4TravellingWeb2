<%-- 
    Document   : Servicios
    Created on : 05-oct-2016, 15:00:32
    Author     : Leonardo
--%>

<%@page import="Logica.ManejadorServicio"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedList"%>
<%@page import="PruebaModelo.Consultas"%>
<%@page import="Logica.DtServicio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        <title>Listado de Servicios</title>
        <div class="navbar navbar-default navbar-fixed-top" id="header"></div>
        <div class="section minimo">
          <div class="container">
            <div class="row">
              <p class="default">Ofertas en Hoteles, Paquetes de viaje y más</p>
            </div>
            <div class="row">
              <table>  
                  <tr>
                     <td>
                        <div class="col-md-12">              
                            <div class="section">
                                <div>
                                    <%@include file="Categorias.jsp"%>
                                </div>
                            </div>
                        </div> 
                    </td>
                    <td>
                        <div class="col-md-12">              
                            <div class="section">
                                <div>
                                    <div class="row default">
                                        <div class="row default"><h2><b>Listado de Servicios</b></h2></div>
                                        <table class="default table table-bordered table-hover table-striped">
                                            <thead>
                                                <tr class="default">
                                                    <td class="default" width="200" align="center"><b>Nombre</b></td>
                                                    <td class="default" width="400" align="center"><b>Descripcion</b></td>
                                                    <td class="default" width="200" align="center"><b>Proveedor</b></td>
                                                    <td class="default" width="100" align="center"><b>Precio</b></td>
                                                    <td class="default" width="100" align="center"><b>Origen</b></td>                          
                                                </tr>
                                            </thead>
                                            <tbody>    
                                              <!--tr >
                                                <td colspan="4"></td>
                                              </tr-->
                                                <% DtServicio dtServ = null;
                                                    List<DtServicio> servicios;
                                                    /*Consultas con = new Consultas();
                                                    servicios = con.listarServiciosSistema();*/
                                                    servicios = ManejadorServicio.getInstance().listarServicios();
                                                    Iterator<DtServicio> iter = servicios.iterator();
                                                    while (iter.hasNext()){
                                                        dtServ = iter.next();
                                                        String nombre = dtServ.getNombre();
                                                        String proveedor = dtServ.getNkProveedor();
                                                        String descripcion = dtServ.getDescripcion();
                                                        float precio = dtServ.getPrecio();
                                                        String origen = dtServ.getNomCiuOrigen();
                                                        String categoria = "Air France";                               
                                                %>     
                                                <tr class="default">
                                                     <td class="default" align="center" width="200" id="nombre"><a href="Servicio.jsp?nombre=<% out.print(nombre); %>&proveedor=<% out.print(proveedor); %>&categoria=<% out.print(categoria); %>"><%=nombre%></a></td>                                       
                                                     <td class="default" align="center" width="400" id="descripcion"><%=descripcion%></td>                             
                                                     <td class="default" align="center" width="200" id="proveedor"><%=proveedor%></td>
                                                     <td class="default" align="center" width="100" id="precio"><%=precio%></td>
                                                     <td class="default" align="center" width="100" id="origen"><%=origen%></td>
                                                </tr>
                                                <%}%>                       
                                            </tbody>
                                        </table>
                                        <ul class="list-group"></ul>
                                    </div>                  
                                </div>
                            </div>
                        </div>
                    </td>
                  </tr>
                </table>
              </div>
            </div>
          </div>    
        <footer class="section section-primary" id="footer"></footer>
    </body>
</html>

  
  
