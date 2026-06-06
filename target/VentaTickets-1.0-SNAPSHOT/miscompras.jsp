<%-- 
    Document   : miscompras
    Created on : 3 jun 2026, 10:42:23 p.m.
    Author     : luise
--%>
<%@page import="datos.productosDAO"%>
<%@page import="datos.carritoDAO"%>
<%@page import="modelo.carrito"%>
<%@page import="modelo.productoCarrito"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("nombreusuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mis Compras | Tickets</title>
        <style>
            body { 
                font-family: 'Segoe UI', Tahoma, sans-serif; 
                background-color: var(--entity-body, #E8E2D1); 
                margin: 0; 
            }
            .container { 
                max-width: 900px; 
                margin: 40px auto; 
                background: white; 
                padding: 40px; 
                border-radius: 12px; 
                box-shadow: 0 4px 15px rgba(0,0,0,0.1); 
            }
            h1 {
                color: #1A1A1A; 
                margin-top: 0;
                border-bottom: 2px solid #eee; 
                padding-bottom: 10px; 
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px; 
            }
            th, td { 
                padding: 15px; 
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #f8f9fa; 
                color: #333; 
                text-transform: uppercase; 
                font-size: 13px; 
            }
            .total-row {
                font-size: 20px; 
                font-weight: bold; 
                text-align: right;
                margin-top: 20px; 
                color: #1A1A1A; 
            }
            .empty-cart { 
                text-align: center;
                padding: 40px; 
                color: #666;
                font-size: 16px;
                background: #f9f9f9;
                border-radius: 8px;
                margin-top: 15px;
            }
            .btn-home {
                background-color: #8EACB8; 
                color: white; 
                padding: 12px 25px; 
                border-radius: 8px; 
                font-size: 16px; 
                font-weight: bold; 
                text-decoration: none; 
                transition: 0.3s;
                display: inline-block;
            }
            .btn-home:hover {
                background-color: #728d99;
            }
        </style>
    </head>
    <body>
        <jsp:include page="img/auxiliares/encabezado.jsp" />

        <div class="container">
            <% if ("reventa_publicada".equals(request.getParameter("exito"))) { %>
                <div class="alert-success">
                    ¡Tu boleto se ha publicado en el mercado de Reventas con éxito!
                </div>
            <% } %>
            
            <h1>Mis Boletos de Conciertos</h1>
            <%
                int idUsuarioActual = (session.getAttribute("idusuario") != null) ? (int) session.getAttribute("idusuario") : 0;
                carritoDAO daoBoletos = new carritoDAO();
                List<carrito> boletos = daoBoletos.obtenerMisBoletos(idUsuarioActual);
                
                if (boletos.isEmpty()) {
            %>
                <div class="empty-cart">
                    <p>No tienes boletos registrados en tu historial</p>
                </div>
            <%
                } else {
                    double totalBoletos = 0;
            %>
                <table>
                    <thead>
                        <tr>
                            <th>Evento</th>
                            <th>Ciudad</th>
                            <th>Zona</th>
                            <th>Fila / Asiento</th>
                            <th>Precio</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (carrito b : boletos) { 
                            totalBoletos += b.getprecio();
                        %>
                        <tr>
                            <td>
                                <strong><%= b.getnombreconcierto() %></strong><br>
                                <small style="color: #666;"><%= b.getfechaconcierto() %></small>
                            </td>
                            <td><%= b.getciudad() %></td>
                            <td><%= b.getzona() %></td>
                            <td>Fila <%= b.getfila() %> - #<%= b.getnumero() %></td>
                            <td>$<%= String.format("%,.2f", b.getprecio()) %></td>
                            <td>
                                <form action="boleto_individual.jsp" method="POST" style="margin: 0;">
                                    <input type="hidden" name="id_boleto" value="<%= b.getid() %>">
                                    
                                    <input type="hidden" name="evento" value="<%= b.getnombreconcierto() %>">
                                    <input type="hidden" name="fecha" value="<%= b.getfechaconcierto() %>">
                                    <input type="hidden" name="ciudad" value="<%= b.getciudad() %>">
                                    <input type="hidden" name="zona" value="<%= b.getzona() %>">
                                    <input type="hidden" name="fila" value="<%= b.getfila() %>">
                                    <input type="hidden" name="asiento" value="<%= b.getnumero() %>">
                                    <input type="hidden" name="precio" value="<%= b.getprecio() %>">
                                    <button type="submit" style="background-color: #3483fa; color: white; padding: 8px 15px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer;">
                                        Ver Boleto
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="total-row">Total Invertido en Boletos: $<%= String.format("%,.2f", totalBoletos) %></div>
            <% } %>

            
            <h1 style="margin-top: 60px;">Mi Mercancía Pagada</h1>
            <%
                String usuarioActual = (String) session.getAttribute("nombreusuario");
                productosDAO pDao = new productosDAO();
                List<productoCarrito> historialMercancia = pDao.obtenerHistorialCompras(usuarioActual);
                
                if (historialMercancia.isEmpty()) {
            %>
                <div class="empty-cart">
                    <p>No has realizado compras en la tienda física</p>
                </div>
            <%
                } else {
                    double totalHistorial = 0;
            %>
                <table>
                    <thead>
                        <tr>
                            <th>Foto</th>
                            <th>Producto</th>
                            <th>Cantidad</th>
                            <th>Precio Pagado</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (productoCarrito hp : historialMercancia) { 
                            double subtotalHp = hp.getprecio() * hp.getcantidad();
                            totalHistorial += subtotalHp;
                        %>
                        <tr>
                            <td><img src="img/productos/<%= hp.getfoto() != null ? hp.getfoto() : "default_productos.jpg" %>" style="width: 50px; border-radius: 4px;"></td>
                            <td>
                                <strong><%= hp.getnombre() %></strong><br>
                                <span style="color: #28a745; font-size: 12px; font-weight: bold;">PAGADO</span>
                            </td>
                            <td><%= hp.getcantidad() %></td>
                            <td>$<%= String.format("%,.2f", hp.getprecio()) %></td>
                            <td>$<%= String.format("%,.2f", subtotalHp) %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="total-row">Total Invertido en Mercancia: $<%= String.format("%,.2f", totalHistorial) %></div>
            <% } %>

            <div style="margin-top: 40px; border-top: 1px solid #eee; padding-top: 20px; text-align: right;">
                <a href="index.jsp" class="btn-home">Volver al Inicio</a>
            </div>
            
        </div>
    </body>
</html>