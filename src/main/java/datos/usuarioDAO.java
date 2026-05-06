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


public boolean registrar(usuario u, String generoFavorito) {
        String sqlUser = "INSERT INTO usuarios (nombre, apellido, correo, contrasena, telefono, pais, tipo_usuario) VALUES (?, ?, ?, ?, ?, ?, 'CLIENTE')";
        String sqlCliente = "INSERT INTO clientes (id_usuario, generoFavorito) VALUES (?, ?)";
        
        Connection conn = null;
        try {
            conn = conexion.getConnection();
            conn.setAutoCommit(false); 
            
            PreparedStatement psUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, u.getnombre());
            psUser.setString(2, u.getapellido());
            psUser.setString(3, u.getcorreo());
            psUser.setString(4, u.getcontrasenia()); 
            psUser.setString(5, u.gettelefono());
            psUser.setString(6, u.getpais());
            psUser.executeUpdate();
            
            ResultSet rs = psUser.getGeneratedKeys();
            int nuevoId = 0;
            if (rs.next()) {
                nuevoId = rs.getInt(1); 
            }
            
            PreparedStatement psCliente = conn.prepareStatement(sqlCliente);
            psCliente.setInt(1, nuevoId);
            psCliente.setString(2, generoFavorito);
            psCliente.executeUpdate();
            
            conn.commit(); 
            return true;
            
        } catch (Exception e) {
            if (conn != null) { 
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); } 
            }
            e.printStackTrace();
            return false;
        } finally {
        }
    }
}