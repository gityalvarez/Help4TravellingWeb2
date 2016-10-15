/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package PruebaModelo;

import Logica.Conexion;
import Logica.Date;
import Logica.DtCategoria;
import Logica.DtItemReserva;
import Logica.DtPromocion;
import Logica.DtProveedor;
import Logica.DtReserva;
import Logica.DtServicio;
import Logica.ManejadorCategoria;
import Logica.DtUsuario;
import Logica.ItemReserva;
import Logica.Proveedor;
import Logica.Reserva;
import Logica.Reserva.eEstado;
import static Logica.Reserva.eEstado.CANCELADA;
import static Logica.Reserva.eEstado.FACTURADA;
import static Logica.Reserva.eEstado.PAGADA;
import static Logica.Reserva.eEstado.REGISTRADA;
import Logica.Servicio;
import PruebaServlets.Oferta;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

/**
 *
 * @author yaman
 */
public class Consultas {
    
    public boolean Autenticacion(HttpSession sesion) throws SQLException{
        Connection con = Conexion.getInstance().getConnection();
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
        Connection con = Conexion.getInstance().getConnection();
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
                Connection con = Conexion.getInstance().getConnection();
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
    
    /*public DtServicio getDtServicio(String nombre, String proveedor) throws SQLException {
        ResultSet rsServ, rsCat, rsImg;
        DtServicio nuevo = null;
        Statement stServ, stImg, stCat;
        try {
            Connection con = Conexion.getInstance().getConnection();
            stServ = con.createStatement();
            String sql = "SELECT * FROM help4traveling.servicios WHERE nombre='" + nombre + "' AND proveedor='" + proveedor + "'";
            rsServ = stServ.executeQuery(sql);
            if (rsServ.next()) {
                String descripcion = rsServ.getString("descripcion");
                String precio = rsServ.getString("precio");
                String origen = rsServ.getString("origen");
                String destino = rsServ.getString("destino");
                Float valor = Float.parseFloat(precio);
                List<String> imagenes = new ArrayList<String>();
                sql = "SELECT * FROM help4traveling.serviciosimagenes WHERE servicio='" + nombre + "'";
                stImg = con.createStatement();
                rsImg = stImg.executeQuery(sql);
                while (rsImg.next()) {
                    imagenes.add(rsImg.getString("imagen"));
                }
                rsImg.close();
                stImg.close();
                Map<String,DtCategoria> categorias = new HashMap<String,DtCategoria>();
                sql = "SELECT * FROM help4traveling.servicioscategorias WHERE servicio='" + nombre + "' AND proveedorServicio='" + proveedor + "'";
                stCat = con.createStatement();
                rsCat = stCat.executeQuery(sql);
                while (rsCat.next()) {
                    DtCategoria dtCat = new DtCategoria(rsCat.getString("categoria"),rsCat.getString("categoriaPadre"));
                    categorias.put(rsCat.getString("categoria"),dtCat);
                }
                rsCat.close();
                stCat.close();
                nuevo = new DtServicio(nombre, proveedor, descripcion, imagenes, categorias, valor, origen, destino);                
            }
            rsServ.close();
            con.close();
            stServ.close();            
        } 
        catch (SQLException e) {
            System.out.println("No pude crear Servicio :(");            
        }
        return nuevo;        
    }*/
    
    /*public DtUsuario getDtProveedor(String nickname) {
        ResultSet rsUsu, rsProv, rsImg;
        DtUsuario nuevo = null;
        Statement stUsu, stProv, stImg;
        try {
            Connection con = Conexion.getInstance().getConnection();
            stUsu = con.createStatement();
            String sql = "SELECT * FROM help4traveling.usuarios WHERE nickname='" + nickname + "'";
            rsUsu = stUsu.executeQuery(sql);
            stProv = con.createStatement();
            sql = "SELECT * FROM help4traveling.proveedores WHERE nickname='" + nickname + "'";
            rsProv = stProv.executeQuery(sql);
            if (rsUsu.next() && rsProv.next()) {
                String nombre = rsUsu.getString("nombre");
                String apellido = rsUsu.getString("apellido");
                String correo = rsUsu.getString("email");      
                Date fecha = new Date(rsUsu.getString("fechaNac"));
                String imagen = null;
                stImg = con.createStatement();
                sql = "SELECT * FROM help4traveling.usuariosimagenes WHERE usuario='" + nickname + "'";
                rsImg = stImg.executeQuery(sql);
                if (rsImg.next())
                    imagen = rsImg.getString("imagen");
                rsImg.close();
                stImg.close();
                String empresa = rsProv.getString("empresa");
                String enlace = rsProv.getString("link");
                nuevo = new DtUsuario(nombre, apellido, nickname, "password", correo, fecha, imagen, "Proveedor", empresa, enlace);                            
            }
            rsProv.close();
            stProv.close();
            rsUsu.close();
            stUsu.close();
            con.close();
            System.out.println("Se obtuvo Proveedor :)");
        } 
        catch (SQLException e) {
            System.out.println("No obtuve Proveedor :(");
            System.err.println(e.getMessage());
        }
        return nuevo;        
    }    */
        
    /*public List<DtPromocion> listarPromociones() throws SQLException {
        List<DtPromocion> promociones = null;
        ResultSet rs;
        Statement st;        
        try {
            Connection con = Conexion.getInstance().getConnection();
            st = con.createStatement();
            String sql = "SELECT * FROM help4traveling.promociones";
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
    }*/
    
    
    public List<DtUsuario> listarUsuariosSistema() throws SQLException {
        List<DtUsuario> usuarios = null;
        ResultSet rsUsu, rsImg;
        Statement stUsu, stImg;
        try {
            Connection con = Conexion.getInstance().getConnection();
            stUsu = con.createStatement();
            String sql = "SELECT * FROM help4traveling.usuarios";
            rsUsu = stUsu.executeQuery(sql);
            usuarios = new LinkedList<DtUsuario>();
            while (rsUsu.next()) {
                String nickname = rsUsu.getString("nickname");
                String nombre = rsUsu.getString("nombre");
                String apellido = rsUsu.getString("apellido");
                String correo = rsUsu.getString("email");
                Date fecha = new Date(rsUsu.getString("fechaNac"));
                String imagen = null;
                stImg = con.createStatement();
                sql = "SELECT * FROM help4traveling.usuariosimagenes WHERE usuario='" + nickname + "'";
                rsImg = stImg.executeQuery(sql);
                if (rsImg.next())
                    imagen = rsImg.getString("imagen");
                rsImg.close();
                stImg.close();
                DtUsuario nuevo = new DtUsuario(nombre, apellido, nickname, "password", correo, fecha, imagen, "tipo", "empresa", "link");                                      
                usuarios.add(nuevo);
            }
            rsUsu.close();
            stUsu.close();
            con.close();            
            System.out.println("Usuarios cargados :)");
        } 
        catch (SQLException e) {
            System.out.println("No pude cargar Usuarios :(");
        }
        return usuarios;
    }
    
     public List<DtReserva> listarReservasUsuario(String cli) throws SQLException {
        List<DtReserva> ReservaxUsuario = null;
        ResultSet rs;
        Connection con = Conexion.getInstance().getConnection();
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

       
    /*public List<DtServicio> listarServicios() throws SQLException {
        List<DtServicio> servicios = null;
        ResultSet rs;
        Statement st;
        try {
            Connection con = Conexion.getInstance().getConnection();
            st = con.createStatement();
            String sql = "SELECT * FROM help4traveling.servicios";
            rs = st.executeQuery(sql);
            servicios = new LinkedList<DtServicio>();            
            while (rs.next()) {
                String nombre = rs.getString("nombre");
                String proveedor = rs.getString("proveedor");
                String descripcion = rs.getString("descripcion");
                float precio = Float.parseFloat(rs.getString("precio"));
                String origen = rs.getString("origen");
                DtServicio nuevo = new DtServicio(nombre, proveedor, descripcion, null, null, precio, origen, null);
                servicios.add(nuevo);
            }
            rs.close();
            con.close();
            st.close();
            System.out.println("Servicios cargados :)");
        } catch (SQLException e) {
            System.out.println("No pude cargar Servicios :(");
        }
        return servicios;
    }*/
    
    /*public String obtenerPadre(String hijo) {
        String padre = null;
        ResultSet rs;
        Connection con = Conexion.getInstance().getConnection();
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
    }*/
    
    /*public List<String> listarServiciosCategoria(String categoria) {
        ResultSet rs;
        Connection con = Conexion.getInstance().getConnection();
        Statement st;
        String sql;
        List<String> servicios = null;
        try {
            st = con.createStatement();
            sql = "SELECT * FROM help4traveling.servicioscategorias WHERE categoria='" + categoria + "'";
            rs = st.executeQuery(sql);
            servicios = new LinkedList<String>();
            while (rs.next()) {
                servicios.add(rs.getString("servicio"));
            }

        } catch (SQLException e) {
            System.out.println("No pude cargar servicios");
            System.err.println(e.getMessage());
        }

        return servicios;
    }*/
     public List<DtItemReserva> listarItems(Integer reserva) {
        List<DtItemReserva> items = new ArrayList<DtItemReserva>();
        ResultSet rs;
        Connection con = Conexion.getInstance().getConnection();
        Statement st;
        String sql;
        sql = "SELECT * FROM help4traveling.reservasitems WHERE reserva='" +reserva+ "'";
        try {
            st = con.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                String oferta = rs.getString("oferta");
                String proveedorOferta = rs.getString("proveedorOferta");
                String inicio = rs.getString("inicio");
                String fin = rs.getString("fin");
                String cantidad = rs.getString("cantidad");
                Date iniciodate = new Date(inicio);
                Date findate = new Date(fin);
                Proveedor prov = new Proveedor(proveedorOferta); 
                Servicio ofertatype = new Servicio(oferta,prov,null,null,0,null);
                
                DtItemReserva item = new DtItemReserva(reserva,Integer.parseInt(cantidad),iniciodate,findate,ofertatype);
                
                items.add(item);
            }
            rs.close();
            st.close();
            con.close();
        } catch (SQLException e) {
            System.out.println("No pude obtener categorias :(");
        }
        return items;
    }
     
    public String getNkProveedorServicio(String servicio) {
        String prov = null;
        ResultSet rs;
        Statement st;
        try {
            Connection con = Conexion.getInstance().getConnection();        
            String sql = "SELECT * FROM help4traveling.servicios WHERE nombre='" + servicio + "'";
            st = con.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                prov = rs.getString("proveedor");
            }
            rs.close();
            st.close();
            con.close();
        } 
        catch (SQLException e) {
            System.out.println("No pude obtener Proveedor :(");
        }
        return prov;
    }     
    

}

        
