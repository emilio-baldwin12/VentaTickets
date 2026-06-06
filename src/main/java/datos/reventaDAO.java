/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package datos;
import java.sql.*;
import config.conexion;
/**
 *
 * @author luise
 */
public class reventaDAO {
    public boolean publicarReventa(int idBoleto, int idVendedor, double precioNuevo, String motivo) {
        String sql = "Insert Into ReventaBoletos (id_boleto, id_vendedor, precio_nuevo, motivo, estado) Values (?, ?, ?, ?, 'ACTIVA')";
        
        try (Connection conn = conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idBoleto);
            ps.setInt(2, idVendedor);
            ps.setDouble(3, precioNuevo);
            ps.setString(4, motivo);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.out.println("Error al registrar el boleto en reventa: " + e.getMessage());
            return false;
        }
    }
    
    public java.util.List<java.util.Map<String, Object>> listarReventasActivas() {
        java.util.List<java.util.Map<String, Object>> lista = new java.util.ArrayList<>();
        String sql = "Select r.id as id_reventa, r.precio_nuevo, r.motivo, " +
                     "u.nombre as vendedor, c.nombre as concierto, c.ciudad, c.fecha as concierto_fecha, " +
                     "s.nombre as zona, a.fila, a.numero as asiento " + 
                     "from ReventaBoletos r " +
                     "join Boletos b on r.id_boleto = b.id " +
                     "join Usuarios u on r.id_vendedor = u.id " +
                     "join Conciertos c on b.id_concierto = c.id " +
                     "join Asientos a on b.id_asiento = a.id " +    
                     "join Secciones s on a.id_seccion = s.id " +  
                     "where r.estado = 'ACTIVA' " +
                     "order by r.fecha desc";
                     
        try (Connection conn = config.conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                java.util.Map<String, Object> map = new java.util.HashMap<>();
                map.put("id_reventa", rs.getInt("id_reventa"));
                map.put("precio_nuevo", rs.getDouble("precio_nuevo"));
                map.put("motivo", rs.getString("motivo"));
                map.put("concierto", rs.getString("concierto"));
                map.put("concierto_fecha", rs.getDate("concierto_fecha"));
                map.put("ciudad", rs.getString("ciudad"));
                map.put("vendedor", rs.getString("vendedor"));
                map.put("zona", rs.getString("zona"));
                map.put("fila", rs.getString("fila"));
                map.put("asiento", rs.getInt("asiento"));
                
                lista.add(map);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar reventas: " + e.getMessage());
        }
        return lista;
    }
    
    public boolean concretarCompraReventa(int idReventa, int idNuevoComprador) {
        Connection conn = null;
        PreparedStatement psSelect = null;
        PreparedStatement psUpdateReventa = null;
        PreparedStatement psUpdateBoleto = null;
        ResultSet rs = null;
        boolean exito = false;

        try {
            conn = config.conexion.getConnection();
            conn.setAutoCommit(false); 

            String sqlSelect = "Select id_boleto From ReventaBoletos Where id = ?";
            psSelect = conn.prepareStatement(sqlSelect);
            psSelect.setInt(1, idReventa);
            rs = psSelect.executeQuery();

            if (rs.next()) {
                int idBoleto = rs.getInt("id_boleto");

                String sqlReventa = "update ReventaBoletos set estado = 'VENDIDA' where id = ?";
                psUpdateReventa = conn.prepareStatement(sqlReventa);
                psUpdateReventa.setInt(1, idReventa);
                psUpdateReventa.executeUpdate();

                String sqlBoleto = "update Boletos set id_usuario = ? where id = ?";
                psUpdateBoleto = conn.prepareStatement(sqlBoleto);
                psUpdateBoleto.setInt(1, idNuevoComprador);
                psUpdateBoleto.setInt(2, idBoleto);
                psUpdateBoleto.executeUpdate();

                conn.commit(); 
                exito = true;
            }
        } catch (SQLException e) {
            System.out.println("Error en transacción de reventa: " + e.getMessage());
            try { 
                if (conn != null) conn.rollback(); 
            } catch (SQLException ex) {}
        } finally {
            try { 
                if (rs != null) rs.close(); 
            } catch (SQLException e) {
            }
            try {
                if (psSelect != null) psSelect.close(); 
            } catch (SQLException e) {
            }
            try {
                if (psUpdateReventa != null) psUpdateReventa.close(); 
            } catch (SQLException e) {
            }
            try {
                if (psUpdateBoleto != null) psUpdateBoleto.close(); 
            } catch (SQLException e) {}
            try {
                if (conn != null) { 
                    conn.setAutoCommit(true);
                    conn.close(); 
                } 
            } catch (SQLException e) {}
        }
        
        return exito;
    }
}
