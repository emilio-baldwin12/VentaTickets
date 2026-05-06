
package modelo;

/**
 *
 * @author luise
 */
public class artista extends usuario{
    private String generoMusical;
    private String descripcion;
    
    public artista(){
        super();
    }
    public String getgeneroMusical(){
        return generoMusical;
    }
    
    public void setgeneroMusical(String generoMusical){
        this.generoMusical=generoMusical;
    }
    
    public String getdescripcion(){
        return descripcion;
    }
    
    public void setdescripcion(String descripcion){
        this.descripcion=descripcion;
    }
}
