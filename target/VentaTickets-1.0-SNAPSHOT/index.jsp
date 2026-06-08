<%@page import="modelo.artista"%>
<%@page import="datos.artistaDAO"%>
<%@page import="modelo.concierto"%>
<%@page import="java.util.List"%>
<%@page import="datos.conciertoDAO"%>
<%@page import="datos.solicitudDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String tipoUser = (String) session.getAttribute("tipo_usuario");
    String nombreUser = (String) session.getAttribute("nombreUsuario");
    int pendientes = 0;

    if("ADMIN".equals(tipoUser)) {
        pendientes = new solicitudDAO().contarPendientes();
    }
    
    conciertoDAO dao = new conciertoDAO();
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tickets | Home</title>
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
            overflow-x: hidden; /*Evita que la pantalla se mueva hacia los lados*/
        }

        .hero-banner-full {
            position: relative;
            width: 100%;
            height: 450px;
            display: flex;
            align-items: flex-end;
            padding: 40px 10%;
            box-sizing: border-box;
            background: url('img/index/unraveled_banner.jpg') center/cover no-repeat;
            margin-bottom: 50px;
        }

        .hero-content p {
            font-size: 14px;
            color: white;
            font-weight: bold;
            margin: 0 0 10px 0;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-hero {
            background-color: #0056b3; 
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            font-weight: bold;
            border-radius: 4px;
            font-size: 16px;
            transition: 0.3s;
            display: inline-block;
            border: none;
            cursor: pointer;
        }

        .btn-hero:hover {
            background-color: #004494;
            transform: scale(1.05); 
        }

        .main-container {
            max-width: 1200px;
            margin: 0 auto 50px auto;
            padding: 0 20px;
        }

        .section-title { 
            font-size: 16px; 
            font-weight: 800;
            margin-bottom: 20px; 
            color: #111;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 2px solid #333;
            display: inline-block;
            padding-bottom: 5px;
        }
        
        .tour-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            margin-bottom: 60px;
        }

        .tour-card {
            display: flex;
            flex-direction: column;
            text-decoration: none;
            transition: 0.2s;
        }

        .tour-card:hover 
        
        .tour-img { 
            opacity: 0.9;
        }

        .tour-img {
            height: 280px; 
            background-color: #e0e0e0;
            background-size: cover;
            background-position: center;
            border-radius: 8px;
            margin-bottom: 12px;
            border: 1px solid rgba(0,0,0,0.1);
        }

        .tour-info h3 { 
            font-size: 18px;
            margin: 0 0 4px 0;
            color: #111;
        }
        .tour-info p { 
            font-size: 13px;
            color: #666; 
            margin: 0; 
            text-transform: uppercase; 
        }

        .trend-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 50px;
        }

        .trend-card {
            display: flex;
            flex-direction: column;
            text-decoration: none;
        }

        .trend-card:hover .trend-img {
            transform: scale(1.02);
        }

        .trend-img {
            height: 150px;
            background-color: #d0d0d0;
            background-size: cover;
            background-position: center;
            border-radius: 8px;
            transition: 0.3s;
        }

        .trend-genre { 
            font-size: 11px; 
            color: #666; 
            font-weight: bold; 
            text-transform: uppercase;
            letter-spacing: 1px;
            margin: 12px 0 2px 0;
        
        }
        .trend-name { 
            font-size: 16px; 
            font-weight: bold;
            color: #000; 
            margin: 0; 
        }

        @media (max-width: 900px) {
            .tour-grid { 
                grid-template-columns: 1fr; 
            }
            
            .trend-grid { 
                grid-template-columns: repeat(2, 1fr);
            }
            
            .hero-banner-full { 
                padding: 40px 5%;
                height: 350px;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="img/auxiliares/encabezado.jsp" />

    <div class="hero-banner-full">
        <div class="hero-content">
            <p> Olivia Rodrigo</p>
            <a href="filaServlet?idConcierto=1" class="btn-hero">Ver boletos</a>
        </div>
    </div>

    <div class="main-container">
        
        <div class="section-title">Lo Más Buscado</div>
        <div class="tour-grid">
            <%
                List<concierto> tours = dao.listarTop4ToursCercanos();
                if(tours != null && !tours.isEmpty()) {
                    for(concierto t : tours) {
            %>
                <a href="conciertos.jsp?tour=<%= java.net.URLEncoder.encode(t.getnombre(), "UTF-8") %>" class="tour-card">
                    <div class="tour-img" style="background-image: url('img/index/<%= t.getfotos() %>');"></div>
                    <div class="tour-info">
                        <p>Tour Oficial</p>
                        <h3><%= t.getnombre() %></h3>
                    </div>
                </a>
            <% 
                    }
                } else { 
            %>
                <p style="color: #333; grid-column: 1 / -1;">No hay tours disponibles en este momento.</p>
            <% } %>
        </div>

        <div class="section-title">Artistas Tendencia</div>
        <div class="trend-grid">
            <%
                artistaDAO artDao = new artistaDAO();
                List<artista> tendencias = artDao.listarTop4Tendencia();
                
                if(tendencias != null && !tendencias.isEmpty()) {
                    for(artista a : tendencias) {
            %>
                <a href="perfil_artista.jsp?id=<%= a.getID() %>" class="trend-card">
                    <div class="trend-img" style="background-image: url('img/index/<%= a.getfoto() %>');"></div>
                    <div class="trend-genre"><%= a.getgenero() %></div>
                    <h3 class="trend-name"><%= a.getnombre() %></h3>
                </a>
            <% 
                    }
                } else { 
            %>
                <p style="color: #333; grid-column: 1 / -1;">No hay artistas en tendencia por el momento</p>
            <% } %>
        </div>
    </div>
</body>
</html>