<%-- 
    Document   : editar_artista
    Created on : 8 jun 2026, 6:46:07 p.m.
    Author     : luise
--%>

<%@page import="modelo.artista"%>
<%@page import="datos.artistaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String rol = (session.getAttribute("tipousuario") != null) ? (String) session.getAttribute("tipousuario") : "";
    if (!rol.equals("ADMIN")) {
        response.sendRedirect("index.jsp");
        return;
    }

    String idParam = request.getParameter("id");
    int idArtista = 0;
    artista art = null;
    artistaDAO dao = new artistaDAO();

    if (idParam != null && !idParam.isEmpty()) {
        try {
            idArtista = Integer.parseInt(idParam);
            art = dao.obtenerPerfil(idArtista); 
        } catch (NumberFormatException e) {
            response.sendRedirect("admin_artistas.jsp");
            return;
        }
    }

    if (art == null) {
        response.sendRedirect("admin_artistas.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panel Admin | Editar Artista</title>
        <style>
            body { 
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background-color: #E8E2D1; 
                margin: 0;
            }
            .container {
                max-width: 600px; 
                margin: 50px auto;
                padding: 20px;
            }
            .card { 
                background: white;
                padding: 30px; 
                border-radius: 12px; 
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }
            h2 {
                margin-top: 0;
                color: #1A1A1A;
                border-bottom: 2px solid #eee;
                padding-bottom: 10px; 
            }
            .form-group { 
                margin-bottom: 15px;
            }
            .form-group label {
                display: block; 
                font-size: 13px; 
                font-weight: bold; 
                color: #333; 
                margin-bottom: 5px;
                text-transform: uppercase;
            }
            .form-group input, .form-group textarea {
                width: 100%; 
                padding: 10px; 
                border: 1px solid #ccc;
                border-radius: 6px; 
                box-sizing: border-box; 
            }
            .btn-container {
                display: flex;
                gap: 15px;
                margin-top: 20px;
            }
            .btn-submit {
                background: #1A1A1A;
                color: white; 
                padding: 12px 20px; 
                border: none; 
                border-radius: 6px;
                font-weight: bold; 
                cursor: pointer;
                transition: 0.3s;
                flex: 2;
            }
            .btn-submit:hover { background: #333; }
            .btn-cancel {
                background: #6c757d;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                text-align: center;
                text-decoration: none;
                cursor: pointer;
                flex: 1;
            }
        </style>
    </head>
    <body>
        <jsp:include page="img/auxiliares/encabezado.jsp" />

        <div class="container">
            <div class="card">
                <h2>Editar Artista: <%= art.getnombre() %></h2>
                <form action="admin_artistaServlet" method="POST">
                    <input type="hidden" name="accion" value="actualizar">
                    <input type="hidden" name="idUsuario" value="<%= art.getID() %>">
                    
                    <div class="form-group">
                        <label>Nombre</label>
                        <input type="text" name="nombre" value="<%= art.getnombre() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Apellido / Alias</label>
                        <input type="text" name="apellido" value="<%= (art.getapellido() != null) ? art.getapellido() : "" %>" required>
                    </div>
                    <div class="form-group">
                        <label>Género Musical</label>
                        <input type="text" name="genero" value="<%= art.getgenero() %>" required>
                    </div>
                    <div class="form-group">
                        <label>URL de la Foto</label>
                        <input type="text" name="foto" value="<%= (art.getfoto() != null) ? art.getfoto() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>URL del Banner</label>
                        <input type="text" name="banner" value="<%= (art.getbanner() != null) ? art.getbanner() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Descripción</label>
                        <textarea name="descripcion" rows="4"><%= (art.getdescripcion() != null) ? art.getdescripcion() : "" %></textarea>
                    </div>
                    
                    <div class="btn-container">
                        <button type="submit" class="btn-submit">Guardar Cambios</button>
                        <a href="admin_artistas.jsp" class="btn-cancel">Cancelar</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>