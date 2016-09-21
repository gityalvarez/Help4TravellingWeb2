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
        <title>Inicio de Sesión</title>
        <link rel="stylesheet" href="Css/style.css"/>

    </head>
    <body style="background-color:orange;">        
         <div align="center">
            <h1>INICIO DE SESIÓN</h1>
            <form action="Autenticacion" method="post" >
              <p>Usuario : <input type = "text" size="30" maxlength="50" value="nickname" name= "usuario" id="usuario"/></p>
              <p>Password: <input type = "text" size="20" maxlength="20" name= "contrasena" id="contrasena"/> </p>
              <p><input type="submit" name="Entrar" id="Entrar" value="Entrar"/> </p> 
                
            </form>
        </div>
        
    </body>
</html>
