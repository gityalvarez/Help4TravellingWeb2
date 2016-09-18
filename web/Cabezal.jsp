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
    </head>
    <body>
       <h1>BIENVENIDO A HELP4TRAVELLING</h1>
        
        <%HttpSession sesion=request.getSession(false);%>

        <%    System.out.println("Bienvenido " + sesion.getAttribute("nickname"));%>
        
            
        
        <span> <a href="InicioSesion.jsp"> [Iniciar Sesion] </a> </span>
        <span> <a href="VerPerfil.jsp"> [VerPerfil] </a> </span>
        <span> <a href="RegistrarCliente.jsp"> [Registrar Cliente] </a> </span>
    </body>
</html>
