/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package PruebaServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author yaman
 */
public class agregarCarrito extends HttpServlet {

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

        String servicio = request.getParameter("servicio_in");
        System.out.println(servicio);
        String cantidad = request.getParameter("cantidad_in");
        System.out.println(cantidad);

        Cookie[] todoslosCookies = request.getCookies();
        boolean existe = false;
        System.out.println("Cantidad de Cookies" + todoslosCookies.length);
        if (todoslosCookies != null) {

            for (int i = 0; i < todoslosCookies.length; i++) {
                Cookie unCookie = todoslosCookies[i];
                if (unCookie.getName().equals(servicio)) {
                    Integer cantidadint = Integer.parseInt(cantidad) + Integer.parseInt(unCookie.getValue());
                    unCookie.setValue(cantidadint.toString());
                    System.out.println(unCookie.getValue());
                    response.addCookie(unCookie);
                    existe = true;
                    break;
                }
            }
        }
        if (!existe) {
            System.out.println("Entre al if ! existe");
            Cookie nuevoCookie = new Cookie(servicio, cantidad);
            System.out.println("Cree la cookie");
            nuevoCookie.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(nuevoCookie);
            System.out.println(nuevoCookie.getName());
            System.out.println(nuevoCookie.getValue());
            for (int i = 0; i < todoslosCookies.length; i++) {
                Cookie unCookie = todoslosCookies[i];
                if (unCookie.getName().equals("contador")){
                    Integer contador = Integer.parseInt(unCookie.getValue()) + 1;
                    unCookie.setValue(contador.toString());
                    System.out.println("El contador de servicios me da" +contador);
                }
                else{
                    Cookie contadorCookie = new Cookie("contador","1");
                    System.out.println("El contador de servicios me da " + contadorCookie.getValue());
                }
                    
            
        }

        
    }
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