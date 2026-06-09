<%-- 
    Document   : admin_artistas.jsp
    Created on : 31 may 2026, 10:46:36 p.m.
    Author     : luise
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.artista"%>
<%@page import="datos.artistaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String rol = (session.getAttribute("tipousuario") != null) ? (String) session.getAttribute("tipousuario") : "";
    if (!rol.equals("ADMIN")) {
        response.sendRedirect("index.jsp");
        return;
    }

    artistaDAO dao = new artistaDAO();
    List<artista> listaArtistas = dao.obtenerArtistas();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panel Admin | Artistas</title>
        <style>
            body { 
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background-color: #E8E2D1; 
                margin: 0;
            }
            .container {
                max-width: 1100px; 
                margin: 40px auto;
                padding: 20px;
                display: flex;
                gap: 30px; 
            }
            .card { 
                background: white;
                padding: 30px; 
                border-radius: 12px; 
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }
            .form-section { 
                flex: 1; 
            }
            .table-section {
                flex: 2; 
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
            
            .btn-submit {
                background: #1A1A1A;
                color: white; 
                padding: 12px 20px; 
                border: none; 
                border-radius: 6px;
                
                width: 100%; 
                font-weight: bold; 
                cursor: pointer;
                transition: 0.3s;
            }
            .btn-submit:hover {
                background: #333;
            }
            .btn-delete { 
                background: #dc3545; 
                color: white; 
                padding: 8px 12px; 
                border: none; 
                border-radius: 4px; 
                cursor: pointer; 
                font-weight: bold;
            }
            
            table { 
                width: 100%; 
                border-collapse: collapse; 
                margin-top: 20px; 
            }
            th, td { 
                padding: 12px; 
                text-align: left; 
                border-bottom: 1px solid #ddd; 
            }
            th { 
                background-color: #f8f9fa; 
                 text-transform: uppercase; 
                 font-size: 13px;
            
            }
        </style>
    </head>
    <body>
        <jsp:include page="img/auxiliares/encabezado.jsp" />

        <div class="container">
            <div class="card form-section">
                <h2>Registrar Artista</h2>
                <form action="admin_artistaServlet" method="POST">
                    <input type="hidden" name="accion" value="agregar">
                    
                    <div class="form-group"><label>Nombre</label><input type="text" name="nombre" required></div>
                    <div class="form-group"><label>Apellido / Alias</label><input type="text" name="apellido" required></div>
                    <div class="form-group"><label>Correo</label><input type="email" name="correo" required></div>
                    <div class="form-group"><label>Contraseña</label><input type="password" name="contrasena" required></div>
                    <div class="form-group"><label>Género Musical</label><input type="text" name="genero" required></div>
                    <div class="form-group"><label>URL de la Foto</label><input type="text" name="foto"></div>
                    <div class="form-group"><label>URL del Banner</label><input type="text" name="banner"></div>
                    <div class="form-group"><label>Descripción</label><textarea name="descripcion" rows="3"></textarea></div>
                    
                    
                    <button type="submit" class="btn-submit">Guardar Artista</button>
                </form>
            </div>

            <div class="card table-section">
                <h2>Artistas Existentes</h2>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Género</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(artista a : listaArtistas) { %>
                        <tr>
                            <td><%= a.getID() %></td>
                            <td><strong><%= a.getnombre() %> <%= a.getapellido() %></strong></td>
                            <td><%= a.getgenero() %></td>
                            <td style="display: flex; gap: 10px; align-items: center;">
                                
                                <a href="editar_artista.jsp?id=<%= a.getID() %>" 
                                   style="background-color: #007bff; color: white; padding: 7px 12px; text-decoration: none; border-radius: 4px; font-weight: bold; font-size: 13px;">
                                   Editar
                                </a>

                                <form action="admin_artistaServlet" method="POST" style="margin:0;" onsubmit="return confirm('¿Estás seguro de eliminar a este artista? Toda su información se perderá');">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <input type="hidden" name="idUsuario" value="<%= a.getID() %>">
                                    <button type="submit" class="btn-delete">Eliminar</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
