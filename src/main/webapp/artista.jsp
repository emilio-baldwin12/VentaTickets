<%@page import="modelo.artista"%>
<%@page import="java.util.List"%>
<%@page import="datos.artistaDAO"%>
<%@page import="datos.solicitudDAO"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tickets | Nuestros Artistas</title>
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

    </style>
</head>
<body>

<%
    String nombreUser = (String) session.getAttribute("nombreusuario");
    String tipoUser = (String) session.getAttribute("tipousuario");
    int pendientes = 0;
    
    if("ADMIN".equals(tipoUser)) {
        pendientes = new solicitudDAO().contarPendientes();
    }
%>

   <header class="main-header">
        <div class="header-top">
            <a href="index.jsp" class="logo">TICKETS</a>
            <div class="user-actions">
                <a href="#" class="action-item">BUSCAR</a>
                <a href="notificaciones.jsp" class="action-item">
                    NOTIFICACIONES <% if(pendientes > 0) { %><span class="badge"><%= pendientes %></span><% } %>
                </a>
                <a class="action-item">PERFIL <%= (nombreUser != null) ? "(" + nombreUser.toUpperCase() + ")" : "" %></a>
                <% if(nombreUser != null) { %>
                    <a href="LogoutServlet" class="action-item" style="color: #ff4444;">SALIR</a>
                <% } else { %>
                    <a href="login.jsp" class="action-item" style="color: var(--accent-green)">INGRESA</a>
                <% } %>
            </div>
        </div>
        <nav class="main-nav">
            <ul class="nav-links">
                <li><a href="index.jsp">INICIO</a></li>
                <li><a href="conciertos.jsp">CONCIERTOS</a></li>
                <li><a href="artista.jsp" style="color: var(--accent-pink);">ARTISTAS</a></li>
                <li><a href="productos.jsp">PRODUCTOS</a></li>
            </ul>
        </nav>
    </header>

    <div class="main-wrapper">
        <div class="section-title">NUESTROS ARTISTAS</div>
        <div class="artist-grid">
            <%
                artistaDAO dao = new artistaDAO();
                List<artista> lista = dao.obtenerArtistas();

                if (lista != null && !lista.isEmpty()) {
                    for (artista art : lista) {
                        String apellido = (art.getapellido() != null) ? art.getapellido() : "";
                        String fotoPath = (art.getfoto() != null && !art.getfoto().isEmpty()) 
                                          ? art.getfoto() : "default_artist.jpg";
            %>
            <div class="artist-card" onclick="location.href='perfilartista.jsp?id=<%=art.getID() %>'" style="cursor: pointer;">
                    <div class="card-header">GÉNERO: <%= art.getgenero().toUpperCase() %></div>
                    <img src="img/artistas/<%= art.getfoto() %>" class="artist-img" alt="<%= art.getnombre() %>">
                    <div class="artist-info">
                        <h3><%= art.getnombre() %></h3>
                        <p>> EXPLORAR EVENTOS</p>
                    </div>
                </div>
            <% 
                    }
                } else { 
            %>
                <div class="no-data">
                    <h3>Aun no hay artistas registrados</h3>
                    <p>Vuelve mas tarde para conocer a nuestros talentos</p>
                </div>
            <% } %>
        </div>
    </div>

</body>
</html>