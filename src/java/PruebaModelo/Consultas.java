/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package PruebaModelo;

import Logica.Conexion;
import Logica.Date;
import Logica.DtItemReserva;
import Logica.DtPromocion;
import Logica.DtProveedor;
import Logica.DtReserva;
import Logica.DtUsuario;
import Logica.ItemReserva;
import Logica.Proveedor;
import Logica.Reserva;
import Logica.Servicio;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yaman
 */
public class Consultas {

    public boolean Autenticacion(HttpSession sesion) throws SQLException {
        Connection con = Conexion.getInstance().getConnection();
        try (Statement st = con.createStatement()) {
            ResultSet rs = null;
            String Consulta = "SELECT * FROM usuarios";
            rs = st.executeQuery(Consulta);
            while (rs.next()) {
                if (sesion.getAttribute("nickname").equals(rs.getString("nickname")) && sesion.getAttribute("password").equals(rs.getString("password"))) {
                    sesion.setAttribute("nombre", rs.getString("nombre"));
                    sesion.setAttribute("apellido", rs.getString("apellido"));
                    sesion.setAttribute("email", rs.getString("email"));
                    sesion.setAttribute("fechaNac", rs.getString("fechaNac"));
                    rs.close();
                    st.close();
                    return true;
                }
            }
            rs.close();
        }
        return false;
    }

    public boolean Comprobacion(String nickname, String email) throws SQLException {
        Connection con = Conexion.getInstance().getConnection();
        try (Statement st = con.createStatement()) {
            ResultSet rs = null;
            String Consulta = "SELECT * FROM usuarios";
            rs = st.executeQuery(Consulta);
            while (rs.next()) {
                if (nickname.equals(rs.getString("nickname")) || email.equals(rs.getString("email"))) {
                    rs.close();
                    st.close();
                    return false;
                }
            }
            rs.close();
        }
        return true;
    }

    public boolean Registrar(String nickname, String nombre, String apellido, String password, String email, String imagen, String fecha) throws SQLException {
        Statement st;
        if (imagen != null) {
            imagen = "'" + imagen + "'";
            //imagen = imagen.replace("\\", "\\\\");
        }
        //String fecha = (anio+ "-" + mes + "-" + dia);
        String fechaNac = fecha.replaceAll("/", "-");

        String sqlau = "INSERT INTO help4traveling.usuarios (nickname,nombre,apellido,password,email,imagen,fechaNac) VALUES ('" + nickname + "','" + nombre + "','" + apellido + "','" + password + "','" + email + "'," + imagen + ",'" + fechaNac + "')";
        System.out.println(sqlau);
        String sqlac = "INSERT INTO help4traveling.clientes (nickname) VALUES ('" + nickname + "')";
        String sqlai = "INSERT INTO help4traveling.usuariosimagenes (usuario,imagen) VALUES ('" + nickname + "'," + imagen + ")";
        try {
            Connection con = Conexion.getInstance().getConnection();
            st = con.createStatement();
            System.out.println("anted de insertar" + imagen);
            System.out.println("sentencia de insertar" + sqlai);
            st.executeUpdate(sqlau);
            st.executeUpdate(sqlac);
            //if ((imagen.equals(null)) && (!imagen.equals(""))) {
            st.executeUpdate(sqlai);
            //con.prepareStatement(sqlai);
            //}
            st.close();
            con.close();
            System.out.println("INSERTE :)");
            return true;
        } catch (SQLException e) {
            System.out.println("No pude INSERTAR :(");
            System.out.println(e);
            return false;
        }
    }

