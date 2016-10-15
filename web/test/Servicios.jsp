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
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script src="js/jquery-3.1.0.min.js"></script>
    <script src="js/includes.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="css\test.css" rel="stylesheet" type="text/css">
    <script src="js/jquery-3.1.1.js"></script>
    <script src="js/jstree.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#selector").jstree();
            $("#selector").on("select_node.jstree",
                    function (evt, data) {
                        //hacemos lo que queremos con la categoria seleccionada
                    }
            );
        });
    </script>  
  </head>
  <title>Listado de Servicios</title>
 <body>
    <div class="navbar navbar-default navbar-fixed-top" id="header"></div>    
    <div>        
        <iframe name="categorias" src="Categorias.jsp" style="position:relative; left:20px;top:60px;width:310px;height:440px;" scrolling="auto" frameborder="0">
        </iframe>
        <iframe name="servicios" src="ListarServicios.jsp?categoria=null" style="position:relative; left:20px;top:60px;width:1021px;height:440px;" scrolling="auto" frameborder="0">
        </iframe>  
    </div>
    <div><footer class="section section-primary" id="footer"></footer></div>
  </body>

  
  
