/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package datos;
import config.conexion;
import java.sql.*;
import modelo.usuario;
/**
 *
 * @author luise 
 */
public class usuarioDAO {
    private static final String SQL_INSERT = "INSERT INTO usuarios (nombre, apellido, correo, contrasena, telefono, pais) VALUES (?, ?, ?, ?, ?, ?)";
    
    private static final String SQL_SELECT_LOGIN = "SELECT * FROM usuarios WHERE correo = ? AND contrasena = ?";
    public int registrar(usuario u) {
        Connection conn = null;
        PreparedStatement ps = null;
        int rows = 0;

        try {
            conn = conexion.getConnection();
            ps = conn.prepareStatement(SQL_INSERT);
            ps.setString(1, u.getnombre());
            ps.setString(2, u.getapellido());
            ps.setString(3, u.getcorreo());
            ps.setString(4, u.getcontrasenia());
            ps.setString(5, u.gettelefono());
            ps.setString(6, u.getpais());

            rows = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            conexion.close(ps);
            conexion.close(conn);
        }
        return rows;
    }

    public boolean validar(String correo, String pass) {//Login
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean loginExitoso = false;

        try {
            conn = conexion.getConnection();
            ps = conn.prepareStatement(SQL_SELECT_LOGIN);
            ps.setString(1, correo);
            ps.setString(2, pass);
            rs = ps.executeQuery();

            if (rs.next()) {
                loginExitoso = true; // Si encontró al usuario en la BD
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            conexion.close(rs);
            conexion.close(ps);
            conexion.close(conn);
        }
        return loginExitoso;
    }
}
