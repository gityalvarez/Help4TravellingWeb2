<%-- 
    Document   : VerPerfil
    Created on : 18/09/2016, 02:34:38 PM
    Author     : yaman
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="Css/style.css"/>
        <%String nick = (String) session.getAttribute("nickname");%>
        <%String mail = (String) session.getAttribute("mail");%>
        <%String nombre = (String) session.getAttribute("nombre");%>
        <%String apellido = (String) session.getAttribute("apellido");%>
       
    </head>
    <body>
        <h1>PERFIL</h1>
        <%=nick%>
        <%=mail%>
        <%=nombre%>
        <%=apellido%>
    </body>
</html>
