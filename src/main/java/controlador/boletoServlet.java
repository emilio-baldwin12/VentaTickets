
package controlador;
import datos.boletoDAO;
import java.io.IOException;
import java.util.ArrayList;
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
@WebServlet(name = "boletoServlet", urlPatterns = {"/boletoServlet"})
public class boletoServlet extends HttpServlet {
/**    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession sesion = request.getSession();
        int idUsuario = (sesion.getAttribute("idusuario") != null) ? (int) sesion.getAttribute("idusuario") : 0;
        String accion = (request.getParameter("accion") != null) ? request.getParameter("accion") : "";
        String controlFlujo = (idUsuario == 0) ? "redireccionar" : accion;
        
        switch(controlFlujo) {
            case "finalizarCompra":
                try {
                    int idConcierto = Integer.parseInt(request.getParameter("idConcierto"));
                    String asientosCad = request.getParameter("asientos");
                    String[] asientosArr = asientosCad.split(",");
                    int[] idAsientos = new int[asientosArr.length];
                    
                    for (int i = 0; i < asientosArr.length; i++) {
                        idAsientos[i] = Integer.parseInt(asientosArr[i].trim());
                    }
                    
                    String totalStr = (request.getParameter("total") != null) ? request.getParameter("total") : "0";
                    double total = Double.parseDouble(totalStr);
                    double precioUnitario = total / asientosArr.length;
                    
                    boletoDAO dao = new boletoDAO();
                    boolean exito = dao.procesar_Compra(idUsuario, idConcierto, idAsientos, precioUnitario);
                    
                    ArrayList<String> misBoletos = (ArrayList<String>) sesion.getAttribute("carritoBoletos");
                    misBoletos = (misBoletos == null) ? new ArrayList<>() : misBoletos;
                    
                    for (String id : asientosArr) {
                        misBoletos.remove(id.trim());
                        misBoletos.add(id.trim());
                    }
                    sesion.setAttribute("carritoBoletos", misBoletos);
                    
                    int idOrden = dao.obtenerUltimaOrden(idUsuario);
                    response.sendRedirect(exito ? "confirmacion.jsp?id_orden=" + idOrden : "concierto_asientos.jsp?id=" + idConcierto + "&error=ocupado");
                } catch(Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("error.jsp");
                }
                break;
            default:
                response.sendRedirect("login.jsp?error=sesion");
                break;
        }
    }
}