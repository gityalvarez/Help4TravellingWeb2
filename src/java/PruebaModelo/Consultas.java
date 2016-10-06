/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package PruebaModelo;

import Logica.Date;
import Logica.DtCategoria;
import Logica.DtPromocion;
import Logica.DtProveedor;
import Logica.DtReserva;
import Logica.DtServicio;
import Logica.DtUsuario;
import Logica.ItemReserva;
import Logica.Proveedor;
import Logica.Reserva;
import Logica.Reserva.eEstado;
import static Logica.Reserva.eEstado.CANCELADA;
import static Logica.Reserva.eEstado.FACTURADA;
import static Logica.Reserva.eEstado.PAGADA;
import static Logica.Reserva.eEstado.REGISTRADA;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
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
    
    public DtProveedor getDtProveedor(String nickname) throws SQLException {
        ResultSet rs;
        DtProveedor p = null;
        Connection con = Logica.Conexion.getInstance().getConnection();
        Statement st;
        String sql = "SELECT * FROM help4traveling.usuarios WHERE nickname='" + nickname + "'";
        try {
            st = con.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                Date fecha = new Date();
                p = new DtProveedor(rs.getString("nombre"), rs.getString("apellido"), rs.getString("nickname"), rs.getString("email"), fecha, "imagen", "empresa", "link");                        
            }
            rs.close();
            st.close();
            con.close();            
        } 
        catch (SQLException e) {
            System.out.println("No obtuve proveedor :(");
            System.err.println(e.getMessage());
        }
        return p;
    }
        
    public List<DtPromocion> listarPromocionesSistema() throws SQLException {
        List<DtPromocion> promociones = null;
        ResultSet rs;
        //Connection con = Logica.Conexion.getInstance().getConnection();
        Statement st;
        String sql = "SELECT * FROM help4traveling.promociones";
        try {
            st = con.createStatement();
            rs = st.executeQuery(sql);
            promociones = new LinkedList<DtPromocion>();
            while (rs.next()) {
                String nombre = rs.getString("nombre");
                String proveedor = rs.getString("proveedor");
                String descuento = rs.getString("descuento");
                String total = rs.getString("total");
                DtPromocion nuevo = new DtPromocion(nombre, proveedor, descuento, total);
                promociones.add(nuevo);
            }
            rs.close();
            con.close();
            st.close();
            System.out.println("promociones  cargadas :)");
        } catch (SQLException e) {
            System.out.println("No pude cargar promociones :(");
        }
        return promociones;
    }
    
    
    public List<DtUsuario> listarUsuariosSistema() throws SQLException {
        List<DtUsuario> usuarios = null;
        ResultSet rs;
        //Connection con = Logica.Conexion.getInstance().getConnection();
        Statement st;
        String sql = "SELECT * FROM help4traveling.usuarios";
        try {
            st = con.createStatement();
            rs = st.executeQuery(sql);
            usuarios = new LinkedList<DtUsuario>();
            while (rs.next()) {
                String nickname = rs.getString("nickname");
                String nombre = rs.getString("nombre");
                String apellido = rs.getString("apellido");
                String correo = rs.getString("email");
                Date fecha = new Date();
                DtUsuario nuevo = new DtUsuario(nombre, apellido, nickname, "password", correo, fecha, null, "tipo", "empresa", "link");                                      
                usuarios.add(nuevo);
            }
            rs.close();
            con.close();
            st.close();
            System.out.println("usuarios  cargados :)");
        } catch (SQLException e) {
            System.out.println("No pude cargar usuarios :(");
        }
        return usuarios;
    }
    
     public List<DtReserva> listarReservasUsuario(String cli) throws SQLException {
        List<DtReserva> ReservaxUsuario = null;
        ResultSet rs;
        //Connection con = Logica.Conexion.getInstance().getConnection();
        Statement st;
        String sql = "SELECT * FROM help4traveling.reservas where cliente ='"+cli+"'";
        try {
            st = con.createStatement();
            rs = st.executeQuery(sql);
            ReservaxUsuario = new LinkedList<DtReserva>();
            while (rs.next()) {
                String numero = rs.getString("numero");
                String fecha1 = rs.getString("fecha");
                String total = rs.getString("total");
                String estado = rs.getString("estado");
                
                String partes[]=fecha1.split("-");
        
       
                Date fecha = new Date(Integer.valueOf(partes[2]),Integer.valueOf(partes[1]), Integer.valueOf(partes[0]));
               Map<Integer, ItemReserva> items=null ;
               
                DtReserva nueva = null;
               switch (estado) {
            case "REGISTRADA":
                nueva = new DtReserva(Long.parseLong(numero), fecha, Reserva.eEstado.REGISTRADA , Double.parseDouble(total), cli, items);
                break;
            case "CANCELADA":
                nueva = new DtReserva(Long.parseLong(numero), fecha, Reserva.eEstado.CANCELADA , Double.parseDouble(total), cli, items);
                break;
            case "FACTURADA":
                nueva = new DtReserva(Long.parseLong(numero), fecha, Reserva.eEstado.FACTURADA , Double.parseDouble(total), cli, items);
                break;
            case "PAGADA":
                nueva = new DtReserva(Long.parseLong(numero), fecha, Reserva.eEstado.PAGADA , Double.parseDouble(total), cli, items);
                break;
        }
                
                ReservaxUsuario.add(nueva);
            }
            rs.close();
            con.close();
            st.close();
            System.out.println("usuarios  cargados :)");
        } catch (SQLException e) {
            System.out.println("No pude cargar usuarios :(");
        }
        return ReservaxUsuario;
    }

       
    public List<DtServicio> listarServiciosSistema() throws SQLException {
        List<DtServicio> servicios = null;
        ResultSet rs;
        //Connection con = Logica.Conexion.getInstance().getConnection();
        Statement st;
        String sql = "SELECT * FROM help4traveling.servicios";
        try {
            st = con.createStatement();
            rs = st.executeQuery(sql);
            servicios = new LinkedList<DtServicio>();            
            while (rs.next()) {
                String nombre = rs.getString("nombre");
                String proveedor = rs.getString("proveedor");
                String descripcion = rs.getString("descripcion");
                float precio = Float.parseFloat(rs.getString("precio"));
                String origen = rs.getString("origen");
                Date fecha = new Date();
                DtServicio nuevo = new DtServicio(nombre, proveedor, descripcion, null, null, precio, origen, null);
                servicios.add(nuevo);
            }
            rs.close();
            con.close();
            st.close();
            System.out.println("usuarios  cargados :)");
        } catch (SQLException e) {
            System.out.println("No pude cargar usuarios :(");
        }
        return servicios;
    }
    
    public String obtenerPadre(String hijo) {
        String padre = null;
        ResultSet rs;
        //Connection con = Logica.Conexion.getInstance().getConnection();
        Statement st;
        String sql;
        sql = "SELECT padre FROM help4traveling.categorias WHERE nombre='" + hijo + "'";
        try {
            st = con.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                padre = rs.getString("padre");
            }
            rs.close();
            st.close();
            con.close();
        } catch (SQLException e) {
            System.out.println("No pude obtener categorias :(");
        }
        return padre;
    }
    
}

        
