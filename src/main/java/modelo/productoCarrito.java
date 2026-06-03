/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author luise
 */
public class productoCarrito {
    private int idproducto;
    private String nombre;
    private double precio;
    private int cantidad;
    private String foto;
    
    public productoCarrito(){
        
    }
    
    public int getidproducto(){
        return idproducto;
    }
    public void setidproducto(int idproducto){
        this.idproducto=idproducto;
    }
    
    public String getnombre(){
        return nombre;
    }
    public void setnombre(String nombre){
        this.nombre=nombre;
    }
    
    public double getprecio(){
        return precio;
    }
    public void setprecio(double precio){
        this.precio=precio;
    }
    
    public int getcantidad(){
        return cantidad;
    }
    public void setcantidad(int cantidad){
        this.cantidad=cantidad;
    }
    
    public String getfoto(){
        return foto;
    }
    public void setfoto(String foto){
        this.foto=foto;
    }
    
    public double getsubtotal(){
        return this.precio*this.cantidad;
    }
    
}
