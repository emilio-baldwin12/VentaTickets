/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import java.sql.Date;
/**
 *
 * @author luise
 */
public class concierto {
    private int id;
    private int id_recinto;
    private String nombre;
    private String descripcion;
    private String ciudad;
    private Date fecha;
    private String fotos;
    private String track_list;
    
    public concierto(){
        
    }
    
    public int getid(){
        return id;
    }
    public void setid(int id){
        this.id=id;
    }
    
    public int getid_recinto(){
        return id_recinto;
    }
    public void setid_recinto(int id_recinto){
        this.id_recinto=id_recinto;
    } 
    
    public String getnombre(){
        return nombre;
    }
    public void setnombre(String nombre){
        this.nombre=nombre;
    } 
    
    public String getdescripcion(){
        return descripcion;
    }
    public void setdescripcion(String descripcion){
        this.descripcion=descripcion;
    } 
    
    public String getciudad(){
        return ciudad;
    }
    public void setciudad(String ciudad){
        this.ciudad=ciudad;
    } 
    
    public Date getfecha(){
        return fecha;
    }
    public void setfecha(Date fecha){
        this.fecha=fecha;
    } 
    
    public String getfotos(){
        return fotos;
    }
    public void setfotos(String fotos){
        this.fotos=fotos;
    } 
    
    public String gettrack_list(){
        return track_list;
    }
    public void settrack_list(String track_list){
        this.track_list=track_list;
    } 
}

    
