

<%@page import="Logica.Proveedor"%>
<%@page import="Logica.Date"%>
<%@page import="Logica.Oferta"%>
<%@page import="java.util.Iterator"%>
<%@page import="Logica.IControladorReserva"%>
<%@page import="Logica.DtItemReserva"%>
<%@page import="java.util.List"%>
<%@page import="Logica.Fabrica"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
           
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
            <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
            <script src="js/jquery-3.1.0.min.js"></script>
            <script src="js/includes.js"></script>
            <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
            <link href="css\test.css" rel="stylesheet" type="text/css">
            <title><%out.println("reserva numero "+request.getParameter("idReserva"));%> </title>
    </head>
    <body>
       <div class="navbar navbar-default navbar-fixed-top" id="header"></div>
    
    <% String IdReserva = request.getParameter("idReserva");
    Fabrica fab= Fabrica.getInstance();
    Integer numRes=Integer.parseInt(IdReserva);
    List<DtItemReserva> itemsReserva;
    
    itemsReserva= fab.getIControladorReserva().listarItems(numRes);
     //aca recibe como parametro la id de reservay devuelve los items vinculados
  //   out.println("la cantidad devuelta es: "+itemsReserva.size());
 /*      
Para la reserva seleccionada se muestra los servicios que
contiene (mostrando para cada uno su nombre, su precio
unitario, su estado y si es Promoción o Servicio), el nickname del
proveedor al que se solicitó el pedido, qué cantidades se
eligieron para cada servicio y el total general de la reserva
 */      
    %>    
    <div class="section">
      <div class="container">
        <div class="row">
          <p class="default">Ofertas en Hoteles, Paquetes de viaje y más</p>
          <%--          <a><%=out.println("la cantidad devuelta es: "+itemsReserva.size())%></a>--%>
          
        </div>
    
        <div class="row">
          <div class="col-md-12">
            <div class="section">
              <div class="container">
                <div class="row default">
                
                    <table class="default table table-bordered table-hover table-striped">
                      <tbody>
                        <tr class="default">
                          <td class="default" width="20" align="center"><b>nombre</b></td>
                          <td class="default" width="200" align="center"><b>tipo</b></td>
                          <td class="default" width="200" align="center"><b>proevedor</b></td>
                          <td class="default" width="200" align="center"><b>cantidad</b></td>
                        
                          
                        </tr>
                        <% 
                            
                            ///declaraciones
                           Iterator<DtItemReserva> iter = itemsReserva.iterator();
                           
                           DtItemReserva ItRes;
                           
                           int cant;
                           Oferta ofertaVinculada=null;
                           String inicio,fin;
                           String NombOfr;
                           Proveedor Prov;
                           String NombProv;
                           String servoprom;
                           String partesfech[];
                           while (iter.hasNext()){
                             //primero itero
                               ItRes = iter.next();
                               
                            //  saco las caracteristicas del item
                               cant  = ItRes.getCantidad();
                               ofertaVinculada= ItRes.getOferta();
                               inicio=ItRes.getInicio().getFecha("/");
                               fin=ItRes.getFin().getFecha("/");
                               NombOfr = ofertaVinculada.getNombre();
                               Prov = ofertaVinculada.getProveedor();
                               NombProv=Prov.getNickname();
                               servoprom =ofertaVinculada.getClass().getName();
                               //invierto fecha inicio
                               partesfech=inicio.split("/");
                               inicio = partesfech[2]+"/"+partesfech[1]+"/"+partesfech[0];
                               partesfech=fin.split("/");
                               fin = partesfech[2]+"/"+partesfech[1]+"/"+partesfech[0];
                               
                               %>
                               <tr class="default">
                                    <td class="default" align="center" width="20" id="numero"><%=NombOfr%></td>                                       
                                    <%--     <td class="default" align="center" width="400" id="descripcion"><%=servoprom%></td>      --%>                       
                                    <td class="default" align="center" width="200" id="proveedor"><%=NombProv%></td>
                                    <td class="default" align="center" width="100" id="precio"><%=cant%></td>
                                    <%-- <td class="default" align="center" width="100" id="origen"><%=total%></td>--%>
                               </tr>
                             
                              
                             
                           <%
                           }                           
                        %>                       
                      </tbody>
                    </table>
                    <ul class="list-group"></ul>
                  </div>
                  
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    <footer class="section section-primary" id="footer"></footer>
    </body>
</html>
