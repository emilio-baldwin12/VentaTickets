/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author luise
 */
public class detalleVenta {
    private int id;
    private int id_venta;
    private int id_asiento;
    private double precio_comprado;

    public detalleVenta() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_venta() {
        return id_venta;
    }

    public void setId_venta(int id_venta) {
        this.id_venta = id_venta;
    }

    public int getId_asiento() {
        return id_asiento;
    }

    public void setId_asiento(int id_asiento) {
        this.id_asiento = id_asiento;
    }

    public double getPrecio_comprado() {
        return precio_comprado;
    }

    public void setPrecio_comprado(double precio_comprado) {
        this.precio_comprado = precio_comprado;
    }
}
