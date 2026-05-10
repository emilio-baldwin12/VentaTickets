package modelo;

/**
 *
 * @author luise
 */
public class cancion {
    private int id;
    private String titulo;
    private String url;
    private String foto;
    
    public cancion(){
        
    }
    
    public int getid(){
        return id;
    }
    public void setid(int id){
        this.id=id;
    }
    
    public String gettitulo(){
        return titulo;
    }
    public void settitulo(String titulo){
        this.titulo=titulo;
    }
    
    public String geturl(){
        return url;
    }
    public void seturl(String url){
        this.url=url;
    }
    
    public String getfoto(){
        return foto;
    }
    public void setfoto(String foto){
        this.foto=foto;
    }
}
