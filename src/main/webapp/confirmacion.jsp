<%-- 
    Document   : confirmacion
    Created on : 18 may 2026, 10:39:30 p.m.
    Author     : luise
--%>
<%@page import="java.util.List"%>
<%@page import="modelo.boleto"%>
<%@page import="datos.boletoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String idOrdenStr = request.getParameter("id_orden");
    List<boleto> misBoletos = null;

    if (idOrdenStr != null && !idOrdenStr.isEmpty()) {
        try {
            int idOrden = Integer.parseInt(idOrdenStr);
            misBoletos = new boletoDAO().listarOrden(idOrden);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tickets | Confirmación de Compra</title>
        <style>
            :root {
                --bg-blue: #8EACB8;
                --entity-header: #1A1A1A;
                --accent-pink: #FFB6C1;
                --accent-green: #90EE90;
            }
            body {
                background-color: var(--bg-blue);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            .container {
                background: white;
                width: 90%;
                max-width: 600px;
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 15px 35px rgba(0,0,0,0.2);
                text-align: center;
            }
            .success-icon {
                font-size: 50px;
                color: var(--accent-green);
                margin-bottom: 10px;
            }
            h1 { color: var(--entity-header); margin-bottom: 5px; }
            p { color: #666; margin-bottom: 30px; }

            /* Estilo del Ticket */
            .ticket {
                display: flex;
                background: #fff;
                border: 2px solid #eee;
                border-radius: 12px;
                margin-bottom: 20px;
                overflow: hidden;
                position: relative;
                text-align: left;
            }
            .ticket-info {
                padding: 20px;
                flex: 2;
                border-right: 2px dashed #ddd;
            }
            .ticket-info h3 { margin: 0 0 10px 0; font-size: 18px; text-transform: uppercase; }
            .ticket-info p { margin: 5px 0; font-size: 14px; color: #444; }
            
            .ticket-qr {
                flex: 1;
                background: #fafafa;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 15px;
            }
            .qr-img {
                width: 100px;
                height: 100px;
                background: #eee;
                border-radius: 4px;
            }
            .qr-code-text {
                font-size: 9px;
                color: #999;
                word-break: break-all;
                margin-top: 8px;
                text-align: center;
            }
            .btn-home {
                display: inline-block;
                margin-top: 20px;
                padding: 12px 30px;
                background: var(--entity-header);
                color: white;
                text-decoration: none;
                border-radius: 8px;
                font-weight: bold;
                transition: background 0.3s;
            }
            .btn-home:hover { background: #333; }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="success-icon">✔</div>
            <h1>¡Gracias por tu compra!</h1>
            <p>Tu orden <strong>#<%= idOrdenStr %></strong> ha sido procesada con éxito.</p>

            <% if (misBoletos != null && !misBoletos.isEmpty()) { 
                for (boleto b : misBoletos) { %>
                <div class="ticket">
                    <div class="ticket-info">
                        <h3><%= b.getrecinto() %></h3>
                        <p>Fecha: <strong><%= b.getfecha() %></strong></p>
                        <p>Zona: <strong><%= b.getzona() %></strong></p>
                        <p>Asiento ID: <strong><%= b.getidasiento() %></strong></p>
                    </div>
                    <div class="ticket-qr">
                        <img class="qr-img" 
                             src="https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=<%= b.getcodigoqr() %>&choe=UTF-8" 
                             alt="QR Code">
                        <div class="qr-code-text"><%= b.getcodigoqr().substring(0, 8) %>...</div>
                    </div>
                </div>
            <%  } 
            } else { %>
                <div style="padding: 20px; background: #fff3cd; color: #856404; border-radius: 8px;">
                    No se encontraron detalles de los boletos. Por favor revisa tu historial en el perfil.
                </div>
            <% } %>

            <a href="index.jsp" class="btn-home">Volver al Inicio</a>
        </div>

    </body>
</html>