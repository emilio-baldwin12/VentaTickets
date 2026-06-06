<%-- 
    Document   : crearConcierto
    Created on : 4 jun 2026, 11:23:01 p.m.
    Author     : luise
--%>
<%@page import="datos.solicitudDAO"%>
<%@page import="modelo.solicitudConcierto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUser = (String) session.getAttribute("nombreusuario");
    String rolUser = (String) session.getAttribute("tipousuario");

    if (nombreUser == null || !"ADMIN".equals(rolUser)) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    String idSolicitud = request.getParameter("id_solic");
    String nombreEvento = "";
    String fecha = "";
    String ciudad = "";
    int idArtista = 0;
    String nombreArtista = "";
    String descripcion = ""; 
    
    if (idSolicitud != null && !idSolicitud.isEmpty()) {
        solicitudDAO sDao = new solicitudDAO();
        solicitudConcierto solic = sDao.obtenerSolicitudPorId(Integer.parseInt(idSolicitud));
        if (solic != null) {
            nombreEvento = solic.getnombreevento();
            fecha = solic.getfechapropuesta();
            ciudad = solic.getciudadpropuesta();
            idArtista = solic.getidartista();
            nombreArtista = solic.getnombreartista();
            descripcion = solic.getdescripcion(); 
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Alta de Concierto | Ticketes</title>
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #E8E2D1; 
            margin: 0; 
        }
        .form-container {
            max-width: 700px;
            margin: 50px auto;
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
        .form-grid {
            display: grid; 
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .form-group { 
            margin-bottom: 20px;
        }
        .form-group.full-width {
            grid-column: span 2;
        }
        label { 
            display: block;
            font-weight: bold;
            margin-bottom: 8px; 
            color: #333;
            font-size: 14px;
        }
        input[type="text"], input[type="date"], input[type="number"], 
        select { 
            width: 100%; 
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px; 
            box-sizing: border-box; 
            font-size: 14px; 
        }
        .btn-submit { 
            background-color: #28a745;
            color: white; 
            padding: 15px;
            border: none;
            border-radius: 8px;
            font-size: 16px; 
            font-weight: bold; 
            width: 100%; 
            cursor: pointer;
            transition: 0.3s;
            margin-top: 20px; 
        }
        .btn-submit:hover { 
            background-color: #218838;
        }
    </style>
</head>
    <body>
        <jsp:include page="img/auxiliares/encabezado.jsp" />

        <div class="form-container">
            <h1>Configurar Tour / Evento</h1>
            <p style="color: #666; margin-bottom: 25px;">Agrega todas las fechas necesarias para esta gira</p>

            <form action="conciertosServlet" method="POST">
                <input type="hidden" name="accion" value="crear_concierto">
                <input type="hidden" name="id_solicitud" value="<%= idSolicitud != null ? idSolicitud : "" %>">

                <h3 style="color: #444; border-bottom: 1px solid #ddd; padding-bottom: 5px;">1. Datos Generales de la Gira</h3>
                <div class="form-grid">
                    <div class="form-group full-width">
                        <label>Nombre del Evento/Tour:</label>
                        <input type="text" name="nombre" value="<%= nombreEvento %>" required placeholder="Ej. The Tour">
                    </div>

                    <div class="form-group full-width">
                        <label>Ruta de la Foto Oficial del Tour:</label>
                        <input type="text" name="fotos" required placeholder="Ej. img/artistas/tour.png">
                    </div>

                    <div class="form-group full-width">
                        <label>Descripción de la Gira:</label>
                        <textarea name="descripcion" style="height: 80px;" required><%= descripcion != null ? descripcion : "" %></textarea>
                    </div>

                    <div class="form-group full-width">
                        <label>Artista Principal:</label>
                        <input type="text" value="<%= nombreArtista.toUpperCase() %>" readonly>
                        <input type="hidden" name="id_artista" value="<%= idArtista %>">
                    </div>
                </div>

                <h3 style="color: #444; border-bottom: 1px solid #ddd; padding-bottom: 5px; margin-top: 20px;">2. Fechas y Lugares</h3>

                <div id="contenedor-fechas">
                    <div class="fecha-bloque">
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Fecha del Concierto:</label>
                                <input type="date" name="fecha" value="<%= fecha %>" required>
                            </div>
                            <div class="form-group">
                                <label>Ciudad:</label>
                                <input type="text" name="ciudad" value="<%= ciudad %>" required>
                            </div>
                            <div class="form-group full-width">
                                <label>ID del Recinto (Lugar):</label>
                                <input type="number" name="id_recinto" required placeholder="Ej. 1 para Auditorio Nacional">
                            </div>
                        </div>
                    </div>
                </div>

                <button type="button" class="btn-add" onclick="agregarFecha()">+ Agregar otra fecha al tour</button>

                <button type="submit" class="btn-submit">Publicar Tour Completo</button>
            </form>
        </div>

        <script>
            function agregarFecha() {
                const contenedor = document.getElementById('contenedor-fechas');
                const nuevoBloque = document.createElement('div');
                nuevoBloque.className = 'fecha-bloque';
                nuevoBloque.innerHTML = `
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Fecha del Concierto:</label>
                            <input type="date" name="fecha" required>
                        </div>
                        <div class="form-group">
                            <label>Ciudad:</label>
                            <input type="text" name="ciudad" required>
                        </div>
                        <div class="form-group full-width">
                            <label>ID del Recinto (Lugar):</label>
                            <input type="number" name="id_recinto" required placeholder="Ej. 1 para Auditorio Nacional">
                        </div>
                    </div>
                `;
                contenedor.appendChild(nuevoBloque);
            }
        </script>
    </body>
</html>