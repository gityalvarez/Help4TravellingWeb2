<%-- 
    Document   : RegistrarCliente
    Created on : 18/09/2016, 02:34:27 PM
    Author     : yaman
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%String nick = (String) session.getAttribute("nickname");%>
        <%String mail = (String) session.getAttribute("mail");%>
        <script type="text/javascript">
            function mostrarinicio() {
                document.getElementById('inicio').style.display = 'block';
            }
            function ocultarinicio() {
                document.getElementById('inicio').style.display = 'none';
            }
            function mostrarsegunda() {
                document.getElementById('segunda').style.display = 'block';
            }
            function ocultarsegunda() {
                document.getElementById('segunda').style.display = 'none';
            }
            function escribir() {

                document.getElementById('nickname').value = "<%=nick%>";
                document.getElementById('mail').value = "<%=mail%>";

            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <body>
        <h1>REGISTRO</h1>
    
        
        <div id="inicio" style='display: none' >
            <form action="Comprobacion" method="post" >
                <p>Escriba su nombre de usuario</p>
                <p>  <input type = "text"   name= "nickname" id="nickname"/> </p>
                <p>Escriba su dirección de e-mail</p>
                <p>  <input type = "text"   name= "mail" id="mail"/> </p>
                <p>  <input type = "submit"   name= "Comprobar" id="Comprobar" value= "Comprobar"/> </p> 
            </form>
        </div>

        <div id="segunda" style='display: none'> 
            <form action="Registrar" method="post">
                <p> Escriba su Nombre </p>
                <p>  <input type = "text"   name= "nombre" id="nombre"/> </p>        
                <p> Escriba su Apellido </p>
                <p>  <input type = "text"   name= "apellido" id="apellido"/> </p>
                <p> Elija su fecha de Nacimiento </p>
                <p>  


                    dia <select id="diaSelect" name="diaSelect">
                        <% for (int i = 1; i < 32; i++) {%>                  
                        <option value="<%=i%>"><%=i%></option>
                        <%}%>
                    </select>
                    mes <select id="mesSelect" name="mesSelect">
                        <% for (int j = 1; j < 13; j++) {%>                  
                        <option value="<%=j%>"><%=j%></option>
                        <%}%>
                    </select>
                    año <select id="anioSelect" name="anioSelect">
                        <% for (int k = 1920; k < 2016; k++) {%>                  
                        <option value="<%=k%>"><%=k%></option>
                        <%}%>
                    </select>


                </p>
            </form>
        </div>
                    
        <%
            String habilitado = (String) session.getAttribute("habilitado");
            //
        if (!(session.getAttribute("habilitado")==null) && habilitado == "true") {%>
        <script type="text/javascript">
            mostrarsegunda();
            mostrarinicio();
            escribir();
            <%session.removeAttribute("habilitado");%>
        </script>  
        <%} else {
            if (session.getAttribute("habilitado")==null){%>
                <script type="text/javascript">
                    mostrarinicio();
                    ocultarsegunda();
                </script>
            <%}%>
        <%}%>
        


    </body>
</html>
