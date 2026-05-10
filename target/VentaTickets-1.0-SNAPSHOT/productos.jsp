<%-- 
    Document   : productos
    Created on : 8 may 2026, 10:03:25 p.m.
    Author     : luise
--%>

<%@page import="modelo.producto"%>
<%@page import="java.util.List"%>
<%@page import="datos.productosDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Tickets | Productos</title>
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

        .main-header {
            background-color: var(--entity-header);
            color: white;
            padding: 0 40px;
            display: flex;
            flex-direction: column; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .header-top { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            height: 70px; 
        }
        .logo { 
            font-size: 30px; 
            font-weight: bold; 
            color: white; 
            text-decoration: none; 
            letter-spacing: 2px;
        }
        .user-actions { 
            display: flex; 
            align-items: center; 
            gap: 20px; 
        }
        .action-item { 
            color: white; 
            text-decoration: none; 
            font-size: 13px; 
            font-weight: bold; 
            text-transform: uppercase; 
        }
        .action-item:hover { 
            color: var(--accent-pink); 
        }
        .search-trigger { 
            background: #2A2A2A; 
            padding: 8px 15px; 
            border-radius: 4px; 
            border: 1px solid #444; 
            color: #888; 
            font-size: 12px; 
        }
        .main-nav { 
            border-top: 1px solid #333; 
            display: flex; 
        }
        .nav-links { 
            display: flex; 
            gap: 30px; 
            list-style: none; 
            margin: 0; 
            padding: 12px 0; 
        }
        .nav-links a { 
            color: white; 
            text-decoration: none; 
            font-size: 14px; 
            font-weight: bold; 
            text-transform: uppercase;
        }
        .nav-links a:hover { 
            color: var(--accent-pink); 
        }
        .badge { 
            background-color: #ff4444; 
            color: white; 
            border-radius: 50%; 
            padding: 2px 7px; 
            font-size: 10px; 
            margin-left: 5px; 
        }

        .main-wrapper {
            max-width: 1200px; 
            margin: 40px auto;
            padding: 0 20px; 
        }
        .section-title { 
            font-size: 18px; 
            font-weight: bold; 
            margin-bottom: 25px; 
            color: white; 
            background: var(--entity-header);
            padding: 8px 15px; 
            display: inline-block; 
            border-radius: 4px;
            text-transform: uppercase;
        }
        .artist-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); 
            gap: 25px; 
        }
        .artist-card { 
            background: var(--entity-body); 
            border: 2px solid var(--entity-header); 
            border-radius: 12px; 
            overflow: hidden;
            display: flex;
            flex-direction: column; 
            transition: 0.3s ease;
        }
        .artist-card:hover { 
            transform: scale(1.03);
            box-shadow: 0 10px 25px rgba(0,0,0,0.3); 
        }
        .card-header { 
            background: var(--entity-header); 
            color: white; 
            padding: 10px; 
            text-align: center; 
            font-size: 12px; 
            font-weight: bold; 
            text-transform: uppercase; 
        }
        .artist-img { 
            width: 100%;
            height: 250px;
            object-fit: cover; 
            border-bottom: 1px solid #ccc;
        }
        .artist-info { 
            padding: 18px; 
            text-align: center; 
        }
        .artist-info h3 {
            margin: 0 0 8px 0; 
            font-size: 20px;
            color: #111; 
            text-transform: capitalize; 
        }
        .artist-info p { 
            margin: 0;
            color: #555; 
            font-size: 14px; 
            font-weight: bold;
        }
        .no-data { 
            grid-column: 1 / -1; 
            text-align: center;
            padding: 50px; 
            background: var(--entity-body);
            border-radius: 8px; 
            border: 2px dashed var(--entity-header); 
        }
    </style></head>
<body>
    <%
    String nombreUser = (String) session.getAttribute("nombreusuario");
    String tipoUser = (String) session.getAttribute("tipousuario");
    int pendientes = 0;
%>
    <header class="main-header">
        <div class="header-top">
            <a href="index.jsp" class="logo">TICKETS</a>
            <div class="user-actions">
                <a href="#" class="action-item search-trigger">BUSCAR ARTISTA O EVENTO</a>
                <a href="notificaciones.jsp" class="action-item">
                    NOTIFICACIONES 
                    <% if(pendientes > 0) { %><span class="badge"><%= pendientes %></span><% } %>
                </a>
                <div class="profile-menu-container">
                    <a class="action-item">
                        PERFIL <%= (nombreUser != null) ? "(" + nombreUser.toUpperCase() + ")" : "" %> ▾
                    </a>
                </div>
                <a href="configuracion.jsp" class="action-item">CONFIGURACIÓN</a>
                <% if(nombreUser == null) { %>
                    <a href="login.jsp" class="action-item" style="color: var(--accent-green)">Ingresa</a>
                <% } %>
            </div>
        </div>
        <nav class="main-nav">
            <ul class="nav-links">
                <li><a href="index.jsp">INICIO</a></li>
                <li><a href="conciertos.jsp">CONCIERTOS</a></li>
                <li><a href="artista.jsp">ARTISTAS</a></li>
                <li><a href="productos.jsp"style="color: var(--accent-pink);">PRODUCTOS</a></li>
            </ul>
        </nav>
    </header>
    <div class="main-wrapper">
        <div class="section-title">MERCH</div>
        
        <div class="artist-grid">
            <%
                productosDAO dao = new productosDAO();
                List<producto> lista = dao.obtenerProductos();
                for(producto p : lista) {
            %>
            <%
                String fotoPath = (p.getfoto() != null && !p.getfoto().isEmpty()) 
                            ? p.getfoto() : "default_productos.jpg";
            %>

                <div class="artist-card">
                    <div class="card-header">STOCK: <%= p.getcantidad() %> unidades</div>

                    <img src="img/productos/<%= fotoPath %>" class="artist-img" alt="<%= p.getnombre() %>">

                    <div class="artist-info">
                        <h3><%= p.getnombre() %></h3>
                        <p style="color: #d32f2f; font-size: 18px;">$ <%= p.getprecio() %></p>
                        <p style="margin-top: 10px; cursor: pointer;">> AGREGAR AL CARRITO</p>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>