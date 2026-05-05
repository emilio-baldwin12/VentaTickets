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


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession sesion=request.getSession();
        if(sesion.getAttribute("idUsuario")==null){
            response.sendRedirect("login.jsp?error=sesion");
            return;
        }
        
        int eventoId=Integer.parseInt(request.getParameter("idEvento"));
        int usuarioId=(int)sesion.getAttribute("idUsuario");
        
        filaDAO dao=new filaDAO();
        dao.entrarFila(eventoId,usuarioId);
        
        response.sendRedirect("espera.jsp?idEvento=" + eventoId);
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}