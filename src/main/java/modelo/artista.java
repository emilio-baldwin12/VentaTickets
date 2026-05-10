
package modelo;

/**
 *
 * @author luise
 */
public class artista extends usuario{
    private String genero;
    private String descripcion;
    private String foto;
    private String banner;
    private int total_seguidores;
    
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
    
    public String getbanner(){
        return banner;
    }
    public void setbanner(String banner){
        this.banner=banner;
    }
    
    public int gettotal_seguidores(){
        return total_seguidores;
    }
    public void settotal_seguidores(int total_seguidores){
        this.total_seguidores=total_seguidores;
    }
}
