
package controlador;

import datos.usuarioDAO;
import modelo.usuario;
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
        
        usuarioDAO dao= new usuarioDAO();
        usuario user=dao.validar(correo,pass);


        if (user!=null) {
            HttpSession sesion = request.getSession();
            sesion.setAttribute("idusuario", user.getID());
            sesion.setAttribute("nombreusuario", user.getnombre());
            sesion.setAttribute("correo", user.getcorreo());
            sesion.setAttribute("pais", user.getpais());
            sesion.setAttribute("tipousuario",user.gettipousuario());
            
            try (Jedis jedis=conexionRedis.getConnection()){// Probando Redis
                jedis.set("ultima_conexion" + user.getID(),correo);
                jedis.expire("ultima_conexion" + user.getID(), 60);
                System.out.println("Dato guardado en redis" + user.getID());
            }catch (Exception e){
                System.out.println("Error al conectar con redis: " +e.getMessage());
            }
            response.sendRedirect("index.jsp");
    }else{
            response.sendRedirect("login.jsp?error=1");
        }
    }
}