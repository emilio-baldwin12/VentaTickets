
package modelo;

/**
 *
 * @author luise
 */
public class usuario {
    private int id;
    private String nombre;
    private String apellido;
    private String correo;
    private String contrasenia;
    private String telefono;
    private String pais;
    
    public usuario(int id, String nombre, String apellido,String correo ,String contrasenia,String telefono,String pais){
        this.id=id;
        this.nombre=nombre;
        this.apellido=apellido;
        this.correo=correo;
        this.contrasenia=contrasenia;
        this.telefono=telefono;
        this.pais=pais;
    }
    public int getID(){
        return id;
    }
    public void setID(int id){
        this.id=id;
    }
    
    public String getnombre(){
        return nombre;
    }
    public void setnombre(String nombre){
        this.nombre=nombre;
    }
    
    public String getapellido(){
        return apellido;
    }
    public void setapellido(String apellido){
        this.apellido=apellido;
    }
    
    public String getcorreo(){
        return correo;
    }
    public void setcorreo(String correo){
        this.correo=correo;
    }
    
    public String getcontrasenia(){
        return contrasenia;
    }
    public void setcontrasenia(String contrasenia){
        this.contrasenia=contrasenia;
    }
    
    public String gettelefono(){
        return telefono;
    }
    public void settelefono(String telefono){
        this.telefono=telefono;
    }
    
    public String getpais(){
        return pais;
    }
    public void setpais(String pais){
        this.pais=pais;
    }
}
