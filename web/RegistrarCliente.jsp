<%-- 
    Document   : RegistrarCliente
    Created on : 18/09/2016, 02:34:27 PM
    Author     : yaman
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
         <%String nick = (String)session.getAttribute("nickname");%>
         <%String mail = (String)session.getAttribute("mail");%>;
       <script type="text/javascript">
            function mostrar(){
            document.getElementById('oculto').style.display='block';
            }
            function escribir(){
               
                document.getElementById('nickname').value="<%=nick%>";
                document.getElementById('mail').value="<%=mail%>";
                
            }
</script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
        <body>
        <h1>REGISTRO</h1>
        
        <section>
            <form action="Comprobacion" method="post" >
                <p>Escriba su nombre de usuario</p>
                <p>  <input type = "text"   name= "nickname" id="nickname"/> </p>
                <p>Escriba su dirección de e-mail</p>
                <p>  <input type = "text"   name= "mail" id="mail"/> </p>
                <p>  <input type = "submit"   name= "Comprobar" id="Comprobar" value= "Comprobar"/> </p> 
                
        </section>
        
        <div id="oculto" style="display:none" > 
            
            <p> Escriba su Nombre </p>
            <p>  <input type = "text"   name= "nombre" id="nombre"/> </p>        
            <p> Escriba su Apellido </p>
            <p>  <input type = "text"   name= "apellido" id="apellido"/> </p>
            <p> Elija su fecha de Nacimiento </p>
            <p>  <input type = "text"   name= "nacimiento" id="nacimiento"/> </p>
        </div>
        
        <%
            String habilitado = (String)session.getAttribute("habilitado");
            session.removeAttribute("habilitado"); 
            if (habilitado=="true"){%>
                <script type="text/javascript">
                    mostrar();
                    escribir();
                </script>  
            <%}%>        
        </body>
</html>
