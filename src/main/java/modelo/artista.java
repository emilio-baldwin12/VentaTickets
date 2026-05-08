
package modelo;

/**
 *
 * @author luise
 */
public class artista extends usuario{
    private String genero;
    private String descripcion;
    private String foto;
    
    public artista(){
        super();
    }
    public String getgenero(){
        return genero;
    }
    
    public void setgenero(String genero){
        this.genero=genero;
    }
    
    public String getdescripcion(){
        return descripcion;
    }
    
    public void setdescripcion(String descripcion){
        this.descripcion=descripcion;
    }
    
    public String getfoto(){
        return foto;
    }
    
    public void setfoto(String foto){
        this.foto=foto;
    }
}
