<%-- 
    Document   : encabezado.jsp
    Created on : 29 may 2026, 8:46:30 p.m.
    Author     : luise
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="https://fonts.cdnfonts.com/css/open-dyslexic" rel="stylesheet">

<%
    String nombreUser = (String) session.getAttribute("nombreusuario");
    String rolUser = (String) session.getAttribute("tipousuario");
    String uri = request.getRequestURI();//La ruta de la pg para poder iluminarla

%>
<style>
    /* Tema 1: You seem pretty sad for a girl so in lovee */
    :root, body.tema-sadgirl {
        --bg-blue: #8EACB8;         
        --entity-header: #1A1A1A;   
        --entity-body: #E8E2D1;     
        --accent-pink: #FFB6C1;     
        --accent-green: #90EE90;
    }

    /* Tema 2: The Life of a Showgirl */
    body.tema-showgirl {
        --bg-blue: #7AB99A;         
        --entity-header: #E8643E;   
        --entity-body: #DABE8C;     
        --accent-pink: #72B393;     
        --accent-green: #e89A53;    
    }
    
    /* Tema 3: Debí tirar más fotos */
    body.tema-fotos {
        --bg-blue: #08391F;         
        --entity-header: #5C4B43;   
        --entity-body: #E7F0E8;     
        --accent-pink: #88B70D;     
        --accent-green: #80564C;    
    }
    /*DISLEXIA*/
    @font-face {
        font-family: 'MiOpenDyslexic';
        src: url('${pageContext.request.contextPath}/fuentes/OpenDyslexicMono-Regular.otf') format('opentype');
        font-weight: normal;
        font-style: normal;
    }

    @font-face {
        font-family: 'MiOpenDyslexic';
        src: url('${pageContext.request.contextPath}/fuentes/OpenDyslexicMono-Regular.otf') format('opentype');
        font-weight: normal;
        font-style: normal;
    }

    body.fuente-dislexia, body.fuente-dislexia * {
        font-family: 'MiOpenDyslexic', 'Comic Sans MS', sans-serif !important;
        letter-spacing: 0.1px !important;
        line-height: 1.3 !important;
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
        font-family: 'Segoe UI', Tahoma, sans-serif;
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
        text-transform: uppercase;
        cursor: pointer;
        transition: color 0.3s;
    }
    .action-item:hover { 
        color: var(--accent-pink); 
    }
    .search-btn {
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
        align-items: center;
        width: 100%;
    }
    .nav-links a {
        color: white;
        text-decoration: none;
        font-size: 14px;
        font-weight: bold;
        text-transform: uppercase;
        transition: color 0.3s; 
    }
    
    .nav-links a:hover, 
    .nav-links a.active {/* Esta regla ilumina la pestaña activa Y cuando se pasa el mouse */
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
    
    
    
    
    .dropdown {
        position: relative;
        display: inline-block;
    }
    
    .dropdown-content {
        display: none;
        position: absolute;
        right: 0; 
        top: 100%; 
        background-color: var(--entity-header);
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.5);
        z-index: 2000;
        border-radius: 6px;
        overflow: hidden;
        margin-top: 10px;
    }

    .dropdown-content a {
        color: white;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
        font-size: 12px;
        font-weight: bold;
        text-transform: uppercase;
        transition: 0.3s;
    }

    .dropdown-content a:hover {
        background-color: #333;
        color: var(--accent-pink);
    }

    .show-dropdown {
        display: block !important;
    }
