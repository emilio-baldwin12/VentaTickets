
package modelo;


public class recinto {
    private int id;
    private String nombre;
    private String direccion;
    private String capacidad;
    private String fotos;
    private String ruta_mapa;
    
    public recinto(){
        
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
    
    public String getdireccion(){
        return direccion;
    }
    public void setdireccion(String direccion){
        this.direccion=direccion;
    }
    
    public String getcapacidad(){
        return capacidad;
    }
    public void setcapacidad(String capacidad){
        this.capacidad=capacidad;
    }
    
    public String getfotos(){
        return fotos;
    }
    public void setfotos(String fotos){
        this.fotos=fotos;
    }
    
    public String getrutamapa(){
        return ruta_mapa;
    }
    public void setrutamapa(String ruta_mapa){
        this.ruta_mapa=ruta_mapa;
    }
}
