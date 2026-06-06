/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import datos.conciertoDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *
 * @author luise
 */
@WebServlet(name = "conciertosServlet", urlPatterns = {"/conciertosServlet"})
public class conciertoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        
        if ("crear_concierto".equals(accion)) {
            String nombre = request.getParameter("nombre");
            String fotos = request.getParameter("fotos"); 
            String descripcion = request.getParameter("descripcion");
            int idArtista = Integer.parseInt(request.getParameter("id_artista"));
            
            String[] fechas = request.getParameterValues("fecha");
            String[] ciudades = request.getParameterValues("ciudad");
            String[] recintos = request.getParameterValues("id_recinto");
            
            conciertoDAO dao = new conciertoDAO();
            boolean exitoTotal = true;
            
            if (fechas != null) {
                for (int i = 0; i < fechas.length; i++) {
                    int idRecinto = Integer.parseInt(recintos[i]);
                    boolean exitoIndividual = dao.registrarConcierto(nombre, idArtista, fechas[i], ciudades[i], idRecinto, fotos, descripcion);
                    
                    if (!exitoIndividual) {
                        exitoTotal = false;
                    }
                }
            }
            if (exitoTotal) {
                response.sendRedirect("conciertos.jsp");
            } else {
                response.sendRedirect("crearConcierto.jsp?error=bd");
            }
        }
    }
}