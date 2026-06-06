/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import datos.solicitudDAO;
import java.io.IOException;
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

@WebServlet(name = "solicitudServlet", urlPatterns = {"/solicitudServlet"})
public class solicitudServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        
        if ("nueva_solicitud".equals(accion)) {
            HttpSession session = request.getSession();
            
            if (session.getAttribute("idusuario") != null) {
                int idArtista = (int) session.getAttribute("idusuario");
                String nombreEvento = request.getParameter("nombre_evento");
                String fechaPropuesta = request.getParameter("fecha_propuesta");
                String ciudadPropuesta = request.getParameter("ciudad_propuesta");
                String descripcion = request.getParameter("descripcion");
                
                solicitudDAO dao = new solicitudDAO();
                boolean exito = dao.registrarSolicitud(idArtista, nombreEvento, fechaPropuesta, ciudadPropuesta, descripcion);
                
                if (exito) {
                    response.sendRedirect("artista_productos.jsp");
                } else {
                    response.sendRedirect("solicitar_concierto.jsp?error=bd");
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        }
        if ("procesar".equals(accion)) {
            HttpSession session = request.getSession();
            if (session.getAttribute("tipousuario") != null && session.getAttribute("tipousuario").equals("ADMIN")) {
                
                int idSolicitud = Integer.parseInt(request.getParameter("id_solicitud"));
                String decision = request.getParameter("decision"); 
                
                solicitudDAO dao = new solicitudDAO();
                dao.actualizarEstadoSolicitud(idSolicitud, decision);
                
                if ("ACEPTADA".equals(decision)) {
                    response.sendRedirect("crearConcierto.jsp?id_solic=" + idSolicitud);
                } else {
                    response.sendRedirect("admin_solicitudes.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        }
    }
}