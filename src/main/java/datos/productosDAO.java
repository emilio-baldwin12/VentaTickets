
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
import modelo.productoCarrito;

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
    
    public producto obtenerProductoIndividual(int id){
        producto p=null;
        String sql="Select * from Productos where id=?";
        
        try(Connection conn=conexion.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql)){
            ps.setInt(1, id);
            try(ResultSet rs=ps.executeQuery()){
                if(rs.next()){
                    p=new producto();
                    p.setid(rs.getInt("id"));
                    p.setnombre(rs.getString("nombre"));
                    p.setdescripcion(rs.getString("descripcion"));
                    p.setprecio(rs.getDouble("precio"));
                    p.setcantidad(rs.getInt("cantidad"));
                    p.setfoto(rs.getString("foto"));
                }
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return p;
    }
    
    public boolean descontarStock(int id, int cantidad) {
        String sql = "update Productos set cantidad = cantidad - ? where id = ? and cantidad >= ?";
        
        try (Connection conn = conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, cantidad);
            ps.setInt(2, id);
            ps.setInt(3, cantidad);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean registrarVenta(String nombreUsuario, double total, List<productoCarrito> carrito) {
        String sqlVenta = "insert into Ventas (nombre_usuario, total) values (?, ?)";
        String sqlDetalle = "insert into Detalle_Ventas (id_venta, id_producto, cantidad, precio_comprado) values (?, ?, ?, ?)";
        
        try (Connection conn = conexion.getConnection()) {
            conn.setAutoCommit(false); 
            
            int idVenta = 0;
            try (PreparedStatement psVenta = conn.prepareStatement(sqlVenta, Statement.RETURN_GENERATED_KEYS)) {
                psVenta.setString(1, nombreUsuario != null ? nombreUsuario : "Usuario Anonimo");
                psVenta.setDouble(2, total);
                
                psVenta.executeUpdate(); 
                
                try (ResultSet rs = psVenta.getGeneratedKeys()) {
                    if (rs.next()) {
                        idVenta = rs.getInt(1); 
                    }
                }
            }
            
            if (idVenta > 0) {
                try (PreparedStatement psDetalle = conn.prepareStatement(sqlDetalle)) {
                    for (productoCarrito item : carrito) {
                        psDetalle.setInt(1, idVenta);
                        psDetalle.setInt(2, item.getidproducto());
                        psDetalle.setInt(3, item.getcantidad());
                        psDetalle.setDouble(4, item.getprecio());
                        psDetalle.addBatch();
                    }
                    psDetalle.executeBatch();
                }
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
        } catch (SQLException e) {
            System.out.println("==== ERROR AL REGISTRAR VENTA EN BD ====");
            e.printStackTrace();
            return false;
        }
    }

    public List<productoCarrito> obtenerHistorialCompras(String nombreUsuario) {
        List<productoCarrito> historial = new ArrayList<>();
        String sql = "select p.id, p.nombre, p.foto, dv.cantidad, dv.precio_comprado " +
                     "from Detalle_Ventas dv " +
                     "join Ventas v ON dv.id_venta = v.id " +
                     "join Productos p ON dv.id_producto = p.id " +
                     "where v.nombre_usuario = ?";
                     
        try (Connection conn = conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, nombreUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    productoCarrito prod = new productoCarrito();
                    prod.setidproducto(rs.getInt("id"));
                    prod.setnombre(rs.getString("nombre"));
                    prod.setfoto(rs.getString("foto"));
                    prod.setcantidad(rs.getInt("cantidad"));
                    prod.setprecio(rs.getDouble("precio_comprado"));
                    historial.add(prod);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return historial;
    }
    
    public boolean actualizarProducto(producto p) {
        String sql = "update Productos set nombre = ?, descripcion = ?, precio = ?, cantidad = ?, foto = ? where id = ?";
        
        try (Connection conn = config.conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, p.getnombre());
            ps.setString(2, p.getdescripcion());
            ps.setDouble(3, p.getprecio()); 
            ps.setInt(4, p.getcantidad());
            ps.setString(5, p.getfoto());
            ps.setInt(6, p.getid());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.out.println("Error al actualizar producto: " + e.getMessage());
            return false;
        }
    }
}
