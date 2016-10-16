<%-- 
    Document   : Promocion
    Created on : 15-oct-2016, 15:42:54
    Author     : Leonardo
--%>

<%@page import="Logica.DtPromocion"%>
<%@page import="Logica.ManejadorProveedor"%>
<%@page import="Logica.ManejadorServicio"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="Logica.DtCategoria"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Logica.DtUsuario"%>
<%@page import="java.util.List"%>
<%@page import="Logica.ManejadorCategoria"%>
<%@page import="Logica.DtServicio"%>
<%@page import="PruebaModelo.Consultas"%>
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
  </head>
  <title>Detalle de Promoción</title>
    <div class="navbar navbar-default navbar-fixed-top" id="header"></div>
    <div>
      <p>AAA</p>
    </div>
    <!--div class="section"></div-->
    <% String nombre = (String) request.getParameter("nombre");
       String proveedor = (String) request.getParameter("proveedor");
       DtPromocion dtProm = ManejadorServicio.getInstance().getDTPromocion(nombre,proveedor); 
       out.print(dtProm.getNombre()); 
    %>    
    <div class="section">
      <div class="container">
        <div class="row">
          <p class="default">Ofertas en Hoteles, Paquetes de viaje y más</p>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="section">
              <div class="container">
                <div class="col-md-6">
                    <div class="row default">
                        <h2><b>Servicios de la Promoción</b></h2>
                    </div>
                    <hr>
                    <table class="default table table-bordered table-hover table-striped">
                        <thead>
                            <tr class="default">
                                <td class="default" width="200" align="center"><b>Nombre</b></td>
                                <td class="default" width="50" align="center"><b>Proveedor</b></td>
                                <td class="default" width="400" align="center"><b>Descripción</b></td>
                                <td class="default" width="50" align="center"><b>Precio</b></td>
                                <td class="default" width="100" align="center"><b>Origen</b></td>
                            </tr>
                        </thead>
                        <tbody>
                        <%  float total = 0;
                            List<String> nomsServProm = new LinkedList<String>();
                            Consultas conlsdp = new Consultas();
                            nomsServProm = conlsdp.listarServiciosDePromociones(nombre,proveedor);
                            if (!nomsServProm.isEmpty()) {
                                List<DtServicio> serviciosProm = new LinkedList<DtServicio>();
                                Iterator<String> itnomserv = nomsServProm.iterator();
                                while (itnomserv.hasNext()) {
                                    String servprom = itnomserv.next();
                                    Consultas congps = new Consultas();
                                    String provserv = congps.getNkProveedorServicio(servprom);
                                    DtServicio dtServ = ManejadorServicio.getInstance().getDtServicio(servprom,provserv);
                                    serviciosProm.add(dtServ);                                    
                                } 
                                if (!serviciosProm.isEmpty()) {
                                    Iterator<DtServicio> itserv = serviciosProm.iterator();
                                    total = 0;
                                    while (itserv.hasNext()){
                                        DtServicio dtServ1 = itserv.next();                                                        
                                        String nomserv = dtServ1.getNombre();
                                        String provserv = dtServ1.getNkProveedor();
                                        String descripcion = dtServ1.getDescripcion();
                                        float precio = dtServ1.getPrecio();
                                        String origen = dtServ1.getNomCiuOrigen();
                                        total = total + precio; %> 
                                        <tr class="default">
                                            <td class="default" align="center" width="200" id="nombre"><a href="Servicio.jsp?nombre=<% out.print(nomserv); %>&proveedor=<% out.print(provserv); %>&categoria=<% out.print(""); %>" target="_blank"><%=nomserv%></a></td>                                           
                                            <td class="default" align="center" width="50" id="proveedor"><%=provserv%></td>
                                            <td class="default" align="center" width="400" id="descripcion"><%=descripcion%></td>                             
                                            <td class="default" align="center" width="50" id="precio"><%=precio%></td>
                                            <td class="default" align="center" width="100" id="origen"><%=origen%></td>
                                        </tr>                                        
                                    <%  } 
                                } 
                            } %>                       
                        </tbody>
                    </table>
                    <ul class="list-group"></ul>
                </div>
                  <div class="col-md-6">
                    <h1><%=nombre%></h1>                    
                    <h3><% DtUsuario prov = ManejadorProveedor.getInstance().getDtProveedor(proveedor);
                        out.print(prov.getNombre()); out.print(" "); out.print(prov.getApellido()); %></h3>
                    <hr>
                    <h3>U$D <%=total%></h3>                    
                    <hr>
                    <% if (Float.parseFloat(dtProm.getPrecio()) > 0) { %>
                        <h3><%=dtProm.getPrecio()%>% de Descuento</h3> 
                    <% } %>
                    <hr>
                    <form class="form-horizontal" role="form" action="../agregarCarrito" method="post">
                      <div class="form-group">
                        <div class="col-sm-4">
                          <input type="hidden" class="hiddden" id="servicio_in" name="servicio_in" value="<%=nombre%>">
                          <input type="hidden" class="hiddden" id="precio_in" name="precio_in" value="<%=total%>"> 
                        <% if ((String) session.getAttribute("nickname") != null) {%>
                            <input type="text" class="form-control input-lg" id="cantidad_in" name="cantidad_in"  placeholder="Cantidad">
                      <%} else {%>
                        <input type="text" disabled="true"class="form-control input-lg" id="cantidad_in" name="cantidad_in"  placeholder="Cantidad"> 
                      <%}%>
                        </div>
                        <% if ((String) session.getAttribute("nickname") != null) {%>
                            <button type="submit" width="5000" class="active btn btn-info btn-lg">Agregar al Carrito</button>
                      <%} else {%>
                            <button type="submit" width="5000" disabled="true" class="active btn btn-info btn-lg">Agregar al Carrito</button>
                        <%}%>
                      </div>
                    </form>                    
                   </div>
                </div>
              </div>
            </div>
        </div>
      </div>
    </div>    
    <footer class="section section-primary" id="footer"></footer>
