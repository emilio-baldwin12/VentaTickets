
package modelo;

/**
 *
 * @author luise
 */
public class cliente extends usuario {
    private String generoFavorito;
    public cliente(){
        super();
    }
    public String getGeneroFavorito(){
        return generoFavorito;
    }
    
    public void setGeneroFavorito(String generoFavorito){
        this.generoFavorito=generoFavorito;
    }
}
