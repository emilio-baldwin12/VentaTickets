
package datos;
import config.conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.artista;
import modelo.cancion;
import modelo.concierto;
public class artistaDAO {
   public List<artista> obtenerArtistas(){
       List<artista> lista = new ArrayList<>();
       String sql = "select u.id,u.nombre, u.apellido, a.genero,a.foto " +
                    "from Usuarios u " +
                    "join Artistas a ON u.id=a.id_usuario";
       
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
       String sql="Select u.id,u.nombre,u.apellido,a.genero, a.foto, a.banner, a.descripcion,a.total_seguidores " +
                   "from Usuarios u " +
                   "join Artistas a ON u.id=a.id_usuario " +
                   "where u.id=?";
       
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
       String sql="select 1 from Seguidores where id_usuario= ? and id_artista=?";
       
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
       String sql= "select titulo,url,foto from Canciones where id_artista = ?";
       
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

        String sqlUsu = "insert into Usuarios (nombre, apellido, correo, contrasena, tipousuario) VALUES (?, ?, ?, ?, 'ARTISTA')";
        String sqlArt = "insert into Artistas (id_usuario, descripcion, genero, foto, banner) VALUES (?, ?, ?, ?, ?)";

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
                psArt.setString(5, art.getbanner());
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
   
   public List<concierto> obtenerGiraArtista(int idArtista){
       List<concierto>lista=new ArrayList<>();
       String sql= "Select c.* from Conciertos c " +
                   "join Conciero_Artista ca on c.id = ca.id_concierto " +
                   "where ca.id_artista = ? " +
                   "order by c.fecha ASC";
       try(Connection conn =config.conexion.getConnection();
           PreparedStatement ps=conn.prepareStatement(sql)){
           ps.setInt(1,idArtista);
           ResultSet rs=ps.executeQuery();
           
           while(rs.next()){
               concierto c= new concierto();
               c.setid(rs.getInt("id"));
               c.setnombre(rs.getString("nombre"));
               c.setciudad(rs.getString("ciudad"));
               c.setfecha(rs.getDate("fecha"));
               c.setdescripcion(rs.getString("descripcion"));
               lista.add(c);
           }
           
       }catch(SQLException e){
           System.out.println("Error: " + e.getMessage());
       }
       return lista;
   }
   
   public List<concierto> obtenerConciertosArtistas(int idArtista){
       List <concierto> lista =new ArrayList<>();
       String sql ="Select c.* From Conciertos c " +
                   "Join Concierto_Artista ca on c.id = ca.id_concierto " +
                   "Where ca.id_artista = ? " +
                   "Order by c.fecha asc";
       
       try(Connection conn = config.conexion.getConnection();
           PreparedStatement ps=conn.prepareStatement(sql)){
           
           ps.setInt(1, idArtista);
           ResultSet rs=ps.executeQuery();
           
           while(rs.next()){
               concierto c= new concierto();
               c.setid(rs.getInt("id"));
               c.setnombre(rs.getString("nombre"));
               c.setciudad(rs.getString("ciudad"));
               c.setfecha(rs.getDate("fecha"));
               lista.add(c);
           }
       }catch(SQLException e){
           e.printStackTrace();
       }
       return lista;
   }
   
   public boolean eliminarArtista(int idUsuario){
       String sql="delete from Usuarios where id=? and tipousuario='ARTISTA'";
       try(Connection conn=conexion.getConnection();
           PreparedStatement ps=conn.prepareStatement(sql)){
           
           ps.setInt(1,idUsuario);
           return ps.executeUpdate() > 0;
       }catch(SQLException e){
           System.out.println("Error al eliminar artista: "+ e.getMessage());
           return false;
       }
   }
   
   public List<artista> listarTop4Tendencia() {
        List<artista> lista = new ArrayList<>();
        String sql = "Select u.id, u.nombre, a.genero, a.foto " +
                     "from Usuarios u " +
                     "join Artistas a on u.id = a.id_usuario " +
                     "order by u.id asc Limit 4"; 
        
        try (Connection conn = config.conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                artista a = new artista();
                a.setID(rs.getInt("id")); 
                a.setnombre(rs.getString("nombre"));
                a.setgenero(rs.getString("genero")); 
                a.setfoto(rs.getString("foto")); 
                lista.add(a);
            }
        } catch (Exception e) {
            System.out.println("Error al listar artistas en tendencia: " + e.getMessage());
        }
        return lista;
    }
   
   public boolean seguirArtista(int idUsuario, int idArtista) {
        String sql = "Insert into Seguidores (id_usuario, id_artista) values (?, ?)";
        try (Connection conn = config.conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setInt(2, idArtista);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al seguir artista: " + e.getMessage());
            return false;
        }
    }
   
   public boolean dejarDeSeguir(int idUsuario, int idArtista) {
        String sql = "Delete From Seguidores where id_usuario = ? and id_artista = ?";
        try (Connection conn = config.conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setInt(2, idArtista);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al dejar de seguir: " + e.getMessage());
            return false;
        }
    }
   
   public List<artista> obtenerArtistasSeguidos(int idUsuario) {
        List<artista> lista = new ArrayList<>();
        String sql = "Select u.id, u.nombre, u.apellido, a.genero, a.foto " +
                     "From Usuarios u " +
                     "join Artistas a on u.id = a.id_usuario " +
                     "join Seguidores s on u.id = s.id_artista " +
                     "where s.id_usuario = ?";
                     
        try (Connection conn = config.conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    artista art = new artista();
                    art.setID(rs.getInt("id"));
                    art.setnombre(rs.getString("nombre"));
                    art.setapellido(rs.getString("apellido"));
                    art.setgenero(rs.getString("genero"));
                    art.setfoto(rs.getString("foto"));
                    lista.add(art);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener seguidos: " + e.getMessage());
        }
        return lista;
    }
   
   public boolean actualizarArtista(artista art) {
        boolean ok = false;
        String sqlUsu = "Update Usuarios set nombre = ?, apellido = ? where id = ?";
        String sqlArt = "update Artistas set descripcion = ?, genero = ?, foto = ?, banner = ? where id_usuario = ?";

        try (Connection conn = config.conexion.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement psUsu = conn.prepareStatement(sqlUsu);
                 PreparedStatement psArt = conn.prepareStatement(sqlArt)) {

                psUsu.setString(1, art.getnombre());
                psUsu.setString(2, art.getapellido());
                psUsu.setInt(3, art.getID());
                int filasUsu = psUsu.executeUpdate();

                psArt.setString(1, art.getdescripcion());
                psArt.setString(2, art.getgenero());
                psArt.setString(3, art.getfoto());
                psArt.setString(4, art.getbanner());
                psArt.setInt(5, art.getID()); 
                int filasArt = psArt.executeUpdate();

                if (filasUsu > 0 && filasArt > 0) {
                    conn.commit();
                    ok = true;
                } else {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                conn.rollback();
                System.out.println("Excepción durante la actualización doble: " + ex.getMessage());
            }
        } catch (SQLException e) {
            System.out.println("Error de conexión al actualizar artista: " + e.getMessage());
        }
        return ok;
    }
}
