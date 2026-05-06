/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author luise
 */
public class administrador extends usuario{
    private String nivelAcceso;
    
    public administrador() {
        super();
    }
        public String getNivelAcceso(){
            return nivelAcceso;
        }
        public void setNivelAcceso(String NivelAcceso){
            this.nivelAcceso=nivelAcceso;
        }
}
