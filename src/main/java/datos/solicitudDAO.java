
package datos;

import config.conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.solicitud;

public class solicitudDAO {
    public int crearsolicitud(int idUsuario, String rol, String motivo){
        String sql="insert into solicitudes(id_usuario, rol, motivo) values (?,?,?)" ;
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
        String sql= "select * from solicitudes where estado= 'PENDIENTE'";
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
        String sqlUpdateUser= "update Usuarios set tipo_usuario = 'ARTISTA' where id=?";
        String sqlInsertArtista="insert into Artista (id_usuario,generoMusical,descripcion) values (?,?,?)";
        String sqlUpdateSol="update solicitudes set estado= 'APROBADO' where id_usuario=? and estado='PENDIENTE'";

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


    public int contarPendientes() {
        String sql = "select count(*) from solicitudes where estado = 'PENDIENTE'";
        try (Connection conn = config.conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
        if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace(); 
        }
        return 0;
    }
    
    public boolean registrarSolicitud(int idArtista, String nombreEvento, String fecha, String ciudad, String descripcion) {
        String sql = "insert into Solicitudes_Conciertos (id_artista, nombre_evento, fecha_propuesta, ciudad_propuesta, descripcion) values (?, ?, ?::date, ?, ?)";
        
        try (Connection conn = conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idArtista);
            ps.setString(2, nombreEvento);
            ps.setString(3, fecha);
            ps.setString(4, ciudad);
            ps.setString(5, descripcion);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.out.println("Error al registrar solicitud: " + e.getMessage());
            return false;
        }
    }
    
    public java.util.List<modelo.solicitudConcierto> obtenerPendientes() {
        java.util.List<modelo.solicitudConcierto> lista = new java.util.ArrayList<>();
        String sql = "select s.*, u.nombre as nombre_artista from Solicitudes_Conciertos s " +
                     "join Usuarios u on s.id_artista = u.id " +
                     "where s.estado = 'PENDIENTE' order by s.fecha_creacion asc";
        
        try (Connection conn = conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                modelo.solicitudConcierto s = new modelo.solicitudConcierto();
                s.setid(rs.getInt("id"));
                s.setidartista(rs.getInt("id_artista"));
                s.setnombreartista(rs.getString("nombre_artista"));
                s.setnombreevento(rs.getString("nombre_evento"));
                s.setdescripcion(rs.getString("descripcion"));
                s.setfechapropuesta(rs.getString("fecha_propuesta"));
                s.setciudadpropuesta(rs.getString("ciudad_propuesta"));
                s.setestado(rs.getString("estado"));
                lista.add(s);
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener pendientes: " + e.getMessage());
        }
        return lista;
    }
    
    public modelo.solicitudConcierto obtenerSolicitudPorId(int id) {
        modelo.solicitudConcierto s = null;
        String sql = "select s.*, u.nombre as nombre_artista from Solicitudes_Conciertos s " +
                     "join Usuarios u on s.id_artista = u.id where s.id = ?";
        
        try (Connection conn = config.conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                s = new modelo.solicitudConcierto();
                s.setid(rs.getInt("id"));
                s.setidartista(rs.getInt("id_artista"));
                s.setnombreartista(rs.getString("nombre_artista"));
                s.setnombreevento(rs.getString("nombre_evento"));
                s.setdescripcion(rs.getString("descripcion"));
                s.setfechapropuesta(rs.getString("fecha_propuesta"));
                s.setciudadpropuesta(rs.getString("ciudad_propuesta"));
                s.setestado(rs.getString("estado"));
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener solicitud por ID: " + e.getMessage());
        }
        return s;
    }
    
    public boolean actualizarEstadoSolicitud(int idSolicitud, String nuevoEstado) {
        String sql = "update Solicitudes_Conciertos set estado = ? where id = ?";
        try (Connection conn = conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, nuevoEstado);
            ps.setInt(2, idSolicitud);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.out.println("Error al actualizar estado: " + e.getMessage());
            return false;
        }
    }
}