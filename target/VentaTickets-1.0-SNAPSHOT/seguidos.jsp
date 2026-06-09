<%-- 
    Document   : seguidos
    Created on : 8 jun 2026, 4:20:44 p.m.
    Author     : luise
--%>

<%@page import="modelo.artista"%>
<%@page import="java.util.List"%>
<%@page import="datos.artistaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Integer idUsuarioLogueado = (Integer) session.getAttribute("idusuario");
    if(idUsuarioLogueado == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tickets | Mis Artistas</title>
    <style>
        body { 
            background-color: var(--bg-blue); 
            font-family: 'Segoe UI', Tahoma, sans-serif; 
            margin: 0; 
            color: #333;
        }

        .main-wrapper {
            max-width: 1200px; 
            margin: 40px auto;
            padding: 0 20px; 
            min-height: 60vh;
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

    <jsp:include page="img/auxiliares/encabezado.jsp" />

    <div class="main-wrapper">
        <div class="section-title">ARTISTAS QUE SIGUES</div>
        
        <div class="artist-grid">
            <%
                artistaDAO dao = new artistaDAO();
                List<artista> misArtistas = dao.obtenerArtistasSeguidos(idUsuarioLogueado);
                
                if(misArtistas != null && !misArtistas.isEmpty()) {
                    for(artista art : misArtistas) {
                        String apellido = (art.getapellido() != null && !art.getapellido().equals("null")) ? art.getapellido() : "";
            %>
                <div class="artist-card" onclick="location.href='perfilartista.jsp?id=<%=art.getID() %>'" style="cursor: pointer;">
                    <div class="card-header">GÉNERO: <%= art.getgenero().toUpperCase() %></div>
                    
                    <img src="img/artistas/<%= art.getfoto() %>" class="artist-img" alt="<%= art.getnombre() %>">
                    
                    <div class="artist-info">
                        <h3><%= art.getnombre() %> <%= apellido %></h3>
                        <p> EXPLORAR EVENTOS</p>
                    </div>
                </div>
            <% 
                    }
                } else { 
            %>
                <div class="no-data">
                    <h3>Aún no sigues a ningún artista</h3>
                    <p>Visita nuestro catálogo para no perderte las próximas fechas de tus favoritos</p>
                    <br>
                    <a href="artista.jsp" style="padding: 10px 20px; background: var(--entity-header); color: white; text-decoration: none; border-radius: 20px; font-weight: bold;">
                        Explorar Artistas
                    </a>
                </div>
            <% } %>
        </div>
    </div>

</body>
</html>