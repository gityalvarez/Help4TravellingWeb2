<%-- 
    Document   : index
    Created on : 16/09/2016, 08:50:20 AM
    Author     : yaman
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="Css/style.css"/>
        <script src="JScript/script.js"> </script>
        <title>Prueba</title>
    </head>
    
        <h1>BIENVENIDO A HELP4TRAVELLING</h1>
        
        <%HttpSession sesion=request.getSession(false);%>

        <%    System.out.println("Bienvenido " + sesion.getAttribute("nickname"));%>
        
            
        
        <span> <a href="InicioSesion.jsp"> [Iniciar Sesion] </a> </span>
        <span> <a href="VerPerfil.jsp"> [VerPerfil] </a> </span>
        <span> <a href="RegistrarCliente.jsp"> [Registrar Cliente] </a> </span>     
                
    
</html>
