<%-- 
    Document   : boleto_individual
    Created on : 4 jun 2026, 5:46:26 p.m.
    Author     : luise
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String evento = request.getParameter("evento");
    String fecha = request.getParameter("fecha");
    String ciudad = request.getParameter("ciudad");
    String zona = request.getParameter("zona");
    String fila = request.getParameter("fila");
    String asiento = request.getParameter("asiento");
    String precio = request.getParameter("precio");

    if(evento == null) {
        response.sendRedirect("mis_compras.jsp");
        return;
    }
    
    String codigoReservacion = "wkhi-" + (int)(Math.random() * 9000000 + 1000000);
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Boleto | Ticketes</title>
    <style>
        body {
            background-color: #E8E2D1;
            font-family: 'Segoe UI', Tahoma, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .ticket-wrapper {
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            display: flex;
            max-width: 850px;
            width: 100%;
            border: 1px solid #e0e0e0;
            overflow: hidden;
        }
        .ticket-left {
            background-color: #d2dee8;
            flex: 2.5;
            padding: 40px;
            position: relative;
        }
        .ticket-right {
            flex: 1;
            background-color: white;
            border-left: 2px dashed #ccc;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 30px 20px;
            gap: 40px;
        }
        .logo-text {
            font-size: 28px;
            font-weight: 900;
            color: #004b93;
            font-style: italic;
            letter-spacing: -1px;
            margin-bottom: 20px;
        }
        .event-title {
            font-size: 34px;
            font-weight: bold;
            color: #444;
            margin-bottom: 30px;
            margin-top: 0;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 25px;
        }
        .info-group {
            display: flex;
            flex-direction: column;
            text-align: center;
        }
        .info-label {
            font-size: 13px;
            color: #666;
            margin-bottom: 5px;
        }
        .info-value {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }
        .back-btn {
            position: absolute;
            top: 20px;
            left: 20px;
            background: #8EACB8;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: 0.3s;
        }
        .back-btn:hover {
            background: #728d99;
        }
    </style>
</head>
<body>
    <div>
        <a href="miscompras.jsp" class="back-btn">Volver a Mis Compras</a>
        
        <div class="ticket-wrapper" style="margin-top: 80px;">
            <div class="ticket-left">
                <div class="logo-text">ticketes&reg;</div>
                <h1 class="event-title"><%= evento %></h1>
                
                <div class="info-grid">
                    <div class="info-group">
                        <span class="info-label">Sección</span>
                        <span class="info-value"><%= zona %></span>
                    </div>
                    <div class="info-group">
                        <span class="info-label">Fila</span>
                        <span class="info-value"><%= fila %></span>
                    </div>
                    <div class="info-group">
                        <span class="info-label">Asientos</span>
                        <span class="info-value"><%= asiento %></span>
                    </div>
                </div>
                
                <div class="info-grid">
                    <div class="info-group">
                        <span class="info-label">Fecha</span>
                        <span class="info-value"><%= fecha %></span>
                    </div>
                    <div class="info-group">
                        <span class="info-label">Hora</span>
                        <span class="info-value">20:00 hrs</span>
                    </div>
                    <div class="info-group">
                        <span class="info-label">Código de Reservación</span>
                        <span class="info-value" style="font-size: 14px;"><%= codigoReservacion %></span>
                    </div>
                </div>
                
                <div class="info-grid" style="grid-template-columns: 1fr 2fr;">
                    <div class="info-group" style="text-align: left;">
                        <span class="info-label">Precio</span>
                        <span class="info-value">MX <%= String.format("%,.2f", Double.parseDouble(precio)) %></span>
                    </div>
                    <div class="info-group" style="text-align: left;">
                        <span class="info-label">Lugar</span>
                        <span class="info-value"><%= ciudad %></span>
                    </div>
                </div>
            </div>
            
            <div class="ticket-right">
                <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=<%= codigoReservacion %>" alt="QR Boleto" style="width: 150px; height: 150px;">
                
                <img src="https://barcode.tec-it.com/barcode.ashx?data=<%= codigoReservacion %>&code=Code128&translate-esc=on" alt="Barcode Boleto" style="width: 200px; height: auto;">
            </div>
        </div>
    </div>
</body>
</html>