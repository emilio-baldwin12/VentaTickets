<%-- 
    Document   : perfilartista
    Created on : 9 may 2026, 4:20:32 p.m.
    Author     : luise
--%>
<%@page import="modelo.cancion"%>
<%@page import="java.util.List"%>
<%@page import="modelo.artista"%>
<%@page import="modelo.concierto"%>
<%@page import="modelo.cancion"%>
<%@page import="datos.artistaDAO"%>
<%@page import="datos.solicitudDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUser = (String) session.getAttribute("nombreusuario");
    Integer idLogueado = (Integer) session.getAttribute("idusuario");
    String tipoUser = (String) session.getAttribute("tipousuario");
    int pendientes = 0;
    if("ADMIN".equals(tipoUser)) {
        pendientes = new solicitudDAO().contarPendientes();
    }

    String idParam = request.getParameter("id");
    int id = 0;
    artista a = null;
    artistaDAO dao = new artistaDAO();

    if (idParam != null && !idParam.isEmpty()) {
        try {
            id = Integer.parseInt(idParam);
            a = dao.obtenerPerfil(id);
        } catch (NumberFormatException e) {
            response.sendRedirect("artista.jsp");
            return;
        }
    } else {
        response.sendRedirect("artista.jsp");
        return;
    }

    if (a == null) {
        response.sendRedirect("artista.jsp");
        return;
    }
    boolean loSigue = false;
    String nombreCompleto = "";

    if (a != null) {
        nombreCompleto = a.getnombre() + " " + (a.getapellido() != null ? a.getapellido() : "");
        
        if(idLogueado != null) {
            loSigue = dao.esSeguidor(idLogueado, a.getID());
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tickets | <%= nombreCompleto %></title> 
    <style>
        :root {
            --bg-blue: #8EACB8;
            --entity-header: #1A1A1A;
            --entity-body: #E8E2D1;
            --accent-pink: #FFB6C1;
            --spotify-green: #1DB954;
        }

        body { background-color: #F8F8F8; 
               font-family: 'Segoe UI', sans-serif; 
               margin: 0; 
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
            gap: 20px; }
        .action-item {
            color: white; 
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
            text-transform: uppercase; 
        }
        .search-trigger {
            background: #2A2A2A;
            padding: 8px 15px;
            border-radius: 4px;
            border: 1px solid #444;
            color: #888;
            font-size: 12px;
        }
        .badge { 
            background-color: #ff4444; 
            color: white; 
            border-radius: 50%; 
            padding: 2px 7px; 
            font-size: 10px; 
            margin-left: 5px; 
        }
        .main-nav { 
            border-top: 1px solid #333; 
            display: flex; }
        
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

        .spotify-header {
            height: 400px;
            background: url('img/artistas/<%= a.getbanner() %>');
            background-size: cover; 
            background-position: center;
            display: flex; 
            align-items: flex-end; 
            padding: 40px; color: 
                white;
        }
        .artist-name { 
            font-size: 80px; 
            font-weight: 900; 
            margin: 10px 0;
            letter-spacing: -2px;
        }

        .action-bar {
            background: #121212;
            padding: 20px 40px; 
            display: flex; 
            align-items: center;
            gap: 25px; 
        }
        .follow-btn { 
            background: transparent; 
            border: 1px solid #888; 
            color: white; 
            padding: 8px 25px; 
            border-radius: 20px; 
            font-weight: bold; 
            cursor: pointer; 
            text-transform: uppercase;
        }
        .follow-btn.siguiendo { 
            background: white; 
            color: black; 
            border: none; 
        }

        .tm-tabs {
            background: white; 
            border-bottom: 1px solid #ddd; 
            padding: 0 40px; 
        }
        .tm-tabs ul { 
            list-style: none; 
            display: flex; 
            gap: 40px; 
            margin: 0; 
            padding: 0; 
        }
        .tm-tabs li { 
            padding: 20px 0;
            font-weight: bold; 
            color: #666; 
            cursor: pointer; 
            text-transform: uppercase; 
            font-size: 13px; 
        }
        .tm-tabs li.active { 
            color: black; 
            border-bottom: 4px solid black; 
        }

        .tab-content { 
            display: none; 
            padding: 40px;
            max-width: 1000px;
            margin: 0 auto; 
        }
        .tab-content.active { 
            display: block;
        }

        .song-item {
            display: flex;
            align-items: center;
            padding: 10px;
            border-radius: 5px;
            transition: 0.3s;
            cursor: pointer; 
            color: #333;
        }
        .song-item:hover { 
            background: #eee; 
        }
        .song-img { 
            width: 50px;
            height: 50px;
            border-radius: 4px;
            margin-right: 15px; 
            object-fit: cover;
        }
        .concert-list {
            margin-top: 20px;
        }

        .concert-card {
            background: white;
            display: flex;
            align-items: center;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: 0.3s;
            border-left: 5px solid #007bff; /* El borde azul de la imagen */
        }

        .concert-card:hover {
            transform: scale(1.01);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .date-box {
            text-align: center;
            min-width: 80px;
            padding-right: 20px;
            border-right: 1px solid #eee;
        }

        .month {
            color: #007bff;
            font-weight: bold;
            text-transform: uppercase;
            font-size: 14px;
        }

        .day {
            font-size: 28px;
            font-weight: 800;
            color: #333;
        }

        .info {
            flex-grow: 1;
            padding-left: 25px;
        }

        .artist-name-card {
            font-size: 20px;
            font-weight: bold;
            color: #000;
        }

        .tour-name-card {
            color: #666;
            font-size: 14px;
            margin-top: 4px;
        }

        .location-card {
            color: #888;
            font-size: 13px;
            margin-top: 4px;
        }

        .btn-tickets-card {
            background: #007bff;
            color: white;
            padding: 12px 25px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            font-size: 13px;
            transition: 0.2s;
        }

        .btn-tickets-card:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

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
                <li><a href="artista.jsp"style="color: var(--accent-pink);">ARTISTAS</a></li>
                <li><a href="productos.jsp">PRODUCTOS</a></li>
            </ul>
        </nav>
    </header>

    <div class="spotify-header" style="background: url('img/banners/<%= a.getbanner() %>')no-repeat center center / cover;">
        <div>
            <div style="color: #4cb3ff; font-weight: bold; display: flex; align-items: center; gap: 8px;">
                <img src="img/banners/verificado.jpg" alt="Verificado" style="width: 25px; height: 25px;">
                Artista Verificado
            </div>
            <h1 class="artist-name">
                <%= nombreCompleto %>
            </h1>
            <div style="font-weight: bold;"><%= a.gettotal_seguidores() %> seguidores</div>
        </div>
    </div>

    <div class="action-bar">
        <button class="follow-btn <%= loSigue ? "siguiendo" : "" %>">
            <%= loSigue ? "SIGUIENDO" : "SEGUIR" %>
        </button>
            <span style="color: <%= loSigue ? "#1DB954" : "white" %>; font-size: 30px;"></span>    
    </div>

    <nav class="tm-tabs">
        <ul>
            <li id="t-conciertos" class="active" onclick="switchTab('conciertos')">Conciertos</li>
            <li id="t-setlist" onclick="switchTab('setlist')">Setlist</li>
            <li id="t-resenas" onclick="switchTab('resenas')">Reseñas</li>
        </ul>
    </nav>

    <div id="conciertos" class="tab-content active">
        <h3>Próximos Eventos</h3>
        <div class="concert-list">
            <%
                java.text.SimpleDateFormat sdfDia = new java.text.SimpleDateFormat("dd");
                java.text.SimpleDateFormat sdfMes = new java.text.SimpleDateFormat("MMM");

                List<concierto> gira = dao.obtenerConciertosArtistas(id);

                if(gira.isEmpty()) {
            %>
                <div style="background: white;
                     padding: 40px;
                     border-radius: 10px; 
                     text-align: center; 
                     color: #666; 
                     border: 2px dashed #ccc;">
                    No hay fechas disponibles por ahora.
                </div>
            <%
                } else {
                    for(concierto c : gira) {
            %>
                    <div class="concert-card">
                        <div class="date-box">
                            <div class="month"><%= sdfMes.format(c.getfecha()).toUpperCase() %></div>
                            <div class="day"><%= sdfDia.format(c.getfecha()) %></div>
                        </div>

                        <div class="info">
                            <div class="artist-name-card"><%= nombreCompleto %></div>
                            <div class="tour-name-card"><%= c.getnombre() %></div>
                            <div class="location-card"><%= c.getciudad() %></div>
                        </div>

                        <div class="actions">
                            <a href="detalle_evento.jsp?id=<%= c.getid() %>" class="btn-tickets-card">VER TICKETS</a>
                        </div>
                    </div>
            <% 
                    } 
                } 
            %>
        </div>
    </div>
    </div>

    <div id="setlist" class="tab-content">
        <h2>Canciones Populares</h2>
        <div class="songs-container">
            <%
                List<cancion> listaSongs = dao.obtenerCanciones(id);
                int n = 1;
                for(cancion c : listaSongs) {
            %>
                <div class="song-item" onclick="window.open('<%= c.geturl() %>', '_blank')">
                    <span style="width: 30px; color: #888;"><%= n++ %></span>
                    <img src="img/canciones/<%= (c.getfoto() != null) ? c.getfoto() : "album.jpg" %>" class="song-img">
                    <div style="flex-grow: 1;">
                        <div style="font-weight: bold;"><%= c.gettitulo() %></div>
                        <div style="font-size: 12px; color: #777;">Sencillo</div>
                    </div>
                    <div style="color: var(--spotify-green); font-size: 20px;"></div>
                </div>
            <% } %>
        </div>
    </div>

    <div id="resenas" class="tab-content">
        <h2>Opiniones de los Fans</h2>
        <p>Aun no hay reseñas para este artista.</p>
    </div>

    <script>
        function switchTab(tabId) {
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
            document.querySelectorAll('.tm-tabs li').forEach(t => t.classList.remove('active'));
            
            document.getElementById(tabId).classList.add('active');
            document.getElementById('t-' + tabId).classList.add('active');
        }
    </script>

</body>
</html>