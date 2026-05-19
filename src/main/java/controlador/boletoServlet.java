
package controlador;
import datos.boletoDAO;
import modelo.boleto;
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
        HttpSession sesion=request.getSession();
        int idUsuario=0;
        
        if(sesion.getAttribute("idusuario")!=null){
            idUsuario=(int)sesion.getAttribute("idusuario");
        }
        if(idUsuario==0){
            System.out.println("DEBUG: No se encontro al usuario en sesion");
            response.sendRedirect("login.jsp?error=sesion");
            return;//si nadie ingresa, se le manda directo para que ingrese o se registre
        }
        try{
            int idConcierto=Integer.parseInt(request.getParameter("idConcierto"));
            double precio= Double.parseDouble(request.getParameter("precio"));
            String asientosCad=request.getParameter("asientosSeleccionados");
            String[] asientosArr=asientosCad.split(",");
            int[]idAsientos=new int[asientosArr.length];
            for(int i=0;i<asientosArr.length;i++){
                idAsientos[i]=Integer.parseInt(asientosArr[i].trim());
            }
            boletoDAO dao=new boletoDAO();
            boolean exito=dao.procesar_Compra(idUsuario, idConcierto, idAsientos, precio);
            if(exito){
                int idOrden=dao.obtenerUltimaOrden(idUsuario);
                response.sendRedirect("confirmacion.jsp?id_orden="+idOrden);
            }else{
                response.sendRedirect("concierto_asientos.jsp?id=" + idConcierto + "&error=ocupado");
            }
        }catch(Exception e){
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

}
