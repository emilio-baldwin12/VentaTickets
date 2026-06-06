/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author luise
 */
public class solicitudConcierto {
    private int id;
    private int idartista;
    private String nombreartista; 
    private String nombreevento;
    private String descripcion;
    private String fechapropuesta;
    private String ciudadpropuesta;
    private String estado;

    public int getid() { 
        return id; 
    }
    public void setid(int id) {
        this.id = id; 
    }
    
    public int getidartista() {
        return idartista; 
    }
    public void setidartista(int idartista) { 
        this.idartista = idartista;
    }
    
    public String getnombreartista() { 
        return nombreartista; 
    }
    public void setnombreartista(String nombreartista) {
        this.nombreartista = nombreartista; 
    }
    
    public String getnombreevento() {
        return nombreevento; 
    }
    public void setnombreevento(String nombreevento) { 
        this.nombreevento = nombreevento;
    }
    
    public String getdescripcion() { 
        return descripcion;
    }
    public void setdescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public String getfechapropuesta() {
        return fechapropuesta;
    }
    public void setfechapropuesta(String fechapropuesta) {
        this.fechapropuesta = fechapropuesta;
    }
    
    public String getciudadpropuesta() { 
        return ciudadpropuesta; 
    }
    public void setciudadpropuesta(String ciudadpropuesta) { 
        this.ciudadpropuesta = ciudadpropuesta; 
    }
    
    public String getestado() { 
        return estado;
    }
    public void setestado(String estado) { 
        this.estado = estado; 
    }
}

