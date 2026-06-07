/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import datos.filaDAO;
/**
 *
 * @author luise
 */
@WebServlet(name = "filaServlet", urlPatterns = {"/filaServlet"})
public class filaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session.getAttribute("idusuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int idUsuario = (int) session.getAttribute("idusuario");
        int idConcierto = Integer.parseInt(request.getParameter("idConcierto"));
        
        filaDAO dao = new filaDAO();
        
        dao.unirseFila(idConcierto, idUsuario);//El usuario toca el botón de comprar y se une a la fila de Redis
        
        if (dao.puedeComprar(idConcierto, idUsuario)) {
            response.sendRedirect("concierto_asientos.jsp?id=" + idConcierto);
        } else {
            response.sendRedirect("salaEspera.jsp?idConcierto=" + idConcierto);
        }
    }
}