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
   public List<carrito> obtenerMisBoletos(int idUsuario) {
        List<carrito> listaBoletos = new ArrayList<>();
        String sql = "Select a.id as idasiento, s.nombre as zona, a.fila, a.numero, b.precio_original as precio, c.id as idconcierto, c.nombre as nombreconcierto, c.ciudad, c.fecha as fechaconcierto " +
                     "from Boletos b " +
                     "join Asientos a on b.id_asiento = a.id " +
                     "join Secciones s on a.id_seccion = s.id " +
                     "join Conciertos c on b.id_concierto = c.id " +
                     "where b.id_usuario = ? and b.estado = 'VENDIDO' " +
                     "order by c.fecha desc";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = conexion.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idUsuario);
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
            System.out.println("Error al obtener mis compras: " + e.getMessage());
        } finally {
            conexion.close(rs);
            conexion.close(ps);
            conexion.close(conn);
        }

        return listaBoletos;
    }
}