</style>
<header class="main-header">
    <div class="header-top">
        <a href="index.jsp" class="logo">
            TICKETS
        </a>
        <div class="user-actions">
            
            <a href="notificaciones.jsp" class="action-item">
                NOTIFICACIONES
            </a>
            
            <% if(nombreUser == null) { %>
                <a href="login.jsp" class="action-item">
                    PERFIL
                </a>
            <% } else { %>
                <div class="dropdown">
                    <span id="btnPerfil" class="action-item" style="cursor: pointer;" onclick="toggleMenu()">
                        PERFIL 
                    </span>
                    <div id="menuPerfil" class="dropdown-content">
                        <a href="cerrarsesionServlet" style="color: #ff4444;">
                            Cerrar Sesión
                        </a>
                    </div>
                </div>
            <% } %>

            <a href="configuracion.jsp" class="action-item">
                CONFIGURACIÓN
            </a>

            <% if(nombreUser == null) { %>
                <a href="login.jsp" class="action-item" style="color: var(--accent-green)">
                    INGRESA
                </a>
            <% } else { %>
                <span class="action-item" style="color: var(--accent-pink)">
                    HOLA, <%= nombreUser.toUpperCase() %>
                </span>
            <% } %>
        </div>
    </div>
    <nav class="main-nav">
        <ul class="nav-links">
            <li>
                <a href="index.jsp" class="<%= (uri.endsWith("index.jsp")) ? "active" : "" %>">INICIO</a></li>
            
            <li>
                <a href="conciertos.jsp" class="<%= (uri.endsWith("conciertos.jsp") || uri.endsWith("concierto_asientos.jsp")) ? "active" : "" %>">
                    CONCIERTOS
                </a>
            </li>
            
            <li>
                <a href="artista.jsp" class="<%= (uri.endsWith("artista.jsp")) ? "active" : "" %>">
                    ARTISTAS
                </a>
            </li>
            <li>
                <a href="productos.jsp" class="<%= (uri.endsWith("productos.jsp")) ? "active" : "" %>">
                    PRODUCTOS
                </a>
            </li>
            
            <% if(nombreUser != null) { %>
                <li>
                    <a href="seguidos.jsp" class="<%= (uri.endsWith("seguidos.jsp")) ? "active" : "" %>">
                        MIS ARTISTAS
                    </a>
                </li>
                <li>
                    <a href="miscompras.jsp" class="<%= (uri.endsWith("miscompras.jsp")) ? "active" : "" %>">
                        MIS COMPRAS
                    </a>
                </li>
                <li>
                    <a href="reventas.jsp" class="<%= (uri.endsWith("reventas.jsp") || uri.endsWith("formulario_reventa.jsp")) ? "active" : "" %>">
                        REVENTAS
                    </a>
                </li>
                
                <li style="display: flex; align-items: center;">
                    <a href="carrito.jsp" class="<%= (uri.endsWith("carrito.jsp")) ? "active" : "" %>" style="color: var(--accent-green); position: relative; display: flex; align-items: center; gap: 6px;">
                        <img src="img/auxiliares/carrito.png" alt="Carrito" style="width: 20px; height: auto;">
                        <span id="header-cart-count" class="badge" style="position: absolute; top: -10px; right: -20px;">0</span>
                    </a>
                </li>
            <% } %>
            
            <% if(rolUser != null && rolUser.equals("ADMIN")) { %>
                <li style="display: flex; align-items: center; margin-left: auto;">
                    <a href="admin_artistas.jsp" class="<%= (uri.endsWith("admin_artistas.jsp")) ? "active" : "" %>" style="display: flex; align-items: center; gap: 6px; color: var(--accent-pink);">
                        ARTISTAS 
                        <img src="img/auxiliares/lapiz.png" alt="Editar" style="width: 14px; height: auto;">
                    </a>
                </li>
            <% } %>
            
            <% if(rolUser != null && rolUser.equals("ARTISTA")) { %>
                <li style="display: flex; align-items: center; margin-left: auto;">
                    <a href="solicitar_concierto.jsp" class="<%= (uri.endsWith("solicitar_concierto.jsp")) ? "active" : "" %>" style="display: flex; align-items: center; gap: 6px; color: var(--accent-pink);">
                        NUEVO CONCIERTO
                    </a>
                </li>
                <li style="display: flex; align-items: center;">
                    <a href="artista_productos.jsp" class="<%= (uri.endsWith("artista_productos.jsp")) ? "active" : "" %>" style="display: flex; align-items: center; gap: 6px; color: var(--accent-green);">
                        MIS PRODUCTOS 
                        <img src="img/auxiliares/lapiz.png" alt="Editar" style="width: 14px; height: auto;">
                    </a>
                </li>
            <% } %>
        </ul>
    </nav>
        <script>
        function toggleMenu() {
            document.getElementById("menuPerfil").classList.toggle("show-dropdown");
        }
        window.onclick = function(event) {
            if (!event.target.matches('#btnPerfil')) {
                var dropdowns = document.getElementsByClassName("dropdown-content");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show-dropdown')) {
                        openDropdown.classList.remove('show-dropdown');
                    }
                }
            }
        }
        (function() {
            const temaActual = localStorage.getItem('preferencia-tema') || 'tema-sadgirl';
            const fuenteActual = localStorage.getItem('preferencia-fuente');

            if (document.body) {
                document.body.classList.remove('tema-sadgirl', 'tema-showgirl', 'tema-fotos');
                document.body.classList.add(temaActual);

                if (fuenteActual === 'activa') {
                    document.body.classList.add('fuente-dislexia');
                } else {
                    document.body.classList.remove('fuente-dislexia');
                }
            }
        })();
    </script>
</header>
