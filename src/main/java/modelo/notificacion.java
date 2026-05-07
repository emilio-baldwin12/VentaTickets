/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author luise
 */
import java.sql.Timestamp;
public class notificacion {
    private int idnotificacion;
    private int idusuario;
    private String titulo;
    private String mensaje;
    private String tipo;
    private boolean leido;
    private Timestamp fecha;
    
    public notificacion(){
        
    }
    
    public int getidnotificacion(){
        return idnotificacion;
    }
    
    public void setidnotificacion(int idnotificacion){
        this.idnotificacion=idnotificacion;
    }
    
    public int getidusuario(){
        return idusuario;
    }
    
    public void setidusuario(int idusuario){
        this.idusuario=idusuario;
    }
    
    public String gettitulo(){
        return titulo;
    }
    
    public void settitulo(String titulo){
        this.titulo=titulo;
    }
    
    public String getmensaje(){
        return mensaje;
    }
    
    public void setmensaje(String mensaje){
        this.mensaje=mensaje;
    }
    
    public String gettipo(){
        return tipo;
    }
    
    public void settipo(String tipo){
        this.tipo=tipo;
    }
    
    public boolean getleido(){
        return leido;
    }
    
    public void setleido(boolean leido){
        this.leido=leido;
    }
    
    
    public Timestamp getfecha(){
        return fecha;
    }
    
    public void setfecha(Timestamp fecha){
        this.fecha=fecha;
    }
}


