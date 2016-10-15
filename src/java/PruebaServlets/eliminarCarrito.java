/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package PruebaServlets;

import Logica.Date;
import Logica.DtItemReserva;
import Logica.ItemReserva;
import Logica.ManejadorReserva;
import Logica.Proveedor;
import Logica.Oferta;
import static Logica.Reserva.eEstado.REGISTRADA;
import Logica.Servicio;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yaman
 */
public class eliminarCarrito extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession sesion = request.getSession();
        String servicio = request.getParameter("servicio_in");
        
        System.out.println(servicio);
        float precio =0;
        int cantidad =0;
        
        if (request.getParameter("eliminar")!=null){
        
        
        List<Reserva> reservas = (List<Reserva>)sesion.getAttribute("carrito");
        Iterator<Reserva> iter = reservas.iterator();
        
            Reserva res;
            while (iter.hasNext()) {
                res = iter.next();
                if (servicio.equals(res.getServicio())) {
                    reservas.remove(res);
                    precio = res.getPrecio();
                    cantidad = res.getCantidad();
                    break;
                }
            }
        sesion.setAttribute("carrito",reservas);
        
        }
        
        else if(request.getParameter("comprar")!=null){
            List<Reserva> reservas = (List<Reserva>)sesion.getAttribute("carrito");
            Iterator<Reserva> iter = reservas.iterator();
            Reserva res;
            while (iter.hasNext()) {
                res = iter.next();
                if (servicio.equals(res.getServicio())) {
                    
                    
                    
                    cantidad = res.getCantidad(); 
                    Proveedor prov= new Proveedor("yama");
                    Servicio ofertatype = new Servicio(servicio,prov);
                    Date iniciodate = new Date("1988-08-01");
                    ItemReserva item = new ItemReserva(28,cantidad ,iniciodate, iniciodate,ofertatype);
                    System.out.println("llegue hasta aca");        
                    Map<Integer,ItemReserva> items = new HashMap<Integer,ItemReserva>();
                    items.put(cantidad,item);
                    Logica.Reserva reserva1 = new Logica.Reserva(iniciodate, REGISTRADA, res.getPrecio()*cantidad, (String)sesion.getAttribute("nickname"),items);
                    
                    ManejadorReserva man = ManejadorReserva.getInstance();
                    man.altaReserva(reserva1);
                    
                    
                    
                    
                    
                    
                    
                    precio = res.getPrecio(); 
                    System.out.println("esta es la cantidad"+cantidad);
                    System.out.println(servicio);
                    reservas.remove(res);
                    break;
                }
            }
            
        sesion.setAttribute("carrito",reservas);
        }
        float preciototal = (float)sesion.getAttribute("preciototal");
        sesion.setAttribute("preciototal",preciototal-(precio*cantidad));       
        response.sendRedirect("test/Carrito.jsp");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
