/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
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
        
        String asientosParam = request.getParameter("asientosComprados");
        
        HttpSession session = request.getSession();
        
        ArrayList<String> carrito = (ArrayList<String>) session.getAttribute("carritoBoletos");
        if (carrito == null) {
            carrito = new ArrayList<>();
        }
        
        if (asientosParam != null && !asientosParam.trim().isEmpty()) {
            String[] idsNuevos = asientosParam.split(",");
            for (String id : idsNuevos) {
                if (!carrito.contains(id.trim())) {
                    carrito.add(id.trim());
                }
            }
        }
        
        session.setAttribute("carritoBoletos", carrito);
        
        response.sendRedirect("carrito.jsp");
    }
}