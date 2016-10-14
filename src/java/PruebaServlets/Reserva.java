/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package PruebaServlets;

/**
 *
 * @author yaman
 */
  public class Reserva {

        private String servicio;
        private float precio;
        private int cantidad;

        public void Reserva(String servicio, float precio, int cantidad) {
            this.servicio = servicio;
            this.precio = precio;
            this.cantidad = cantidad;
            
        }
        public void getServicio(String servicio){
            this.servicio= servicio;
        }
        
        public void setPrecio(float precio){
            this.precio= precio;
        }
        public void setCantidad(int cantidad){
            this.cantidad= cantidad;
        }
        
        
        
        
        public String getServicio(){
            return servicio;
        }
        
        public float getPrecio(){
            return precio;
        }
        public int getCantidad(){
            return cantidad;
        }
        
    }
