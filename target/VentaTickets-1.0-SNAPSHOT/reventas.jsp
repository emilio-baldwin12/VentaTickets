<%-- 
    Document   : reventas
    Created on : 5 jun 2026, 11:37:46 p.m.
    Author     : luise
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="datos.reventaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Mercado de Reventas Oficial | Ticketes</title>
    <style>
        :root {
            --bg-blue: #8EACB8;  
            --entity-header: #1A1A1A; 
            --entity-body: #E8E2D1;   
            --accent-pink: #FFB6C1;   
            --accent-green: #90EE90;  
        }
        body {
            background-color: var(--bg-blue);
            font-family: 'Segoe UI', Tahoma, sans-serif;
            margin: 0; 
            color: #333;
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
        
        .grid-reventas { 
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px; 
            margin-top: 25px;
        }
        .card-reventa {
            background: #f9f9f9; 
            border-left: 6px solid var(--accent-green);
            padding: 20px; 
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05); 
            display: flex; 
            justify-content: space-between;
            align-items: center;
        }
        .info-reventa h3 { 
            margin: 0 0 5px 0;
            color: #111; 
            font-size: 18px;
        }
        .info-reventa p { 
            margin: 5px 0;
            color: #555; 
            font-size: 14px;
        }
        .badge-verificado { 
            display: inline-flex; 
            align-items: center;  
            gap: 8px;            
            background-color: #d4edda; 
            color: #155724;      
            font-size: 12px;
            font-weight: bold;
            padding: 5px 15px;   
            border-radius: 20px;
            margin-bottom: 10px;
            border: 1px solid #c3e6cb;
        }
        .badge-verificado img {
            width: 16px;  
            height: 16px;
            object-fit: contain; 
        }
        .side-reventa { 
            text-align: right;
            min-width: 150px;
        }
        .precio-tag { 
            font-size: 24px;
            font-weight: bold;
            color: #28a745;
            margin-bottom: 15px;
        }
        .btn-buy { 
            background-color: #3483fa; 
            color: white;
            padding: 10px 20px;
            border: none; 
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer; 
            font-size: 14px; 
            width: 100%;
            transition: 0.3s; 
        }
        .btn-buy:hover {
            background-color: #2968c8;
        }
        .no-tickets {
            text-align: center; 
            padding: 50px;
            color: #777;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <jsp:include page="img/auxiliares/encabezado.jsp" />

    <div class="container">
        <h1>Mercado Secundario Seguro</h1>
        <p style="color: #666;">Todos los boletos listados aquí son de fans verificados. Precios protegidos contra reventa abusiva</p>

        <%
            reventaDAO dao = new reventaDAO();
            List<Map<String, Object>> reventas = dao.listarReventasActivas();

            if (reventas == null || reventas.isEmpty()) {
        %>
            <div class="no-tickets">
                <p>No hay boletos en reventa disponibles en este momento</p>
            </div>
        <% } else { %>
            <div class="grid-reventas">
                <% for (Map<String, Object> r : reventas) { %>
                <div class="card-reventa">
                    <div class="info-reventa">
                        <span class="badge-verificado">
                            <img src="img/auxiliares/verificado.png" alt="Icono Verificado">
                            Boleto Original Verificado
                        </span>
                        <h3><%= r.get("concierto") %></h3>
                        
                        <p><strong>Ciudad:</strong> <%= r.get("ciudad") %></p>
                        
                        <p><strong>Fecha Evento:</strong> <%= r.get("concierto_fecha") %></p>
                        
                        <p style="color: #1A1A1A; background-color: #f0f0f0; padding: 5px 10px; border-radius: 5px; display: inline-block; font-size: 13px;">
                            <strong>Zona:</strong> <%= r.get("zona") %> | 
                            <strong>Fila:</strong> <%= r.get("fila") %> | 
                            <strong>Asiento:</strong> <%= r.get("asiento") %>
                        </p>
                        
                        <p style="color: #888; font-style: italic; margin-top: 10px;">
                            "Motivo: <%= r.get("motivo") != null && !((String)r.get("motivo")).isEmpty() ? r.get("motivo") : "No especificado" %>"
                        </p>
                            <small style="color: #999; display: block; margin-top: 5px;">Vendedor: <%= ((String)r.get("vendedor")).toUpperCase() %></small>
                        </div>
                        
                        <div class="side-reventa">
                            <div class="precio-tag">$<%= r.get("precio_nuevo") %></div>
                            
                            <form action="reventaServlet" method="POST">
                                <input type="hidden" name="accion" value="comprar_boleto">
                                <input type="hidden" name="id_reventa" value="<%= r.get("id_reventa") %>">
                                <button type="submit" class="btn-buy">Comprar Boleto</button>
                            </form>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>
</body>
</html>
