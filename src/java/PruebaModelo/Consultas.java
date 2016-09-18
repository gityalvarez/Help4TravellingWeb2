/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package PruebaModelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author yaman
 */
public class Consultas extends Conexion{
    
    public boolean Autenticacion(String usuario, String contrasena) throws SQLException{
        
        Statement st = con.createStatement();
        ResultSet rs = null;
        String Consulta = "SELECT * FROM usuarios";
        rs = st.executeQuery(Consulta);
       
        while (rs.next()){
           if (usuario.equals(rs.getString("nickname")) && contrasena.equals(rs.getString("password")))
               return true;
       }
        return false;
    }
       /* public static void main(String[] args) throws SQLException {
            Consultas con = new Consultas();
            System.out.println(con.Autenticacion("adippet","Dippet123"));
        }*/
}
        
