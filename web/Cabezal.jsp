<%-- 
    Document   : Cabezal
    Created on : 18/09/2016, 06:19:22 PM
    Author     : yaman
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function ocultarperfil() {
                document.getElementById('verPerfil').style.display = 'none';
        </script>  
        
    </head>
    <body>
       <h1>BIENVENIDO A HELP4TRAVELLING</h1>
        <form id="searchbox" action="">
             <input id="search" type="text" placeholder="Servicios y Promociones">
            <input id="submit" type="submit" value="Search">
        </form>
          
        
        <span> <a href="InicioSesion.jsp"> [Iniciar Sesion] </a> </span>
        
        <span> <a href="RegistrarCliente.jsp"> [Registrar Cliente] </a> </span>
        
        <%HttpSession sesion=request.getSession();%>
        
        <% if(sesion.getAttribute("nickname")==null) {%>
                  <span> <a rel="verPerfil" href="VerPerfil.jsp" style='dispaly:none'> [VerPerfil] </a> </span>
         <%} else{%>
          <span> <a rel="verPerfil" href="VerPerfil.jsp"> [VerPerfil] </a> </span>
          <%}%>
    </body>
</html>
