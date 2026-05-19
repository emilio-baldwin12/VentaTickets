package datos;

import config.conexion;
import java.sql.*;
import java.util.UUID;

/**
 *
 * @author luise
 */
public class boletoDAO {

    public boolean procesar_Compra(int idUsuario, int idConcierto, int[] idAsientos, double precio) {
        Connection conn = null;
        PreparedStatement orden = null;
        PreparedStatement boleto = null;
        ResultSet rs = null;

        try {
            conn = conexion.getConnection();
            conn.setAutoCommit(false); //Para iniciar las Transacciones
            String sqlOrden = "Insert into Ordenes(id_cliente,precio_total,estado,fecha) values(?,?,?,current_date) returning id";
            orden = conn.prepareStatement(sqlOrden);
            orden.setInt(1, idUsuario);
            orden.setDouble(2, precio * idAsientos.length);
            orden.setString(3, "COMPLETADA");

            rs = orden.executeQuery();
            int id_orden = 0;
            if (rs.next()) {
                id_orden = rs.getInt(1);
            }
            String sqlBoleto = "Update Boletos SET id_usuario=?, id_orden = ?, estado= 'VENDIDO', codigo_qr=? " +
                               "Where id_concierto =? and id_asiento=? and estado='DISPONIBLE'";
            boleto = conn.prepareStatement(sqlBoleto);
            for (int idasiento : idAsientos) {
                String qr = UUID.randomUUID().toString();//Genera el qr
                boleto.setInt(1, idUsuario);
                boleto.setInt(2, id_orden);
                boleto.setString(3, qr); 
                boleto.setInt(4, idConcierto);
                boleto.setInt(5, idasiento);

                int filas_afectadas = boleto.executeUpdate();

                if (filas_afectadas == 0) {//Si la fila no se actualizó fue porque alguien mas lo comrpo jussto en el moemento
                    conn.rollback();
                    return false;
                }
            }

            conn.commit();//Guardamos 
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // Por si se truena 
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            conexion.close(rs);
            conexion.close(orden);
            conexion.close(boleto);
            conexion.close(conn);
        }
    }
}