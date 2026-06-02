
package datos;

/**
 *
 * @author luise
 */
import config.conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.producto;

public class productosDAO {
    
    public List<producto> obtenerProductos(int idartista){
        List<producto>lista=new ArrayList<>();
        String sql= "select * from Productos where id_artista= ? order by id desc";
        
        try(Connection conn= conexion.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql)){
            ps.setInt(1, idartista);
            
            try(ResultSet rs=ps.executeQuery()){
                while(rs.next()){
                    producto p=new producto();
                    p.setid(rs.getInt("id"));
                    p.setnombre(rs.getString("nombre"));
                    p.setdescripcion(rs.getString("descripcion"));
                    p.setprecio(rs.getDouble("precio"));
                    p.setcantidad(rs.getInt("cantidad"));
                    p.setfoto(rs.getString("foto"));
                    lista.add(p);
                }
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return lista;
    }
    
    public boolean agregaProductos(int idartista,String nombre,String descripcion,double precio, int cantidad,String foto){
        String sql= "insert into Productos(id_artista,nombre,descripcion,precio,cantidad,foto) values(?,?,?,?,?,?)";
        try(Connection conn=conexion.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql)){
            ps.setInt(1,idartista);
            ps.setString(2, nombre);
            ps.setString(3, descripcion);
            ps.setDouble(4, precio);
            ps.setInt(5, cantidad);
            ps.setString(6, foto);
            return ps.executeUpdate()>0;
        }catch(Exception e){
            System.out.println("Error al agregar producto: " + e.getMessage());
            return false;
        }
    }
    
    public boolean eliminarProductos(int idproducto,int idartista){
        String sql="Delete from productos where id=? and id_artista=?";
        try(Connection conn= conexion.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql)){
            
            
            ps.setInt(1, idproducto);
            ps.setInt(2, idartista);
            return ps.executeUpdate()>0;
        }catch(Exception e){
            return false;
        }
    }
    
    public List<producto> obtenerTodosLosProductos() {
        List<producto> lista = new ArrayList<>();
        String sql = "select * from Productos order by id desc";
        
        try (Connection conn = conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                producto p = new producto();
                p.setid(rs.getInt("id"));
                p.setnombre(rs.getString("nombre"));
                p.setdescripcion(rs.getString("descripcion"));
                p.setprecio(rs.getDouble("precio"));
                p.setcantidad(rs.getInt("cantidad"));
                p.setfoto(rs.getString("foto"));
                lista.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
