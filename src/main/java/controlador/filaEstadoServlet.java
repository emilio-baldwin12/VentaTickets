/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;
import datos.filaDAO;
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
@WebServlet(name = "filaEstadoServlet", urlPatterns = {"/filaEstadoServlet"})
public class filaEstadoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        response.setContentType("application/json");//Le decimos al navegador que le vamos a responder con datos puros JSON
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        if (session.getAttribute("idusuario") == null) {
            response.getWriter().write("{\"error\": \"sesion_caducada\"}");
            return;
        }

        try {
            int idUsuario = (int) session.getAttribute("idusuario");
            int idConcierto = Integer.parseInt(request.getParameter("idConcierto"));

            filaDAO dao = new filaDAO();
            long posicion = dao.obtenerPosicion(idConcierto, idUsuario);
            boolean puedeComprar = dao.puedeComprar(idConcierto, idUsuario);

            
            String jsonRespuesta = "{\"posicion\": " + posicion + ", \"puedeComprar\": " + puedeComprar + "}";//Se arma la respuesta en formato JSON a mano para no usar librerias extra
            
            response.getWriter().write(jsonRespuesta);
            
        } catch (Exception e) {
            response.getWriter().write("{\"error\": \"datos_invalidos\"}");
        }
    }
}
