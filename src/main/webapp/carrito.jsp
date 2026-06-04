<%-- 
    Document   : carrito.jsp
    Created on : 29 may 2026, 9:11:58 p.m.
    Author     : luise
--%>

<%@page import="datos.productosDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.carrito"%>
<%@page import="datos.carritoDAO"%>
<%@page import="modelo.productoCarrito"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Tu Carrito | Tickets</title>
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
                font-size: 24px; 
                font-weight: bold; 
                text-align: right;
                margin-top: 30px; 
                color: #1A1A1A; 
            }
            .btn-pagar { 
                background-color: #28a745; 
                color: white; 
                padding: 15px 30px; 
                border: none; 
                border-radius: 8px; 
                font-size: 18px; 
                font-weight: bold;
                cursor: pointer; 
                float: right; 
                margin-top: 20px; 
                transition: 0.3s;
                text-decoration: none;
                display: inline-block;
            }
            .btn-pagar:hover { 
                background-color: #218838;
                transform: translateY(-2px);
            }
            .empty-cart { 
                text-align: center;
                padding: 50px; 
                color: #666;
                font-size: 18px;
            }
            .btn-eliminar {
                color: #d32f2f;
                background: none;
                border: none;
                font-weight: bold;
                cursor: pointer;
                font-size: 14px;
            }
            .btn-eliminar:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <jsp:include page="img/auxiliares/encabezado.jsp" />

        <div class="container">
            <h1>Carrito de Compras</h1>
            <%
                List<productoCarrito> carritoProductos = (List<productoCarrito>) session.getAttribute("carritoProductos");
                double totalMercancia = 0;
                
                if (carritoProductos == null || carritoProductos.isEmpty()) {
            %>
                <div class="empty-cart">
                    <p>Tu carrito está vacío en este momento.</p>
                    <a href="productos.jsp" style="color: #3483fa; font-weight: bold; text-decoration: none; font-size: 18px;">Ver productos en la Tienda -></a>
                </div>
            <%
                } else {
            %>
                <table>
                    <thead>
                        <tr>
                            <th>Foto</th>
                            <th>Producto</th>
                            <th>Precio Unitario</th>
                            <th>Cant.</th>
                            <th>Subtotal</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (productoCarrito prod : carritoProductos) { 
                            totalMercancia += (prod.getprecio() * prod.getcantidad());
                        %>
                        <tr>
                            <td><img src="img/productos/<%= prod.getfoto() != null ? prod.getfoto() : "default_productos.jpg" %>" style="width: 50px; border-radius: 4px;"></td>
                            <td>
                                <strong><%= prod.getnombre() %></strong>
                                <br>
                                <a href="producto_individual.jsp?id=<%= prod.getidproducto() %>" style="color: #3483fa; font-size: 13px; text-decoration: none; font-weight: bold; margin-top: 5px; display: inline-block;">Ver producto</a>
                            </td>
                            <td>$<%= String.format("%,.2f", prod.getprecio()) %></td>
                            <td><%= prod.getcantidad() %></td>
                            <td>$<%= String.format("%,.2f", prod.getprecio() * prod.getcantidad()) %></td>
                            <td>
                                <form action="carritoServlet" method="POST" style="margin: 0;">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <input type="hidden" name="idproducto" value="<%= prod.getidproducto() %>">
                                    <button type="submit" class="btn-eliminar">X Eliminar</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="total-row">
                    Total a Pagar: $<%= String.format("%,.2f", totalMercancia) %>
                </div>
                <div style="overflow: hidden; margin-top: 20px;">
                    <a href="pago_productos.jsp" class="btn-pagar">Proceder al Pago</a>
                </div>
            <% } %>
        </div>
    </body>
</html>