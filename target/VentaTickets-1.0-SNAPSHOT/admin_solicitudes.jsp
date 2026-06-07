<%-- 
    Document   : admin_solicitudes
    Created on : 4 jun 2026, 10:39:10 p.m.
    Author     : luise
--%>

<%@page import="java.util.List"%>
<%@page import="datos.solicitudDAO"%>
<%@page import="modelo.solicitudConcierto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUser = (String) session.getAttribute("nombreusuario");
    String rolUser = (String) session.getAttribute("tipousuario");
    if (nombreUser == null || !"ADMIN".equals(rolUser)) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Solicitudes de Artistas | Ticketes</title>
    <style>
        body {
            background-color: #E8E2D1; 
            font-family: 'Segoe UI', Tahoma, sans-serif;
            margin: 0; 
        }
        .container { 
            max-width: 1000px; 
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
        .btn { 
            padding: 8px 12px;
            border: none;
            border-radius: 4px; 
            font-weight: bold;
            cursor: pointer; 
            color: white;
            font-size: 12px;
        }
        .btn-accept {
            background-color: #28a745;
        }
        .btn-accept:hover {
            background-color: #218838;
        }
        .btn-reject {
            background-color: #dc3545;
        }
        .btn-reject:hover { 
            background-color: #c82333;
        }
        .empty-msg { 
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 16px; 
        }
    </style>
</head>
<body>
    <jsp:include page="img/auxiliares/encabezado.jsp" />

    <div class="container">
        <h1>Bandeja de Solicitudes</h1>
        <%
            solicitudDAO sDao = new solicitudDAO();
            List<solicitudConcierto> pendientes = sDao.obtenerPendientes();
            
            if (pendientes.isEmpty()) {
        %>
            <div class="empty-msg">No hay solicitudes pendientes en este momento.</div>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>Artista</th>
                        <th>Evento Propuesto</th>
                        <th>Fecha</th>
                        <th>Ciudad</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (solicitudConcierto s : pendientes) { %>
                    <tr>
                        <td><strong><%= s.getnombreartista().toUpperCase() %></strong></td>
                        <td>
                            <%= s.getnombreevento() %><br>
                            <small style="color: #888;"><%= s.getdescripcion() != null ? s.getdescripcion() : "Sin descripción" %></small>
                        </td>
                        <td><%= s.getfechapropuesta() %></td>
                        <td><%= s.getciudadpropuesta() %></td>
                        <td>
                            <form action="solicitudServlet" method="POST" style="display:inline;">
                                <input type="hidden" name="accion" value="procesar">
                                <input type="hidden" name="id_solicitud" value="<%= s.getid() %>">
                                <input type="hidden" name="decision" value="ACEPTADA">
                                <button type="submit" class="btn btn-accept">Aprobar</button>
                            </form>
                            
                            <form action="solicitudServlet" method="POST" style="display:inline;">
                                <input type="hidden" name="accion" value="procesar">
                                <input type="hidden" name="id_solicitud" value="<%= s.getid() %>">
                                <input type="hidden" name="decision" value="RECHAZADA">
                                <button type="submit" class="btn btn-reject">Rechazar</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>
</body>
</html>
