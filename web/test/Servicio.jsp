<%-- 
    Document   : Servicio
    Created on : 03-oct-2016, 23:40:06
    Author     : Leonardo
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Logica.DtProveedor"%>
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
  
    <div class="navbar navbar-default navbar-fixed-top" id="header"></div>
    <div>
      <p>A</p>
    </div>
    <!--div class="section"></div-->
    <% //String nombre = (String) request.getParameter("nombre");
       //String proveedor = (String) request.getParameter("proveedor");
       //String categoria = (String) request.getParameter("categoria");
       String nombre = "Air-France-FC";
       String proveedor = "tCook";
       String categoria = "Air France";
       Consultas con = new Consultas();
       //ManejadorCategoria mc = ManejadorCategoria.getInstance();
       String padre = null;
       //padre = mc.obtenerPadre(categoria);
       padre = con.obtenerPadre(categoria);
       String abuelo = null;
       DtServicio dtServ = null;
       dtServ = con.getDtServicio(nombre, proveedor);
    %>    
    <div class="section">
      <div class="container">
        <div class="row">
          <p class="default">Ofertas en Hoteles, Paquetes de viaje y más</p>
        </div>
        <div class="row">
          <div class="col-md-12">
            <ul class="breadcrumb">
            <%  if (padre != null){
                    //abuelo = mc.obtenerPadre(padre);
                    abuelo = con.obtenerPadre(padre);
                    if (abuelo != null){
                        out.println("<li>"); 
                        out.println("<a href=\"#\">" + abuelo + "</a>"); 
                        out.println("</li>");                     
                    }
                    out.println("<li>"); 
                    out.println("<a href=\"#\">" + padre + "</a>"); 
                    out.println("</li>");                     
                }
            %>
            <li class="active"><%=categoria%></li>
            </ul>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="section">
              <div class="container">
                <div class="row default">
                <% List<String> imagenes = new ArrayList<String>(); // = dtServ.getImagenes();
                   imagenes.add("imagen1");
                   imagenes.add("imagen2");
                   imagenes.add("imagen3");
                   int cantimgs = imagenes.size(); 
                   System.out.println(cantimgs);
                   if (cantimgs > 0)
                       if (cantimgs == 1){  
                           out.println("<div class=\"col-md-6\">");                    
                           out.println("<a href=\"#\"><img src=\""+imagenes.get(0)+"\"class=\"img-responsive\"></a>");
                           out.println("<hr>"); 
                           out.println("<div class=\"row\">");
                           out.println("<div class=\"col-md-4\">");
                           out.println("<a href=\"#\"><img src=\""+imagenes.get(0)+"\"class=\"img-responsive\"></a>");
                           out.println("</div>");
                           out.println("</div>");                               
                       }
                       else if (cantimgs == 2){  
                                out.println("<div class=\"col-md-6\">");                    
                                out.println("<a href=\"#\"><img src=\""+imagenes.get(0)+"\"class=\"img-responsive\"></a>");
                                out.println("<hr>"); 
                                out.println("<div class=\"row\">");
                                out.println("<div class=\"col-md-4\">");
                                out.println("<a href=\"#\"><img src=\""+imagenes.get(0)+"\"class=\"img-responsive\"></a>");
                                out.println("</div>");
                                out.println("<div class=\"col-md-4\">");
                                out.println("<a href=\"#\"><img src=\""+imagenes.get(1)+"\"class=\"img-responsive\"></a>");
                                out.println("</div>");
                                out.println("</div>");                               
                            }
                            else if (cantimgs == 3){  
                                    out.println("<div class=\"col-md-6\">");                    
                                    out.println("<a href=\"#\"><img src=\""+imagenes.get(0)+"\"class=\"img-responsive\"></a>");
                                    out.println("<hr>"); 
                                    out.println("<div class=\"row\">");
                                    out.println("<div class=\"col-md-4\">");
                                    out.println("<a href=\"#\"><img src=\""+imagenes.get(0)+"\"class=\"img-responsive\"></a>");
                                    out.println("</div>");
                                    out.println("<div class=\"col-md-4\">");
                                    out.println("<a href=\"#\"><img src=\""+imagenes.get(1)+"\"class=\"img-responsive\"></a>");
                                    out.println("</div>");
                                    out.println("</div>");                               
                                 }            
                %>  
                    <hr>
                    <table class="default table table-bordered table-hover table-striped">
                      <tbody>
                        <tr class="default">
                          <td class="default" width="200">Proveedor</td>
                          <% String nickname = dtServ.getNkProveedor();
                             DtProveedor prov = con.getDtProveedor(nickname);
                             out.println("<td id=\"nomprov\">"+prov.getNombre()+" "+prov.getApellido()+"</td>");
                          %>                          
                        </tr>
                        <tr>
                          <td class="default" width="200">Origen</td>
                          <% String origen = dtServ.getNomCiuOrigen();
                             out.println("<td id=\"ciuorigen\">"+origen+"</td>");
                          %>
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
  

