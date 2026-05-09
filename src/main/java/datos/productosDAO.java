
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
    public List<producto> obtenerProductos(){
        List<producto>lista=new ArrayList<>();
        String sql= "SELECT * FROM Productos";
        
        try(Connection conn= conexion.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql);
            ResultSet rs=ps.executeQuery()){
            
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
        }catch(SQLException e){
            e.printStackTrace();
        }
        return lista;
    }
}
