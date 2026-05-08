<%@page import="datos.solicitudDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tickets | Home</title>
    <style>
        :root {
            --bg-blue: #8EACB8;  /* Azul OR */
            --entity-header: #1A1A1A; /* Negro */
            --entity-body: #E8E2D1;   /* Crema */
            --accent-pink: #FFB6C1;   /* Rosa */
            --accent-green: #90EE90;  /* Verde */
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
            display: flex;
            align-items: center;
            gap: 8px;
            color: white;
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
            transition: 0.3s;
            cursor: pointer;
            text-transform: uppercase;
        }

        .action-item:hover { color: var(--accent-pink); }

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
            justify-content: flex-start;
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
            transition: 0.3s;
        }

        .nav-links a:hover { color: var(--accent-pink); }

        .badge {
            background-color: #ff4444;
            color: white;
            border-radius: 50%;
            padding: 2px 7px;
            font-size: 10px;
            margin-left: 5px;
        }

        .main-wrapper {
            display: flex;
            max-width: 1200px;
            margin: 30px auto;
            gap: 25px;
            padding: 0 20px;
        }

        .content-main { flex: 3; }
        .sidebar { flex: 1; }

        .section-title { 
            font-size: 18px; 
            font-weight: bold;
            margin-bottom: 20px; 
            color: white;
            background: var(--entity-header);
            padding: 8px 15px; 
            display: inline-block; 
            border-radius: 4px;
        }
        
        .event-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }

        .event-card {
            background: var(--entity-body);
            border: 2px solid var(--entity-header);
            border-radius: 8px; 
            overflow: hidden; 
            transition: 0.3s;
            display: flex;
            flex-direction: column;
        }

        .event-card:hover { 
            transform: scale(1.02); 
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        .event-header { 
            background: var(--entity-header); 
            color: white; 
            padding: 10px; 
            text-align: center; 
            font-size: 13px; 
            font-weight: bold;
        }
        .event-info { 
            padding: 15px; 
            border-top: 1px solid #ccc; 
        }
        .event-info h3 { 
            font-size: 16px; 
            margin: 0 0 8px 0; 
            color: #111; 
        }
        .event-info p { 
            font-size: 13px; 
            color: #444; 
            margin: 2px 0; 
        }

        .side-card {
            background: var(--entity-body);
            border: 2px solid var(--entity-header);
            padding: 20px;
            border-radius: 8px; 
            margin-bottom: 20px;
        }
        .side-card h4 { 
            margin-top: 0; 
            border-bottom: 2px solid var(--entity-header); 
            padding-bottom: 5px; 
        }
    </style>
</head>
<body>

<%
    String tipoUser = (String) session.getAttribute("tipo_usuario");
    String nombreUser = (String) session.getAttribute("nombreUsuario");
    int pendientes = 0;
    
    if("ADMIN".equals(tipoUser)) {
        pendientes = new solicitudDAO().contarPendientes();
    }
%>

<header class="main-header">
    <div class="header-top">
        <a href="index.jsp" class="logo">TICKETS</a>

        <div class="user-actions">
            <a href="#" class="action-item search-trigger">
                <span></span> BUSCAR ARTISTA O EVENTO
            </a>

            <a href="notificaciones.jsp" class="action-item">
                NOTIFICACIONES 
                <% if(pendientes > 0) { %><span class="badge"><%= pendientes %></span><% } %>
            </a>

            <div class="profile-menu-container" onclick="toggleMenu()">
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
            <li><a href="productos.jsp">PRODUCTOS</a></li>
        </ul>
    </nav>
</header>

<div class="main-wrapper">
    <div class="content-main">
        <div class="section-title">LO MÁS BUSCADO</div>
        
        <div class="event-grid">
            <div class="event-card">
                <div class="event-header">ARTISTA : ID_01</div>
                <div class="event-info">
                    <h3>Vans Warped Tour</h3>
                    <p>> Autodromo Hnos. Rodriguez</p>
                    <p>> Fecha: 15/06/2026</p>
                </div>
            </div>

            <div class="event-card">
                <div class="event-header">ARTISTA : ID_02</div>
                <div class="event-info">
                    <h3>Mentiras, El Musical</h3>
                    <p>> Teatro Aldama</p>
                    <p>> Disponibilidad: Alta</p>
                </div>
            </div>

            <div class="event-card">
                <div class="event-header">ARTISTA : ID_03</div>
                <div class="event-info">
                    <h3>Zayn</h3>
                    <p>> Estadio GNP Seguros</p>
                    <p>> Estado: Preventa</p>
                </div>
            </div>
        </div>
    </div>

    <div class="sidebar">
        <div class="side-card">
            <h4>SISTEMA</h4>
            <p>Bienvenido al vendedor de boletos derrocador.</p>
        </div>
        <div class="side-card" style="border-color: var(--accent-pink);">
            <h4 style="color: #d81b60;">EXPERIENCIAS+</h4>
            <p>Consulta los paquetes VIP disponibles para ID_03.</p>
        </div>
    </div>
</div>

<script>
    function toggleMenu() {
        alert("Abriendo menú de perfil...");
    }
</script>

</body>
</html>