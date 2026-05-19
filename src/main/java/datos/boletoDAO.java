package datos;

import config.conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import modelo.boleto;
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
    
    
    
    public List<boleto>listarOrden(int idOrden){
        List<boleto>lista=new ArrayList<>();
        Connection conn=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        
        try{
            conn=conexion.getConnection();
            String sql="Select b.*,r.nombre as nombreRecinto,c.fecha " +
                       "From Boletos b " +
                        "Join Concierto c on b.id_concierto=c.id " +
                        "Join Recintos r on c.id_recinto=r.id " +
                        "Where b.id_orden=?";
        
            ps=conn.prepareStatement(sql);
            ps.setInt(1, idOrden);
            rs=ps.executeQuery();
            
            while(rs.next()){
                boleto b=new boleto();
                b.setid(rs.getInt("id"));
                b.setidconcierto(rs.getInt("id_concierto"));
                b.setidasiento(rs.getInt("id_asiento"));
                b.setidusuario(rs.getInt("id_usuario"));
                b.setidorden(rs.getInt("id_orden"));
                b.setzona(rs.getString("zona"));
                b.setcodigoqr(rs.getString("codigo_qr"));
                b.setpreciooriginal(rs.getDouble("precio_original"));
                b.setestado(rs.getString("estado"));
                b.setrecinto(rs.getString("nombreRecinto"));
                b.setfecha(rs.getString("fecha"));
                lista.add(b);
            }        
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            conexion.close(rs);
            conexion.close(ps);
            conexion.close(conn);
        }
        return lista;
    }
    
    public int obtenerUltimaOrden(int idUsuario) {
        int id = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = conexion.getConnection();
            String sql = "Select id From Ordenes Where id_cliente = ? Order by id Desc limit 1";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();
            if (rs.next()) {
                id = rs.getInt("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conexion.close(rs);
            conexion.close(ps);
            conexion.close(conn);
        }
        return id;
    }
}
