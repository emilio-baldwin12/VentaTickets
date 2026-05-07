
package datos;

/**
 *
 * @author luise
 */
import config.conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.notificacion;

public class notificacionDAO {
    public List<notificacion> obtenerNotis(int idusuario, String tipousuario) {
        List<notificacion> lista = new ArrayList<>();
        
        String sql = "SELECT * FROM notificaciones WHERE id_usuario_destino = ? ORDER BY fecha DESC";
        String sqlAdmin = "SELECT id_usuario, rol, motivo, fecha FROM solicitudes WHERE estado = 'PENDIENTE'";

        try (Connection conn = conexion.getConnection(); 
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, idusuario);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            notificacion n = new notificacion();
            n.settitulo(rs.getString("titulo"));
            n.setmensaje(rs.getString("mensaje"));
            n.setfecha(rs.getTimestamp("fecha"));
            n.settipo(rs.getString("tipo"));
            lista.add(n);
        }

            if ("ADMIN".equals(tipousuario)) {
                try (PreparedStatement psAdmin = conn.prepareStatement(sqlAdmin)) {
                    ResultSet rsAdmin = psAdmin.executeQuery();
                    while (rsAdmin.next()) {
                        notificacion n = new notificacion();
                        n.settitulo("SOLICITUD DE ROL: " + rsAdmin.getString("rol"));
                        n.setmensaje("El usuario ID " + rsAdmin.getInt("id_usuario") + " solicita cambio. Motivo: " + rsAdmin.getString("motivo"));
                        n.setfecha(rsAdmin.getTimestamp("fecha"));
                        n.settipo("PERMISO"); // Categoría especial para filtrar
                        lista.add(n);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}