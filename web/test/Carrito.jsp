<%-- 
    Document   : Carrito
    Created on : 05-oct-2016, 11:33:26
    Author     : yaman
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedList"%>
<%@page import="PruebaModelo.Consultas"%>
<%@page import="Logica.DtUsuario"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script src="js/jquery-3.1.1.js"></script>
    <script src="js/includes.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="css\test.css" rel="stylesheet" type="text/css">
    <script>


    </script>    
</head>

<div class="navbar navbar-default navbar-fixed-top" id="header"></div>
<div>
    <p>A</p>
</div>
<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="section">
                    <div class="container">
                        <div class="row default"><h2><b>Carrito de Compras</b></h2></div>
                        <hr>
                        <%
                            
                            Cookie[] todoslosCookies = request.getCookies();
                            String nickCookie;
                            nickCookie = "";
                            if (todoslosCookies !=null ){
                            for (int i = 0; i < todoslosCookies.length; i++) {
                                Cookie unCookie = todoslosCookies[i];
                                if (unCookie.getName().equals("nick")) {
                                    nickCookie = unCookie.getValue();
                                    break;
                                }
                            }
                            }
                            out.print("<div class='row default'>"
                                    + "<table class='default table table-bordered table-hover table-striped'>"
                                    + "<tbody>"
                                    + "<tr class='default'>"
                                    + "<td class='default' width='300' align='center'><b><h1>Reservas de " + nickCookie + "</h1></b></td>"
                                    + " </tr>");

                            out.print("<table class='table'>"
                                    + "<thead>"
                                    + "<tr>"
                                    + "<th><h2>Reserva</h2></th>"
                                    + "<th><h2>Cantidad</h2></th>"
                                    + "</tr>"
                                    + "</thead>"
                                    + "<tbody>"
                                    + "<tr>");
                            for (int i = 0; i < todoslosCookies.length; i++) {
                                Cookie unCookie = todoslosCookies[i];
                                if (!unCookie.getName().equals("nick") && (!unCookie.getName().equals("JSESSIONID"))) {

                                    out.println("<td><h2>" + unCookie.getName() + "</h2></td>"
                                            + "<td><h2>" + unCookie.getValue() + "</h2></td>"
                                            + "<td width='80' align='center'>"
                                            + "<input type='submit' name='comprar' id='comprar' value='Comprar' align='center' width='80' class='active btn btn-info btn-lg'></td>"
                                            + "<td width='80' align='center'>"
                                            + "<input type='submit' name='eliminar' id='eliminar' value='Eliminar del Carrito' align='center' width='80' class='active btn btn-info btn-lg'></td>"
                                            + "</tr>");
                                }
                            }

                            out.println("</tbody>"
                                    + "</table>");

        
                        %>                       
                        </tbody>
                        </table>
                        <ul class="list-group"></ul>
                    </div>                  
                </div>
            </div>
        </div>
    </div>
</div>
</div>    
<footer class="section section-primary" id="footer"></footer>
