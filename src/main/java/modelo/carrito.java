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
public class carrito {
    private int idasiento;
    private String zona;
    private String fila;
    private int numero;
    private double precio;
    private int idconcierto;
    private String nombreconcierto;
    private String ciudad;
    private Date fechaconcierto; 

    public carrito() {
    }

    public int getidasiento() {
        return idasiento;
    }

    public void setidasiento(int idAsiento) {
        this.idasiento = idAsiento;
    }

    public String getzona() {
        return zona;
    }

    public void setzona(String zona) {
        this.zona = zona;
    }

    public String getfila() {
        return fila;
    }

    public void setfila(String fila) {
        this.fila = fila;
    }

    public int getnumero() {
        return numero;
    }

    public void setnumero(int numero) {
        this.numero = numero;
    }

    public double getprecio() {
        return precio;
    }

    public void setprecio(double precio) {
        this.precio = precio;
    }

    public int getidconcierto() {
        return idconcierto;
    }

    public void setidconcierto(int idconcierto) {
        this.idconcierto = idconcierto;
    }

    public String getnombreconcierto() {
        return nombreconcierto;
    }

    public void setnombreconcierto(String nombreconcierto) {
        this.nombreconcierto = nombreconcierto;
    }

    public String getciudad() {
        return ciudad;
    }

    public void setciudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public Date getfechaconcierto() {
        return fechaconcierto;
    }

    public void setfechaconcierto(Date fechaconcierto) {
        this.fechaconcierto = fechaconcierto;
    }
}

