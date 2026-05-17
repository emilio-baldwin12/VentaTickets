
package modelo;
import java.util.Date;
/*****************************
 * @author luise :P(Es una carita)
 */
public class reventaboleto {
    private int id;
    private int id_boleto;
    private int id_vendedor;
    private double precio_nuevo;
    private Date fecha;
    private String motivo;
    private String estado;
    
    public reventaboleto(){
        
    }
    public reventaboleto(int id, int id_boleto, int id_vendedor, double precio_nuevo, Date fecha, String motivo, String estado) {
        this.id = id;
        this.id_boleto = id_boleto;
        this.id_vendedor = id_vendedor;
        this.precio_nuevo = precio_nuevo;
        this.fecha = fecha;
        this.motivo = motivo;
        this.estado = estado;
    }
    public int getid() {
        return id;
    }

    public void setid(int id) {
        this.id=id;
    }

    public int getidboleto() {
        return id_boleto;
    }

    public void setidboleto(int id_boleto) {
        this.id_boleto=id_boleto;
    }

    public int getidvendedor() {
        return id_vendedor;
    }

    public void setidvendedor(int id_vendedor) {
        this.id_vendedor=id_vendedor;
    }

    public double getprecionuevo() {
        return precio_nuevo;
    }

    public void setprecionuevo(double precio_nuevo) {
        this.precio_nuevo=precio_nuevo;
    }

    public Date getfecha() {
        return fecha;
    }

    public void setfecha(Date fecha) {
        this.fecha=fecha;
    }

    public String getmotivo() {
        return motivo;
    }

    public void setmotivo(String motivo) {
        this.motivo=motivo;
    }

    public String getestado() {
        return estado;
    }

    public void setestado(String estado) {
        this.estado=estado;
    }
}
