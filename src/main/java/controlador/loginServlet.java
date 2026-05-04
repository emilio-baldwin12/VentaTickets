
package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import redis.clients.jedis.Jedis;
import config.conexionRedis;

/**
 *
 * @author luise
 */
@WebServlet(name = "loginServlet", urlPatterns = {"/loginServlet"})
public class loginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String correo = request.getParameter("correo");
        String pass = request.getParameter("pass");

        System.out.println("Intento de login con: " + correo);

        if (correo != null && pass != null) {
            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuarioLogueado", correo);

            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
        
        
        try (Jedis jedis=conexionRedis.getConnection()){// Probando Redis
            jedis.set("ultima_conexion",correo);
            jedis.expire("ultima_conexion", 60);
            System.out.println("Dato guardado en redis");
        }catch (Exception e){
            System.out.println("Error al conectar con redis: " +e.getMessage());
        }
    }
}