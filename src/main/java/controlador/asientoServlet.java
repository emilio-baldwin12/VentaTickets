package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import config.conexion;

@WebServlet(name = "asientoServlet", urlPatterns = {"/asientoServlet"})
public class asientoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String idRecintoStr = request.getParameter("idRecinto");
        String nombrezona = request.getParameter("zona");
        
        PrintWriter out = response.getWriter();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            String idConciertoStr = request.getParameter("idConcierto");

            if(idRecintoStr == null || nombrezona == null){
                out.print("[]");
                return;
            }
            int idRecinto = Integer.parseInt(idRecintoStr);
            int idConcierto = (idConciertoStr != null && !idConciertoStr.isEmpty()) ? Integer.parseInt(idConciertoStr) : 1; 

            conn = conexion.getConnection();
            
            String sql = "select a.id, a.fila, a.numero, a.precio, COALESCE(b.estado, a.estado) as estado " +
                         "from Asientos a " +
                         "join Secciones s on a.id_seccion = s.id " +
                         "left join Boletos b on a.id = b.id_asiento and b.id_concierto = ? " +
                         "where s.id_recinto = ? and cast(s.nombre as varchar) = ? " +
                         "order by a.fila, a.numero";
            
            ps = conn.prepareStatement(sql);
            
            ps.setInt(1, idConcierto); 
            ps.setInt(2, idRecinto);  
            ps.setString(3, nombrezona); 
            
            rs = ps.executeQuery();
            
            StringBuilder json = new StringBuilder("[");
            boolean primero = true;
            while(rs.next()){
                if(!primero){
                    json.append(",");
                }
                json.append("{")
                        .append("\"id\":").append(rs.getInt("id")).append(",")
                        .append("\"fila\":\"").append(rs.getString("fila")).append("\",")
                        .append("\"numero\":").append(rs.getInt("numero")).append(",")
                        .append("\"precio\":").append(rs.getDouble("precio")).append(",")
                        .append("\"estado\":\"").append(rs.getString("estado")).append("\"")
                        .append("}");
                primero = false;
            }
            json.append("]");
            out.print(json.toString());
            
        } catch(Exception e) {
            String mensajeError = e.getMessage();
            if(mensajeError != null) {
                mensajeError = mensajeError.replace("\"", "'").replace("\n", " ");
            }
            out.print("[{\"error\": \"Error de Backend: " + mensajeError + "\"}]");
            
        } finally {
            try {
                if(rs != null) rs.close(); 
            } catch(Exception e) {
            }
            try { 
                if(ps != null) ps.close(); 
            } catch(Exception e) {
            }
            try {
                if(conn != null) conn.close(); 
            } catch(Exception e) {
            }
            out.flush();
            out.close();
        }
    }
}