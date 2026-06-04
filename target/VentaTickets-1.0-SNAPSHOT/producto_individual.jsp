<%-- 
    Document   : producto_individual
    Created on : 2 jun 2026, 7:59:58 p.m.
    Author     : luise
--%>

<%@page import="modelo.producto"%>
<%@page import="datos.productosDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String idParam = request.getParameter("id");
    producto p = null;
    
    if (idParam != null && !idParam.isEmpty()) {
        int idProducto = Integer.parseInt(idParam);
        productosDAO dao = new productosDAO();
        p = dao.obtenerProductoIndividual(idProducto);
    }
    
    if (p == null) {
        response.sendRedirect("productos.jsp");
        return;
    }
    
    String fotoPath = (p.getfoto() != null && !p.getfoto().isEmpty()) ? p.getfoto() : "default_productos.jpg";
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= p.getnombre() %> | Tickets</title>
    <style>
        :root {
            --bg-blue: #8EACB8;
            --entity-header: #1A1A1A;
            --entity-body: #E8E2D1;
            --accent-pink: #FFB6C1;
            --meli-blue: #3483fa; 
            --meli-blue-hover: #2968c8;
        }
        * {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            box-sizing: border-box;
        }

        body { 
            background-color: var(--bg-blue); 
            margin: 0; 
            color: #333; 
        }
        
        .product-container {
            max-width: 1000px;
            margin: 40px auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            display: flex;
            padding: 30px;
            gap: 40px;
        }
        
        .product-gallery {
            flex: 1.5;
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }
        .main-image {
            width: 100%;
            max-width: 500px;
            border-radius: 8px;
            object-fit: contain;
        }
        
        .product-details {
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        .status { 
            font-size: 14px; 
            color: #666; 
            margin-bottom: 10px; 
            font-weight: bold;
        }
        
        .title { 
            font-size: 26px; 
            font-weight: bold; 
            color: var(--entity-header); 
            margin-top: 0; 
            margin-bottom: 15px; 
            text-transform: uppercase; 
        }
        
        .price { 
            font-size: 36px; 
            color: #231c1c; 
            font-weight: bold; 
            margin-bottom: 20px; 
        }
        
        .description-box {
            margin-bottom: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        
        .description-title { 
            font-size: 18px; 
            margin-bottom: 15px; 
            color: var(--entity-header); 
            text-transform: uppercase;
            font-weight: bold;
        }
        
        .description-text { 
            font-size: 15px; 
            color: #555; 
            line-height: 1.6; 
            font-weight: 500;
        }
        
        .buy-box {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 24px;
            background: #f8f9fa;
        }
        
        .stock-info {
            font-size: 16px; 
            font-weight: bold; 
            margin-bottom: 20px;
            color: #111;
        }
        
        .btn-buy {
            width: 100%; 
            padding: 15px; 
            border-radius: 6px; 
            border: none;
            font-size: 14px; 
            font-weight: bold; 
            text-transform: uppercase;
            cursor: pointer; 
            transition: 0.3s;
            margin-bottom: 10px;
            letter-spacing: 1px;
        }
        
        .btn-primary {
            background-color: var(--meli-blue); 
            color: white;
        }
        .btn-primary:hover { 
            background-color: var(--meli-blue-hover); 
        }
        
        .btn-secondary {
            background-color: rgba(65,137,230,.15); 
            color: var(--meli-blue);
        }
        .btn-secondary:hover { 
            background-color: rgba(65,137,230,.2); 
        }
    </style>
</head>
    <body>
        <jsp:include page="img/auxiliares/encabezado.jsp" />

        <div class="product-container">
            <div class="product-gallery">
                <img src="img/productos/<%= fotoPath %>" class="main-image" alt="<%= p.getnombre() %>">
            </div>

            <div class="product-details">
                <div class="status">Nuevo | <%= p.getcantidad() %> disponibles</div>
                <h1 class="title"><%= p.getnombre() %></h1>
                <div class="price">$ <%= String.format("%,.2f", p.getprecio()) %></div>

                <div class="description-box">
                    <h2 class="description-title">Lo que tienes que saber de este producto</h2>
                    <p class="description-text"><%= p.getdescripcion() != null ? p.getdescripcion() : "Sin descripción disponible" %></p>
                </div>

                <div class="buy-box">
                    <div class="stock-info">Stock disponible</div>
                        <form action="carritoServlet" method="POST">
                            <input type="hidden" name="idProducto" value="<%= p.getid() %>">
                            <input type="hidden" name="nombre" value="<%= p.getnombre() %>">
                            <input type="hidden" name="precio" value="<%= p.getprecio() %>">
                            <input type="hidden" name="foto" value="<%= fotoPath %>">

                            <button type="submit" name="accion" value="comprar_ahora" class="btn-buy btn-primary">Comprar ahora</button>
                            <button type="submit" name="accion" value="agregar" class="btn-buy btn-secondary">Agregar al carrito</button>
                        </form>
                </div>
            </div>
        </div>
    </body>
</html>