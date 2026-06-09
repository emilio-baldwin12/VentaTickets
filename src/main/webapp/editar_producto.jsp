<%-- 
    Document   : editar_producto
    Created on : 8 jun 2026, 6:45:54 p.m.
    Author     : luise
--%>

<%@page import="modelo.producto"%>
<%@page import="datos.productosDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String rol = (session.getAttribute("tipousuario") != null) ? (String) session.getAttribute("tipousuario") : "";
    if (!rol.equals("ARTISTA")) {
        response.sendRedirect("index.jsp");
        return;
    }

    String idParam = request.getParameter("id");
    int idProducto = 0;
    producto p = null;
    productosDAO dao = new productosDAO();

    if (idParam != null && !idParam.isEmpty()) {
        try {
            idProducto = Integer.parseInt(idParam);
            p = dao.obtenerProductoIndividual(idProducto); 
        } catch (NumberFormatException e) {
            response.sendRedirect("artista_productos.jsp");
            return;
        }
    }
    

    if (p == null) {
        response.sendRedirect("artista_productos.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panel Artista | Editar Producto</title>
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
                background: #28a745; 
                color: white; 
                padding: 12px 20px; 
                border: none; 
                border-radius: 6px;
                font-weight: bold; 
                cursor: pointer;
                transition: 0.3s;
                flex: 2;
            }
            .btn-submit:hover { background: #218838; }
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
                <h2>Editar Producto</h2>
                <form action="artista_productoServlet" method="POST">
                    <input type="hidden" name="accion" value="actualizar">
                    <input type="hidden" name="idProducto" value="<%= p.getid() %>">
                    
                    <div class="form-group">
                        <label>Nombre del Producto</label>
                        <input type="text" name="nombre" value="<%= p.getnombre() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Precio (USD)</label>
                        <input type="number" step="0.01" name="precio" value="<%= p.getprecio() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Stock Disponible</label>
                        <input type="number" name="cantidad" value="<%= p.getcantidad() %>" required>
                    </div>
                    <div class="form-group">
                        <label>URL de la Foto</label>
                        <input type="text" name="foto" value="<%= p.getfoto() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Descripción</label>
                        <textarea name="descripcion" rows="4"><%= (p.getdescripcion() != null) ? p.getdescripcion() : "" %></textarea>
                    </div>
                    
                    <div class="btn-container">
                        <button type="submit" class="btn-submit">Actualizar Producto</button>
                        <a href="artista_productos.jsp" class="btn-cancel">Cancelar</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
