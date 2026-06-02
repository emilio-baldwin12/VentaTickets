/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;
import datos.productosDAO;
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
@WebServlet(name = "artista_productoServlet", urlPatterns = {"/artista_productoServlet"})
public class artista_productoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession sesion=request.getSession();
        
        String tipousuario=(sesion.getAttribute("tipousuario")!=null)?(String) sesion.getAttribute("tipousuario"): "";
        int idartista=(sesion.getAttribute("idusuario")!=null)?(int)sesion.getAttribute("idusuario"):0;
        String accion=(request.getParameter("accion")!=null)?request.getParameter("accion"):"";
        String control=(!tipousuario.equals("ARTISTA")|| idartista==0)? "bloqueado":accion;
        productosDAO dao=new productosDAO();
        
        switch(control){
                case "agregar":
                    String nombre=request.getParameter("nombre");
                    String descripcion=request.getParameter("descripcion");
                    double precio=Double.parseDouble(request.getParameter("precio"));
                    int cantidad=Integer.parseInt(request.getParameter("cantidad"));
                    String foto=request.getParameter("foto");
                    boolean exitoAgregar=dao.agregaProductos(idartista, nombre, descripcion, precio, cantidad, foto);
                    response.sendRedirect(exitoAgregar ? "artista_productos.jsp?msg=agregado" : "artista_productos.jsp?error=bd");
                    break;
                    
                case "eliminar":
                    int idproducto=Integer.parseInt(request.getParameter("idProducto"));
                    boolean exitoEliminado=dao.eliminarProductos(idproducto, idartista);
                    response.sendRedirect(exitoEliminado ? "artista_productos.jsp?msg=eliminado" : "artista_productos,jsp?error=bd");
                    break;
                    
                case "bloqueado":
                    response.sendRedirect("index.jsp");
                    break;
                    
                default:
                    response.sendRedirect("artista_productos.jsp");
                    break;
            }
    }
}
