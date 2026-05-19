
package modelo;

/**
 *
 * @author luise
 */
public class boleto {
    private int id;
    private int id_concierto;
    private int id_asiento;
    private int id_usuario;
    private int id_orden;
    private String zona;
    private String codigo_qr;
    private double precio_original;
    private String estado;
    private String recinto;
    private String fecha;
    
    public boleto(){
        
    }
    
    public boleto(int id,int id_concierto, int id_asiento, int id_usuario, int id_orden, String zona, String codigo_qr, double precio_original, String estado){
        this.id=id;
        this.id_concierto=id_concierto  ;
        this.id_asiento=id_asiento;
        this.id_orden=id_orden;
        this.zona=zona;
        this.codigo_qr=codigo_qr;
        this.precio_original=precio_original;
        this.estado=estado;
    }
    public int getid(){
        return id;
    }
    public void setid(int id){
        this.id=id;
    }
    
    public int getidconcierto(){
        return id_concierto;
    }
    public void setidconcierto(int id_concierto){
        this.id_concierto=id_concierto;
    }
    public int getidasiento() {
        return id_asiento;
    }

    public void setidasiento(int id_asiento) {
        this.id_asiento = id_asiento;
    }

    public int getidusuario() {
        return id_usuario;
    }

    public void setidusuario(int id_usuario) {
        this.id_usuario=id_usuario;
    }

    public int getidorden() {
        return id_orden;
    }

    public void setidorden(int id_orden) {
        this.id_orden=id_orden;
    }

    public String getzona() {
        return zona;
    }

    public void setzona(String zona) {
        this.zona=zona;
    }

    public String getcodigoqr() {
        return codigo_qr;
    }

    public void setcodigoqr(String codigo_qr) {
        this.codigo_qr=codigo_qr;
    }

    public double getpreciooriginal() {
        return precio_original;
    }

    public void setpreciooriginal(double precio_original) {
        this.precio_original=precio_original;
    }

    public String getestado() {
        return estado;
    }

    public void setestado(String estado) {
        this.estado=estado;
    }

    public String getrecinto() {
        return recinto;
    }

    public void setrecinto(String recinto) {
        this.recinto=recinto;
    }

    public String getfecha() {
        return fecha;
    }

    public void setfecha(String fecha) {
        this.fecha=fecha;
    }
}
