/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import datos.reventaDAO;
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
@WebServlet(name = "reventaServlet", urlPatterns = {"/reventaServlet"})
public class reventaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        HttpSession session = request.getSession();
        if ("publicar".equals(accion)) {
            if (session.getAttribute("idusuario") != null) {
                int idVendedor = (int) session.getAttribute("idusuario");
                int idBoleto = Integer.parseInt(request.getParameter("id_boleto"));
                double precioNuevo = Double.parseDouble(request.getParameter("precio_nuevo"));
                String motivo = request.getParameter("motivo");
                
                reventaDAO dao = new reventaDAO();
                boolean exito = dao.publicarReventa(idBoleto, idVendedor, precioNuevo, motivo);
                
                if (exito) {
                    response.sendRedirect("miscompras.jsp?exito=reventa_publicada");
                } else {
                    response.sendRedirect("reventa_formulario.jsp?id_bol=" + idBoleto + "&error=bd");
                }
                
            } else {
                response.sendRedirect("login.jsp");
            }
            
        }else if ("comprar_boleto".equals(accion)) {
            
            if (session.getAttribute("idusuario") != null) {
                String idReventa = request.getParameter("id_reventa");
                response.sendRedirect("pago.jsp?origen=reventa&id_reventa=" + idReventa);

            } else {
                response.sendRedirect("login.jsp");
            }
        }
        else if ("finalizar_compra_reventa".equals(accion)) {
            
            if (session.getAttribute("idusuario") != null) {
                int idComprador = (int) session.getAttribute("idusuario");
                int idReventa = Integer.parseInt(request.getParameter("id_reventa"));

                reventaDAO dao = new reventaDAO();
                boolean exito = dao.concretarCompraReventa(idReventa, idComprador);

                if (exito) {
                    response.sendRedirect("miscompras.jsp?exito=compra_exitosa");
                } else {
                    response.sendRedirect("reventas.jsp?error=transaccion_fallida");
                }

            } else {
                response.sendRedirect("login.jsp");
            }
        }
    }
}