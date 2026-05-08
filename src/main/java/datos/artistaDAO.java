
package datos;
import config.conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.artista;

public class artistaDAO {
   public List<artista> obtenerArtistas(){
       List<artista> lista = new ArrayList<>();
       String sql = "SELECT u.nombre, u.apellido, a.genero,a.foto " +
                    "FROM Usuarios u " +
                    "INNER JOIN Artistas a ON u.id=a.id_usuario";
       
       try(Connection conn=conexion.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql);
            ResultSet rs=ps.executeQuery()){
           while(rs.next()){
               System.out.println("DEBUG: Encontré al artista: " + rs.getString("nombre"));
               artista art= new artista();
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
