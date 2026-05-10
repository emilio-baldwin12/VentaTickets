
package datos;
import config.conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.artista;
import modelo.cancion;
public class artistaDAO {
   public List<artista> obtenerArtistas(){
       List<artista> lista = new ArrayList<>();
       String sql = "SELECT u.id,u.nombre, u.apellido, a.genero,a.foto " +
                    "FROM Usuarios u " +
                    "JOIN Artistas a ON u.id=a.id_usuario";
       
       try(Connection conn=conexion.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql);
            ResultSet rs=ps.executeQuery()){
           while(rs.next()){
               System.out.println("DEBUG: Encontré al artista: " + rs.getString("nombre"));
               artista art= new artista();
               art.setID(rs.getInt("id"));
               art.setnombre(rs.getString("nombre"));
               art.setapellido(rs.getString("apellido"));
               art.setgenero(rs.getString("genero"));
               art.setfoto(rs.getString("foto"));
               lista.add(art);
           }
       }catch(SQLException e){
           System.out.println("Error al listar artistas: " + e.getMessage());
           e.printStackTrace();
       }
       return lista;
   } 
   
   public artista obtenerPerfil(int idartista){
       artista art=null;
       String sql="SELECT u.id,u.nombre,u.apellido,a.genero, a.foto, a.banner, a.descripcion,a.total_seguidores " +
                   "FROM Usuarios u " +
                   "JOIN Artistas a ON u.id=a.id_usuario " +
                   "WHERE u.id=?";
       
       try(Connection conn = conexion.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql)){
           
           ps.setInt(1,idartista);
           try(ResultSet rs= ps.executeQuery()){
               if(rs.next()){
                   art= new artista();
                   art.setID(rs.getInt("id"));
                   art.setnombre(rs.getString("nombre"));
                   art.setapellido(rs.getString("apellido"));
                   art.setgenero(rs.getString("genero"));
                   art.setfoto(rs.getString("foto"));
                   art.setbanner(rs.getString("banner"));
                   art.setdescripcion(rs.getString("descripcion"));
                   art.settotal_seguidores(rs.getInt("total_seguidores"));
               }
           }
       }catch(SQLException e){
           System.out.println("Error al obtener perfil: " + e.getMessage());
       }
       return art;
   }
   
   public boolean esSeguidor(int idusuario, int idartista){
       boolean siguiendo= false;
       String sql="SELECT 1 FROM Seguidores WHERE id_usuario= ? AND id_artista=?";
       
       try(Connection conn= conexion.getConnection();
           PreparedStatement ps= conn.prepareStatement(sql)){
           ps.setInt(1,idusuario);
           ps.setInt(2, idartista);
           
           try(ResultSet rs = ps.executeQuery()){
               siguiendo = rs.next();
          
           }
       }catch (SQLException e){
           System.out.println("Error en esSeguidor: " + e.getMessage());
       }
       return siguiendo;
   }
   
   public List<cancion> obtenerCanciones(int idartista){
       List<cancion> lista = new ArrayList<>();
       String sql= "SELECT titulo,url,foto FROM Canciones WHERE id_artista = ?";
       
       try (Connection conn=config.conexion.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql)){
            ps.setInt(1, idartista);
            ResultSet rs= ps.executeQuery();
            while(rs.next()){
                cancion c= new cancion();
                c.settitulo(rs.getString("titulo"));
                c.seturl(rs.getString("url"));
                c.setfoto(rs.getString("foto"));
                lista.add(c);
                
            }
       }catch(SQLException e){
           e.printStackTrace();
       }
       return lista;
   }
   
   public boolean registrarArtista(artista art) {
    Connection conn = null;
    PreparedStatement psUsu = null;
    PreparedStatement psArt = null;
    ResultSet rs = null;
    boolean ok = false;

    String sqlUsu = "INSERT INTO Usuarios (nombre, apellido, correo, contrasena, tipousuario) VALUES (?, ?, ?, ?, 'ARTISTA')";
    String sqlArt = "INSERT INTO Artistas (id_usuario, descripcion, genero, foto) VALUES (?, ?, ?, ?)";

    try {
        conn = config.conexion.getConnection();
        conn.setAutoCommit(false); 

        psUsu = conn.prepareStatement(sqlUsu, Statement.RETURN_GENERATED_KEYS);
        psUsu.setString(1, art.getnombre());
        psUsu.setString(2, art.getapellido());
        psUsu.setString(3, art.getcorreo());
        psUsu.setString(4, art.getcontrasena());
        psUsu.executeUpdate();

        rs = psUsu.getGeneratedKeys();
        if (rs.next()) {
            int idGenerado = rs.getInt(1);

            psArt = conn.prepareStatement(sqlArt);
            psArt.setInt(1, idGenerado);
            psArt.setString(2, art.getdescripcion());
            psArt.setString(3, art.getgenero());
            psArt.setString(4, art.getfoto());
            psArt.executeUpdate();

            conn.commit();//Se guarda todo
            ok = true;
        }
    } catch (SQLException e) {
        if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
        e.printStackTrace();
    }
    return ok;
}
}
