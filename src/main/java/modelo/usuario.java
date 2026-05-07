
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
    private String contrasena;
    private String telefono;
    private String pais;
    private String tipousuario;
    
    public usuario(){
    }
    
    public usuario(int id, String nombre, String apellido,String correo ,String contrasena,String telefono,String pais,String tipousuario){
        this.id=id;
        this.nombre=nombre;
        this.apellido=apellido;
        this.correo=correo;
        this.contrasena=contrasena;
        this.telefono=telefono;
        this.pais=pais;
        this.tipousuario=tipousuario;
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
    
    public String getcontrasena(){
        return contrasena;
    }
    public void setcontrasena(String contrasena){
        this.contrasena=contrasena;
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
    
     public String gettipousuario(){
        return tipousuario;
    }
    public void settipousuario(String tipousuario){
        this.tipousuario=tipousuario;
    }
}
