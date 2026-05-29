/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author luise
 */
@WebServlet(name = "carritoServlet", urlPatterns = {"/carritoServlet"})
public class carritoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String asientos=request.getParameter("asientos");
        PrintWriter out=response.getWriter();
        
        try{
            HttpSession session=request.getSession();
            ArrayList<String>carrito=(ArrayList<String>)session.getAttribute("listaCarrito");
            if(carrito==null){
                carrito=new ArrayList<>();
            }
            if(asientos!=null && !asientos.trim().isEmpty()){
                String[] tokens=asientos.split(",");
                for(String id: tokens){
                    if(!carrito.contains(id)){
                        carrito.add(id);
                    }
                }
            }
            session.setAttribute("listarCarrito",carrito);
            out.print("{\"succes\": true, \"totalItems\": " + carrito.size() +"}");
        }catch(Exception e){
            out.print("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }

}
