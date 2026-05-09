
package modelo;

/**
 *
 * @author luise
 */
public class producto {
    private int id;
    private String nombre;
    private String descripcion;
    private double precio;
    private int cantidad;
    private String foto;
    
    public producto(){
        
    }
    
    public int getid(){
        return id;
    }
    public void setid(int id){
        this.id=id;
    }
    
    public String getnombre(){
        return nombre;
    }
    public void setnombre(String nombre){
        this.nombre=nombre;
    }
    
    public String getdescripcion(){
        return descripcion;
    }
    public void setdescripcion(String descripcion){
        this.descripcion=descripcion;
    }
    
    public double getprecio(){
        return precio;
    }
    public void setprecio(double precio){
        this.precio=precio;
    }
    
    public int getcantidad(){
        return cantidad;
    }
    public void setcantidad(int cantidad){
        this.cantidad=cantidad;
    }
    
    public String getfoto(){
        return foto;
    }
    public void setfoto(String foto){
        this.foto=foto;
    }
}
