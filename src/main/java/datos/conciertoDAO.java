
package datos;
import config.conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.concierto;
/**
 *
 * @author luise
 */
public class conciertoDAO {
    public List<concierto> listar(){
        List<concierto> lista= new ArrayList<>();
        String sql= "SELECT c.*, u.nombre as nombreArtista, u.apellido as ApellidoArtista " +
                    "FROM Conciertos c " +
                    "JOIN Concierto_Artista ca ON c.id = ca.id_concierto " +
                    "JOIN Usuarios u ON ca.id_artista = u.id " +
                    "ORDER BY c.fecha ASC";
        
        try(Connection conn = conexion.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql);
            ResultSet rs= ps.executeQuery()){
            
            while(rs.next()){
                concierto c= new concierto();
                c.setid(rs.getInt("id"));
                c.setnombre(rs.getString("nombre"));
                c.setciudad(rs.getString("ciudad"));
                c.setfecha(rs.getDate("fecha"));
                c.setfotos(rs.getString("fotos"));
                c.setdescripcion(rs.getString("nombreArtista") + " " + rs.getString("ApellidoArtista"));
                lista.add(c);
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return lista;
    }
}
