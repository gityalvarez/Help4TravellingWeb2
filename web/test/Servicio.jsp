<%-- 
    Document   : Servicio
    Created on : 03-oct-2016, 23:40:06
    Author     : Leonardo
--%>

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
  <title>Detalle de Servicio</title>
    <div class="navbar navbar-default navbar-fixed-top" id="header"></div>
    <div>
      <p>AAA</p>
    </div>
    <!--div class="section"></div-->
    <% String nombre = (String) request.getParameter("nombre");
       String proveedor = (String) request.getParameter("proveedor");
       String categoria = (String) request.getParameter("categoria");
       //ManejadorCategoria mc = ManejadorCategoria.getInstance();
       String padre = null;
       //padre = mc.obtenerPadre(categoria);
       Consultas con = new Consultas();
       padre = con.obtenerPadre(categoria);
       con = new Consultas();
       String abuelo = null;
       DtServicio dtServ = con.getDtServicio(nombre,proveedor);       
    %>    
    <div class="section">
      <div class="container">
        <div class="row">
          <p class="default">Ofertas en Hoteles, Paquetes de viaje y más</p>
        </div>
        <div class="row">
          <div class="col-md-12">
            <ul class="breadcrumb">
            <%  if (padre != null) {
                    //abuelo = mc.obtenerPadre(padre);
                    con = new Consultas();
                    abuelo = con.obtenerPadre(padre);
                    if (abuelo != null){ 
                        /*out.println("<li>"); 
                        out.println("<a href=\"#\">" + abuelo + "</a>"); 
                        out.println("</li>");*/  %>
                        <li><% out.print(abuelo); %></li>
                 <% }    
                    /*out.println("<li>"); 
                    out.println("<a href=\"#\">" + padre + "</a>"); 
                    out.println("</li>");*/ %>
                    <li><% out.print(padre); %></li>    
            <%  }  %>
            <li class="active"><%=categoria%></li>
            </ul>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="section">
              <div class="container">
                <div class="row default">
                <% List<String> imagenes = dtServ.getImagenes();
                   int cantimgs = imagenes.size(); 
                   System.out.println(cantimgs);
                   if (cantimgs > 0)
                       if (cantimgs == 1){ %>           
                           <div class="col-md-6">                   
                                <a href="#"><img src="<% out.print(imagenes.get(0)); %>" class="img-responsive"></a>
                                <hr> 
                                <div class="row">
                                    <div class="col-md-4">
                                        <a href="#"><img src="<% out.print(imagenes.get(0)); %>" class="img-responsive"></a>
                                    </div>
                                </div>
                    <% }
                       else if (cantimgs == 2){ %>
                                <div class="col-md-6">                   
                                    <a href="#"><img src="<% out.print(imagenes.get(0)); %>" class="img-responsive"></a>
                                    <hr> 
                                    <div class="row">
                                        <div class="col-md-4">
                                            <a href="#"><img src="<% out.print(imagenes.get(0)); %>" class="img-responsive"></a>
                                        </div>
                                        <div class="col-md-4">
                                            <a href="#"><img src="<% out.print(imagenes.get(1)); %>" class="img-responsive"></a>
                                        </div>
                                    </div>
                         <% }
                            else if (cantimgs == 3){ %>
                                    <div class="col-md-6">                   
                                        <a href="#"><img src="<% out.print(imagenes.get(0)); %>" class="img-responsive"></a>
                                        <hr> 
                                        <div class="row">
                                            <div class="col-md-4">
                                                <a href="#"><img src="<% out.print(imagenes.get(0)); %>" class="img-responsive"></a>
                                            </div>
                                            <div class="col-md-4">
                                                <a href="#"><img src="<% out.print(imagenes.get(1)); %>" class="img-responsive"></a>
                                            </div>
                                            <div class="col-md-4">
                                                <a href="#"><img src="<% out.print(imagenes.get(2)); %>" class="img-responsive"></a>
                                            </div>
                                        </div>
                              <% } %>  
                    <hr>
                    <table class="default table table-bordered table-hover table-striped" style="font-size:20px">
                      <tbody>
                        <tr class="default">
                          <td class="default" width="200">Proveedor</td>
                          <% String nickname = dtServ.getNkProveedor();
                             con = new Consultas();
                             DtUsuario prov = con.getDtProveedor(nickname); %> 
                          <td id="nomprov"><% out.print(prov.getNombre()); out.print(" "); out.print(prov.getApellido()); %></td>
                        </tr>
                        <tr>
                          <td class="default" width="200">Origen</td>
                          <td id="ciuorigen"><%=dtServ.getNomCiuOrigen()%></td>                                                    
                        </tr>
                        <% if (dtServ.getNomCiuDestino() != null) {%>
                        <tr>
                          <td class="default" width="200">Destino</td>
                          <td id="ciudestino"><%=dtServ.getNomCiuDestino()%></td>
                        </tr>                        
                        <% } %>
                        <tr>
                          <td class="default" width="200">Precio</td>
                          <td id="precio">U$D <%=dtServ.getPrecio()%></td>
                        </tr>
                      </tbody>
                    </table>
                    <ul class="list-group"></ul>
                  </div>
                  <div class="col-md-6">
                    <h1><%=nombre%></h1>                    
                    <!--h2>Descripción:</h2-->
                    <h3><%=dtServ.getDescripcion()%><h3>
                    <hr>
                    <h3>U$D <%=dtServ.getPrecio()%></h3>
                    <form class="form-horizontal" role="form">
                      <div class="form-group">
                        <div class="col-sm-4">
                          <input type="text" class="form-control input-lg" id="inputEmail3" placeholder="Cantidad">
                        </div>
                        <button type="submit" width="5000" class="active btn btn-info btn-lg">Agregar al Carrito</button>
                      </div>
                    </form>
                    <hr>
                    <h3>Categorías</h3>
                 <% Map<String,DtCategoria> categorias = dtServ.getDtCategorias();
                    Iterator<DtCategoria> iter = categorias.values().iterator();
                    if (iter.hasNext()) { %>
                        <h4 class="lead"><%=iter.next().getNombre()%>  
                     <% while (iter.hasNext()) { %>
                         | <%=iter.next().getNombre()%>  
                     <% } %>  
                 <% } %>   
                        </h4>
                    <!--p class="lead">Categoría 1 | Categoría 2 | Categoría 3</p-->
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <footer class="section section-primary" id="footer"></footer>
  

