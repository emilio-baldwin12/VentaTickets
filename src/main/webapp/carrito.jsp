<%-- 
    Document   : carrito.jsp
    Created on : 29 may 2026, 9:11:58 p.m.
    Author     : luise
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.carrito"%>
<%@page import="datos.carritoDAO"%>
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
        </style>
    </head>
    <body>
        <jsp:include page="img/auxiliares/encabezado.jsp" />

        <div class="container">
            <h1>Tus Compras</h1>
                <%
                    int idUsuarioActual = (session.getAttribute("idusuario") != null) ? (int) session.getAttribute("idusuario") : 0;
                    carritoDAO dao = new carritoDAO();
                    List<carrito> boletos = dao.obtenerMisBoletos(idUsuarioActual);
                    if (idUsuarioActual == 0 || boletos.isEmpty()) {
                %>
                    <div class="empty-cart">
                        <p>Aún no tienes boletos comprados.</p>
                        <a href="conciertos.jsp" style="color: #8EACB8; font-weight: bold; text-decoration: none; font-size: 20px;">Ver Conciertos -></a>
                    </div>
                <%
                    } else {
                        double total = 0;
                %>
                <table>
                    <thead>
                        <tr>
                            <th>Evento</th>
                            <th>Ciudad</th>
                            <th>Zona</th>
                            <th>Fila / Asiento</th>
                            <th>Precio</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (carrito b : boletos) { 
                            total += b.getprecio();
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
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                    <div class="total-row">
                    Total pagado: $<%= String.format("%,.2f", total) %>
                    </div>

                <div style="overflow: hidden; margin-top: 20px;">
                      <a href="index.jsp" style="float: right; background-color: #8EACB8; color: white; padding: 15px 30px; border-radius: 8px; font-size: 18px; font-weight: bold; text-decoration: none; transition: 0.3s;">Volver al Inicio</a>
                </div>
            <% } %>
        </div>
    </body>
</html>
