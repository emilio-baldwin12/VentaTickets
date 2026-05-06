
package modelo;

/**
 *
 * @author luise
 */
import java.sql.Timestamp;
public class solicitud {
    private int solicitud;
    private int idusuario;
    private String rol;
    private String estado;
    private String motivo;
    private Timestamp fecha;
    
    public solicitud(){
        
    }
    
    public int getsolicitud(){
        return solicitud;
    }
    
    public void setsolicitud(int solicitud){
        this.solicitud=solicitud;
    }
    
    public int getidusuario(){
        return idusuario;
    }
    
    public void setidusuario(int idusuario){
        this.idusuario=idusuario;
    }
    
    public String getrol(){
        return rol;
    }
    
    public void setrol(String rol){
        this.rol=rol;
    }
    
    public String getestado(){
        return estado;
    }
    
    public void setestado(String estado){
        this.estado=estado;
    }
    
    public String getmotivo(){
        return motivo;
    }
    
    public void setmotivo(String motivo){
        this.motivo=motivo;
    }
    
    public Timestamp getfecha(){
        return fecha;
    }
    
    public void setfecha(Timestamp fecha){
        this.fecha=fecha;
    }
}
