package controlador;

import datos.artistaDAO;
import modelo.artista;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/artistaServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, 
    maxFileSize = 1024 * 1024 * 10, 
    maxRequestSize = 1024 * 1024 * 50
)     
public class artistaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena"); 
        String genero = request.getParameter("genero");
        String descripcion = request.getParameter("descripcion"); 
        
        Part filePart = request.getPart("fileFoto");
        String nombreFoto = "default_artist.jpg";
        
        if (filePart != null && filePart.getSize() > 0) {
            nombreFoto = filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("/img/artistas");
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            
            filePart.write(uploadPath + File.separator + nombreFoto);
        }

        artista nuevoArt = new artista();
        nuevoArt.setnombre(nombre);
        nuevoArt.setapellido(apellido);
        nuevoArt.setcorreo(correo);
        nuevoArt.setcontrasena(contrasena); 
        nuevoArt.setgenero(genero);
        nuevoArt.setdescripcion(descripcion); 
        nuevoArt.setfoto(nombreFoto);

        artistaDAO dao = new artistaDAO();
        if (dao.registrarArtista(nuevoArt)) {
            response.sendRedirect("artistas.jsp?success=1");
        } else {
            response.sendRedirect("registroArtista.jsp?error=1");
        }
    }
}