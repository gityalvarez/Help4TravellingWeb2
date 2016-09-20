<%-- 
    Document   : InicioSesion
    Created on : 18/09/2016, 02:28:31 PM
    Author     : yaman
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="Css/style.css"/>

    </head>
    <body>
        <h1>INICIO DE SESIÓN</h1>
        
         <div>
            <form action="Autenticacion" method="post" >
                <p>  <input type = "text"   name= "usuario" id="usuario"/> </p>
              <p>  <input type = "text"   name= "contrasena" id="contrasena"/> </p>
              <p>  <input type = "submit"   name= "Entrar" id="Entrar" value= "Entrar"/> </p> 
                
            </form>
        </div>
        
    </body>
</html>
