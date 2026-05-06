
package datos;

import config.conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.solicitud;

public class solicitudDAO {
    public int crearsolicitud(int idUsuario, String rol, String motivo){
        String sql="INSERT INTO solicitudes(id_usuario, rol, motivo) VALUES (?,?,?)" ;
        try (Connection conn=conexion.getConnection();
             PreparedStatement ps=conn.prepareStatement(sql)){
            ps.setInt(1,idUsuario);
            ps.setString(2,rol);
            ps.setString(3, motivo);
            return ps.executeUpdate();
        
    }catch(SQLException e){
        e.printStackTrace();
        return 0;
    }
}
    
public List <solicitud> listarPendientes(){
    List<solicitud> lista=new ArrayList<>();
    String sql= "SELECT * FROM solicitudes WHERE estado= 'PENDIENTE'";
    try(Connection conn= conexion.getConnection();
        PreparedStatement ps=conn.prepareStatement(sql);
        ResultSet rs= ps.executeQuery()){
        while (rs.next()){
            solicitud s=new solicitud();
            s.setsolicitud(rs.getInt("id_solicitud"));
            s.setidusuario(rs.getInt("id_usuario"));
            s.setrol(rs.getString("rol"));
            s.setmotivo(rs.getString("motivo"));
            lista.add(s);
        }
    }catch( SQLException e){
        e.printStackTrace();
        }
        return lista;
    }

public boolean aprobarArtista(int idusuario,String genero, String descripcion){
    String sqlUpdateUser= "UPDATE Usuarios SET tipo_usuario = 'ARTISTA' WHERE id=?";
    String sqlInsertArtista="INSERT INTO Artista (id_usuario,generoMusical,descripcion) VALUES (?,?,?)";
    String sqlUpdateSol="UPDATE solicitudes SET estado= 'APROBADO' WHERE id_usuario=? AND estado='PENDIENTE'";
    
    try(Connection conn= conexion.getConnection()){
        conn.setAutoCommit(false);
        
        try(PreparedStatement ps1=conn.prepareStatement(sqlUpdateUser);
            PreparedStatement ps2= conn.prepareStatement(sqlInsertArtista);
            PreparedStatement ps3= conn.prepareStatement(sqlUpdateSol)){
            
            ps1.setInt(1,idusuario);
            ps1.executeUpdate();
            
            ps2.setInt(1, idusuario);
            ps2.setString(2, genero);
            ps2.setString(3, descripcion);
            ps2.executeUpdate();
            
            ps3.setInt(1, idusuario);
            ps3.executeUpdate();
            
            conn.commit();
            return true;
        }catch(SQLException e){
            conn.rollback();
            e.printStackTrace();
            return false;
        }
    }catch(SQLException e){
        e.printStackTrace();
        return false;
    }
    }
}