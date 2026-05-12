<%-- 
    Document   : conciertos
    Created on : 11 may 2026, 10:06:53 p.m.
    Author     : luise
--%>

<%@page import="modelo.concierto"%>
<%@page import="java.util.List"%>
<%@page import="datos.conciertoDAO"%>
<%@page import="datos.artistaDAO"%>
<%@page import="datos.solicitudDAO"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUser = (String) session.getAttribute("nombreusuario");
    String tipoUser = (String) session.getAttribute("tipousuario");

    int pendientes = 0;
    if("ADMIN".equals(tipoUser)) {
        pendientes = new solicitudDAO().contarPendientes();
    }

    conciertoDAO dao = new conciertoDAO();
    List<concierto> todos = dao.listar(); 
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ticketes | Descubre Eventos</title>
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

        .container { 
            max-width: 1100px;
            margin: 30px auto;
            padding: 0 20px; 
        }
        h1 { 
            font-size: 28px; 
            color: #111;
            margin-bottom: 30px;
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
            border-left: 5px solid #007bff;
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
        .artist-name {
            font-size: 20px;
            font-weight: bold; 
            color: #000;
        }
        .tour-name { 
            color: #666; 
            font-size: 14px; 
            margin-top: 4px;
        }
        .location { 
            color: #888; 
            font-size: 13px; 
            margin-top: 4px;
        }

        .btn-tickets {
            background: #007bff;
            color: white;
            padding: 12px 25px;
            border-radius: 4px;
            text-decoration: none; 
            font-weight: bold;
            font-size: 13px; 
            transition: 0.2s;
        }
        .btn-tickets:hover { 
            background: #0056b3;
        }
    </style>
</head>
<body>
    
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
                    <a href="login.jsp" class="action-item" style="color: #28a745">INGRESA</a>
                <% } %>
            </div>
        </div>
        <nav class="main-nav">
            <ul class="nav-links">
                <li><a href="index.jsp">INICIO</a></li>
                <li><a href="conciertos.jsp" style="color: var(--accent-pink);">CONCIERTOS</a></li>
                <li><a href="artista.jsp">ARTISTAS</a></li>
                <li><a href="productos.jsp">PRODUCTOS</a></li>
            </ul>
        </nav>
    </header>

    <div class="container">
        <h1>Próximos Conciertos en <%= (todos.size() > 0) ? todos.get(0).getciudad() : "tu ciudad" %></h1>

        <div class="concert-list">
            <%
                java.text.SimpleDateFormat sdfDia = new java.text.SimpleDateFormat("dd");
                java.text.SimpleDateFormat sdfMes = new java.text.SimpleDateFormat("MMM");

                for(concierto c : todos) {
            %>
                <div class="concert-card">
                    <div class="date-box">
                        <div class="month"><%= sdfMes.format(c.getfecha()) %></div>
                        <div class="day"><%= sdfDia.format(c.getfecha()) %></div>
                    </div>

                    <div class="info">
                        <div class="artist-name"><%= c.getdescripcion() %></div> 
                        <div class="tour-name"><%= c.getnombre() %></div>
                        <div class="location"><%= c.getciudad() %></div>
                    </div>

                    <div class="actions">
                        <a href="detalle_evento.jsp?id=<%= c.getid() %>" class="btn-tickets">
                            VER TICKETS
                        </a>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

</body>
</html>