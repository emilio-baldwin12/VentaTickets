
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
       public List<concierto> listarTours(){
       List<concierto>lista=new ArrayList<>();
       String sql= "Select nombre,fotos From Conciertos Group by nombre, fotos";
       
       try (Connection conn = config.conexion.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql);
            ResultSet rs=ps.executeQuery()){
           while(rs.next()) {
               concierto c=new concierto();
               c.setnombre(rs.getString("nombre"));
               c.setfotos(rs.getString("fotos"));
               lista.add(c);
           }
       }catch (SQLException e){
           e.printStackTrace();
       }
       return lista;
   }
       
    public List<concierto> listarPorTour(String nombreTour){
        List<concierto> lista= new ArrayList<>();
        String sql= "Select c.*, u.nombre as nombreArtista, u.apellido as ApellidoArtista " +
                    "from Conciertos c " +
                    "Join Concierto_Artista ca on c.id = ca.id_concierto " +
                    "Join Usuarios u on ca.id_artista = u.id " +
                    "where c.nombre= ? order by c.fecha ASC";
        
        try(Connection conn = conexion.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql)){
            ps.setString(1, nombreTour);
            ResultSet rs=ps.executeQuery();
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
    
    public concierto detalleConcierto(int idConcierto){
        concierto c=null;
        String sql="Select c.*,r.ruta_mapa " +
                   "from Conciertos c " +
                   "Join Recintos r on c.id_recinto=r.id " +
                   "where c.id=?";
        try(Connection conn = config.conexion.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql)){
            
            ps.setInt(1,idConcierto);
            ResultSet rs=ps.executeQuery();
            
            if(rs.next()){
                c=new concierto();
                c.setid(rs.getInt("id"));
                c.setnombre(rs.getString("nombre"));
                c.setciudad(rs.getString("ciudad"));
                c.setfecha(rs.getDate("fecha"));
                c.setfotos(rs.getString("fotos"));
                c.setdescripcion(rs.getString("descripcion"));
                c.setrutamapa(rs.getString("ruta_mapa"));
            }
        }catch(SQLException e){
            System.out.println("Error al intentar obetener los detalles: " + e.getMessage());
        }
         return c;   
    }
    
    public boolean registrarConcierto(String nombre, int idArtista, String fecha, String ciudad, int idRecinto, String fotos, String descripcion) {
        String sqlConcierto = "Insert into Conciertos (nombre, fecha, ciudad, id_recinto, fotos, descripcion) values (?, ?::date, ?, ?, ?, ?) returning id";
        String sqlPuente = "Insert Into Concierto_Artista (id_concierto, id_artista) values (?, ?)";
        
        try (Connection conn = config.conexion.getConnection()) {
            conn.setAutoCommit(false);
            int idNuevoConcierto = 0;
            
            try (PreparedStatement ps = conn.prepareStatement(sqlConcierto)) {
                ps.setString(1, nombre);
                ps.setString(2, fecha);
                ps.setString(3, ciudad);
                ps.setInt(4, idRecinto);
                ps.setString(5, fotos);
                ps.setString(6, descripcion);
                
                try (ResultSet rs = ps.executeQuery()) {
                    if(rs.next()){
                        idNuevoConcierto = rs.getInt("id");
                    }
                }
            }
            
            if(idNuevoConcierto > 0){
                try (PreparedStatement ps2 = conn.prepareStatement(sqlPuente)) {
                    ps2.setInt(1, idNuevoConcierto);
                    ps2.setInt(2, idArtista);
                    ps2.executeUpdate();
                }
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
        } catch (SQLException e) {
            System.out.println("Error en transacción de concierto: " + e.getMessage());
            return false;
        }
    }
}
