/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;
import datos.artistaDAO;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "seguidorServlet", urlPatterns = {"/seguidorServlet"})
public class seguidorServlet extends HttpServlet {
   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        if(session.getAttribute("idusuario") == null) {
            out.print("{\"status\":\"error\", \"mensaje\":\"no_logueado\"}");
            return;
        }

        int idUsuario = (Integer) session.getAttribute("idusuario");
        int idArtista = Integer.parseInt(request.getParameter("idArtista"));
        String accion = request.getParameter("accion"); // "seguir" o "dejar"
        artistaDAO dao = new artistaDAO();
        boolean exito = false;
        
        if ("seguir".equals(accion)) {
            exito = dao.seguirArtista(idUsuario, idArtista);
        } else if ("dejar".equals(accion)) {
            exito = dao.dejarDeSeguir(idUsuario, idArtista);
        }
        if(exito) {
            out.print("{\"status\":\"ok\"}");
        } else {
            out.print("{\"status\":\"error\", \"mensaje\":\"fallo_bd\"}");
        }
    }
}