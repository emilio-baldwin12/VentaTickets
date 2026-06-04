<%-- 
    Document   : pago_carrito
    Created on : 2 jun 2026, 11:21:25 p.m.
    Author     : luise
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.productoCarrito"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<productoCarrito> carrito = (List<productoCarrito>) session.getAttribute("carritoProductos");

    if (carrito == null || carrito.isEmpty()) {
        response.sendRedirect("productos.jsp");
        return;
    }

    double totalPagar = 0;
    int totalArticulos = 0;
    for (productoCarrito item : carrito) {
        totalPagar += item.getsubtotal();
        totalArticulos += item.getcantidad();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tickets | Metodo de Pago</title>
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

        .page-layout { 
            display: flex; 
            gap: 30px; 
            max-width: 1000px;
            margin: 50px auto; 
            align-items: stretch;
        }
        .col-resumen {
            flex: 1;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .col-pago {
            flex: 1;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        h2 { 
            color: var(--entity-header); 
             margin-top: 0; 
             margin-bottom: 25px; 
             text-transform: uppercase;
        }
        
        .detalle-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
            font-size: 15px;
        }
        .item-nombre {
            font-weight: 500; 
            color: #444; 
        }
        .item-precio {
            font-weight: bold; 
            color: #1a1a1a; 
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            padding-top: 15px;
            font-weight: bold;
            font-size: 24px;
            color: var(--entity-header);
            border-top: 2px dashed #ccc;
        }

        .btn-pago {
            background: #f8f9fa;
            border: 2px solid #e0e0e0;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 15px;
            font-size: 16px;
            font-weight: bold;
            color: #333;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: space-between;
            text-align: left;
        }
        .btn-pago:hover {
            border-color: var(--entity-header);
            background: #fff;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        .icono-pago {
            height: 35px; 
            width: auto;
            object-fit: contain;
        }
    </style>
</head>
<body>
    <jsp:include page="img/auxiliares/encabezado.jsp" />

    <div class="page-layout">
        <div class="col-resumen">
            <h2>Resumen del Carrito</h2>
            
            <div style="margin-bottom: 20px;">
                <% for (productoCarrito item : carrito) { %>
                    <div class="detalle-item">
                        <span class="item-nombre"><%= item.getcantidad() %>x <%= item.getnombre() %></span>
                        <span class="item-precio">$ <%= String.format("%,.2f", item.getsubtotal()) %></span>
                    </div>
                <% } %>
            </div>

            <div class="detalle-item" style="border-bottom: none; font-size: 14px; color: #666;">
                <span>Total de artículos:</span>
                <span><%= totalArticulos %></span>
            </div>

            <div class="total-row">
                <span>Total a Pagar:</span>
                <span>$ <%= String.format("%,.2f", totalPagar) %> USD</span>
            </div>
        </div>

        <div class="col-pago">
            <h2>Método de Pago</h2>
            <p style="color: #666; font-size: 14px; margin-top: -15px; margin-bottom: 25px;">Selecciona una opción para procesar tu mercancía</p>

            <button class="btn-pago" onclick="procesarPago('CREDITO')">
                <span>Tarjeta de Crédito</span>
                <img src="${pageContext.request.contextPath}/img/auxiliares/credito.jpg" class="icono-pago">
            </button>

            <button class="btn-pago" onclick="procesarPago('DEBITO')">
                <span>Pago con PayPal</span>
                <img src="${pageContext.request.contextPath}/img/auxiliares/paypal.jpg" class="icono-pago">
            </button>

            <button class="btn-pago" onclick="procesarPago('OXXO')">
                <span>Pago en Efectivo (OXXO)</span>
                <img src="${pageContext.request.contextPath}/img/auxiliares/oxxo.jpg" class="icono-pago">
            </button>
        </div>
    </div>

    <form id="formFinalizarPago" action="transaccion_productos.jsp" method="POST" style="display: none;">
        <input type="hidden" name="metodoPago" id="inputMetodoPago">
        <input type="hidden" name="totalPagar" value="<%= totalPagar %>">
    </form>

    <script>
        function procesarPago(metodo) {
            document.getElementById('inputMetodoPago').value = metodo;
            document.getElementById('formFinalizarPago').submit();
        }
    </script>
</body>
</html>