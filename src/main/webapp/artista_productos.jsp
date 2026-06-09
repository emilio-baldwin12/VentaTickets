<%-- 
    Document   : artista_productos
    Created on : 1 jun 2026, 10:05:52 p.m.
    Author     : luise
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.producto"%>
<%@page import="datos.productosDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String rol = (session.getAttribute("tipousuario") != null) ? (String) session.getAttribute("tipousuario") : "";
    int idArtistaActual = (session.getAttribute("idusuario") != null) ? (int) session.getAttribute("idusuario") : 0;
    
    if (!rol.equals("ARTISTA")) {
        response.sendRedirect("index.jsp");
        return;
    }

    productosDAO dao = new productosDAO();
    List<producto> misProductos = dao.obtenerProductos(idArtistaActual);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mis Productos | Panel Artista</title>
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
                background: #28a745;
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
                background: #218838;
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
                vertical-align: middle;
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
                <h2>Nuevo Producto</h2>
                <form action="artista_productoServlet" method="POST">
                    <input type="hidden" name="accion" value="agregar">
                    
                    <div class="form-group"><label>Nombre del Producto</label><input type="text" name="nombre" required></div>
                    <div class="form-group"><label>Precio (USD)</label><input type="number" step="0.01" name="precio" required></div>
                    <div class="form-group"><label>Stock Disponible</label><input type="number" name="cantidad" required></div>
                    <div class="form-group"><label>URL de la Foto</label><input type="text" name="foto" required></div>
                    <div class="form-group"><label>Descripción</label><textarea name="descripcion" rows="3"></textarea></div>
                    
                    <button type="submit" class="btn-submit">Subir Producto</button>
                </form>
            </div>

            <div class="card table-section">
                <h2>Mi Inventario</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Foto</th>
                            <th>Producto</th>
                            <th>Precio</th>
                            <th>Stock</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(producto p : misProductos) { %>
                        <tr>
                            <td>
                                <img src="img/productos/<%= p.getfoto() != null && !p.getfoto().isEmpty() ? p.getfoto() : "default_productos.jpg" %>" alt="Foto" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                            </td>
                            <td>
                                <strong><%= p.getnombre() %></strong><br>
                                <small style="color:#666;"><%= p.getdescripcion() %></small>
                            </td>
                            <td>$<%= String.format("%,.2f", p.getprecio()) %></td>
                            <td>
                                <span style="color: <%= p.getcantidad() == 0 ? "red" : "green" %>; font-weight: bold;">
                                    <%= p.getcantidad() %>
                                </span>
                            </td>
                            <td style="display: flex; gap: 10px; align-items: center;">
                                
                                <a href="editar_producto.jsp?id=<%= p.getid() %>" 
                                   style="background-color: #007bff; color: white; padding: 7px 12px; text-decoration: none; border-radius: 4px; font-weight: bold; font-size: 13px;">
                                   Editar
                                </a>

                                <form action="artista_productoServlet" method="POST" style="margin:0;" onsubmit="return confirm('¿Seguro que deseas eliminar este producto de la tienda?');">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <input type="hidden" name="idProducto" value="<%= p.getid() %>">
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