<%@page import="modelo.notificacion"%>
<%@page import="java.util.List"%>
<%@page import="datos.solicitudDAO"%>
<%@page import="modelo.solicitudConcierto"%>
<%@page import="datos.notificacionDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tickets | Notificaciones</title>
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

        .action-item:hover { 
            color: var(--accent-pink);
        }
        .active-link {
            color: var(--accent-pink) !important;
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

        .tab-container { 
            max-width: 900px; 
            margin: 40px auto; 
            background: var(--entity-body); 
            border-radius: 8px; 
            overflow: hidden; 
            border: 2px solid var(--entity-header);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2); 
        }

        .tab-nav { 
            display: flex; 
            background: var(--entity-header); 
            padding: 0 10px; 
        }

        .tab-btn { 
            padding: 15px 25px; 
            color: white; 
            cursor: pointer; 
            border: none; 
            background: none; 
            font-weight: bold; 
            font-size: 13px;
            text-transform: uppercase;
            border-bottom: 4px solid transparent; 
            transition: 0.3s;
        }

        .tab-btn.active { 
            border-bottom: 4px solid var(--accent-pink); 
            color: var(--accent-pink); 
        }

        .notif-body {
            padding: 25px; 
            min-height: 400px; 
        }

        .notif-card { 
            background: white; 
            margin-bottom: 15px; 
            padding: 20px; 
            border-radius: 6px; 
            border-left: 6px solid var(--entity-header); 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: 0.3s;
        }
        
        .notif-card:hover {
            transform: translateX(5px); 
        }
        .notif-card.PERMISO { 
            border-left-color: var(--accent-pink);
        }
        .notif-card.hidden {
            display: none; 
        }

        .notif-info h4 {
            margin: 0; 
            color: #111; 
            font-size: 17px; 
        }
        .notif-info p {
            margin: 8px 0;
            color: #555;
            font-size: 14px;
            line-height: 1.4;
        }
        .notif-time { 
            font-size: 11px; 
            color: #999; 
            font-weight: bold; 
            text-align: right;
            min-width: 120px; 
        }
    </style>
</head>
    <body>

        <%
            Object idObj = session.getAttribute("idusuario");
            String rol = (String) session.getAttribute("tipousuario");
            String nombreUser = (String) session.getAttribute("nombreusuario");

            if (idObj == null) {
                response.sendRedirect("login.jsp?error=vacio");
                return; 
            }

            int idUser = (int) idObj;
            String tipousuario = (rol != null) ? rol : "CLIENTE";
            notificacionDAO daoNotis = new notificacionDAO();
            List<notificacion> lista = daoNotis.obtenerNotis(idUser, tipousuario);

            List<solicitudConcierto> listaPendientes = new java.util.ArrayList<>();
            if("ADMIN".equals(tipousuario)) {
                solicitudDAO sDao = new solicitudDAO();
                listaPendientes = sDao.obtenerPendientes();
            }
        %>
        
        <jsp:include page="img/auxiliares/encabezado.jsp" />
        
        <div class="container" style="max-width: 1000px; margin: 40px auto; background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
            <h1 style="color: #1A1A1A; margin-top: 0; border-bottom: 2px solid #eee; padding-bottom: 10px;">Centro de Notificaciones</h1>

            <div class="tab-container" style="margin-top: 30px;">
                <div class="tab-nav">
                    <button class="tab-btn active" onclick="filtrar('TODAS', this)">TODAS</button>
                    <button class="tab-btn" onclick="filtrar('SISTEMA', this)">SISTEMA</button>
                    <% if("ADMIN".equals(tipousuario)) { %>
                        <button class="tab-btn" onclick="filtrar('PERMISO', this)">PERMISOS</button>
                    <% } %>
                </div>

                <div class="notif-body">
                    <% if((lista == null || lista.isEmpty()) && listaPendientes.isEmpty()) { %>
                        <div style="text-align:center; padding: 50px; color:#777;">
                            <p style="font-size: 16px;">No tienes notificaciones por el momento</p>
                        </div>
                    <% } else { 
                        if(lista != null) {
                            for(notificacion n : lista) { %>
                                <div class="notif-card <%= n.gettipo() %>">
                                    <div class="notif-info">
                                        <small style="color:var(--entity-header); font-weight:bold; text-transform: uppercase; font-size: 10px;">
                                            <%= n.gettipo() %>
                                        </small>
                                        <h4><%= n.gettitulo() %></h4>
                                        <p><%= n.getmensaje() %></p>
                                    </div>
                                    <div class="notif-time">
                                        <%= n.getfecha() %>
                                    </div>
                                </div>
                        <%  }
                        }
                        for(solicitudConcierto s : listaPendientes) { %>
                            <div class="notif-card PERMISO">
                                <div class="notif-info">
                                    <small style="color:var(--accent-pink); font-weight:bold; text-transform: uppercase; font-size: 10px;">
                                        PERMISO - NUEVO CONCIERTO
                                    </small>
                                    <h4><%= s.getnombreartista().toUpperCase() %> quiere abrir una fecha</h4>
                                    <p><strong>Evento:</strong> <%= s.getnombreevento() %> en <%= s.getciudadpropuesta() %></p>
                                    <p style="margin-bottom: 15px;"><strong>Fecha propuesta:</strong> <%= s.getfechapropuesta() %></p>
                                    
                                    <form action="solicitudServlet" method="POST" style="display:inline;">
                                        <input type="hidden" name="accion" value="procesar">
                                        <input type="hidden" name="id_solicitud" value="<%= s.getid() %>">
                                        <input type="hidden" name="decision" value="ACEPTADA">
                                        <button type="submit" style="background-color: #28a745; color: white; padding: 8px 15px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 12px;">APROBAR</button>
                                    </form>
                                    <form action="solicitudServlet" method="POST" style="display:inline;">
                                        <input type="hidden" name="accion" value="procesar">
                                        <input type="hidden" name="id_solicitud" value="<%= s.getid() %>">
                                        <input type="hidden" name="decision" value="RECHAZADA">
                                        <button type="submit" style="background-color: #dc3545; color: white; padding: 8px 15px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 12px; margin-left: 10px;">RECHAZAR</button>
                                    </form>
                                </div>
                                <div class="notif-time" style="color: #f39c12;">
                                    En Espera
                                </div>
                            </div>
                        <% } 
                    } %>
                </div>
            </div>
        </div>
        
        <script>
            function filtrar(tipo, btn) {
                document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');

                document.querySelectorAll('.notif-card').forEach(card => {
                    if (tipo === 'TODAS') {
                        card.classList.remove('hidden');
                    } else {
                        card.classList.contains(tipo) ? card.classList.remove('hidden') : card.classList.add('hidden');
                    }
                });
            }
        </script>
    </body>
</html>