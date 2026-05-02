
package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.usuario;

/**
 *
 * @author luise
 */
@WebServlet(name = "registroServlet", urlPatterns = {"/registroServlet"})
public class registroServlet extends HttpServlet {

   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nom = request.getParameter("nombre");
        String ape = request.getParameter("apellido");
        String mail = request.getParameter("correo");
        String pas = request.getParameter("pass");
        String tel = request.getParameter("telefono");
        String pai = request.getParameter("pais");

        usuario nuevoUsuario = new usuario(0, nom, ape, mail, pas, tel, pai);

        System.out.println("Se ha recibido a: " + nuevoUsuario.getnombre() + " " + nuevoUsuario.getapellido());

        response.sendRedirect("index.jsp?vista=login");
    }
}