    public DtUsuario getDtUsuario(String nickname) {
        ResultSet rsUsu, rsImg;
        DtUsuario nuevo = null;
        Statement stUsu, stImg;
        try {
            Connection con = Conexion.getInstance().getConnection();
            stUsu = con.createStatement();
            String sql = "SELECT * FROM help4traveling.usuarios WHERE nickname='" + nickname + "'";
            rsUsu = stUsu.executeQuery(sql);
            if (rsUsu.next()) {
                String nombre = rsUsu.getString("nombre");
                String apellido = rsUsu.getString("apellido");
                String correo = rsUsu.getString("email");
                Date fecha = new Date(rsUsu.getString("fechaNac"));
                String imagen = null;
                stImg = con.createStatement();
                sql = "SELECT * FROM help4traveling.usuariosimagenes WHERE nickname='" + nickname + "'";
                rsImg = stImg.executeQuery(sql);
                if (rsImg.next()) {
                    imagen = rsImg.getString("imagen");
                }
                rsImg.close();
                stImg.close();
                nuevo = new DtUsuario(nombre, apellido, nickname, "password", correo, fecha, imagen, "tipo", "empresa", "link");
            }
            rsUsu.close();
            stUsu.close();
            con.close();
            System.out.println("Se obtuvo Usuario :)");
        } catch (SQLException e) {
            System.out.println("No obtuve Usuario :(");
            System.err.println(e.getMessage());
        }
        return nuevo;
    }

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
                if (rsImg.next()) {
                    imagen = rsImg.getString("imagen");
                }
                rsImg.close();
                stImg.close();
                DtUsuario nuevo = new DtUsuario(nombre, apellido, nickname, "password", correo, fecha, imagen, "tipo", "empresa", "link");
                usuarios.add(nuevo);
            }
            rsUsu.close();
            stUsu.close();
            con.close();
            System.out.println("Usuarios cargados :)");
        } catch (SQLException e) {
            System.out.println("No pude cargar Usuarios :(");
        }
        return usuarios;
    }

    public List<DtReserva> listarReservasUsuario(String cli) throws SQLException {
        List<DtReserva> ReservaxUsuario = null;
        ResultSet rs;
        Connection con = Conexion.getInstance().getConnection();
        Statement st;
        String sql = "SELECT * FROM help4traveling.reservas where cliente ='" + cli + "'";
        try {
            st = con.createStatement();
            rs = st.executeQuery(sql);
            ReservaxUsuario = new LinkedList<DtReserva>();
            while (rs.next()) {
                String numero = rs.getString("numero");
                String fecha1 = rs.getString("fecha");
                String total = rs.getString("total");
                String estado = rs.getString("estado");

                String partes[] = fecha1.split("-");

                Date fecha = new Date(Integer.valueOf(partes[2]), Integer.valueOf(partes[1]), Integer.valueOf(partes[0]));
                Map<Integer, ItemReserva> items = null;

                DtReserva nueva = null;
                switch (estado) {
                    case "REGISTRADA":
                        nueva = new DtReserva(Long.parseLong(numero), fecha, Reserva.eEstado.REGISTRADA, Double.parseDouble(total), cli, items);
                        break;
                    case "CANCELADA":
                        nueva = new DtReserva(Long.parseLong(numero), fecha, Reserva.eEstado.CANCELADA, Double.parseDouble(total), cli, items);
                        break;
                    case "FACTURADA":
                        nueva = new DtReserva(Long.parseLong(numero), fecha, Reserva.eEstado.FACTURADA, Double.parseDouble(total), cli, items);
                        break;
                    case "PAGADA":
                        nueva = new DtReserva(Long.parseLong(numero), fecha, Reserva.eEstado.PAGADA, Double.parseDouble(total), cli, items);
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

    public List<DtReserva> listarReservasProveedor(String prov) throws SQLException {
        List<DtReserva> ReservaxProveedor = null;
        ResultSet rs;
        Connection con = Conexion.getInstance().getConnection();
        Statement st;
        String sql = "SELECT * FROM help4traveling.reservas WHERE numero IN (SELECT reserva FROM help4traveling.reservasitems WHERE proveedorOferta ='" + prov + "')";
        try {
            st = con.createStatement();
            rs = st.executeQuery(sql);
            ReservaxProveedor = new LinkedList<DtReserva>();
            while (rs.next()) {
                String numero = rs.getString("numero");
                String fecha1 = rs.getString("fecha");
                String total = rs.getString("total");
                String estado = rs.getString("estado");
                String cliente = rs.getString("cliente");

                String partes[] = fecha1.split("-");

                Date fecha = new Date(Integer.valueOf(partes[2]), Integer.valueOf(partes[1]), Integer.valueOf(partes[0]));
                Map<Integer, ItemReserva> items = null;

                DtReserva nueva = null;
                switch (estado) {
                    case "REGISTRADA":
                        nueva = new DtReserva(Long.parseLong(numero), fecha, Reserva.eEstado.REGISTRADA, Double.parseDouble(total), cliente, items);
                        break;
                    case "CANCELADA":
                        nueva = new DtReserva(Long.parseLong(numero), fecha, Reserva.eEstado.CANCELADA, Double.parseDouble(total), cliente, items);
                        break;
                    case "FACTURADA":
                        nueva = new DtReserva(Long.parseLong(numero), fecha, Reserva.eEstado.FACTURADA, Double.parseDouble(total), cliente, items);
                        break;
                    case "PAGADA":
                        nueva = new DtReserva(Long.parseLong(numero), fecha, Reserva.eEstado.PAGADA, Double.parseDouble(total), cliente, items);
                        break;
                }

                ReservaxProveedor.add(nueva);
            }
            rs.close();
            con.close();
            st.close();
            System.out.println("Reservas  cargadas :)");
        } catch (SQLException e) {
            System.out.println("No pude cargar reservas :(");
        }
        return ReservaxProveedor;
    }

    public ArrayList<DtPromocion> listarPromocionesProveedor(String prov) {
        Connection con = Conexion.getInstance().getConnection();
        Statement st;
        ResultSet rs;
        String sql = "SELECT * FROM help4traveling.promociones WHERE proveedor= '" + prov + "'";
        ArrayList<DtPromocion> promociones = new ArrayList<DtPromocion>();
        try {
            st = con.createStatement();
            rs = st.executeQuery(sql);

            DtPromocion prom;
            while (rs.next()) {
                String nombre = rs.getString("nombre");
                String proveedor = rs.getString("proveedor");
                String descuento = rs.getString("descuento");
                String total = rs.getString("total");
                prom = new DtPromocion(nombre, proveedor, descuento, total);
                promociones.add(prom);
            }
            rs.close();
            con.close();
            st.close();

        } catch (SQLException e) {
            System.out.println("No se encontraron promociones.");
            System.out.println(e.getMessage());
        }
        return promociones;
    }

    public List<DtItemReserva> listarItems(Integer reserva) {
        List<DtItemReserva> items = new ArrayList<DtItemReserva>();
        ResultSet rs;
        Connection con = Conexion.getInstance().getConnection();
        Statement st;
        String sql;
        sql = "SELECT * FROM help4traveling.reservasitems WHERE reserva='" + reserva + "'";
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
                Servicio ofertatype = new Servicio(oferta, prov, null, null, 0, null);

                DtItemReserva item = new DtItemReserva(reserva, Integer.parseInt(cantidad), iniciodate, findate, ofertatype);

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

    public Boolean esProveedor(String nickname) {
        Boolean esProv = false;
        ResultSet rs;
        Statement st;
        try {
            Connection con = Conexion.getInstance().getConnection();
            String sql = "SELECT * FROM help4traveling.proveedores WHERE nickname='" + nickname + "'";
            st = con.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                esProv = true;
            }
            rs.close();
            st.close();
            con.close();
        } catch (SQLException e) {
            System.out.println("No pude obtener Proveedor :(");
        }
        return esProv;
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
        } catch (SQLException e) {
            System.out.println("No pude obtener Proveedor :(");
        }
        return prov;
    }

    public String getNkProveedorPromocion(String promocion) {
        String prov = null;
        ResultSet rs;
        Statement st;
        try {
            Connection con = Conexion.getInstance().getConnection();
            String sql = "SELECT * FROM help4traveling.promociones WHERE nombre='" + promocion + "'";
            st = con.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                prov = rs.getString("proveedor");
            }
            rs.close();
            st.close();
            con.close();
        } catch (SQLException e) {
            System.out.println("No pude obtener Proveedor :(");
        }
        return prov;
    }

    public List<String> listarServiciosDePromociones(String nombre, String prov) {
        List<String> listaServicios = new LinkedList<String>();
        ResultSet rs;
        Connection con = Conexion.getInstance().getConnection();
        Statement st;
        String sql = "SELECT * FROM help4traveling.promocionesservicios WHERE promocion='" + nombre + "' AND proveedorPromocion='" + prov + "'";
        try {
            st = con.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                String servicio = rs.getString("servicio");
                //String proveedor = rs.getString("proveedorServicio");
                listaServicios.add(servicio);
            }
            rs.close();
            st.close();
            con.close();
            System.out.println("servicios cargados :)");
        } catch (SQLException e) {
            System.out.println("No pude cargar servicios :(");
        }
        return listaServicios;
    }

    public String imagenPerfilUsuario(String nickname) {
        String imagen = null;
        ResultSet rs;
        Connection con = Conexion.getInstance().getConnection();
        Statement st;
        String sql = "SELECT * FROM help4traveling.usuariosimagenes WHERE usuario='" + nickname + "'";
        try {
            st = con.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                imagen = rs.getString("imagen");
            }
            if ((imagen.equals(null)) || (imagen.equals(""))) {
                imagen = "../img/user.png";
            }
            rs.close();
            st.close();
            con.close();
            System.out.println("Imagenes cargadas :)");
        } catch (SQLException e) {
            System.out.println("No pude cargar Imagenes :(");
        }
        return imagen;
    }

    public void altaReserva(Reserva nueva) {
        //conexion = new Conexion();
        Connection con = Conexion.getInstance().getConnection();
        Statement st;
        ResultSet rsId;
        String sid;
        Calendar c = Calendar.getInstance();
        int dia = c.get(Calendar.DATE);
        int mes = c.get(Calendar.MONTH) + 1;
        int anio = c.get(Calendar.YEAR);
        String creada = Integer.toString(anio) + "-" + Integer.toString(mes) + "-" + Integer.toString(dia);
        String sql = "INSERT INTO help4traveling.reservas (fecha,total,estado,cliente) "
                + "VALUES ('" + creada + "'," + nueva.getTotal() + ",'" + nueva.getEstado() + "','" + nueva.getCliente() + "')";

        try {
            st = con.createStatement();
            st.executeUpdate(sql);

            try {
                sql = "SELECT MAX(numero) AS id FROM help4traveling.reservas";
                rsId = st.executeQuery(sql);
                rsId.next();
                sid = rsId.getString("id");

                try {
                    if (nueva.getItems().size() > 0) {
                        System.out.println("entre al if 1");
                        for (Map.Entry<Integer, ItemReserva> entry : nueva.getItems().entrySet()) {
                            System.out.println("entre al for 1");
                            ItemReserva key = entry.getValue();
                            String oferta = key.getOferta().getNombre();
                            String proveedor = "";
                            if (esservicio(oferta)) {
                                proveedor = getNkProveedorServicio(oferta);
                            } else {
                                proveedor = getNkProveedorPromocion(oferta);
                            }
                            String cantidad = String.valueOf(key.getCantidad());
                            String inicio = key.getInicio().getAno() + "-" + key.getInicio().getMes() + "-" + key.getInicio().getDia();
                            String fin = key.getFin().getAno() + "-" + key.getFin().getMes() + "-" + key.getFin().getDia();
                            System.out.println(sid + " " + oferta + " " + proveedor + " " + cantidad + " " + inicio + " " + fin);
                            sql = "INSERT INTO help4traveling.reservasitems (reserva, oferta, proveedorOferta, cantidad, inicio, fin) "
                                    + "VALUES (" + sid + ",'" + oferta + "','" + proveedor + "'," + cantidad + ",'" + inicio + "','" + fin + "')";

                            st.executeUpdate(sql);
                        }
                        con.close();
                        st.close();
                        System.out.println("Reserva creada con exito :)");
                    }
                } catch (SQLException e) {
                    System.out.println("No se pudo insertar item reserva :(");
                    System.err.println(e);
                }
            } catch (SQLException e) {
                System.out.println("No se pudo obtener id :(");
            }
        } catch (SQLException e) {
            System.out.println("No se pudo crear reserva :(");
            System.err.println(e);
        }
    }

    public boolean esservicio(String nombre) {
        boolean es = false;
        ResultSet rs;
        Connection con = Conexion.getInstance().getConnection();
        Statement st;
        String sql = "SELECT * FROM help4traveling.servicios WHERE nombre='" + nombre + "'";
        try {
            st = con.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                es = true;
            }
            rs.close();
            st.close();
            con.close();
            System.out.println("consula servicio realizada :)");
            System.out.println(es);
        } catch (SQLException e) {
            System.out.println("consula servicio NO realizada :(");
        }
        return es;

    }
    
}
