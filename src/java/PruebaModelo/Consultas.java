/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package PruebaModelo;

import Logica.DtCategoria;
import Logica.DtServicio;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yaman
 */
public class Consultas extends Conexion{
    
    public boolean Autenticacion(HttpSession sesion) throws SQLException{
        
        try (Statement st = con.createStatement()) {
            ResultSet rs = null;
            String Consulta = "SELECT * FROM usuarios";
            rs = st.executeQuery(Consulta);
            
            while (rs.next()){
                if (sesion.getAttribute("nickname").equals(rs.getString("nickname")) && sesion.getAttribute("password").equals(rs.getString("password"))){
                    //HttpSession sesion =request.getSession();
                    sesion.setAttribute("nombre",rs.getString("nombre"));
                    sesion.setAttribute("apellido",rs.getString("apellido"));
                    sesion.setAttribute("email",rs.getString("email"));
                    sesion.setAttribute("fechaNac",rs.getString("fechaNac"));
                    rs.close();
                    st.close();
                    return true;
                }
            }
            rs.close();
        }
        return false;
    }
    
    public void SetearSesion(HttpSession sesion){
        
    }
    
    public boolean Comprobacion(String nickname, String email) throws SQLException{        
        try (Statement st = con.createStatement()) {
            ResultSet rs = null;
            String Consulta = "SELECT * FROM usuarios";
            rs = st.executeQuery(Consulta);
            
            while (rs.next()){
                if (nickname.equals(rs.getString("nickname")) || email.equals(rs.getString("email"))){
                    rs.close();
                    st.close();
                    return false;
                }
            }
            rs.close();
        }
        return true;
    }    
    
    public void Registrar(String nickname,String nombre,String apellido, String password, String email, String imagen, String fecha) throws SQLException{        
        Statement st;
        if (imagen != null) {
            imagen = "'" + imagen + "'";
            imagen = imagen.replace("\\", "\\\\");
        }
            //String fecha = (anio+ "-" + mes + "-" + dia);
            String fechaNac = fecha.replaceAll("/", "-");
            String sqlau = "INSERT INTO help4traveling.usuarios (nickname,nombre,apellido,password,email,imagen,fechaNac) VALUES ('"+nickname + "','" + nombre + "','" + apellido + "','" + password + "','" + email + "'," + imagen + ",'" + fechaNac + "')";
            System.out.println(sqlau);
            String sqlac = "INSERT INTO help4traveling.clientes (nickname) VALUES ('" + nickname + "')";
            String sqlai = "INS\"INSERT INTO help4traveling.usuarios (nickname,nombre,apellido,password,email,imagen,fechaNac) \"ERT INTO help4traveling.usuariosimagenes (usuario,imagen) VALUES ('" + nickname + "','" + imagen + "')";
            try {
                st = con.createStatement();
                //System.out.println("antes de insertar");
                st.executeUpdate(sqlau);
                st.executeUpdate(sqlac);
                if ((imagen != null) && (!imagen.equals(""))) {
                    //st.executeUpdate(sqlai);
                    con.prepareStatement(sqlai);
                }
                con.close();
                st.close();
                System.out.println("INSERTE :)");
            } catch (SQLException e) {
                System.out.println("No pude INSERTAR :(");
                System.out.println(e);
            }
    }    
    
    public DtServicio getDtServicio(String nombre, String proveedor) throws SQLException {
        ResultSet rsServ, rsCat, rsImg;
        DtServicio dtServ = null;
        Connection con = Logica.Conexion.getInstance().getConnection();
        Statement st;
        String sql = "SELECT * FROM help4traveling.servicios WHERE nombre='" + nombre + "' and proveedor='" + proveedor + "'";
        try {
            st = con.createStatement();
            rsServ = st.executeQuery(sql);
            while (rsServ.next()) {
                String descripcion = rsServ.getString("descripcion");
                String precio = rsServ.getString("precio");
                String origen = rsServ.getString("origen");
                String destino = rsServ.getString("destino");
                Float valor = Float.parseFloat(precio);
                List<String> imagenes = new ArrayList<String>();
                sql = "SELECT * FROM help4traveling.serviciosimagenes WHERE servicio='" + nombre + "'";
                rsImg = st.executeQuery(sql);
                while (rsImg.next()) {
                    imagenes.add(rsImg.getString("imagen"));
                }
                rsImg.close();
                Map<String,DtCategoria> categorias = new HashMap<String,DtCategoria>();
                sql = "SELECT * FROM help4traveling.servicioscategorias WHERE servicio='" + nombre + "' and proveedorServicio='" + proveedor + "'";
                rsCat = st.executeQuery(sql);
                while (rsCat.next()) {
                    DtCategoria dtCat = new DtCategoria(rsCat.getString("categoria"),rsCat.getString("categoriaPadre"));
                    categorias.put(rsCat.getString("categoria"),dtCat);
                }
                rsCat.close();
                dtServ = new DtServicio(nombre, proveedor, descripcion, imagenes, categorias, valor, origen, destino);
            }
            rsServ.close();
            st.close();
            con.close();
        } 
        catch (SQLException e) {
            System.out.println("No pude crear DtServicio :(");
        }
        return dtServ;
    }
    
}
        
