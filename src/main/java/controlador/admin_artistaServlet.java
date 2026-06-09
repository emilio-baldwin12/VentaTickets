/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;
import datos.artistaDAO;
import modelo.artista;
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
@WebServlet(name = "admin_artistaServlet", urlPatterns = {"/admin_artistaServlet"})
public class admin_artistaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession sesion=request.getSession();
        
        String tipousuario=(sesion.getAttribute("tipousuario")!=null)?(String) sesion.getAttribute("tipousuario"): "";
        String accion=(request.getParameter("accion")!=null)?request.getParameter("accion"): "";
        String control=(!tipousuario.equals("ADMIN"))?"bloqueado" : accion;//para Solo admins
        
        artistaDAO dao= new artistaDAO();
        switch(control){
            case "agregar":
                artista a=new artista();
                a.setnombre(request.getParameter("nombre"));
                a.setapellido(request.getParameter("apellido"));
                a.setcorreo(request.getParameter("correo"));
                a.setcontrasena(request.getParameter("contrasena"));
                a.setdescripcion(request.getParameter("descripcion"));
                a.setgenero(request.getParameter("genero"));
                a.setfoto(request.getParameter("foto")); 
                a.setbanner(request.getParameter("banner"));
                
                boolean exitoAgregar=dao.registrarArtista(a);
                response.sendRedirect(exitoAgregar ? "admin_artistas.jsp?msg=agregado" : "admin_artistas.jsp?error=bd");
                break;
            
            case "eliminar":
                int idEliminar=(request.getParameter("idusuario")!=null)? Integer.parseInt(request.getParameter("idusuario")) : 0;
                boolean exitoEliminar=dao.eliminarArtista(idEliminar);
                response.sendRedirect(exitoEliminar ? "admin_artistas.jsp?msg=eliminado" : "admin_artistas.jsp?error=bd");
                break;
                
            case "actualizar":
                artista art = new artista();
                art.setID(Integer.parseInt(request.getParameter("idUsuario")));
                art.setnombre(request.getParameter("nombre"));
                art.setapellido(request.getParameter("apellido"));
                art.setgenero(request.getParameter("genero"));
                art.setfoto(request.getParameter("foto"));
                art.setbanner(request.getParameter("banner"));
                art.setdescripcion(request.getParameter("descripcion"));
                
                boolean exitoActualizar = dao.actualizarArtista(art);
                response.sendRedirect(exitoActualizar ? "admin_artistas.jsp?msg=actualizado" : "admin_artistas.jsp?error=bd");
                break;
                
            case "bloqueado":
                response.sendRedirect("index.jsp");
                break;
            default:
                response.sendRedirect("admin_artistas.jsp");
                break;
        }
    }
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */

}
