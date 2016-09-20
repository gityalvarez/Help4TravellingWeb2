<%-- 
    Document   : VerPerfil
    Created on : 20/09/2016, 03:15:56 PM
    Author     : yaman
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <link rel="stylesheet" href="Css/Pestanas.css"/>
        <script>
            function abrirPestana(evt, pestana) {
                // Declare all variables
                var i, tabcontent, tablinks;

                // Get all elements with class="tabcontent" and hide them
                tabcontent = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }

                // Get all elements with class="tablinks" and remove the class "active"
                tablinks = document.getElementsByClassName("tablinks");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace(" active", "");
                }

                // Show the current tab, and add an "active" class to the link that opened the tab
                document.getElementById(pestana).style.display = "block";
                evt.currentTarget.className += " active";
            }



        </script>    
    </head>
    <body>
        <ul class="tab">
            <li><a href="#" class="tablinks" onclick="abrirPestana(event, 'Datos')">Datos</a></li>
            <li><a href="#" class="tablinks" onclick="abrirPestana(event, 'Reservas')">Reservas</a></li>
            
        </ul>

        <div id="Datos" class="tabcontent">
            <h3>Datos</h3>
            <p>Acá van los datos del usuario.</p>
            <% HttpSession sesion=request.getSession();%>
            <p>Nombre <%=sesion.getAttribute("nombre")%></p>
            <p>Apellido <%=sesion.getAttribute("apellido")%></p>
            <p>Nickname <%=sesion.getAttribute("nickname")%></p>
            <p>Email <%=sesion.getAttribute("email")%></p>
            <p>Nacimiento <%=sesion.getAttribute("fechaNac")%></p>
            <p>Acá van los datos del usuario.</p>
        </div>

        <div id="Reservas" class="tabcontent">
            <h3>Reservas</h3>
            <p>Acá van las reservas del usuario.</p> 
        </div>

    </body>
</html>
