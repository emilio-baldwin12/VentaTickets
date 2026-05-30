/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package datos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import config.conexion;
import modelo.carrito;
/**
 *
 * @author luise
 */
public class carritoDAO {
    public List<carrito> obtenerDetallesCarrito(ArrayList<String> idsAsientos) {
        List<carrito> listaBoletos = new ArrayList<>();
        
        if (idsAsientos == null || idsAsientos.isEmpty()) {
            return listaBoletos;
        }

        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < idsAsientos.size(); i++) {
            placeholders.append("?");
            if (i < idsAsientos.size() - 1) {
                placeholders.append(",");
            }
        }

        String sql = "select a.id as idasiento, s.nombre as zona, a.fila, a.numero, a.precio, c.id as idconcierto, c.nombre as nombreconcierto, c.ciudad, c.fecha as fechaconcierto " +
                     "from Asientos a " +
                     "join Secciones s on a.id_seccion = s.id " +
                     "join Conciertos c on s.id_recinto = c.id_recinto " +
                     "where a.id in (" + placeholders.toString() + ")";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = conexion.getConnection();
            ps = conn.prepareStatement(sql);

            for (int i = 0; i < idsAsientos.size(); i++) {
                ps.setInt(i + 1, Integer.parseInt(idsAsientos.get(i).trim()));
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                carrito boleto = new carrito();
                boleto.setidasiento(rs.getInt("idasiento"));
                boleto.setzona(rs.getString("zona"));
                boleto.setfila(rs.getString("fila"));
                boleto.setnumero(rs.getInt("numero"));
                boleto.setprecio(rs.getDouble("precio"));
                boleto.setidconcierto(rs.getInt("idconcierto"));
                boleto.setnombreconcierto(rs.getString("nombreconcierto"));
                boleto.setciudad(rs.getString("ciudad"));
                boleto.setfechaconcierto(rs.getDate("fechaconcierto"));
                
                listaBoletos.add(boleto);
            }

        } catch (Exception e) {
            System.out.println("Error al obtener el carrito: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        return listaBoletos;
    }
}
