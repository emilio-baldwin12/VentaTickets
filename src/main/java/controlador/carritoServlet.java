/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import datos.productosDAO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.productoCarrito;
import java.util.List;

/**
 *
 * @author luise
 */
@WebServlet(name = "carritoServlet", urlPatterns = {"/carritoServlet"})
public class carritoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String asientosParam = request.getParameter("asientosComprados");
        String accion=request.getParameter("accion");
        
        if (asientosParam != null && !asientosParam.trim().isEmpty()) {
            ArrayList<String> carritoboletos = (ArrayList<String>) session.getAttribute("carritoBoletos");
            if (carritoboletos == null) {
                carritoboletos = new ArrayList<>();
            }
            String[] idsNuevos = asientosParam.split(",");
            for (String id : idsNuevos) {
                if (!carritoboletos.contains(id.trim())) {
                    carritoboletos.add(id.trim());
                }
            }
            session.setAttribute("carritoBoletos", carritoboletos);
        
            response.sendRedirect("carrito.jsp");
            return;
        }
        
        if("agregar".equals(accion) || "comprar_ahora".equals(accion)){
            List<productoCarrito> carritoproductos = (List<productoCarrito>) session.getAttribute("carritoProductos");
            if(carritoproductos == null){
                carritoproductos = new ArrayList<>();
            }
            
            int idproducto = Integer.parseInt(request.getParameter("idProducto"));
            String nombre = request.getParameter("nombre");
            double precio = Double.parseDouble(request.getParameter("precio"));
            String foto = request.getParameter("foto");
            
            boolean existe = false;
            for (productoCarrito articulo : carritoproductos){
               if(articulo.getidproducto() == idproducto){
                    articulo.setcantidad(articulo.getcantidad() + 1);
                    existe = true;
                    break;
               } 
            }
            
            if (!existe) {
                productoCarrito nuevoarticulo = new productoCarrito();
                nuevoarticulo.setidproducto(idproducto);
                nuevoarticulo.setnombre(nombre);
                nuevoarticulo.setprecio(precio);
                nuevoarticulo.setcantidad(1);
                nuevoarticulo.setfoto(foto);
                
                carritoproductos.add(nuevoarticulo);
            }
            
            session.setAttribute("carritoProductos", carritoproductos);
            
            if ("comprar_ahora".equals(accion)) {
                response.sendRedirect("pago_productos.jsp");
            } else {
                response.sendRedirect("carrito.jsp");
            }
        }
        if("eliminar".equals(accion)){
            List<productoCarrito>carritoproducto=(List<productoCarrito>)session.getAttribute("carritoProductos");
            if(carritoproducto!=null){
                int idproducto=Integer.parseInt(request.getParameter("idproducto"));
                carritoproducto.removeIf(articulo->articulo.getidproducto()==idproducto);
                session.setAttribute("carritoproducto", carritoproducto);
            }
            response.sendRedirect("carrito.jsp");
        }
        if("finalizarCompraProductos".equals(accion)){
            List<productoCarrito> carritoproductos = (List<productoCarrito>) session.getAttribute("carritoProductos");
            
            if(carritoproductos != null && !carritoproductos.isEmpty()){
                productosDAO dao = new productosDAO();
                boolean todoOk = true;
                
                for (productoCarrito articulo : carritoproductos){
                    boolean exito = dao.descontarStock(articulo.getidproducto(), articulo.getcantidad());
                    if(!exito){
                        todoOk = false; 
                    }
                }
                
               if(todoOk){
                    String totalStr = request.getParameter("total");
                    double totalPagar = Double.parseDouble(totalStr);
                    String nombreUser = (String) session.getAttribute("nombreusuario"); 
                    
                    boolean exitoVenta = dao.registrarVenta(nombreUser, totalPagar, carritoproductos);
                    
                    if (exitoVenta) {
                        session.setAttribute("ultimoTotal", totalStr);
                        session.removeAttribute("carritoProductos");//Vaciamos memoria
                        response.sendRedirect("confirmacion_productos.jsp");
                    } else {
                        System.out.println("El DAO devolvió false al intentar guardar el ticket.");
                        response.sendRedirect("pago_productos.jsp?error=bd");
                    }
                } else {
                    response.sendRedirect("pago_productos.jsp?error=stock");
                }
            } else {
                response.sendRedirect("productos.jsp");
            }
        }
    }
}